-- LEARNING OS / SUPABASE SETUP
-- Ejecuta este archivo completo en Supabase > SQL Editor.

create extension if not exists pgcrypto;

create table if not exists public.courses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  platform text,
  category text,
  instructor text,
  status text default 'pending' check (status in ('pending','in_progress','paused','completed','abandoned')),
  priority text default 'normal' check (priority in ('low','normal','high','now')),
  progress numeric default 0 check (progress between 0 and 100),
  estimated_hours numeric default 0,
  start_date date,
  target_date date,
  url text,
  notes text,
  created_at timestamptz default now()
);

create table if not exists public.sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  course_id uuid references public.courses(id) on delete set null,
  date date not null default current_date,
  minutes integer not null check (minutes > 0),
  notes text,
  created_at timestamptz default now()
);

create table if not exists public.goals (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  target numeric default 1,
  current numeric default 0,
  target_date date,
  category text,
  created_at timestamptz default now()
);

create table if not exists public.certificates (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  platform text,
  issue_date date,
  credential_url text,
  file_path text,
  created_at timestamptz default now()
);

alter table public.courses enable row level security;
alter table public.sessions enable row level security;
alter table public.goals enable row level security;
alter table public.certificates enable row level security;

create policy "courses own" on public.courses for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "sessions own" on public.sessions for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "goals own" on public.goals for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "certificates own" on public.certificates for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Storage:
-- En Supabase > Storage crea un bucket PRIVADO llamado: certificates
-- Luego crea estas policies para permitir a cada usuario gestionar solo su carpeta:
create policy "certificates insert own folder" on storage.objects
for insert to authenticated
with check (bucket_id = 'certificates' and (storage.foldername(name))[1] = (select auth.uid()::text));

create policy "certificates select own folder" on storage.objects
for select to authenticated
using (bucket_id = 'certificates' and (storage.foldername(name))[1] = (select auth.uid()::text));

create policy "certificates delete own folder" on storage.objects
for delete to authenticated
using (bucket_id = 'certificates' and (storage.foldername(name))[1] = (select auth.uid()::text));

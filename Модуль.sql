PGDMP  1    8                |         	   LibraryDB    17.2    17.2     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16550 	   LibraryDB    DATABASE        CREATE DATABASE "LibraryDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "LibraryDB";
                     postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                     pg_database_owner    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                        pg_database_owner    false    5            �            1259    16591    books    TABLE     �   CREATE TABLE public.books (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title text,
    author text,
    year integer
);
    DROP TABLE public.books;
       public         heap r       postgres    false    5            �            1259    16571    users    TABLE     �   CREATE TABLE public.users (
    username character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    role character varying(50) NOT NULL
);
    DROP TABLE public.users;
       public         heap r       postgres    false    5            �          0    16591    books 
   TABLE DATA           8   COPY public.books (id, title, author, year) FROM stdin;
    public               postgres    false    219          �          0    16571    users 
   TABLE DATA           9   COPY public.users (username, password, role) FROM stdin;
    public               postgres    false    218   :       3           2606    16598    books books_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.books DROP CONSTRAINT books_pkey;
       public                 postgres    false    219            1           2606    16575    users users_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 postgres    false    218            �      x������ � �      �   N   x�KL����L��FƜ� Wiqj'� 	�i��Ҕ�TΪ�d���.컰�b?���/삊��B���qqq r�!�     
PGDMP  
    :                |            repairdb    17.2    17.2      �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    24619    repairdb    DATABASE     |   CREATE DATABASE repairdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE repairdb;
                     postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                     pg_database_owner    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                        pg_database_owner    false    4            �            1255    32785    set_completion_date()    FUNCTION     �   CREATE FUNCTION public.set_completion_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."Статус" = 'Выполнено' THEN
        NEW."ДатаВыполнения" = CURRENT_DATE;
    END IF;
    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.set_completion_date();
       public               postgres    false    4            �            1255    32787    update_statistics_on_delete()    FUNCTION     �  CREATE FUNCTION public.update_statistics_on_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Уменьшаем количество по типу неисправности
    UPDATE "Статистика"
    SET "КоличествоПоТипу" = "КоличествоПоТипу" - 1
    WHERE "ТипНеисправности" = OLD."ТипНеисправности";

    RETURN OLD;
END;
$$;
 4   DROP FUNCTION public.update_statistics_on_delete();
       public               postgres    false    4            �            1259    24659 7   ЗаявкиНаРемонт_НомерЗаявки_seq    SEQUENCE     �   CREATE SEQUENCE public."ЗаявкиНаРемонт_НомерЗаявки_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 P   DROP SEQUENCE public."ЗаявкиНаРемонт_НомерЗаявки_seq";
       public               postgres    false    4            �            1259    24628    ЗаявкиНаРемонт    TABLE     �  CREATE TABLE public."ЗаявкиНаРемонт" (
    "Идентификатор" integer NOT NULL,
    "НомерЗаявки" integer DEFAULT nextval('public."ЗаявкиНаРемонт_НомерЗаявки_seq"'::regclass),
    "ДатаДобавления" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "Оборудование" character varying(100),
    "ТипНеисправности" character varying(50),
    "ОписаниеПроблемы" text,
    "Клиент" character varying(100),
    "Статус" character varying(20),
    "Ответственный" text,
    "Комментарии" text,
    "ДатаВыполнения" timestamp without time zone,
    "НовыйСрокВыполнения" date,
    CONSTRAINT "ЗаявкиНаРемонт_Статус_check" CHECK ((("Статус")::text = ANY ((ARRAY['Ожидание'::character varying, 'В работе'::character varying, 'Выполнено'::character varying])::text[])))
);
 2   DROP TABLE public."ЗаявкиНаРемонт";
       public         heap r       postgres    false    222    4            �            1259    24627 ;   ЗаявкиНаРемонт_Идентификатор_seq    SEQUENCE     �   CREATE SEQUENCE public."ЗаявкиНаРемонт_Идентификатор_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 T   DROP SEQUENCE public."ЗаявкиНаРемонт_Идентификатор_seq";
       public               postgres    false    220    4            �           0    0 ;   ЗаявкиНаРемонт_Идентификатор_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public."ЗаявкиНаРемонт_Идентификатор_seq" OWNED BY public."ЗаявкиНаРемонт"."Идентификатор";
          public               postgres    false    219            �            1259    24621    Пользователи    TABLE     �   CREATE TABLE public."Пользователи" (
    "Идентификатор" integer NOT NULL,
    "Логин" character varying(50) NOT NULL,
    "Пароль" character varying(50) NOT NULL,
    "Роль" character varying(20) NOT NULL
);
 .   DROP TABLE public."Пользователи";
       public         heap r       postgres    false    4            �            1259    24620 7   Пользователи_Идентификатор_seq    SEQUENCE     �   CREATE SEQUENCE public."Пользователи_Идентификатор_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 P   DROP SEQUENCE public."Пользователи_Идентификатор_seq";
       public               postgres    false    4    218            �           0    0 7   Пользователи_Идентификатор_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public."Пользователи_Идентификатор_seq" OWNED BY public."Пользователи"."Идентификатор";
          public               postgres    false    217            �            1259    32772    Статистика    TABLE     =  CREATE TABLE public."Статистика" (
    "КоличествоВыполненных" integer DEFAULT 0,
    "СреднееВремяВыполнения" interval DEFAULT '00:00:00'::interval,
    "ТипНеисправности" text NOT NULL,
    "КоличествоПоТипу" integer DEFAULT 0
);
 *   DROP TABLE public."Статистика";
       public         heap r       postgres    false    4            �            1259    24657    номер_заявки_seq    SEQUENCE     �   CREATE SEQUENCE public."номер_заявки_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public."номер_заявки_seq";
       public               postgres    false    4            /           2604    24631 7   ЗаявкиНаРемонт Идентификатор    DEFAULT     �   ALTER TABLE ONLY public."ЗаявкиНаРемонт" ALTER COLUMN "Идентификатор" SET DEFAULT nextval('public."ЗаявкиНаРемонт_Идентификатор_seq"'::regclass);
 j   ALTER TABLE public."ЗаявкиНаРемонт" ALTER COLUMN "Идентификатор" DROP DEFAULT;
       public               postgres    false    219    220    220            .           2604    24624 3   Пользователи Идентификатор    DEFAULT     �   ALTER TABLE ONLY public."Пользователи" ALTER COLUMN "Идентификатор" SET DEFAULT nextval('public."Пользователи_Идентификатор_seq"'::regclass);
 f   ALTER TABLE public."Пользователи" ALTER COLUMN "Идентификатор" DROP DEFAULT;
       public               postgres    false    217    218    218            �          0    24628    ЗаявкиНаРемонт 
   TABLE DATA           �  COPY public."ЗаявкиНаРемонт" ("Идентификатор", "НомерЗаявки", "ДатаДобавления", "Оборудование", "ТипНеисправности", "ОписаниеПроблемы", "Клиент", "Статус", "Ответственный", "Комментарии", "ДатаВыполнения", "НовыйСрокВыполнения") FROM stdin;
    public               postgres    false    220   �2       �          0    24621    Пользователи 
   TABLE DATA           |   COPY public."Пользователи" ("Идентификатор", "Логин", "Пароль", "Роль") FROM stdin;
    public               postgres    false    218   �2       �          0    32772    Статистика 
   TABLE DATA           �   COPY public."Статистика" ("КоличествоВыполненных", "СреднееВремяВыполнения", "ТипНеисправности", "КоличествоПоТипу") FROM stdin;
    public               postgres    false    223   k3       �           0    0 ;   ЗаявкиНаРемонт_Идентификатор_seq    SEQUENCE SET     l   SELECT pg_catalog.setval('public."ЗаявкиНаРемонт_Идентификатор_seq"', 1, false);
          public               postgres    false    219            �           0    0 7   ЗаявкиНаРемонт_НомерЗаявки_seq    SEQUENCE SET     h   SELECT pg_catalog.setval('public."ЗаявкиНаРемонт_НомерЗаявки_seq"', 1, false);
          public               postgres    false    222            �           0    0 7   Пользователи_Идентификатор_seq    SEQUENCE SET     g   SELECT pg_catalog.setval('public."Пользователи_Идентификатор_seq"', 7, true);
          public               postgres    false    217            �           0    0    номер_заявки_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public."номер_заявки_seq"', 4, true);
          public               postgres    false    221            9           2606    24637 >   ЗаявкиНаРемонт ЗаявкиНаРемонт_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."ЗаявкиНаРемонт"
    ADD CONSTRAINT "ЗаявкиНаРемонт_pkey" PRIMARY KEY ("Идентификатор");
 l   ALTER TABLE ONLY public."ЗаявкиНаРемонт" DROP CONSTRAINT "ЗаявкиНаРемонт_pkey";
       public                 postgres    false    220            ;           2606    24673 T   ЗаявкиНаРемонт ЗаявкиНаРемонт_НомерЗаявки_key 
   CONSTRAINT     �   ALTER TABLE ONLY public."ЗаявкиНаРемонт"
    ADD CONSTRAINT "ЗаявкиНаРемонт_НомерЗаявки_key" UNIQUE ("НомерЗаявки");
 �   ALTER TABLE ONLY public."ЗаявкиНаРемонт" DROP CONSTRAINT "ЗаявкиНаРемонт_НомерЗаявки_key";
       public                 postgres    false    220            7           2606    24626 6   Пользователи Пользователи_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."Пользователи"
    ADD CONSTRAINT "Пользователи_pkey" PRIMARY KEY ("Идентификатор");
 d   ALTER TABLE ONLY public."Пользователи" DROP CONSTRAINT "Пользователи_pkey";
       public                 postgres    false    218            =           2606    32784 .   Статистика статистика_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."Статистика"
    ADD CONSTRAINT "статистика_pkey" PRIMARY KEY ("ТипНеисправности");
 \   ALTER TABLE ONLY public."Статистика" DROP CONSTRAINT "статистика_pkey";
       public                 postgres    false    223            >           2620    32788 ;   ЗаявкиНаРемонт decrement_statistics_on_delete    TRIGGER     �   CREATE TRIGGER decrement_statistics_on_delete AFTER DELETE ON public."ЗаявкиНаРемонт" FOR EACH ROW EXECUTE FUNCTION public.update_statistics_on_delete();
 V   DROP TRIGGER decrement_statistics_on_delete ON public."ЗаявкиНаРемонт";
       public               postgres    false    225    220            ?           2620    32786 3   ЗаявкиНаРемонт update_completion_date    TRIGGER     �   CREATE TRIGGER update_completion_date BEFORE UPDATE ON public."ЗаявкиНаРемонт" FOR EACH ROW EXECUTE FUNCTION public.set_completion_date();
 N   DROP TRIGGER update_completion_date ON public."ЗаявкиНаРемонт";
       public               postgres    false    220    224            �      x������ � �      �   \   x���	�0�s3�`�q����Wi���?{x|��3wX�𢠢�Q�h���t���������$�{�a����پ���>�5�      �   f   x�3����0�bÅ}6�� ��.�+ ��v\l��,�	��w��b��N]C.��9�^lJ�*l�/�"�� �u��@5��b�h����� �zq�     
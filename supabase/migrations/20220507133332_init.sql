-- This script was generated by the Schema Diff utility in pgAdmin 4
-- For the circular dependencies, the order in which Schema Diff writes the objects is not very sophisticated
-- and may require manual changes to the script to ensure changes are applied in the correct order.
-- Please report an issue for any failure with the reproduction steps.

-- Type: TimerStatus

-- DROP TYPE IF EXISTS public."TimerStatus";

CREATE TYPE public."TimerStatus" AS ENUM
    ('ACTIVE', 'FINISHED');

ALTER TYPE public."TimerStatus"
    OWNER TO postgres;

-- Type: TimerType

-- DROP TYPE IF EXISTS public."TimerType";

CREATE TYPE public."TimerType" AS ENUM
    ('FOCUS', 'EXERCISE');

ALTER TYPE public."TimerType"
    OWNER TO postgres;

CREATE TABLE IF NOT EXISTS public."Pomodoro"
(
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT "Pomodoro_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Pomodoro"
    OWNER to postgres;

GRANT ALL ON TABLE public."Pomodoro" TO anon;

GRANT ALL ON TABLE public."Pomodoro" TO authenticated;

GRANT ALL ON TABLE public."Pomodoro" TO postgres;

GRANT ALL ON TABLE public."Pomodoro" TO service_role;

COMMENT ON TABLE public."Pomodoro"
    IS 'Collection of Timers';

CREATE TABLE IF NOT EXISTS public."Timer"
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    created_at timestamp with time zone DEFAULT now(),
    length bigint DEFAULT '1500'::bigint,
    "pomodoroId" uuid,
    type "TimerType" DEFAULT 'FOCUS'::"TimerType",
    status "TimerStatus" DEFAULT 'ACTIVE'::"TimerStatus",
    CONSTRAINT "Timer_pkey" PRIMARY KEY (id),
    CONSTRAINT "Timer_pomodoroId_fkey" FOREIGN KEY ("pomodoroId")
        REFERENCES public."Pomodoro" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Timer"
    OWNER to postgres;

GRANT ALL ON TABLE public."Timer" TO anon;

GRANT ALL ON TABLE public."Timer" TO authenticated;

GRANT ALL ON TABLE public."Timer" TO postgres;

GRANT ALL ON TABLE public."Timer" TO service_role;

COMMENT ON TABLE public."Timer"
    IS 'A pomodor';

COMMENT ON COLUMN public."Timer".type
    IS 'Exercise or focus';

COMMENT ON COLUMN public."Timer".status
    IS 'ACTIVE or FINISHED';

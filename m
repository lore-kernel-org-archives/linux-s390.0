Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37163401A28
	for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537920; cv=pass; b=qXmV/9KP+XPEKcrcNXrTwmrHEzKah8eIMb7S6USf9BeZif680v+ypim4+nQPOZoe+1k4N6EU5ejNVh8wV4JOEHRP6K6IOQfc2VL9dVkPfVvRQj6kye1vuQecp3DBHBhL+9M75yVdEa97wwfazbz8WThVVDFEqDqgd+RgzOXk8Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537920; c=relaxed/simple;
	bh=cvapLnmHQEXt8+tYYBv2XdeGtW59V8SY6I7gJV89Xgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZGMUz50X8h3wYF5S9ToRTcOLTsZAKOPJ1mLyJQMi+94DqQM5B2cYOHJdWppsQs5aDCeD7oRoWT/eKm+1IzbLCPSZdJBByypf+PDoV+4IIYsf6CnlEQ1SBKtexkdMNVentue4dturayMR3Y7hX/4/LreMXYEItKz6ue4NVj9ZVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fIfyjoPs; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIfyjoPs"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-126ea4e9697so9430c88.1
        for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 08:11:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774537917; cv=none;
        d=google.com; s=arc-20240605;
        b=PrnVFKjw+nauCdwl+9GWmWPpnruIJU/bDA01PbZvYwD6twuwr889qKMqz4IReE2Guu
         rlx8k9q/e+/RxRTxz6E26V0uZTTzpPO1n1Gsk08EY83vY5JRWdtiDdbqOUvERl/ekQuY
         /ffDgHU67AY1hS8M7IYXmputXSQV8u/WakYUneV5x/2uHVq5svN215MxNddozauzd1lW
         EEE/avjZKQyqnkalWShXnJWdE4eAjdqK8VawYJ3eHq8m9/Ka9r7z8TWCO0DCQ1PkxnOu
         jOspURClpkqZH3+/GhTucNxuQwvOlExDeHYWwvrceYJ3YY/3EKdO8ygEgLhVW8K+R+6F
         4Bbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ilk6v7xPawRVXOD/wjlIWSWAURV1ipewvPaDHVmhMXI=;
        fh=rU67PUjxhJWqXnV0vtADe9HXf173PH2DBB0NteE30Wk=;
        b=jIVI51owlusoh/KZtqBdiJ9F2dhNeTqxIfLA+tL28RQ63BQILsLZIJMR+oLtVrd+LW
         k8fxrzykrvos0OPKAI4nwzjucs3rUDqULd7kDCvZAaEp8EbVf9SsHQimHkX7qBAl9gtz
         4z/95M0AFQUCuE4+OqBb5xKOhCGV76HERYlyA/VpEYNqXo5S/47wQ4f+u7GjDeJWdZRY
         EZZCHAN+8GZgqrbBM3XIXiX0oX6H5RK9ZDS/HgeUm6dw4zptIhw9MVQaTqcrc0J97m2Z
         WX3ChC10/souc4gq5TUbinmTNFXkY71iT85UT9Dm5rUYEQHUZxlFFo+tBDs/xq//KAI4
         iJGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774537917; x=1775142717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilk6v7xPawRVXOD/wjlIWSWAURV1ipewvPaDHVmhMXI=;
        b=fIfyjoPsjbe/S0hbucK7BFND9Uzsuw/TUz2cmx/lZHRoHebO1tBY0Rwx3m2y+jD+IV
         SXnYjr1cadu4sBQw1xqQhHOmCyQwZNQr5hWg18vcQISL57mlOIRMEtsUWdfLpyp5Mf5m
         40CdmuhMO/lPGDB1p/T8QD2+KnVNtLC9nZF5A7uHDJ31jn6RpcJT79W3ele7bc/voykT
         CmJSTL1xhsnXJSZgybOWiL6qvLy01aUeBotRO0AknrZEyaP1f+Z2LqbzybaT3PWlFqXU
         fxi2WESnscQZBA6pRw0ug4bMmClFqGBOrFu47Vpbg0XuG7ZFbZ9uooOWn4HZqCMknFbT
         g60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774537917; x=1775142717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ilk6v7xPawRVXOD/wjlIWSWAURV1ipewvPaDHVmhMXI=;
        b=K6Po0foWmJjfaoGS5GdOFNPtuOmX+J09DeHvs6LUhMe0u7TfjWYU5a3qNTub06qqET
         1Wr0QrUoPKE6HcPmjo+mHFxHKePZfqs/NIusrM9rAvKuUqUviqGRjt9cjK7jMGMUimFw
         +YgyBZn5tfpWZz7JoHWaGN7s7yaiII0FcxGdP3vMsyEl9h6qUpelZ2YI6ikUvIQdUlc8
         MauhG+0GYIm2BnsRcH46INOb6Qa7Ta7Qz76KBJ2azjmdJgqPUZxXFH9JvOsJLJHxru8J
         YuiDOdqRjilYQxn62GxsMwuJjAzCaMEyvAS2KxXOkTS1R/kL11h3+uTGxgWC9Mz5BGr8
         8qqw==
X-Forwarded-Encrypted: i=1; AJvYcCW4jMouifbOlfmnX0Ec7WUdRLU7xyVUO6cDRYl7VddmPM7TmceSqMJebU7KYXnpF0PP0XAN0C49bou5@vger.kernel.org
X-Gm-Message-State: AOJu0YwdYTcrMECwFkhFzf1LAQo7cAceL32QWRtSGIPI3d0rOWflwLgr
	T8WateO93XWFFhn0KRt6iJdcsuK6+bODlkLoLKD2MUnq7IL6m5v/0q6mAEzkaHyM6ju/2Ng1O40
	Ma6EuxTewv6ykcIChn8nehGXaZ1D9/DElkiSisOfP
X-Gm-Gg: ATEYQzxfOTaIENYBDAl75voONdKLQ8PyLO2l00DPyoF9H4SOo+oX4d987blkDAo8HK1
	5h2ScJhpM5QW3HcEDvJZX4qQQ8nd48ESQ4sk765eTm3ZjEUI3zWNcfrDR/nlASiQEb5l7AO2Efm
	B9Lm5lrCFTqnmLoESrpHuNmVyYMxAipPg01rtW0nQTxSSBpLcOD0sTTQpg4gTKx7P60+OsOxsn9
	B9fcCT0ESXqJJyCC3hp+CBQ/ye3igCJSxXiaZo/I/9kHzH5v77V9O6CMjxhxtjHiO1Cu48dVcJH
	zQV05nB/0J/MUrq43lOFg31KNaMvOt9SPF4slA==
X-Received: by 2002:a05:7022:670a:b0:12a:6ca2:3085 with SMTP id
 a92af1059eb24-12aa93db293mr162007c88.18.1774537916537; Thu, 26 Mar 2026
 08:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302234343.564937-1-irogers@google.com> <20260325161836.1029457-1-irogers@google.com>
 <c9b522c0-09ce-47c4-a377-1a46ae84e609@126.com>
In-Reply-To: <c9b522c0-09ce-47c4-a377-1a46ae84e609@126.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Mar 2026 08:11:43 -0700
X-Gm-Features: AQROBzBDQYCHdWLyMMIZm-zdmCOgWRHxLZtFirFW5XIXrpNY6Wtk20V-gmUUcas
Message-ID: <CAP-5=fVJVc8uvPssSnUyTdO9PSbKy9qb0PrrE7VLUurwTa6MpQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf symbol: Lazily compute idle and use the perf_env
To: Honglei Wang <jameshongleiwang@126.com>
Cc: acme@kernel.org, namhyung@kernel.org, tmricht@linux.ibm.com, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 12:20=E2=80=AFAM Honglei Wang <jameshongleiwang@126=
.com> wrote:
>
> Hi Ian,
>
> On 3/26/26 12:18 AM, Ian Rogers wrote:
> > Move the idle boolean to a helper symbol__is_idle function. In the
> > function lazily compute whether a symbol is an idle function taking
> > into consideration the kernel version and architecture of the
> > machine. As symbols__insert no longer needs to know if a symbol is for
> > the kernel, remove the argument.
> >
> > This change is inspired by mailing list discussion, particularly from
> > Thomas Richter <tmricht@linux.ibm.com> and Heiko Carstens
> > <hca@linux.ibm.com>:
> > https://lore.kernel.org/lkml/20260219113850.354271-1-tmricht@linux.ibm.=
com/
> >
> > The change switches x86 matches to use strstarts which means
> > intel_idle_irq is matched as part of strstarts(name, "intel_idle"), a
> > change suggested by Honglei Wang <jameshongleiwang@126.com> in:
> > https://lore.kernel.org/lkml/20260323085255.98173-1-jameshongleiwang@12=
6.com/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > v1: https://lore.kernel.org/lkml/20260302234343.564937-1-irogers@google=
.com/
> > ---
> >  tools/perf/builtin-top.c     |   6 +-
> >  tools/perf/util/symbol-elf.c |   2 +-
> >  tools/perf/util/symbol.c     | 105 ++++++++++++++++++++++-------------
> >  tools/perf/util/symbol.h     |  15 +++--
> >  4 files changed, 84 insertions(+), 44 deletions(-)
> >
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index 37950efb28ac..bdc1c761cd61 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -751,6 +751,7 @@ static void perf_event__process_sample(const struct=
 perf_tool *tool,
> >  {
> >       struct perf_top *top =3D container_of(tool, struct perf_top, tool=
);
> >       struct addr_location al;
> > +     struct dso *dso =3D NULL;
> >
> >       if (!machine && perf_guest) {
> >               static struct intlist *seen;
> > @@ -830,7 +831,10 @@ static void perf_event__process_sample(const struc=
t perf_tool *tool,
> >               }
> >       }
> >
> > -     if (al.sym =3D=3D NULL || !al.sym->idle) {
> > +     if (al.map)
> > +             dso =3D map__dso(al.map);
> > +
> > +     if (al.sym =3D=3D NULL || !symbol__is_idle(al.sym, dso, machine->=
env)) {
> >               struct hists *hists =3D evsel__hists(evsel);
> >               struct hist_entry_iter iter =3D {
> >                       .evsel          =3D evsel,
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.=
c
> > index 3cd4e5a03cc5..9fabf5146d89 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -1723,7 +1723,7 @@ dso__load_sym_internal(struct dso *dso, struct ma=
p *map, struct symsrc *syms_ss,
> >
> >               arch__sym_update(f, &sym);
> >
> > -             __symbols__insert(dso__symbols(curr_dso), f, dso__kernel(=
dso));
> > +             __symbols__insert(dso__symbols(curr_dso), f);
> >               nr++;
> >       }
> >       dso__put(curr_dso);
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index ce9195717f44..1a357af93a0a 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -25,6 +25,8 @@
> >  #include "demangle-ocaml.h"
> >  #include "demangle-rust-v0.h"
> >  #include "dso.h"
> > +#include "dwarf-regs.h"
> > +#include "env.h"
> >  #include "util.h" // lsdir()
> >  #include "event.h"
> >  #include "machine.h"
> > @@ -50,7 +52,6 @@
> >
> >  static int dso__load_kernel_sym(struct dso *dso, struct map *map);
> >  static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map=
);
> > -static bool symbol__is_idle(const char *name);
> >
> >  int vmlinux_path__nr_entries;
> >  char **vmlinux_path;
> > @@ -357,8 +358,7 @@ void symbols__delete(struct rb_root_cached *symbols=
)
> >       }
> >  }
> >
> > -void __symbols__insert(struct rb_root_cached *symbols,
> > -                    struct symbol *sym, bool kernel)
> > +void __symbols__insert(struct rb_root_cached *symbols, struct symbol *=
sym)
> >  {
> >       struct rb_node **p =3D &symbols->rb_root.rb_node;
> >       struct rb_node *parent =3D NULL;
> > @@ -366,17 +366,6 @@ void __symbols__insert(struct rb_root_cached *symb=
ols,
> >       struct symbol *s;
> >       bool leftmost =3D true;
> >
> > -     if (kernel) {
> > -             const char *name =3D sym->name;
> > -             /*
> > -              * ppc64 uses function descriptors and appends a '.' to t=
he
> > -              * start of every instruction address. Remove it.
> > -              */
> > -             if (name[0] =3D=3D '.')
> > -                     name++;
> > -             sym->idle =3D symbol__is_idle(name);
> > -     }
> > -
> >       while (*p !=3D NULL) {
> >               parent =3D *p;
> >               s =3D rb_entry(parent, struct symbol, rb_node);
> > @@ -393,7 +382,7 @@ void __symbols__insert(struct rb_root_cached *symbo=
ls,
> >
> >  void symbols__insert(struct rb_root_cached *symbols, struct symbol *sy=
m)
> >  {
> > -     __symbols__insert(symbols, sym, false);
> > +     __symbols__insert(symbols, sym);
> >  }
> >
> >  static struct symbol *symbols__find(struct rb_root_cached *symbols, u6=
4 ip)
> > @@ -554,7 +543,7 @@ void dso__reset_find_symbol_cache(struct dso *dso)
> >
> >  void dso__insert_symbol(struct dso *dso, struct symbol *sym)
> >  {
> > -     __symbols__insert(dso__symbols(dso), sym, dso__kernel(dso));
> > +     __symbols__insert(dso__symbols(dso), sym);
> >
> >       /* update the symbol cache if necessary */
> >       if (dso__last_find_result_addr(dso) >=3D sym->start &&
> > @@ -716,47 +705,87 @@ int modules__parse(const char *filename, void *ar=
g,
> >       return err;
> >  }
> >
> > +static int sym_name_cmp(const void *a, const void *b)
> > +{
> > +     const char *name =3D a;
> > +     const char *const *sym =3D b;
> > +
> > +     return strcmp(name, *sym);
> > +}
> > +
> >  /*
> >   * These are symbols in the kernel image, so make sure that
> >   * sym is from a kernel DSO.
> >   */
> > -static bool symbol__is_idle(const char *name)
> > +bool symbol__is_idle(struct symbol *sym, const struct dso *dso, const =
struct perf_env *env)
> >  {
> > -     const char * const idle_symbols[] =3D {
> > +     static const char * const idle_symbols[] =3D {
> >               "acpi_idle_do_entry",
> >               "acpi_processor_ffh_cstate_enter",
> >               "arch_cpu_idle",
> >               "cpu_idle",
> >               "cpu_startup_entry",
> > -             "idle_cpu",
> > -             "intel_idle",
> > -             "intel_idle_ibrs",
> >               "default_idle",
> > -             "native_safe_halt",
> >               "enter_idle",
> >               "exit_idle",
> > -             "mwait_idle",
> > -             "mwait_idle_with_hints",
> > -             "mwait_idle_with_hints.constprop.0",
> > +             "idle_cpu",
> > +             "native_safe_halt",
> >               "poll_idle",
> > -             "ppc64_runlatch_off",
> >               "pseries_dedicated_idle_sleep",
> > -             "psw_idle",
> > -             "psw_idle_exit",
> > -             NULL
> >       };
> > -     int i;
> > -     static struct strlist *idle_symbols_list;
> > +     const char *name =3D sym->name;
> > +     uint16_t e_machine =3D env ? env->e_machine : EM_HOST;
> >
> > -     if (idle_symbols_list)
> > -             return strlist__has_entry(idle_symbols_list, name);
> > +     if (sym->idle)
> > +             return sym->idle =3D=3D SYMBOL_IDLE__IDLE;
> >
> > -     idle_symbols_list =3D strlist__new(NULL, NULL);
> > +     if (!dso || dso__kernel(dso) =3D=3D DSO_SPACE__USER) {
> > +             sym->idle =3D SYMBOL_IDLE__NOT_IDLE;
> > +             return false;
> > +     }
> >
> > -     for (i =3D 0; idle_symbols[i]; i++)
> > -             strlist__add(idle_symbols_list, idle_symbols[i]);
> > +     /*
> > +      * ppc64 uses function descriptors and appends a '.' to the
> > +      * start of every instruction address. Remove it.
> > +      */
> > +     if (name[0] =3D=3D '.')
> > +             name++;
> >
> > -     return strlist__has_entry(idle_symbols_list, name);
> > +     if (bsearch(name, idle_symbols, ARRAY_SIZE(idle_symbols),
> > +                 sizeof(idle_symbols[0]), sym_name_cmp)) {
> > +             sym->idle =3D SYMBOL_IDLE__IDLE;
> > +             return true;
> > +     }
> > +
> > +     if (e_machine =3D=3D EM_386 || e_machine =3D=3D EM_X86_64) {
>
> As said in anther thread, intel_idle_irq was still there on my test
> machine. I did a bit debug and found e_machine =3D=3D 0 so it couldn't ru=
n
> into this branch. After dig more, it should be
> deliver_event()->perf_session__find_machine() return a struct machine
> whose env->e_machine is 0. I'm still busy today to do more, wish this
> clue can help.

I can see this, the env's e_machine isn't being lazily initialized for
the host like the arch is. I'll add a patch for this.

Thanks,
Ian

> Thanks,
> Honglei
>
> > +             if (strstarts(name, "mwait_idle") ||
> > +                 strstarts(name, "intel_idle")) {
> > +                     sym->idle =3D SYMBOL_IDLE__IDLE;
> > +                     return true;
> > +             }
> > +     }
> > +
> > +     if (e_machine =3D=3D EM_PPC64 && !strcmp(name, "ppc64_runlatch_of=
f")) {
> > +             sym->idle =3D SYMBOL_IDLE__IDLE;
> > +             return true;
> > +     }
> > +
> > +     if (e_machine =3D=3D EM_S390) {
> > +             int major =3D 0, minor =3D 0;
> > +             const char *release =3D env && env->os_release
> > +                     ? env->os_release : perf_version_string;
> > +
> > +             sscanf(release, "%d.%d", &major, &minor);
> > +
> > +             /* Before v6.10, s390 used psw_idle. */
> > +             if ((major < 6 || (major =3D=3D 6 && minor < 10)) && strs=
tarts(name, "psw_idle")) {
> > +                     sym->idle =3D SYMBOL_IDLE__IDLE;
> > +                     return true;
> > +             }
> > +     }
> > +
> > +     sym->idle =3D SYMBOL_IDLE__NOT_IDLE;
> > +     return false;
> >  }
> >
> >  static int map__process_kallsym_symbol(void *arg, const char *name,
> > @@ -785,7 +814,7 @@ static int map__process_kallsym_symbol(void *arg, c=
onst char *name,
> >        * We will pass the symbols to the filter later, in
> >        * map__split_kallsyms, when we have split the maps per module
> >        */
> > -     __symbols__insert(root, sym, !strchr(name, '['));
> > +     __symbols__insert(root, sym);
> >
> >       return 0;
> >  }
> > diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> > index c67814d6d6d6..f26f67bd7982 100644
> > --- a/tools/perf/util/symbol.h
> > +++ b/tools/perf/util/symbol.h
> > @@ -25,6 +25,7 @@ struct dso;
> >  struct map;
> >  struct maps;
> >  struct option;
> > +struct perf_env;
> >  struct build_id;
> >
> >  /*
> > @@ -42,6 +43,12 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep=
,
> >                            GElf_Shdr *shp, const char *name, size_t *id=
x);
> >  #endif
> >
> > +enum symbol_idle_kind {
> > +     SYMBOL_IDLE__UNKNOWN =3D 0,
> > +     SYMBOL_IDLE__NOT_IDLE =3D 1,
> > +     SYMBOL_IDLE__IDLE =3D 2,
> > +};
> > +
> >  /**
> >   * A symtab entry. When allocated this may be preceded by an annotatio=
n (see
> >   * symbol__annotation) and/or a browser_index (see symbol__browser_ind=
ex).
> > @@ -57,8 +64,8 @@ struct symbol {
> >       u8              type:4;
> >       /** ELF binding type as defined for st_info. E.g. STB_WEAK or STB=
_GLOBAL. */
> >       u8              binding:4;
> > -     /** Set true for kernel symbols of idle routines. */
> > -     u8              idle:1;
> > +     /** Cache for symbol__is_idle. */
> > +     enum symbol_idle_kind idle:2;
> >       /** Resolvable but tools ignore it (e.g. idle routines). */
> >       u8              ignore:1;
> >       /** Symbol for an inlined function. */
> > @@ -202,8 +209,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, st=
ruct symsrc *ss);
> >
> >  char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_=
name);
> >
> > -void __symbols__insert(struct rb_root_cached *symbols, struct symbol *=
sym,
> > -                    bool kernel);
> > +void __symbols__insert(struct rb_root_cached *symbols, struct symbol *=
sym);
> >  void symbols__insert(struct rb_root_cached *symbols, struct symbol *sy=
m);
> >  void symbols__fixup_duplicate(struct rb_root_cached *symbols);
> >  void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsy=
ms);
> > @@ -286,5 +292,6 @@ enum {
> >  };
> >
> >  int symbol__validate_sym_arguments(void);
> > +bool symbol__is_idle(struct symbol *sym, const struct dso *dso, const =
struct perf_env *env);
> >
> >  #endif /* __PERF_SYMBOL */
>

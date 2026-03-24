Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D23F0AB5
	for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2026 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372461; cv=pass; b=Bpn1IsYkdXdIDCfJKKL2sS6c6vdy+3uIo7hP28RzKRat/VFkCThCMXR7/etHPQs49za82TqUNRCgZxbHKpzDrgybZ0gjPuvOFjrQt9TovjXefwsyyzdD4hRad7p9VyfIBcXTwDDKBjDrspxqLTcXj9q5KYUW+hCsa2OFvZZjnJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372461; c=relaxed/simple;
	bh=TPMZ0guEsDu1fBmTTSOoikqO5QOdog97pNpUt2KoWpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqgahBU0PzousKA2Gcx6BfQqUFOZKN9t72Dnm/i0MTrHF+5AABqaQdbY6OPUzXsDIn0Ss9KUP5GAbp+fhj3FfcR6D22LucXmRcePi6I6l+nkQ5qKiBUjWhIVfPn1si2CWI2kATa98m4MFkHAyhSHmDs/AjZ33ynvfje88VpE+98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AIhaGq2n; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AIhaGq2n"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-126ea4e9697so544c88.1
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2026 10:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774372457; cv=none;
        d=google.com; s=arc-20240605;
        b=avLiL2rbQv5FkcaXHTGOtWRe7hyPJ4vWznmWFrlID5AtVuR600NW8+fO4QXORivFdt
         SCLtakv//XYt8vjcrYQBXr5F3rjdk9H35/x7pFxPqB97nMMZ8xThSofn5RgVrUa/4Wf1
         c5WDsgU/uf1NSmNsREhFnfQnnij/hLdTcPni1XdzYYos6c587jer7Tx1p/AZ7XEnULt5
         ZMspPAOEb/aVTixh4IvbN2kc9yB1OiBoZX1zHHXjpPN07RXcjp95y55vM7kHUq768s9o
         o5PA7Kzn1OnjzNJu+PIRr2nLx6Wbl3c0x0Q3rDsKDAt3zAf5JDkYrsOapwbr8gIfMN1m
         YWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y6UGHkZW2dwA/OaJX502PqCak29ZGkb8gxJ7v1DAxKA=;
        fh=/trMyo25q143QKGQvoY9Tu/0Kcrz8ltoKZLpsyImuok=;
        b=gNOlysDrC+7s+gypnqtUT6ppf5gBKWpowa/xWFCyEEet1Jo1t2ROBEh3gGBa9WM4EE
         ei5x91XDknsWk28vvnLMKHXKFA/yT84XZu4556AIbD+OEMmqo8Y26STOROa49IT8DfGr
         vbt6BL4Oo1z3N84fZIDQtgbWBldkZ73cCflU4sCH67iSWaStZlhfS61a44kwAx37bzuY
         E7EmOShJdkNRXWLhTbxOBEftMNkFuO3UbUydK5eGM1XwBx2NqtthYIdIVCXotIWQNGTi
         r+fxx/JzfyrUFHdH+f/MooDzvizpmKWt5jacnPw1cHBBBjCiDnAH7iIQkAvXmMNT6TAZ
         lhPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774372457; x=1774977257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6UGHkZW2dwA/OaJX502PqCak29ZGkb8gxJ7v1DAxKA=;
        b=AIhaGq2nd0xG4K1VSbakXExVV7oqzmcCO747U6DuJvF0PIDGgGpY4WguaQh7+hLKcq
         zTXWYTor6zNkB6MiPmFIE1MEEpU08EgEG20myA5CUr6jPGSgx1x3TQZomUjFQc8LD4S/
         z0Niuur7xVDYQ0GdloSTdvWm2zm4DznJAWrNy9v5uUgXQOnxL6d041NF7I8EsthqWn7Y
         xojZTHEvv3v6RkbTpat3Xs+X3xjJGTuNn6fX9mg4JigAV8oXEAjjm+VSoj65tcSmWW+y
         wRHZ1lvHeVHiiHAEfljX51y+MMDK+Or9ej3w4GBa44rU2SMVtkMEs+j3mPcagQfMtiSo
         VwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774372457; x=1774977257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y6UGHkZW2dwA/OaJX502PqCak29ZGkb8gxJ7v1DAxKA=;
        b=OrISqHGseymLrDBJjOQGYv6AAlTyfSsC158nJ1BusaJjkfyVqIvk6Qc+sLD316Kfvl
         AhIr/z3dmtpcM+M85jGuQjAJZVG1msNAiDsIo7f36YKdJgXukrFXjQAJV2b1KEJzTRpn
         6V+vAHpquthO2QjzVGYm/QcJQGhbWTNJzuxA8Edrh8VNrTugSiu3SOTiljFoHqrvi0bo
         v67cMDWFRODEzcKkttdGZree2txSbP1aPPKp2h3OFUhrVzAWplAxeoyc5Tat+PgUOLES
         wg/MjhSwodwBMejs8uaGu4lexz9wEB1cGZlhTq6ad0IZbfua7QOCE3s9m+MfbGno04s0
         UT0g==
X-Forwarded-Encrypted: i=1; AJvYcCV0rSDVkqgjacrLr+BdudsIjmaQ1UhxoJTx67/+6lTy3NfvFNxBpcsemDKv49wNHLh35rDMqigDwOXZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxlW7vUDmk+od9Fy1/ivdTQdXhgZbUxqJULbCN5sqCA7nkmHxV6
	gqilXjVSlPaSUe/93QngTksZOF22PXhHFDZFBzDKKTThJOVOl3BedzqBdO/nLbSCHNkIpDmAR0l
	QwowekMHtKTntUhTWobEpljO4iPen5hii9H35Fjl7kGhr2aBHcHCeJK+FH4A=
X-Gm-Gg: ATEYQzyp5MeaMQV8PvQg6dhOJTiYCywbaFRZeVi1RpUrP6OSIb403A2KrMEow5tsD/r
	w19GCIZZW5c6787qDLR4uCjv0LTDFmh6aquuHn2GLibwUXoiUUmJ0o7YKAyxL0iys64Lzu0bDhI
	P3292r+XWR+je1ZPUt1c+joNAf9pWVoTxO8t8IoH/w7jaQSkU5KP67ra7F1pjhUPUtf4lFN8RHK
	AANHO50AilW0K8g3B8Av7S1GcE19+kTCxDXm9Dw825U+Pwu4l3nFPTwbx2l+n0N0v/Tgtz0VqXz
	q8vosW3VBHSLCkNNcNw68VKbDBaLWPjzWcC8ZrIVW5glAQ8n
X-Received: by 2002:a05:7022:322:b0:119:e55a:8087 with SMTP id
 a92af1059eb24-12a9744d747mr7659c88.4.1774372456710; Tue, 24 Mar 2026 10:14:16
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219113850.354271-1-tmricht@linux.ibm.com> <20260302234343.564937-1-irogers@google.com>
In-Reply-To: <20260302234343.564937-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Mar 2026 10:14:01 -0700
X-Gm-Features: AQROBzDcW54RPb4VzSi-SKKYsdcX2A1amDUpzQmAXOKavUNK1r1w-Rf11LVK0Nw
Message-ID: <CAP-5=fW0Bu2313nAuhur+wP5Y2JtBNY+wpPoiKLqNzcSe-R3gA@mail.gmail.com>
Subject: Re: [PATCH v1] perf symbol: Lazily compute idle and use the perf_env
To: tmricht@linux.ibm.com, namhyung@kernel.org, acme@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 3:43=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Move the idle boolean to a helper symbol__is_idle function. In the
> function lazily compute whether a symbol is an idle function taking
> into consideration the kernel version and architecture of the
> machine. As symbols__insert no longer needs to know if a symbol is for
> the kernel, remove the argument.
>
> This change is inspired by mailing list discussion, particularly from
> Thomas Richter <tmricht@linux.ibm.com> and Heiko Carstens
> <hca@linux.ibm.com>:
> https://lore.kernel.org/lkml/20260219113850.354271-1-tmricht@linux.ibm.co=
m/
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/builtin-top.c     |   6 +-
>  tools/perf/util/symbol-elf.c |   2 +-
>  tools/perf/util/symbol.c     | 106 ++++++++++++++++++++++-------------
>  tools/perf/util/symbol.h     |  15 +++--
>  4 files changed, 85 insertions(+), 44 deletions(-)
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 710604c4f6f6..bc3c8e3b6ec0 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -750,6 +750,7 @@ static void perf_event__process_sample(const struct p=
erf_tool *tool,
>  {
>         struct perf_top *top =3D container_of(tool, struct perf_top, tool=
);
>         struct addr_location al;
> +       struct dso *dso =3D NULL;
>
>         if (!machine && perf_guest) {
>                 static struct intlist *seen;
> @@ -829,7 +830,10 @@ static void perf_event__process_sample(const struct =
perf_tool *tool,
>                 }
>         }
>
> -       if (al.sym =3D=3D NULL || !al.sym->idle) {
> +       if (al.map)
> +               dso =3D map__dso(al.map);
> +
> +       if (al.sym =3D=3D NULL || !symbol__is_idle(al.sym, dso, machine->=
env)) {
>                 struct hists *hists =3D evsel__hists(evsel);
>                 struct hist_entry_iter iter =3D {
>                         .evsel          =3D evsel,
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 76912c62b6a0..6bb46384aa0c 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1725,7 +1725,7 @@ dso__load_sym_internal(struct dso *dso, struct map =
*map, struct symsrc *syms_ss,
>
>                 arch__sym_update(f, &sym);
>
> -               __symbols__insert(dso__symbols(curr_dso), f, dso__kernel(=
dso));
> +               __symbols__insert(dso__symbols(curr_dso), f);
>                 nr++;
>         }
>         dso__put(curr_dso);
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 8662001e1e25..6155f509ca70 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -25,6 +25,8 @@
>  #include "demangle-ocaml.h"
>  #include "demangle-rust-v0.h"
>  #include "dso.h"
> +#include "dwarf-regs.h"
> +#include "env.h"
>  #include "util.h" // lsdir()
>  #include "debug.h"
>  #include "event.h"
> @@ -51,7 +53,6 @@
>
>  static int dso__load_kernel_sym(struct dso *dso, struct map *map);
>  static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
> -static bool symbol__is_idle(const char *name);
>
>  int vmlinux_path__nr_entries;
>  char **vmlinux_path;
> @@ -357,8 +358,7 @@ void symbols__delete(struct rb_root_cached *symbols)
>         }
>  }
>
> -void __symbols__insert(struct rb_root_cached *symbols,
> -                      struct symbol *sym, bool kernel)
> +void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sy=
m)
>  {
>         struct rb_node **p =3D &symbols->rb_root.rb_node;
>         struct rb_node *parent =3D NULL;
> @@ -366,17 +366,6 @@ void __symbols__insert(struct rb_root_cached *symbol=
s,
>         struct symbol *s;
>         bool leftmost =3D true;
>
> -       if (kernel) {
> -               const char *name =3D sym->name;
> -               /*
> -                * ppc64 uses function descriptors and appends a '.' to t=
he
> -                * start of every instruction address. Remove it.
> -                */
> -               if (name[0] =3D=3D '.')
> -                       name++;
> -               sym->idle =3D symbol__is_idle(name);
> -       }
> -
>         while (*p !=3D NULL) {
>                 parent =3D *p;
>                 s =3D rb_entry(parent, struct symbol, rb_node);
> @@ -393,7 +382,7 @@ void __symbols__insert(struct rb_root_cached *symbols=
,
>
>  void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
>  {
> -       __symbols__insert(symbols, sym, false);
> +       __symbols__insert(symbols, sym);
>  }
>
>  static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 =
ip)
> @@ -554,7 +543,7 @@ void dso__reset_find_symbol_cache(struct dso *dso)
>
>  void dso__insert_symbol(struct dso *dso, struct symbol *sym)
>  {
> -       __symbols__insert(dso__symbols(dso), sym, dso__kernel(dso));
> +       __symbols__insert(dso__symbols(dso), sym);
>
>         /* update the symbol cache if necessary */
>         if (dso__last_find_result_addr(dso) >=3D sym->start &&
> @@ -716,47 +705,88 @@ int modules__parse(const char *filename, void *arg,
>         return err;
>  }
>
> +static int sym_name_cmp(const void *a, const void *b)
> +{
> +       const char *name =3D a;
> +       const char *const *sym =3D b;
> +
> +       return strcmp(name, *sym);
> +}
> +
>  /*
>   * These are symbols in the kernel image, so make sure that
>   * sym is from a kernel DSO.
>   */
> -static bool symbol__is_idle(const char *name)
> +bool symbol__is_idle(struct symbol *sym, const struct dso *dso, const st=
ruct perf_env *env)
>  {
> -       const char * const idle_symbols[] =3D {
> +       static const char * const idle_symbols[] =3D {
>                 "acpi_idle_do_entry",
>                 "acpi_processor_ffh_cstate_enter",
>                 "arch_cpu_idle",
>                 "cpu_idle",
>                 "cpu_startup_entry",
> -               "idle_cpu",
> -               "intel_idle",
> -               "intel_idle_ibrs",
>                 "default_idle",
> -               "native_safe_halt",
>                 "enter_idle",
>                 "exit_idle",
> -               "mwait_idle",
> -               "mwait_idle_with_hints",
> -               "mwait_idle_with_hints.constprop.0",
> +               "idle_cpu",
> +               "native_safe_halt",
>                 "poll_idle",
> -               "ppc64_runlatch_off",
>                 "pseries_dedicated_idle_sleep",
> -               "psw_idle",
> -               "psw_idle_exit",
> -               NULL
>         };
> -       int i;
> -       static struct strlist *idle_symbols_list;
> +       const char *name =3D sym->name;
> +       uint16_t e_machine =3D env ? env->e_machine : EM_HOST;
> +
> +       if (sym->idle)
> +               return sym->idle =3D=3D SYMBOL_IDLE__IDLE;
> +
> +       if (!dso || dso__kernel(dso) =3D=3D DSO_SPACE__USER) {
> +               sym->idle =3D SYMBOL_IDLE__NOT_IDLE;
> +               return false;
> +       }
>
> -       if (idle_symbols_list)
> -               return strlist__has_entry(idle_symbols_list, name);
> +       /*
> +        * ppc64 uses function descriptors and appends a '.' to the
> +        * start of every instruction address. Remove it.
> +        */
> +       if (name[0] =3D=3D '.')
> +               name++;
> +
> +
> +       if (bsearch(name, idle_symbols, ARRAY_SIZE(idle_symbols),
> +                   sizeof(idle_symbols[0]), sym_name_cmp)) {
> +               sym->idle =3D SYMBOL_IDLE__IDLE;
> +               return true;
> +       }
> +
> +       if (e_machine =3D=3D EM_386 || e_machine =3D=3D EM_X86_64) {
> +               if (strstarts(name, "mwait_idle") ||
> +                   strstarts(name, "intel_idle")) {
> +                       sym->idle =3D SYMBOL_IDLE__IDLE;
> +                       return true;
> +               }
> +       }
> +
> +       if (e_machine =3D=3D EM_PPC64 &&!strcmp(name, "ppc64_runlatch_off=
")) {
> +               sym->idle =3D SYMBOL_IDLE__IDLE;
> +               return true;
> +       }
>
> -       idle_symbols_list =3D strlist__new(NULL, NULL);
> +       if (e_machine =3D=3D EM_S390) {
> +               int major =3D 0, minor =3D 0;
> +               const char *release =3D env && env->os_release
> +                       ? env->os_release : perf_version_string;
>
> -       for (i =3D 0; idle_symbols[i]; i++)
> -               strlist__add(idle_symbols_list, idle_symbols[i]);
> +               sscanf(release, "%d.%d", &major, &minor);
>
> -       return strlist__has_entry(idle_symbols_list, name);
> +               /* Before v6.10, s390 used psw_idle. */
> +               if ((major < 6 || (major =3D=3D 6 && minor < 10)) && strs=
tarts(name, "psw_idle")) {
> +                       sym->idle =3D SYMBOL_IDLE__IDLE;
> +                       return true;
> +               }
> +       }
> +
> +       sym->idle =3D SYMBOL_IDLE__NOT_IDLE;
> +       return false;
>  }
>
>  static int map__process_kallsym_symbol(void *arg, const char *name,
> @@ -785,7 +815,7 @@ static int map__process_kallsym_symbol(void *arg, con=
st char *name,
>          * We will pass the symbols to the filter later, in
>          * map__split_kallsyms, when we have split the maps per module
>          */
> -       __symbols__insert(root, sym, !strchr(name, '['));
> +       __symbols__insert(root, sym);
>
>         return 0;
>  }
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 3fb5d146d9b1..508dd9f336e9 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -24,6 +24,7 @@ struct dso;
>  struct map;
>  struct maps;
>  struct option;
> +struct perf_env;
>  struct build_id;
>
>  /*
> @@ -41,6 +42,12 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
>                              GElf_Shdr *shp, const char *name, size_t *id=
x);
>  #endif
>
> +enum symbol_idle_kind {
> +       SYMBOL_IDLE__UNKNOWN =3D 0,
> +       SYMBOL_IDLE__NOT_IDLE =3D 1,
> +       SYMBOL_IDLE__IDLE =3D 2,
> +};
> +
>  /**
>   * A symtab entry. When allocated this may be preceded by an annotation =
(see
>   * symbol__annotation) and/or a browser_index (see symbol__browser_index=
).
> @@ -56,8 +63,8 @@ struct symbol {
>         u8              type:4;
>         /** ELF binding type as defined for st_info. E.g. STB_WEAK or STB=
_GLOBAL. */
>         u8              binding:4;
> -       /** Set true for kernel symbols of idle routines. */
> -       u8              idle:1;
> +       /** Cache for symbol__is_idle. */
> +       enum symbol_idle_kind idle:2;
>         /** Resolvable but tools ignore it (e.g. idle routines). */
>         u8              ignore:1;
>         /** Symbol for an inlined function. */
> @@ -184,8 +191,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, stru=
ct symsrc *ss);
>
>  char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_na=
me);
>
> -void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sy=
m,
> -                      bool kernel);
> +void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sy=
m);
>  void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)=
;
>  void symbols__fixup_duplicate(struct rb_root_cached *symbols);
>  void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms=
);
> @@ -269,5 +275,6 @@ enum {
>  };
>
>  int symbol__validate_sym_arguments(void);
> +bool symbol__is_idle(struct symbol *sym, const struct dso *dso, const st=
ruct perf_env *env);
>
>  #endif /* __PERF_SYMBOL */
> --
> 2.53.0.473.g4a7958ca14-goog
>

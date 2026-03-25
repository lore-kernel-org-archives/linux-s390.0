Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA53E868D
	for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2026 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454301; cv=pass; b=WZN6dNPfSKur+VqNRF0xl+zYcITrKvuabvTev0Wp6MgDB+8YtM8AO/5esi4RQ4bVKyBnnkodSLo0KiS7wp+wWGgu3RdukhkBi8mL8RIPq21C5dCtkKyK8nqeiBFVeNLOL2ZRJ1eq4yNup+0C2/fUHZB+82K4FbtZD/8KgkYNZ/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454301; c=relaxed/simple;
	bh=31v6dVcQjc/pLZxpJdzPz04ZotyuRNXgR5C/JrvThjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxuVEZdi5pn1mHxYNg7Gv1WMNQY+E39XyZdgDMsTyNL8zk7J7j2QTr278BVSjQNoaz5oRNRFktfBBXfOisEkTUO8K+v/LLUw8/lSbcv3CPanirNt6lF49E298jlbtuc7xhfCyWYVpQKRCmDUMcRWgNdeF0YF6jr5a+cUmWtqXns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l0XaCJwk; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0XaCJwk"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aeab6ff148so88905ad.1
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2026 08:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774454298; cv=none;
        d=google.com; s=arc-20240605;
        b=Qtih6RXVOBZYHD6TphZ2ki9Q6X8SPEcjN9CyN4T5AybqbRVsnWR2mgbXRnTTBnJlMA
         lSxlOzUjeGOjgTZ17WuEgZdwVjjTvJxSNz5Y43eUBqJg/7C+8k9XipLaAKQT51+/O/Au
         XtS4Fc2dx58vhJJJ0rhSAZPsym0B4kWIWsKCG7c6X12otvCgPFgzgB8AYjniOXTULgPY
         s7/OoLUN6FBbvgCFWOBt8Rmpk1GzElIRj46HM/Oas+Yo4+7c02NShP+/jud0puA2owji
         bpgoPTFVNV/bBiFKiYYZHSecBsoZHRmBDpvnb6zCQ/K9sNAw6tx3g8XMk46l5ANN8F9i
         Qh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4NlapPe71gz9z0qpcpgNNnFPRNCo/H/SsEHbnVcdX28=;
        fh=wvNFN40Pcg+wgiyXK9QX7WjjrRHwRsUQPKRUNUtbb8A=;
        b=kKpQ/Bcu0IoZfT1/Q/slVpXEPqaes38iqlxq3CYPiz0I2XyRU4rkIYD2nm6vTspoEv
         ADIyBEtVohLAhtsPyqCefhqWD4lwuXwNAje95cMtm64HPQewVo8n5PCSCd+HWBMWTKua
         MEo/i3yZ/DyeeiOgOtzcDH4P9szX4pQeORFravFpBePaSQ21Si/8KyoeaitzmOPRzJmc
         Sbd5sWN8wyucAkPfGleNhHGg7C97wjyp/bCXNhqwY3FeMocBugp11f0Q+h2nKppEKWhx
         TB9MztM4hDlpKXuzp3ZrKlmPUIkr+FLi+FeO4aYa5IGkL+Dqn4QtXDZ/MTIrTuKJ8WNU
         QCsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774454298; x=1775059098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NlapPe71gz9z0qpcpgNNnFPRNCo/H/SsEHbnVcdX28=;
        b=l0XaCJwkahqIvMvINx5+eyaDH3bJz0MVhmNyKVG5j4eT4EyMnrxxVlGv3Y8JFiA/N5
         uxX1wWK8AMC0vS6XitFt1TQ4QsXR/iIazskl1xpkk6vnQ4kRkHPyFm4uSk+vfS36JqxD
         oI/cfrbOAG5cd2LJu+OQVzyznD85FG/Hn1YOlH1loVAjHsFqCeQm/Knf8HjS3gfNZyCT
         lCFFTradBb6P9uPIjZ2oFhGOkNqoxwSOOgXSOiTVgVKaW2x4tRL1QCi0M9ReYnykgHkK
         ezFB2QbzRBVMcR9xRGyfL83ntcyDJtzREuVVWiYLQ3NYdBqwkEX3c9cu1BvXYYmRZWNK
         DIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774454298; x=1775059098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4NlapPe71gz9z0qpcpgNNnFPRNCo/H/SsEHbnVcdX28=;
        b=kOlEJj8upWWeTnvbGlunIIZI8d0BOcIcRkhCn+vfM5/wcun26h9sPbnNkZ87agaNoy
         qFvJYy1QRewmb+YmRYPUBjjNQFkW3A3T/4D7oBWbRYrdeKuRLFXT2KkuuWjB1t3RfmyK
         wA0nStUBb5dY39HYnkXot0N0p6kWIwqAQfgMpK+9lMRBuM/SNTIO8oHf3pfRwGtxFQZw
         B6MO/y9UuWTJitslBt904XWAvQ6nz9sdp5C8PKcLXKQX3JjzcpzWy6if5JO6qemwlxSK
         o/BU4tRTr4Ffkc1/cRF/ZrKE0f+UFmc/HdWXeU7GTUN0vpjmQ6SOvGUc1c5a0INucDTs
         b7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWecYdp9U55mhgXCK9sJXl4u0y6wG59cXO9J//D0jWxVrjKBqCeqVMgdq+A8+QIyMK6S+zku4i9KVtZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxEPbilsQVGHA1Tyn60pN3PFtF72hg7OQ3+KIz/RSPQAOmOL7BB
	gVqMUaYFP4Ldtqcezz5rP/nD2taLAtZlKRCr6qn39ktyyxbx2yD6duuz0sgX/hFsABsGUV4MMeP
	AqWGYDHR0kL7xzNWaVnSZVw6g8DTZzZHYi+7bPOJN
X-Gm-Gg: ATEYQzwe6F9hE4Ycwq/cm1bJiuWjpgw6M5yoTPQmr1x/gcdgpWMHA/SAVv3ql/y+TrG
	qnJYzOpARGACOu9aBhMwMyfkJtqJJc1VUw9ynzI5qx3ZDZOFv4/m7yZRk0XW15O/XjZOhQKdhP7
	DdeFfPf2NT9lwawXeVGY1Lw5iwaGyEbws2dGjaNzglhLmgib3kVT4mvX8DEW0N2mi1kHOgTcGXX
	kbGd89BUOGFoFf1sbeGKvBeD6FpC6X02BCA7wGaozW3Gvc8GbJC21Mk5mPKJWKXxIYUy2t9dpG1
	YMSxn/7s/2WgHmSr5knri3Ig01NLGCUEYX2o2g==
X-Received: by 2002:a17:903:1a08:b0:2b0:5c88:51e1 with SMTP id
 d9443c01a7336-2b0b15e34b9mr712735ad.14.1774454297593; Wed, 25 Mar 2026
 08:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219113850.354271-1-tmricht@linux.ibm.com>
 <20260302234343.564937-1-irogers@google.com> <CAP-5=fW0Bu2313nAuhur+wP5Y2JtBNY+wpPoiKLqNzcSe-R3gA@mail.gmail.com>
 <acOHgYoM6oYWWTmC@google.com>
In-Reply-To: <acOHgYoM6oYWWTmC@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Mar 2026 08:58:06 -0700
X-Gm-Features: AaiRm525eJRZyq4wKqduzPONL8OvxU9mCR-LMkOhMDNYqJEk_WtRzP7shjYJI78
Message-ID: <CAP-5=fUDdyVneU9LY0gcc-KdNkOi8vR0mo9yqndpwo7QTwqwyw@mail.gmail.com>
Subject: Re: [PATCH v1] perf symbol: Lazily compute idle and use the perf_env
To: Namhyung Kim <namhyung@kernel.org>
Cc: tmricht@linux.ibm.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 11:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> Sorry for the delay.
>
> On Tue, Mar 24, 2026 at 10:14:01AM -0700, Ian Rogers wrote:
> > On Mon, Mar 2, 2026 at 3:43=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> [SNIP]
> > > -       if (idle_symbols_list)
> > > -               return strlist__has_entry(idle_symbols_list, name);
> > > +       /*
> > > +        * ppc64 uses function descriptors and appends a '.' to the
> > > +        * start of every instruction address. Remove it.
> > > +        */
> > > +       if (name[0] =3D=3D '.')
>
> Then e_machine =3D=3D EM_PPC64 can be checked here.

Agreed, but potentially this is load bearing for more than just PPC so
I'd rather leave it as it is.

> > > +               name++;
> > > +
> > > +
>
> Two blank lines.

Will fix in v2.

> > > +       if (bsearch(name, idle_symbols, ARRAY_SIZE(idle_symbols),
> > > +                   sizeof(idle_symbols[0]), sym_name_cmp)) {
> > > +               sym->idle =3D SYMBOL_IDLE__IDLE;
> > > +               return true;
> > > +       }
> > > +
> > > +       if (e_machine =3D=3D EM_386 || e_machine =3D=3D EM_X86_64) {
> > > +               if (strstarts(name, "mwait_idle") ||
> > > +                   strstarts(name, "intel_idle")) {
> > > +                       sym->idle =3D SYMBOL_IDLE__IDLE;
> > > +                       return true;
> > > +               }
> > > +       }
> > > +
> > > +       if (e_machine =3D=3D EM_PPC64 &&!strcmp(name, "ppc64_runlatch=
_off")) {
> > > +               sym->idle =3D SYMBOL_IDLE__IDLE;
> > > +               return true;
> > > +       }
> > >
> > > -       idle_symbols_list =3D strlist__new(NULL, NULL);
> > > +       if (e_machine =3D=3D EM_S390) {
> > > +               int major =3D 0, minor =3D 0;
> > > +               const char *release =3D env && env->os_release
> > > +                       ? env->os_release : perf_version_string;
> > >
> > > -       for (i =3D 0; idle_symbols[i]; i++)
> > > -               strlist__add(idle_symbols_list, idle_symbols[i]);
> > > +               sscanf(release, "%d.%d", &major, &minor);
> > >
> > > -       return strlist__has_entry(idle_symbols_list, name);
> > > +               /* Before v6.10, s390 used psw_idle. */
> > > +               if ((major < 6 || (major =3D=3D 6 && minor < 10)) && =
strstarts(name, "psw_idle")) {
> > > +                       sym->idle =3D SYMBOL_IDLE__IDLE;
> > > +                       return true;
> > > +               }
> > > +       }
> > > +
> > > +       sym->idle =3D SYMBOL_IDLE__NOT_IDLE;
> > > +       return false;
> > >  }
> > >
> > >  static int map__process_kallsym_symbol(void *arg, const char *name,
> > > @@ -785,7 +815,7 @@ static int map__process_kallsym_symbol(void *arg,=
 const char *name,
> > >          * We will pass the symbols to the filter later, in
> > >          * map__split_kallsyms, when we have split the maps per modul=
e
> > >          */
> > > -       __symbols__insert(root, sym, !strchr(name, '['));
> > > +       __symbols__insert(root, sym);
> > >
> > >         return 0;
> > >  }
> > > diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> > > index 3fb5d146d9b1..508dd9f336e9 100644
> > > --- a/tools/perf/util/symbol.h
> > > +++ b/tools/perf/util/symbol.h
> > > @@ -24,6 +24,7 @@ struct dso;
> > >  struct map;
> > >  struct maps;
> > >  struct option;
> > > +struct perf_env;
> > >  struct build_id;
> > >
> > >  /*
> > > @@ -41,6 +42,12 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *=
ep,
> > >                              GElf_Shdr *shp, const char *name, size_t=
 *idx);
> > >  #endif
> > >
> > > +enum symbol_idle_kind {
> > > +       SYMBOL_IDLE__UNKNOWN =3D 0,
> > > +       SYMBOL_IDLE__NOT_IDLE =3D 1,
> > > +       SYMBOL_IDLE__IDLE =3D 2,
> > > +};
> > > +
> > >  /**
> > >   * A symtab entry. When allocated this may be preceded by an annotat=
ion (see
> > >   * symbol__annotation) and/or a browser_index (see symbol__browser_i=
ndex).
> > > @@ -56,8 +63,8 @@ struct symbol {
> > >         u8              type:4;
> > >         /** ELF binding type as defined for st_info. E.g. STB_WEAK or=
 STB_GLOBAL. */
> > >         u8              binding:4;
> > > -       /** Set true for kernel symbols of idle routines. */
> > > -       u8              idle:1;
> > > +       /** Cache for symbol__is_idle. */
> > > +       enum symbol_idle_kind idle:2;
>
> I'm curious if bitfields with different types (u8 and enum) can be
> placed consecutively bitwise.  There can be a lot of symbols so it
> could be a concern.

pahole says no size difference:

Before:
```
struct symbol {
       struct rb_node             rb_node
__attribute__((__aligned__(8))); /*     0    24 */
       u64                        start;                /*    24     8 */
       u64                        end;                  /*    32     8 */
       u16                        namelen;              /*    40     2 */
       u8                         type:4;               /*    42: 0  1 */
       u8                         binding:4;            /*    42: 4  1 */
       u8                         idle:1;               /*    43: 0  1 */
       u8                         ignore:1;             /*    43: 1  1 */
       u8                         inlined:1;            /*    43: 2  1 */
       u8                         annotate2:1;          /*    43: 3  1 */
       u8                         ifunc_alias:1;        /*    43: 4  1 */

       /* XXX 3 bits hole, try to pack */

       u8                         arch_sym;             /*    44     1 */
       char                       name[];               /*    45     0 */

       /* size: 48, cachelines: 1, members: 13 */
       /* sum members: 43 */
       /* sum bitfield members: 13 bits, bit holes: 1, sum bit holes: 3 bit=
s */
       /* padding: 3 */
       /* forced alignments: 1 */
       /* last cacheline: 48 bytes */
} __attribute__((__aligned__(8)));
```

After:
```
struct symbol {
       struct rb_node             rb_node
__attribute__((__aligned__(8))); /*     0    24 */
       u64                        start;                /*    24     8 */
       u64                        end;                  /*    32     8 */
       u16                        namelen;              /*    40     2 */
       u8                         type:4;               /*    42: 0  1 */
       u8                         binding:4;            /*    42: 4  1 */

       /* Bitfield combined with previous fields */

       enum symbol_idle_kind      idle:2;               /*    40:24  4 */

       /* Bitfield combined with next fields */

       u8                         ignore:1;             /*    43: 2  1 */
       u8                         inlined:1;            /*    43: 3  1 */
       u8                         annotate2:1;          /*    43: 4  1 */
       u8                         ifunc_alias:1;        /*    43: 5  1 */

       /* XXX 2 bits hole, try to pack */

       u8                         arch_sym;             /*    44     1 */
       char                       name[];               /*    45     0 */

       /* size: 48, cachelines: 1, members: 13 */
       /* sum members: 43 */
       /* sum bitfield members: 14 bits, bit holes: 1, sum bit holes: 2 bit=
s */
       /* padding: 3 */
       /* forced alignments: 1 */
       /* last cacheline: 48 bytes */
} __attribute__((__aligned__(8)));
```

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > >         /** Resolvable but tools ignore it (e.g. idle routines). */
> > >         u8              ignore:1;
> > >         /** Symbol for an inlined function. */
> > > @@ -184,8 +191,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, =
struct symsrc *ss);
> > >
> > >  char *dso__demangle_sym(struct dso *dso, int kmodule, const char *el=
f_name);
> > >
> > > -void __symbols__insert(struct rb_root_cached *symbols, struct symbol=
 *sym,
> > > -                      bool kernel);
> > > +void __symbols__insert(struct rb_root_cached *symbols, struct symbol=
 *sym);
> > >  void symbols__insert(struct rb_root_cached *symbols, struct symbol *=
sym);
> > >  void symbols__fixup_duplicate(struct rb_root_cached *symbols);
> > >  void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kall=
syms);
> > > @@ -269,5 +275,6 @@ enum {
> > >  };
> > >
> > >  int symbol__validate_sym_arguments(void);
> > > +bool symbol__is_idle(struct symbol *sym, const struct dso *dso, cons=
t struct perf_env *env);
> > >
> > >  #endif /* __PERF_SYMBOL */
> > > --
> > > 2.53.0.473.g4a7958ca14-goog
> > >

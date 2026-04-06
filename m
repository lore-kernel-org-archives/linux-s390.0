Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139352BE03C
	for <linux-s390@vger.kernel.org>; Mon,  6 Apr 2026 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489783; cv=pass; b=G7cDBAszPYQ4QlfYgw/9otA52sTBqtMYuoh+WOTGg7ohxiFPw0FmnlwZ3aiApITxTnT+03mVMJC6NP0toCcVLC7K/N3spbtH/HHfFpTgusHpTxSKYHINW9wyaSK4kV3oi8lVk+ExOlcLOCylFZobv3BP48gmqasuNZKB7n5rMFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489783; c=relaxed/simple;
	bh=nlWstzIKajjZsgq7ASMegQ3LfAZegoZeZgMhp3KDNdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mhedb2c1IHhSBrpoSHCxga8RNTG51mLZBYTM+lhanabE3OLnb/OTDgizJJ2O/GCQK0VDY5JOaoDH+JD0jhqQarbCjHAQJ/8AgieIkDyhWyL97KJTYHG8hWEnSiRc6y1t5yM5b4C24xjHsOy95HV9UdWdlQkKMb6p1VfakHKzffM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oz6BpW1X; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oz6BpW1X"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b243198058so211805ad.1
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2026 08:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775489781; cv=none;
        d=google.com; s=arc-20240605;
        b=Fv5UrolNeetS3iGFUG1MirMQuNUmuURWX2PG/o0Q9dYv6Q7GQ5no30sb0wehfhagpC
         77BYZWdAH2QIVJSu116BbbOvWW5FGl9TuCGJ4NGPPOQgovemP8Tdjs1QtuAR4nRYgjUl
         Wg6xX9JA41ofB98K4KMYPcEowGiAoDy3nbAuhqW/9pEQfFMTKk+k+d3KVmi7m2GJXEwJ
         3qfgzGEya/Cdm+mU6RBtXYf1dGX2CTNxiX7bHenzOfUPi7Nm3gyIsRBa4GMvgownuY58
         Z+cxeZVrGo74mouOiZo7afunytajLpLmRwHYP0p5gbIi71/KdgRKNRUN4X+9o45kzYRR
         HumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uaoUY6HpZKfM17HYDhxh0f2g0mDO1KbjYq9Ox6pQpq8=;
        fh=ZTJP75cOyuWs/mlffRziyYXa5oAGKWvb5wgxCEaQy58=;
        b=fETKAetFNvEn8wYu4hORoj2Bl0CKPbr4a6x22lzjkQpCVpScMl6zoI9sRu/ri4LxQh
         k1/9doanGcWFChieHRJ9usbQUpVGyQc+EEHBC0WCiOyXKPaqXEoJxT9R5RWTGsNUYXwH
         XQ1Gh+TTnDpK5x4v62a/oGzip6v/CGzq9q/MnTaUK6hcXM4yf9Dan9z8lVJM2oAGqRqi
         pFdaVe27zvtYW1z7+QXb8bM5zGWwQknaEx3qlQa83OzxDeYp5W3xplBk3K6jkotwvkcY
         uQe0trc3tOmqPczlqwZuS1thY57xDLVFjm0sbWMHG87TCvp077hu+JHO8hCrb6uwZ2SZ
         bsfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775489781; x=1776094581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaoUY6HpZKfM17HYDhxh0f2g0mDO1KbjYq9Ox6pQpq8=;
        b=Oz6BpW1XzVgZq4mv9c7hTYgA/tnk1SKuKnH497qyZUODd7oGmbJmZ54wFak16DAWCh
         zrXcidBF1u1pxtg66z4Geyva4pto0zGPkdXUe13m4rwIS0hKjK1luhqpC3s+2K3bg9C4
         tvIfcVJAUnZXc8msG5azh4TZxXjOzYnSza1Fjeg9K0eH7PvZtidXMH1T+L401QfZAHdJ
         PkxNqmHTdCsRIvlY0ZZhI5iIeKl0Eqo24S5/xcXc7+GIzXAqYCAmf5OvZLdBmxe/oBrM
         HFCfrunNl6OEU4vbxqG9SxpR48/UKfLmcb+l7ug+FoCaA4csfX8vMOK9DVB4wukpRleZ
         7ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775489781; x=1776094581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uaoUY6HpZKfM17HYDhxh0f2g0mDO1KbjYq9Ox6pQpq8=;
        b=Qo7Bd0BVPv+/6ds0i9ZD4x2ey01s+sRKLSLkNoDk1y2I8ka+uySxvyHW0TLtnbzjyN
         dtvbpy4Mb/j18wQ4fAcMMoV/U7kBjf5gqI2aqcrmHd251ijXmGgC4D1yTvFngiKb4XXo
         ifFJ1dW3oKaeZt5V/h61R8GFGfeh5+H9RPgBzjkD1fx+RJXfPaGuRp0ykvKQ+S89DfuA
         TpMCU9pX+EqSzNIGehyBExLKKR0lpJOPtomVKnt9YIM8HRdh7Y/7WfrjDylR9iFzhTLf
         11nb6PAz1L8RC8JyRNzNSbkYi/HtNcehycGYydZPgWEt1+g3m7v8C6hoSjHZzuwc6dp6
         RTPA==
X-Forwarded-Encrypted: i=1; AJvYcCWV9meyaW/MMurLX4xKL3YYRzoCtDzqyumWI07swTkXS+szVhhrvCToZMmXo4OAZFxfuKUKZLgviIig@vger.kernel.org
X-Gm-Message-State: AOJu0YzujjgS++PBwkCyYk1YrgenO0TwCNBeSdWNhGHoU9V1MwZLcxZy
	vXDziB8rl1WHS0PaK+NVy8Sn6J5i5R4BdlyjzubcUOtOfvHM6XpeIzJRTro3AkwY6309+l9qiul
	23azT0EHliUxLouTVl6FEnAQH/G+rbw/pjiX0mEBB
X-Gm-Gg: AeBDievO8zo8iQ1N+y9mOjCcrKP7GWCDZEahRWsE50NzhmMAm5Dt2AeAbRdVJqjnTmq
	J4jGZCOHX0ddoPXd6sU/gDxh9OvfTHypgVRPQvyEz/80ZeTziWDno4WO0HIt2eQCv/vSJmBvFFt
	RPt6rS+V8TRl1dHrCODk1FcSPCX54anMYyAt1OWYHAYDB4+sJRCVE0ekiR7ZElbV4nDZEZAh8gC
	U1Mz48XBY3N+3tfFunD1AtW/781o24WwLfLIy+ewByaN4WfDWH7ZIJJUzLZ03jYY/twee41Ws5z
	CqMc0vyTeW7oEo8sc+K+N9M0rjOlm7rbfDK1shJiSMrVBY64
X-Received: by 2002:a17:903:2c0e:b0:2ae:d10c:6382 with SMTP id
 d9443c01a7336-2b282f7f418mr7591915ad.20.1775489780632; Mon, 06 Apr 2026
 08:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326174521.1829203-1-irogers@google.com> <20260327045025.2276517-1-irogers@google.com>
 <20260327045025.2276517-2-irogers@google.com> <adM-_viYsw5KEoeV@google.com>
In-Reply-To: <adM-_viYsw5KEoeV@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Apr 2026 08:36:08 -0700
X-Gm-Features: AQROBzAKTRtFLJ8MS4wmTBHobWacjfFthdSkbbee17nwzGFBy47KOe7WhybLKIw
Message-ID: <CAP-5=fWMzWKpHKy9+qwNuaGEgVmmqpu2keMVa1+N0ssHE2PfNw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] perf env: Add perf_env__e_machine helper and use
 in perf_env__arch
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, tmricht@linux.ibm.com, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, jameshongleiwang@126.com, 
	japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 10:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Mar 26, 2026 at 09:50:24PM -0700, Ian Rogers wrote:
> > Add a helper that lazily computes the e_machine and falls back of
> > EM_HOST. Use the perf_env's arch to compute the e_machine if
> > available. Use a binary search for some efficiency in this, but handle
> > somewhat complex duplicate rules. Switch perf_env__arch to be derived
> > the e_machine for consistency. This switches arch from being uname
> > derived to matching that of the perf binary (via EM_HOST). Update
> > session to use the helper, which may mean using EM_HOST when no
> > threads are available. This also updates the perf data file header
> > that gets the e_machine/e_flags from the session.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/env.c     | 185 ++++++++++++++++++++++++++++++--------
> >  tools/perf/util/env.h     |   1 +
> >  tools/perf/util/session.c |  14 +--
> >  3 files changed, 157 insertions(+), 43 deletions(-)
> >
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index 93d475a80f14..ae08178870d7 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -1,10 +1,12 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include "cpumap.h"
> > +#include "dwarf-regs.h"
> >  #include "debug.h"
> >  #include "env.h"
> >  #include "util/header.h"
> >  #include "util/rwsem.h"
> >  #include <linux/compiler.h>
> > +#include <linux/kernel.h>
> >  #include <linux/ctype.h>
> >  #include <linux/rbtree.h>
> >  #include <linux/string.h>
> > @@ -588,51 +590,160 @@ void cpu_cache_level__free(struct cpu_cache_leve=
l *cache)
> >       zfree(&cache->size);
> >  }
> >
> > +struct arch_to_e_machine {
> > +     const char *prefix;
> > +     uint16_t e_machine;
> > +};
> > +
> >  /*
> > - * Return architecture name in a normalized form.
> > - * The conversion logic comes from the Makefile.
> > + * A mapping from an arch prefix string to an ELF machine that can be =
used in a
> > + * bsearch. Some arch prefixes are shared an need additional processin=
g as
> > + * marked next to the architecture. The prefixes handle both perf's ar=
chitecture
> > + * naming and those from uname.
> >   */
> > -static const char *normalize_arch(char *arch)
> > -{
> > -     if (!strcmp(arch, "x86_64"))
> > -             return "x86";
> > -     if (arch[0] =3D=3D 'i' && arch[2] =3D=3D '8' && arch[3] =3D=3D '6=
')
> > -             return "x86";
> > -     if (!strcmp(arch, "sun4u") || !strncmp(arch, "sparc", 5))
> > -             return "sparc";
> > -     if (!strncmp(arch, "aarch64", 7) || !strncmp(arch, "arm64", 5))
> > -             return "arm64";
> > -     if (!strncmp(arch, "arm", 3) || !strcmp(arch, "sa110"))
> > -             return "arm";
> > -     if (!strncmp(arch, "s390", 4))
> > -             return "s390";
> > -     if (!strncmp(arch, "parisc", 6))
> > -             return "parisc";
> > -     if (!strncmp(arch, "powerpc", 7) || !strncmp(arch, "ppc", 3))
> > -             return "powerpc";
> > -     if (!strncmp(arch, "mips", 4))
> > -             return "mips";
> > -     if (!strncmp(arch, "sh", 2) && isdigit(arch[2]))
> > -             return "sh";
> > -     if (!strncmp(arch, "loongarch", 9))
> > -             return "loongarch";
> > -
> > -     return arch;
> > +static const struct arch_to_e_machine prefix_to_e_machine[] =3D {
> > +     {"aarch64", EM_AARCH64},
> > +     {"alpha", EM_ALPHA},
> > +     {"arc", EM_ARC},
> > +     {"arm", EM_ARM}, /* Check also for EM_AARCH64. */
> > +     {"avr", EM_AVR},  /* Check also for EM_AVR32. */
> > +     {"bfin", EM_BLACKFIN},
> > +     {"blackfin", EM_BLACKFIN},
> > +     {"cris", EM_CRIS},
> > +     {"csky", EM_CSKY},
> > +     {"hppa", EM_PARISC},
> > +     {"i386", EM_386},
> > +     {"i486", EM_386},
> > +     {"i586", EM_386},
> > +     {"i686", EM_386},
> > +     {"loongarch", EM_LOONGARCH},
> > +     {"m32r", EM_M32R},
> > +     {"m68k", EM_68K},
> > +     {"microblaze", EM_MICROBLAZE},
> > +     {"mips", EM_MIPS},
> > +     {"msp430", EM_MSP430},
> > +     {"parisc", EM_PARISC},
> > +     {"powerpc", EM_PPC}, /* Check also for EM_PPC64. */
> > +     {"ppc", EM_PPC}, /* Check also for EM_PPC64. */
> > +     {"riscv", EM_RISCV},
> > +     {"s390", EM_S390},
> > +     {"sa110", EM_ARM},
> > +     {"sh", EM_SH},
> > +     {"sparc", EM_SPARC}, /* Check also for EM_SPARCV9. */
> > +     {"sun4u", EM_SPARC},
> > +     {"x86", EM_X86_64}, /* Check also for EM_386. */
> > +     {"xtensa", EM_XTENSA},
> > +};
> > +
> > +static int compare_prefix(const void *key, const void *element)
> > +{
> > +     const char *search_key =3D key;
> > +     const struct arch_to_e_machine *map_element =3D element;
> > +     size_t prefix_len =3D strlen(map_element->prefix);
> > +
> > +     return strncmp(search_key, map_element->prefix, prefix_len);
> > +}
> > +
> > +static uint16_t perf_arch_to_e_machine(const char *perf_arch, bool is_=
64_bit)
> > +{
> > +     /* Binary search for a matching prefix. */
> > +     const struct arch_to_e_machine *result;
> > +
> > +     if (!perf_arch)
> > +             return EM_HOST;
> > +
> > +     result =3D bsearch(perf_arch,
> > +                      prefix_to_e_machine, ARRAY_SIZE(prefix_to_e_mach=
ine),
> > +                      sizeof(prefix_to_e_machine[0]),
> > +                      compare_prefix);
> > +
> > +     if (!result) {
> > +             pr_debug("Unknown perf arch for ELF machine mapping: %s\n=
", perf_arch);
> > +             return EM_NONE;
> > +     }
> > +
> > +     /* Handle conflicting prefixes. */
> > +     switch (result->e_machine) {
> > +     case EM_ARM:
> > +             return !strcmp(perf_arch, "arm64") ? EM_AARCH64 : EM_ARM;
> > +     case EM_AVR:
> > +             return !strcmp(perf_arch, "avr32") ? EM_AVR32 : EM_AVR;
> > +     case EM_PPC:
> > +             return is_64_bit || strstarts(perf_arch, "ppc64") ? EM_PP=
C64 : EM_PPC;
>
> I'm curious what's the name `uname -m` returns for PPC64.  Is
> "powerpc64" possible?

It is.

> > +     case EM_SPARC:
> > +             return is_64_bit || !strcmp(perf_arch, "sparc64") ? EM_SP=
ARCV9 : EM_SPARC;
> > +     case EM_X86_64:
> > +             return is_64_bit || !strcmp(perf_arch, "x86_64") ? EM_X86=
_64 : EM_386;
> > +     default:
> > +             return result->e_machine;
> > +     }
> > +}
> > +
> > +static const char *e_machine_to_perf_arch(uint16_t e_machine)
> > +{
> > +     /*
> > +      * Table for if either the perf arch string differs from uname or=
 there
> > +      * are >1 ELF machine with the prefix.
> > +      */
> > +     static const struct arch_to_e_machine extras[] =3D {
> > +             {"arm64", EM_AARCH64},
> > +             {"avr32", EM_AVR32},
> > +             {"powerpc", EM_PPC},
> > +             {"powerpc", EM_PPC64},
>
> Here it returns powerpc for both.

Yep. This is 100% intentional as the existing code does the same:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/env.c?h=3Dperf-tools-next#n611
```
static const char *normalize_arch(char *arch)
...
if (!strncmp(arch, "powerpc", 7) || !strncmp(arch, "ppc", 3))
return "powerpc";
```
The strncmp is limited to just the prefix of the uname string,
ignoring the 64. So the arch "powerpc" can be 32-bit or 64-bit, just
as "x86" can be 32-bit or 64-bit. To determine which case applies, the
code should really check `struct perf_env`'s `kernel_is_64_bit`. I
think this is generally much more painful than just using the
e_machine - especially since you need to strcmp the name. For the
e_machine, the problem is that on x86 we have 32-bit, x32 and x86_64.
There is then also an ABI question regarding the use of SIMD registers
and the newer APX registers. If there are no samples and no DSOs in
play, making a choice of e_machine to set up variables with is
somewhat arbitrary. I think EM_HOST, the e_machine of the current perf
binary, is a good choice.

Thanks,
Ian

> > +             {"sparc", EM_SPARCV9},
> > +             {"x86", EM_386},
> > +             {"x86", EM_X86_64},
> > +             {"none", EM_NONE},
> > +     };
> > +
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(extras); i++) {
> > +             if (extras[i].e_machine =3D=3D e_machine)
> > +                     return extras[i].prefix;
> > +     }
> > +
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(prefix_to_e_machine); i++) {
> > +             if (prefix_to_e_machine[i].e_machine =3D=3D e_machine)
> > +                     return prefix_to_e_machine[i].prefix;
> > +
> > +     }
> > +     return "unknown";
> > +}
> > +
> > +uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags)
> > +{
> > +     if (!env) {
> > +             if (e_flags)
> > +                     *e_flags =3D EF_HOST;
> > +
> > +             return EM_HOST;
> > +     }
> > +     if (env->e_machine =3D=3D EM_NONE) {
> > +             env->e_machine =3D perf_arch_to_e_machine(env->arch, env-=
>kernel_is_64_bit);
> > +
> > +             if (env->e_machine =3D=3D EM_HOST)
> > +                     env->e_flags =3D EF_HOST;
> > +     }
> > +     if (e_flags)
> > +             *e_flags =3D env->e_flags;
> > +
> > +     return env->e_machine;
> >  }
> >
> >  const char *perf_env__arch(struct perf_env *env)
> >  {
> > -     char *arch_name;
> > +     if (!env)
> > +             return e_machine_to_perf_arch(EM_HOST);
> >
> > -     if (!env || !env->arch) { /* Assume local operation */
> > -             static struct utsname uts =3D { .machine[0] =3D '\0', };
> > -             if (uts.machine[0] =3D=3D '\0' && uname(&uts) < 0)
> > -                     return NULL;
> > -             arch_name =3D uts.machine;
> > -     } else
> > -             arch_name =3D env->arch;
> > +     if (!env->arch) {
> > +             /*
> > +              * Lazily compute/allocate arch. The e_machine may have b=
een
> > +              * read from a data file and so may not be EM_HOST.
> > +              */
> > +             uint16_t e_machine =3D perf_env__e_machine(env, /*e_flags=
=3D*/NULL);
> >
> > -     return normalize_arch(arch_name);
> > +             env->arch =3D strdup(e_machine_to_perf_arch(e_machine));
> > +     }
> > +     return env->arch;
> >  }
> >
> >  #if defined(HAVE_LIBTRACEEVENT)
> > diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> > index a4501cbca375..91ff252712f4 100644
> > --- a/tools/perf/util/env.h
> > +++ b/tools/perf/util/env.h
> > @@ -186,6 +186,7 @@ int perf_env__read_cpu_topology_map(struct perf_env=
 *env);
> >
> >  void cpu_cache_level__free(struct cpu_cache_level *cache);
> >
> > +uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags);
> >  const char *perf_env__arch(struct perf_env *env);
> >  const char *perf_env__arch_strerrno(struct perf_env *env, int err);
> >  const char *perf_env__cpuid(struct perf_env *env);
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 4b465abfa36c..dcc9bef303aa 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -2996,14 +2996,16 @@ uint16_t perf_session__e_machine(struct perf_se=
ssion *session, uint32_t *e_flags
> >               return EM_HOST;
> >       }
> >
> > +     /* Is the env caching an e_machine? */
> >       env =3D perf_session__env(session);
> > -     if (env && env->e_machine !=3D EM_NONE) {
> > -             if (e_flags)
> > -                     *e_flags =3D env->e_flags;
> > -
> > -             return env->e_machine;
> > -     }
> > +     if (env && env->e_machine !=3D EM_NONE)
> > +             return perf_env__e_machine(env, e_flags);
> >
> > +     /*
> > +      * Compute from threads, note this is more accurate than
> > +      * perf_env__e_machine that falls back on EM_HOST and doesn't con=
sider
> > +      * mixed 32-bit and 64-bit threads.
> > +      */
> >       machines__for_each_thread(&session->machines,
> >                                 perf_session__e_machine_cb,
> >                                 &args);
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >

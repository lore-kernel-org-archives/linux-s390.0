Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A263137CD4C
	for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2026 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435036; cv=pass; b=XHO4lCQ2Ycen8YIzWVEn9sSSHuDTWXKT6xxulGeUIyLevh+4mvqU/YtXrHRj7YoutrDzlRh5ZBNdMSNVM0+VuBVvlLzQW8vxE0W4fiTYXTVrg7/SdS8HTrVcfCQiNm0q1pa0lvwNjhzVqbFP/kcLpT3O2xaqKT/gbWbuMIjZVwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435036; c=relaxed/simple;
	bh=CRTB0rvLPUWbgmQPVFGsG9fKu133Dx4BOGCkPJ1QcLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpfwoN/PC4lGSDEx6e8sTor/CdONfDSOmr/MUvlA4ujpmmrBowJRwAvUD73CD91OJpZw1UjKQMFkFPilktqTK1MNbqPvH2CxqeURbBJExxwHThNmhvg+kobWHAWjvDeTtgWV/ei3Lg48CRQo8w2JTGZBGfD15z0i5KcPGYS5r9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sqdxx6Wc; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sqdxx6Wc"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aeab6ff148so7265ad.1
        for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2026 13:50:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773435033; cv=none;
        d=google.com; s=arc-20240605;
        b=LM3lJz5det6W271wvu8fI8mKYFNIf1PIH9aNnN8fKrLgpoBM8D73S4W49o0qtVLA3B
         58SeFRPMq4n55vQPugLBNNpaRsTDOUrJxublO/i3IyHWxz/58ErjvBgy0JGK3rmn5dU5
         t6aECHTsYxcqIva75W5oBut83C2jLzTNz/RSeIu0YWUu7lVyIzLpPXhRPuPY7dUfzafI
         IeMzJGFavLYHcHzGm8kfKa+s463Vuof7vzAe5z91ndX29qSKIfl/2dAAhwy26EygaG9e
         Qk42AFV9m/zqE+Zqae3dkg+jvuY9qHQpK04n1zYKvQKhoB1iFO8WtFFZNGOyZlaTFLxS
         BeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uiD4tYD5kTcoUckTF0mt3ib4Qawq7lU5JzHwtKX4SDI=;
        fh=oMeJWAJZxOTFwvYqOVGwgb7/C2lj3ki/+T4AWrtCZZI=;
        b=bZH4+uwceQSCXL0fu4NerE6vN/WFMjE63ygrW2cC3+jXbuOOtoFYhDGPqRSBKoAAVV
         jghg76L0h8RHrRPH58fLKvYaQzYpHETuSEwhXgihM3RqfGVnUddzqPXUUPoPKK7Ga4XR
         nWHwfFaM/zTt9qqsIngOubS7daGlUopneypCsqnvVEx/WbUwwIhrz3LXqJrfADEsWyih
         H4UFx4VrK3I+wu3V6Q7NJVuSIRIo12pwAPY8GRLFpIjIbvz/eawxNqL89hD7nqSgONEe
         PuAnd8O7MCmj26JzIuh6debiWfvbJPlPAUbQxDzRp1f7VuxMku8BzpJVtgrvaFZ5Kd+d
         RBFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773435033; x=1774039833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiD4tYD5kTcoUckTF0mt3ib4Qawq7lU5JzHwtKX4SDI=;
        b=Sqdxx6WcWmRw4mAloAkvBLmLLX6A69lenTWcZ8W25wrFWpl1TMCdnR4yAycOg9QChV
         IAClo82m5a67y06tUME11dbEkLQjlA/B1ZlzURkHiQ1CbPrd9RN561svuZNxrXyURuX8
         WIbNDmsoyZxsLfCsng346rsDQCVMVyosjazJQyEP3ZFLMArRq/aYA43YbRlRVccDJRJI
         WBmYK3HqJFA4KdzgHDuegrjm86Te6pFHRRIxemqZCAZQDN2TbOaJRfrIY1W15FscJg1p
         fX8rG3cDjhf5WVtyycrPng1kopTE5bcI3g/B3o9CQ4u0AzHATbyQ8+BVZrnf19365F1N
         e2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435033; x=1774039833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uiD4tYD5kTcoUckTF0mt3ib4Qawq7lU5JzHwtKX4SDI=;
        b=ET+n2z9PDqgTNn+LvMtnyayclRwUwIyEZx/DJ7vnnoX7zCzBL+gxKi4gnkP+hVc0ZF
         VwGQoQselpI514i9BKUpuyPRlc9lphuTlLrq8etkJchZuMtG92KLRvs8+WH5zL0n0dgu
         dG9M9qRKirFIh/ao/kliCbxyFK0yzSiNHagxfxdnEGR7QMNTwFFhNombEG2iBVVK6yEu
         UYC+b19C2J8btdDbOCD2LMD3X61H2GlUf2ya69ZT3ogAwNaO066rlNIMHXM9HnIeKvMH
         TI1rKUKmmFHafKHvYwqA+JnG9z7b0Q7tmuU8nRWOqyoFiznm8pHEVZr3xZjg+bny3fiH
         zwrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgHXzpaLCuOWZ5IOCY0uyJ6A0+h7HYrzR8GYxUdLKpVMH/P1fbHcf/arwfw0IoMjlAuIBb6TnM9xGq@vger.kernel.org
X-Gm-Message-State: AOJu0YyjbHFpOOsCU0MIvVnQjD/sY5vmsABksxyUfMmjRNFKIJrCbMnt
	lCmZVLxhJLgEcUP+rvoNVUsGy4HaH/w42OPdWGJK/gcr0j7XPODihv2zltRXX55qCqM0E+rn0yx
	9QlOLhaQjzhiezmoPctbQBnWjrQwOpIMcypSOkqW0
X-Gm-Gg: ATEYQzyRxrmnrgxr+DlC8UFf6imeK0/kRzOuBgBXAkTa6tmKxUEcM8u6rEwMY5PYjot
	HqFhoqeX5dQ9ZTxkQACEjdSQz/sPwygf/BJd8r6syxbIUwiMDThuXBxRnMBZCZoq/AP0w3PiODp
	zFxF/TrPAkII4kpbqWZSqT6APWNHdIe7DjbWl2QhkyrJ9RQdwQd3fs6MJpZ0NqVeIXUBBnELHf7
	bReEQJSkAPqXlgxX2XEXxHfsJuYFtI2VFNmQkuopgM9AMBbDAd/XC8exnGW2tcvkMZ+uIj7mOhn
	d9WvswZbBI1jsMRGq29ABcpSnHVuncZVbkVu
X-Received: by 2002:a17:903:44cb:b0:2ae:c358:bb9f with SMTP id
 d9443c01a7336-2b0420883bamr619905ad.10.1773435032491; Fri, 13 Mar 2026
 13:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313132302.3347751-1-tmricht@linux.ibm.com>
In-Reply-To: <20260313132302.3347751-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Mar 2026 13:50:19 -0700
X-Gm-Features: AaiRm52m-wjV1pXoGxPYImJlolftypsHZ9mGQCdsloyTkZ7E8iNB4Fb0ptX2Vis
Message-ID: <CAP-5=fU1Spg+rxTkjqECZZbRjkLASPu14Q=ZyONFWHe4rwy9+g@mail.gmail.com>
Subject: Re: [PATCH v2] perf record: Add support for arch_sdt_arg_parse_op()
 on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	dapeng1.mi@linux.intel.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 6:33=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> commit e5e66adfe45a6 ("perf regs: Remove __weak attributive arch_sdt_arg_=
parse_op() function")
> removes arch_sdt_arg_parse_op() functions. s390 support is missing.
> The following warning is printed:
>
>   Unknown ELF machine 22, standard arguments parse will be skipped.
>
> ELF machine 22 is the EM_S390 host. This happens with command
>   # ./perf record -v -- stress-ng -t 1s --matrix 0
> on a z/VM system when the event is not specified.
>
> Add s390 specific __perf_sdt_arg_parse_op_s390() function to support
> -architecture calls to arch_sdt_arg_parse_op() for s390.
> The warning disappears.
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Tested-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  .../perf/util/perf-regs-arch/perf_regs_s390.c | 89 +++++++++++++++++++
>  tools/perf/util/perf_regs.c                   |  3 +
>  tools/perf/util/perf_regs.h                   |  1 +
>  3 files changed, 93 insertions(+)
>
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf=
/util/perf-regs-arch/perf_regs_s390.c
> index c61df24edf0f..c830aeae606e 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_s390.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
> @@ -1,7 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include <errno.h>
> +#include <regex.h>
>  #include "../perf_regs.h"
>  #include "../../arch/s390/include/perf_regs.h"
> +#include "debug.h"
> +
> +#include <linux/zalloc.h>
> +#include <linux/kernel.h>
>
>  uint64_t __perf_reg_mask_s390(bool intr __maybe_unused)
>  {
> @@ -95,3 +101,86 @@ uint64_t __perf_reg_sp_s390(void)
>  {
>         return PERF_REG_S390_R15;
>  }
> +
> +/* %rXX */
> +#define SDT_OP_REGEX1  "^%r([0-9]|1[0-5])$"
> +/* -###(%rXX) */
> +#define SDT_OP_REGEX2  "^(-?[0-9]+)\\(%r([0-9]|1[0-5])\\)$"
> +static regex_t sdt_op_regex1, sdt_op_regex2;
> +
> +static int sdt_init_op_regex(void)
> +{
> +       static int initialized;
> +       int ret =3D 0;
> +
> +       if (initialized)
> +               return 0;
> +
> +       ret =3D regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
> +       if (ret)
> +               goto error;
> +       initialized =3D 1;
> +
> +       ret =3D regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
> +       if (ret)
> +               goto free_regex1;
> +       initialized =3D 2;
> +
> +       return 0;
> +
> +free_regex1:
> +       regfree(&sdt_op_regex1);
> +error:
> +       pr_debug4("Regex compilation error, initialized %d\n", initialize=
d);
> +       initialized =3D 0;
> +       return ret;
> +}
> +
> +/*
> + * Parse OP and convert it into uprobe format, which is, +/-NUM(%gprREG)=
.
> + * Possible variants of OP are:
> + *     Format          Example
> + *     -------------------------
> + *     NUM(%rREG)      48(%r1)
> + *     -NUM(%rREG)     -48(%r1)
> + *     %rREG           %r1
> + */
> +int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op)
> +{
> +       int ret, new_len;
> +       regmatch_t rm[6];
> +       unsigned long i;
> +
> +       *new_op =3D NULL;
> +       ret =3D sdt_init_op_regex();
> +       if (ret < 0)
> +               return ret;

Some AI feedback:

POSIX regcomp() returns 0 on success and a positive error code on failure
(like REG_ESPACE). Since sdt_init_op_regex() returns this positive code,
will ret < 0 evaluate to false on compilation failure?

If so, this would allow execution to proceed to regexec() using uninitializ=
ed
or freed regex structs, which could crash the tool.

> +
> +       if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
> +               /* Extract %rX */
> +               new_len =3D 2;    /* % NULL */
> +               new_len +=3D (int)(rm[1].rm_eo - rm[1].rm_so);
> +               *new_op =3D zalloc(new_len);
> +               if (!*new_op)
> +                       return -ENOMEM;
> +
> +               scnprintf(*new_op, new_len, "%%%.*s",
> +                         (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1=
].rm_so);

Does this formatting correctly preserve the 'r' prefix for s390 registers?
The regex SDT_OP_REGEX1 is defined as ^%r([0-9]|1[0-5])$, meaning rm[1]
captures the numeric digits, not the 'r'. So an input like %r15 will be
formatted as %15.

However, the s390 kernel's regs_query_register_offset() strictly requires
the register name to start with 'r', otherwise it returns -EINVAL. Will
the kernel's parse_probe_arg() reject the uprobe definition without the
'r' prefix?

> +       } else if (!regexec(&sdt_op_regex2, old_op, ARRAY_SIZE(rm), rm, 0=
)) {
> +               /* Extract #(%rX) */
> +               new_len =3D 4;    /* (%)NULL */
> +               for (i =3D 1; i < ARRAY_SIZE(rm) && rm[i].rm_so !=3D -1; =
++i)
> +                       new_len +=3D (int)(rm[i].rm_eo - rm[i].rm_so);
> +               *new_op =3D zalloc(new_len);
> +               if (!*new_op)
> +                       return -ENOMEM;
> +
> +               scnprintf(*new_op, new_len, "%.*s(%%%.*s)",
> +                         (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1=
].rm_so,
> +                         (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2=
].rm_so);

Similar to the above, rm[2] isolates the digits without the 'r' prefix,
creating an argument like 48(%15).

Additionally, does this string translation handle positive memory
displacements correctly?

The kernel's parse_probe_arg() in kernel/trace/trace_probe.c parses memory
dereferences by matching the case '+': or case '-': prefix switch cases.
If an argument starts with a digit rather than a + or -, it falls through
to the default case and is rejected with -EINVAL.

Should positive memory offsets be translated to explicitly include the +
prefix (e.g., +48(%r15)) so they are accepted by the uprobe parser?

Thanks,
Ian


> +       } else {
> +               pr_debug4("Skipping unsupported SDT argument: %s\n", old_=
op);
> +               return SDT_ARG_SKIP;
> +       }
> +
> +       return SDT_ARG_VALID;
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 5b8f34beb24e..f52b0e1f7fc7 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -23,6 +23,9 @@ int perf_sdt_arg_parse_op(uint16_t e_machine, char *old=
_op, char **new_op)
>         case EM_X86_64:
>                 ret =3D __perf_sdt_arg_parse_op_x86(old_op, new_op);
>                 break;
> +       case EM_S390:
> +               ret =3D __perf_sdt_arg_parse_op_s390(old_op, new_op);
> +               break;
>         default:
>                 pr_debug("Unknown ELF machine %d, standard arguments pars=
e will be skipped.\n",
>                          e_machine);
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 7c04700bf837..573f0d1dfe04 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -62,6 +62,7 @@ uint64_t __perf_reg_mask_s390(bool intr);
>  const char *__perf_reg_name_s390(int id);
>  uint64_t __perf_reg_ip_s390(void);
>  uint64_t __perf_reg_sp_s390(void);
> +int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op);
>
>  int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op);
>  uint64_t __perf_reg_mask_x86(bool intr);
> --
> 2.53.0
>
>

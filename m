Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6B285CBC
	for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852369; cv=pass; b=tt+ikoxqpn+wrLXVmVxwBCn2J7nxdS7bKSHQaodBvsxgcmZMXV0GsUFjOKuraIusQCeUqrmwSwk4vEwbesUwni/1imweHzJ2/qkkrA0StQ+pu0q8H0iCobaO+CdZVBF834doF972Pm4p1Icf5PCuQeC3z/L9x+YSCHZIheJ2A8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852369; c=relaxed/simple;
	bh=Q4n9jfZEAODE1uo4fvDs2z8RWAST35w1xfTU2vLeq+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBxgI/ZLB755l8kCOu4Ybw+8qJSron6jUdIC1KBRPDiAtkL5QrrADRz3zYJeYKacWGIGnGe1xzmhJc3kYO+xurYovetXzkOdgZ77p0Q7hsfvXCSH7sQsTK7rXgheBT1QujblBFYjrTytW6R83fOv3qXWR04JyXmTCd1bmOsUljA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBqA4G3W; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBqA4G3W"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aeab6ff148so107665ad.1
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 09:46:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773852366; cv=none;
        d=google.com; s=arc-20240605;
        b=bSs6v65n7JodJ1mpn0PxOJjERVQPstrMDRSc8QnFZUKI6qzAqhY7HWYA9tC/LiyPWi
         YjToHVEkhQYlVnk5EkpyxnAPcGUYj/wKzx3ZHPwji8380qXatDvlU+oryXbRSYcyEB5x
         CHiTz+Co7Ylv7DNOjppawlCvhsOplDfeWUKNxHESLpwEa9s6d+dQPk2ufcpqcT++mGjH
         9j/iHlZ6t+MN+R3w2q5z1lSxck6hqDWloO9Akg7F5sPnZvjWCaYA5CLEjlr/217RCnFY
         71Re7fOGMp//C0lMiHAoP5ENcDD0jjHcdodVfvbOWnsdm2rq79DOd8L1o99eWYyM17Ho
         09GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7h9KC5mHA+CbPkZHaMGK+FJap31XVl4YArpJmwoyUIc=;
        fh=RisNHOleVS3pefm76rJvFw/pA597Ggf7PaHMoIt/bZc=;
        b=jRLH0U2U99HAXQDeNvPe7REmgr+dB8MrY+P3iNWk/Ba2osO5wWb1pu2IxjpVoyCVvs
         UAY/DLwBCPzgH/QyAGirPW+ysDz0eHdO0iJ3VNqCBmS59kHbhrdjdaVBrqTlGc7PKXS+
         Ghw/uIIfjQZr/elPJUE9zE45R7TLo6Q94W1nFOCajcQ8gNcoOQwdcCuBi7q3Rs8z+sRH
         Z8q0X/s9YYeFldahZvXWNq5rNlTSYK35ijYPsguVZFENaNxO0iTUle77AHUSagJhYcH+
         Fh96Z6DLdkAxsFHXJMtJ4WuZTqyzkmnmU750P4fi31gwEJ6jqlq7h7CHKYw7vc8qZKws
         k2/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773852366; x=1774457166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h9KC5mHA+CbPkZHaMGK+FJap31XVl4YArpJmwoyUIc=;
        b=pBqA4G3WJkDXRdlvtxYGecRm6715w2U3T9x0RYcoUxonwyEI7S+untbP3XLiudYMZ5
         GHRjg6Gq/IFWDM/CZOMRDppKdMsZsU5L5IaRwzeDgGQmjOFJW0FTh5eLYjsU6bX4GHoo
         loEvtstqaMdiaZ+VUgch+Jl/qKRuZhCk0V6wkUymjUFuVcPw5s+/9oMhsl1uSB3+Sk1w
         im4qg/ASdcmzKJ8Zccoi3Ae0uDRKuxNhHcay89wT1QM/YTdJhVm0G/XyJeRUEx/ScmGw
         eUDpJcOLricHGkKiI6CncXfjbsnC4AXINYy6bQK6ryEoZx2IhkEgRsQlgLmdbF9Idd89
         9WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773852366; x=1774457166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7h9KC5mHA+CbPkZHaMGK+FJap31XVl4YArpJmwoyUIc=;
        b=adOXaLOu92KkKu2uEd74YVdLqRjc9br7txVvAjyLeCXRl53emmgXgkmJWDFOs3DfHE
         yP2aJkzIFKzJZk2PYi4Xzjnj97NxhCweqjVShEooOukhX66uOn+SbqCoge0eQQpSf5kq
         mY1dOZ9xYc2q2IQZnjfrH5+JYWCLUFuibj7GxSl8sKxtZ+JOO2G1I4jOLj6zeAesxt1E
         lDkmLz/fdva+lUFrYLFWNtCiMsJgousNyB+wikdXe9KiK7ijJOeoFBHVPHlzO1WZjHd5
         rZv7UBATTTtjspqmVNaEzgiYPz9ZrLT9+FEWT0bTXE31OPpKsWh3S3bLnoKr59C/WuI2
         TxSg==
X-Forwarded-Encrypted: i=1; AJvYcCXVTCKk2CdYoXVUdLppHVTGO4ojAft/Oga2pjyoqYcQ1At3kbJNoBvwLx6tLOspfFx+NzwwfmD2Meuw@vger.kernel.org
X-Gm-Message-State: AOJu0YxKBTF2ZD7ZAldor6f4zgjr8NgaIRe8iLxviDCXECNKN+23Q/sa
	FoWG4HHJrFyk+RBM4gs6lkjxOo+oMsIJKHFQxIGyrf7JNdxBEXaANhoPy1dG52nXLYtHvOpPmPJ
	v8s4D6cUm0DjYZc997neJGBPgj6QkNwH5buEIxKhF
X-Gm-Gg: ATEYQzz8UnIqKGY4E2I5PHnc/s+Ur7Ro9CAHhJuCBGISVfkgJR7BnY9M7ZRYFlaFHz7
	qPQwRf0lVZkjQA0IaVSYfrd4OIiOUgJ9fYgHXFXqtboSAQsdIlN8YM23ZspvR9oCFSpmfYZs2RK
	15BHyoI4s6pKQDvYAsYrqXSfhKD7vhomy5bz+Q+r/AKH9oeQoBlJJ5H+/2jjMI7/aaroinm3ZTN
	O8yNQUQGm68xkAGQcpr6EjfgVj6fjuK1/cYAH/Xevidhkg2AIbbsKK/qNTxcVCv2It+g17NZKR6
	tYPZEq+5
X-Received: by 2002:a17:902:e842:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2b06f8883fcmr3321175ad.15.1773852365387; Wed, 18 Mar 2026
 09:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318113416.2287472-1-tmricht@linux.ibm.com>
In-Reply-To: <20260318113416.2287472-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Mar 2026 09:45:53 -0700
X-Gm-Features: AaiRm53GC4iacG1vFNkmqVI2i4dw_Y9i8i-2ZL7WbfewzUDPVNuuzk42Zh4o4S0
Message-ID: <CAP-5=fWV1LemkYe7684CNmWTEBFe-U=CgSgG90-x4c3=KC3vpA@mail.gmail.com>
Subject: Re: [PATCH v4] perf record: Add support for arch_sdt_arg_parse_op()
 on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	dapeng1.mi@linux.intel.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 4:34=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> V4: Add comments from Ian and Sashiko:
>     Reset variable initialized to zero on error
>     Rework regular expression and reduce to one case.
> V3: Add comments from Ian
>     Print register expression without leading 'r' (wrong).
> V2: Add comments from Sumanth Koirkkar

nit: these need to be placed after a line of "---" so that git mailbox
won't include it in the commit message.

> commit e5e66adfe45a6 ("perf regs: Remove __weak attributive arch_sdt_arg_=
parse_op() function")
> removes arch_sdt_arg_parse_op() functions and reveals missing s390 suppor=
t.
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
> Cc: Ian Rogers <irogers@google.com>
> Tested-by: Jan Polensky <japo@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  .../perf/util/perf-regs-arch/perf_regs_s390.c | 77 +++++++++++++++++++
>  tools/perf/util/perf_regs.c                   |  3 +
>  tools/perf/util/perf_regs.h                   |  1 +
>  3 files changed, 81 insertions(+)
>
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf=
/util/perf-regs-arch/perf_regs_s390.c
> index c61df24edf0f..9d34549be477 100644
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
> @@ -95,3 +101,74 @@ uint64_t __perf_reg_sp_s390(void)
>  {
>         return PERF_REG_S390_R15;
>  }
> +
> +/* %rXX */
> +#define SDT_OP_REGEX1  "^(%r([0-9]|1[0-5]))$"
> +/* +-###(%rXX) */
> +#define SDT_OP_REGEX2  "^([+-]?[0-9]+\\(%r([0-9]|1[0-5])\\))$"
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

nit: Sashiko notes this comment may be stale:
https://sashiko.dev/#/patchset/20260318113416.2287472-1-tmricht%40linux.ibm=
.com

This isn't a bug, but the comment mentions converting the OP into the
+/-NUM(%gprREG) format. Is this a leftover copy-paste from the PowerPC
implementation?

The actual s390 implementation correctly parses and outputs the %rREG forma=
t
as shown in the examples.

Thanks,
Ian

> +int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op)
> +{
> +       int ret, new_len;
> +       regmatch_t rm[6];
> +
> +       *new_op =3D NULL;
> +       ret =3D sdt_init_op_regex();
> +       if (ret)
> +               return -EINVAL;
> +
> +       if (!regexec(&sdt_op_regex1, old_op, ARRAY_SIZE(rm), rm, 0) ||
> +           !regexec(&sdt_op_regex2, old_op, ARRAY_SIZE(rm), rm, 0)) {
> +               new_len =3D 1;    /* NULL byte */
> +               new_len +=3D (int)(rm[1].rm_eo - rm[1].rm_so);
> +               *new_op =3D zalloc(new_len);
> +               if (!*new_op)
> +                       return -ENOMEM;
> +
> +               scnprintf(*new_op, new_len, "%.*s",
> +                         (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1=
].rm_so);
> +       } else {
> +               pr_debug4("Skipping unsupported SDT argument: %s\n", old_=
op);
> +               return SDT_ARG_SKIP;
> +       }
> +
> +       return SDT_ARG_VALID;
> +}
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

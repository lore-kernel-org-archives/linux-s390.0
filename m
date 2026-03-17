Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C331A8F84
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761557; cv=pass; b=DyymcYbG4VUhmq41D7SM0E0SgvphieY/qt+suJb0hXDk4jyzEE+wx7evaYZUlDjwCTirmCLVg+XnaRGz84b6CpzM0yYDXabx3ss5XR9NSiv1FvDDhaklQ+Ridr5h5R+VoCdz5bIFosOVnq0bU3P2aDSRFTfjwnxV9Q+oO3kmWl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761557; c=relaxed/simple;
	bh=ApEZkM0jYqujC4X9S2HoQoK9lEJKjGaSsk15Iej8Ogw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzr2agufDKUq0ZwLxIqpJI9oxaBQwOugUF+ZlfoW8/rEL1LOQ/HVVg0GM4JK4Kh6alLpa8jY2sddWoE0V8CO0uiRBBj00RQH9+8Ia1m2Jjls15m2kTImu4O2LR1/+sPoGowoOJjWhr//iMXAzFDUUbAJ+KZ7tnLkOkAJ543au/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1kmbtSl; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1kmbtSl"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b052ec7176so83495ad.1
        for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 08:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773761555; cv=none;
        d=google.com; s=arc-20240605;
        b=Tq/nVxak2+QcS9uZEfg+LXmJdfBq/R4XxFjT/YO037yDMl0V3mF/GI8KwGWqOBu2lb
         P8JdWHR3vHCo1vIyoOkvSX3U/8ZjO2l0FQWu416T3dMZnNYF2a4HbwdhG1Zh9gf5TpDY
         kNbDksAKA6xVE5LNfwvWdeoHjS/Cqd7Jb5Ega339bQIfPkqb5FS2n1eeUCq5JfOpy1zc
         SR2kOnDUk6zMdSGjq/aclTD/BeQeQh280t+j7ugHxm7pYw09gYVtkV7Mc/zdVRsyWS71
         Wh4t/69ck9LhTn3kHQifLmYw1/NP+nbTHGjdF/bNQerEQMGO/pwnI02DsPSqv3TqYgKr
         IopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BhkaLEEGAixAQMrvos9+dLptA5RYw1Pl3uUnTFzQa/M=;
        fh=w/WA8G7/Evi8C/1avCZhtxintIIQwZLT2HXv4brLieg=;
        b=MHiu1QMHoOqU6/hcFijFZAgMMCNXxGthzvB1jdWVx2ZthmSgtKtp75gt881CwWk9ZX
         JG/itvicQLB58+qB2LRHm2FajMYK5Fz9IEnyGZ2XhGUBNISUUa/fkd6eS3aXO9YoYCzv
         6aAs1PyDMrdcOwwjA/OGB9Zt4Y+8A9fyeTilVeWyXTypL7+PoVxJv9o4LASa5bz7/A1Z
         VHMssrPoIL9CqCtaSvPiezUFtQi8lhQsL9g1IS11SvendCZA0CMBRrJ9BCUrPQ1BjqIN
         o+FcEL7gVv8J4+eCNyqfmRt8nl+g+YHRx7/oqCoKEtl1LTJZMGjh6ShtYPz6dNj+Ig4P
         hDNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773761555; x=1774366355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhkaLEEGAixAQMrvos9+dLptA5RYw1Pl3uUnTFzQa/M=;
        b=J1kmbtSlA9gr4SX9xWNgAorkqiPgNF01ANyakTlWoXO+b+t9U5itXPwzBr+2dqu6Zv
         EUmFsoLCcgx0OtiNUAA1+MioFPpBSESqY8P3qtY6GDpkxviHhJbf3l1YurFDo3t5U9h7
         eO6pdYUtlB0pTTbLygak0LF1k86mDYoQt9DeEMh+iPMiDXvyApJbAxxMwo4VvtmghQWA
         ShQxfgNLLev+XycVqNPR7RrMQtgh/0TU5PH1lI4/MJFGQQuk8cWnxHSlM+FDVUkmhEx9
         aFpZtpFp5ywxuZDuuC4oTThFkbTvYUsDQQsGrImIbwo3mKWELSPx86uv6YoyQYPCkzIa
         OkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773761555; x=1774366355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BhkaLEEGAixAQMrvos9+dLptA5RYw1Pl3uUnTFzQa/M=;
        b=IXCF/mkyHbrHArlJJN5WWZsa9FRTVd7BdeJeikfxaNdhFFPNtYLUb8stC8NEKd5Pwt
         7rs8Xw2Yd7pyRO4J92gU9Lk+koV06JknKx4595njuaPQBUDZVrj2xqwXc55mO8I9207m
         BktgLPEtlo/l3xw3BMeEcVWBVrFvzFMCFRPZp39MuQg+zLd41OCLfu6ELaH3/njccrq3
         r0ASpRAiVx7mv/0CkabCppocPANwCOe2n2HdjlT7jjlXIiJA7WIAhVvs6l5wD/jCox4F
         QoGJHMIxjFnZU1XtLkwOt6nhoYq9uelZtv3KWDRKkayrk9XbtL4uEXXrHzBkYU1oYU79
         9Ngw==
X-Forwarded-Encrypted: i=1; AJvYcCVzrPOuqzHCc8OyuCDF9UTncPSaB1Eb/XafzwJ1JAav5N2CiPWpMbwH3IFNmolZu0TsYF2EWFfp0rE4@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJrvH7a9fSSIWiyrb8nRahCx67XX9pdfkvQBA55nVMrOyHJta
	blfB75i0jHIdakKAZmJjuI5jdjkK323GE0wWoBUxHghcGQk3Jk7t93p3DZhIi5CVUeGC+mPeGJU
	+cC2jBFPTr5tMEYS+HqoVP002QPSU+7NV8pxn7BSc
X-Gm-Gg: ATEYQzyvfJZ3CsbVKuKHTWopFJr7ovuiRKD3fj09VYtbUkP8OhG5SIf586DvBEs5SBT
	ySGKExYPRqX9DZDg/k7kS4zlAuTfOJa8qY0KPeUJkIK29POHTRFSLej3vlzAJEeWTc2jLL79eaR
	N4M/rZAfahqbiLMRzNaM9Je0+PmY5r3j5kcWtGiI+5k8YqqZeYSOs+b5CDIGH3OBGFJllHQGF79
	3XHEyb1kDrdxN4BKZrZbTWe1zCflDfSbRz2ehIXcUf1/Plm4bvUbN1XNTW75a3VObT9OsOkvPSR
	+z6lOo8j
X-Received: by 2002:a17:903:2284:b0:2ae:c566:bd99 with SMTP id
 d9443c01a7336-2b064050a74mr3541605ad.22.1773761554698; Tue, 17 Mar 2026
 08:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317110641.39975-1-tmricht@linux.ibm.com>
In-Reply-To: <20260317110641.39975-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Mar 2026 08:32:23 -0700
X-Gm-Features: AaiRm51sDcxb0oBkf_9EcnaMRntY3oFxYJD4ORK821DJdA0cyvTGiNKYUS_CPhs
Message-ID: <CAP-5=fWL=ium-_+aXe1TfTADuThv1T43hh2RWb+MV2pyZSf8tg@mail.gmail.com>
Subject: Re: [PATCH v3] perf record: Add support for arch_sdt_arg_parse_op()
 on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	dapeng1.mi@linux.intel.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 4:06=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> commit e5e66adfe45a6 ("perf regs: Remove __weak attributive arch_sdt_arg_=
parse_op() function")
> removes arch_sdt_arg_parse_op() functions and s390 support is lost.
> The following warning is printed:

Apologies again for this breakage.

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
> ---
>  .../perf/util/perf-regs-arch/perf_regs_s390.c | 89 +++++++++++++++++++
>  tools/perf/util/perf_regs.c                   |  3 +
>  tools/perf/util/perf_regs.h                   |  1 +
>  3 files changed, 93 insertions(+)
>
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf=
/util/perf-regs-arch/perf_regs_s390.c
> index c61df24edf0f..2aa70eb23311 100644
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
> +#define SDT_OP_REGEX1  "^%(r([0-9]|1[0-5]))$"
> +/* -###(%rXX) */
> +#define SDT_OP_REGEX2  "^([+-]?[0-9]+)\\(%(r[0-9]|r1[0-5])\\)$"
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

Sashiko's review:
https://sashiko.dev/#/patchset/20260317110641.39975-1-tmricht%40linux.ibm.c=
om
notes that here 'initialized' will still be 1, should it be made 0 again?

It triggers an ENOMEM, so I doubt this will be very useful, but it may
make the code read better.

> +       initialized =3D 2;
> +
> +       return 0;
> +
> +free_regex1:
> +       regfree(&sdt_op_regex1);
> +error:
> +       pr_debug4("Regex compilation error, initialized %d\n", initialize=
d);
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
> +       if (ret)
> +               return -EINVAL;
> +
> +       if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
> +               /* Extract %rX */
> +               new_len =3D 2;    /* % NULL */
> +               new_len +=3D (int)(rm[1].rm_eo - rm[1].rm_so);
> +               *new_op =3D zalloc(new_len);
> +               if (!*new_op)
> +                       return -ENOMEM;
> +
> +               scnprintf(*new_op, new_len, "%.*s",
> +                         (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1=
].rm_so);

Sashiko notes this is probably more of an issue:

The allocation size accounts for a % character, but the scnprintf format
string "%.*s" seems to omit it.

Will this output r1 instead of %r1?

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
> +               scnprintf(*new_op, new_len, "%.*s(%.*s)",
> +                         (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1=
].rm_so,
> +                         (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2=
].rm_so);


Similarly, does this scnprintf format string "%.*s(%.*s)" need a %% charact=
er
to produce the correct uprobe format? As written, it appears it will output
48(r1) instead of 48(%r1).

Thanks,
Ian

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

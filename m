Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3463FF1D5
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406446; cv=none; b=mWb6YD3kHfJ4Mfjtsei8f+/UoaM4LshrXPP0TnmWeEA0YchJxxhexekReMpd/otSc6kjdGeGpfZpO5Xl36husB4LrOP8YiiPCsQ8GluTn6XC9sdE47ViUsiIZeKn7Sf2izRWIKihEuMha3lAr4Un33pQQ42J6jEk91kokxlu8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406446; c=relaxed/simple;
	bh=hj/XwCVdONtH0VWyjacCJuXK/a5cu9l5If0Rw/Fj1d0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WPwrf/G3yUHuAA2tcG0xhTkvB+qEEUENuU1r1JUCToYqrDnARL75PqzNi0mqpIJXsPrxXMdEg6AvqfdfiBD+9QAguOaBBmVfIk166iQU+5ji9cDyjh/GmYUrUbYNHZqkjJTvQGG677UpiscWNXtRNAjv2BLbNu9mkMUwUzrxxJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW1U8Y7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW1U8Y7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0FB1F00A3A;
	Thu, 30 Jul 2026 10:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785406441;
	bh=E/sXvpr62ifVowsKmhkX2O73lPLQmuHT2CJIgOzppwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HW1U8Y7rkaPxYzkC/iC8N2Ao4q/ag9kn2Ej1S9ZZnzBPqvOaPVP9PoaoIuHdqPDGq
	 ggmZEFnKuDJ0+ZLGGof1GMjHaBfIBIhBr/nWOrAtKG/E18bS+17L4yoYZYY+lofI83
	 xF0Gau5xrdFnOatz4hwfgzd3zpC6jXow6RIvVDl2NkW6HvX+UNuVk0ezTt9kWILHep
	 z2xSnjrFvdT8AYPljcX9rNdhFlb8xxwf0VK3U4jXkq3BK7sMv5P3I5Q2XFh2kM/5DA
	 sTSeMe9QJL8i9//UwKaxCT5hTkxM/yAJ8jt2/0QfBRsH37w/OvZIJCJ8fRF4lwBbAm
	 sIHv0mScMhw0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] sparc: Implement arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260730-arch_do_panic-v3-3-d5401e683cdb@linux.ibm.com>
References: <20260730-arch_do_panic-v3-0-d5401e683cdb@linux.ibm.com>
 <20260730-arch_do_panic-v3-3-d5401e683cdb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:14:00 +0000
Message-Id: <20260730101401.3A0FB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing explicit `#include <linux/panic.h>` and `#include <linux/pr=
intk.h>` in `arch/sparc/kernel/setup.c`.
- [Low] Redundant local block-scoped `extern` declaration for `stop_a_enabl=
ed`.
--

--- Patch [3]: [PATCH v3 3/3] sparc: Implement arch_do_panic ---
commit 96c609160e8ec354a006cf513eb7fe2d614de6bc
Author: Mete Durlu <meted@linux.ibm.com>

sparc: Implement arch_do_panic

This commit implements a sparc specific arch_do_panic() instead of using
ifdef sections in vpanic() code. It also reorders arch specific panic handl=
ing.

> diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
> index 4975867d9001b..87d3569c520f8 100644
> --- a/arch/sparc/kernel/setup.c
> +++ b/arch/sparc/kernel/setup.c
[ ... ]
> @@ -36,6 +36,14 @@ static const struct ctl_table sparc_sysctl_table[] =3D=
 {
>  #endif
>  };
> =20
> +void arch_do_panic(void)
> +{

[Severity: Low]
Should this file explicitly include <linux/panic.h> and <linux/printk.h>?

Since arch_do_panic() is a globally exported function, missing the panic.h
header can cause a missing prototypes warning during compilation. It might
also be better to explicitly include printk.h for pr_emerg() rather than
relying on implicit header inclusions.

> +	extern int stop_a_enabled;

[Severity: Low]
Is this block-scoped extern declaration still needed?

While this declaration was copied from its old location in kernel/panic.c,
it is redundant here because arch/sparc/kernel/setup.c already includes
<asm/setup.h>, which provides the exact same global extern declaration for
stop_a_enabled.=20

> +	/* Make sure the user can actually press Stop-A (L1-A) */
> +	stop_a_enabled =3D 1;
> +	pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
> +		 "twice on console to return to the boot prom\n");
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-arch_do_pa=
nic-v3-0-d5401e683cdb@linux.ibm.com?part=3D3

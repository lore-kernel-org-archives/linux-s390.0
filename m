Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7B1397
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787960115; cv=none; b=hW3NVEfTJczWGTOcOFiiQVOIKkK6xb2ZvVbAQdHyAvm2HM2EzQFMTx00qIigY4ORTyszws5r/bLkEhH7ygwKQfitfnAozJYi/KNp359ocN6O1AIGq7p0v2VBlK8/HGEW3u91/v9ob7bjlZ/1T452V86AxVIs7h8Xm66HRV7LeDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787960115; c=relaxed/simple;
	bh=OO3HJ0IXXCcMF8GqWYquTWYHQiWi1aasKHNUAPCTZkQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IT5H2vj0GR70Falb7cz/0ZcRDUe1jzNd4R0wK3/SVDFitiP11Q6T9JU/l1FDjX1pjOaua5yS1VcKVOs/G1Q5yUoBLHm9Kt98CtSTLY5KCIiux31CrxMScophNyl0+JM1mHTk6Sk02EScJssKIpVb6XyxdzN2WsbPcPfH8IrBDSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCuk3RGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCuk3RGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20641F000E9;
	Fri, 28 Aug 2026 23:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787960113;
	bh=rqQSmmcet1dLuPZTCAYb04LSiT4lEJnRH/slMtZWLG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jCuk3RGgKMzMcQFSnppopxKeo2bATOYKGaxAuRCFWFddlf9AKfWQdcErA7aDXcfec
	 OetH8e5wwSCgDLMozSviCuqNrQRZkvHg7WTQOjvxptan48LIf1ENYZk9NJ4rRNwTYa
	 6LLWbyI2JqlhPg2Ip0j26doGO96VzyCjLNNatx3EjD3HZdKLkHNT7PcJGjdZRZa8hZ
	 6m+CRc1osn6bTKMWQWw5Mloe9arPq4/Fyh2rp1ujXzD5sYXcEZRHgKo36szQDWAa/i
	 CZ1k6/4YBr+zS1mFiHLfZfOHH1wD/V8Yxrds8e/qprNApFSI0M8SXdBOvdUj8RrPZ0
	 5VjczHXiWSJgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/13] arm: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260828-tonyk-syscall_table-v6-4-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <20260828-tonyk-syscall_table-v6-4-fdd358456cf1@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 23:35:12 +0000
Message-Id: <20260828233512.F20641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Enabling `CONFIG_OABI_COMPAT` on ARM results in a build failure (li=
nker error) due to undefined references to generic `compat_sys_*` functions=
 (e.g., `compat_sys_pselect6_time64`).
--

commit 2bf52522202bca8bc80bed32cfca4dba194babdc
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

arm: Use the common syscall table

This commit removes duplicated syscall definitions for ARM by using the
common syscall number table.

> diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
> index 28b6da8ac5f64..9ea6c853e241f 100644
> --- a/arch/arm/tools/Makefile
> +++ b/arch/arm/tools/Makefile

[ ... ]

> @@ -38,20 +40,22 @@ $(kapi)/mach-types.h: $(src)/gen-mach-types $(src)/ma=
ch-types FORCE
>  	$(call if_changed,gen_mach)
> =20
>  quiet_cmd_syshdr =3D SYSHDR  $@
> -      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --abis common,$* \
> +      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --abis $(abis),$* \
> +		   --common-tbl $(syscalltbl_common) \
>  		   --offset __NR_SYSCALL_BASE $< $@
> =20
>  quiet_cmd_systbl =3D SYSTBL  $@
> -      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
> +      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) --abis $(abis),$* \
> +		   --common-tbl $(syscalltbl_common) $< $@

[Severity: Low]
Does using the common syscall table here break the build when
CONFIG_OABI_COMPAT is enabled?

The abis variable includes "32", which pulls in entries from
scripts/syscall_common.tbl. This table maps several syscalls to
their compat versions, such as:

413 32 pselect6_time64 sys_pselect6 compat_sys_pselect6_time64

For OABI, arch/arm/kernel/entry-common.S routes these via:

#undef __SYSCALL_WITH_COMPAT
#define __SYSCALL_WITH_COMPAT(nr, native, compat)       __SYSCALL(nr, compa=
t)
#include <calls-oabi.S>

This seems to cause the generated calls-oabi.S to reference generic
compat functions like compat_sys_pselect6_time64, which are not
compiled on 32-bit ARM, leading to undefined references during linking.

Is there a way to filter out or avoid routing these compat wrappers
for the ARM OABI table?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-tonyk-sysc=
all_table-v6-0-fdd358456cf1@igalia.com?part=3D4

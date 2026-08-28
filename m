Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AFF1397
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787960125; cv=none; b=GhUJWLQ7p8z4K2YhSiFPeaJz6x6ygxtu4sOwwevZ+w5miL6trJ8Z+cXvOoUkHH4MZkjyyaCinVaVPE37uwUo86If6KemLODidQ5pNQwO2KhrqWTrj3xsz8vWq7HjOw+Hb0YREOEzh8xNQ1W2oF1jwae312VYvc3UWD+UVWt+RKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787960125; c=relaxed/simple;
	bh=5TJaPrThdlF8QneBDyIeVjwd07+2s0nCC8LDaJcCv04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hV+fdc2X76TeUnCUIU3T5p6P1jwJGrAQaNB79btU+cdkuenNkRz9h8IsCs69RlKfQkC2/mNqEnButQnnAevYzmcijhFFmIsYs9NpWgw/BDl2kkpGoiseWgfKC0LU6G8c7O7zTrjoX2K9keWsqKrH+TYQa6l37Nv8IehkVPHlf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYEmfcfd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYEmfcfd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36BB1F000E9;
	Fri, 28 Aug 2026 23:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787960124;
	bh=lDQa5A6985UTqAONH7A4Te5w3md2CM3bUUjLY0BtwbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YYEmfcfd3mixI74NURxtd6sqTXLDbNp8428UTg//rwRKmpY+UaN61GKmD5TSj1jL8
	 z/ECBduTm2hNp5mJj6E+/RAD6UHgBspc/x02QG/sURGGeKZNm/42dfFvTjga1enyTr
	 I0DrY2kyvGH7ZawbI5YGh4qurWj6/jAIHgfy9tcp4Tm/5cDGVriuOonohdU5DOpIqq
	 QTOQE+wnA+HI5rLhVJTnvpQpPwcZl+ea/mttTBj4kNyjWp/9MueqvtV3d+Bibg/ETD
	 ESKIudxLIUHmzzx4eplVlxLoMr3N6QlpgUqPBYSM8MIsx40yvcpEp8dADzw3gRgb9y
	 b98hKIg6RpviA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/13] mips: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260828-tonyk-syscall_table-v6-9-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <20260828-tonyk-syscall_table-v6-9-fdd358456cf1@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 23:35:23 +0000
Message-Id: <20260828233523.D36BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Missing `--abis` flag in `cmd_sysnr` creates a latent out-of-bou=
nds kernel memory access vulnerability on the syscall table.
- [Low] Typo in `rt_sigtimedwait` syscall entry causes linker error for N64=
 ABI.
- [Low] Typo in `ustat` syscall entry causes linker errors for both N32 and=
 N64 ABIs.
- [Low] Build fatally broken due to missing and deleted prerequisites in Ma=
kefile rules for generated headers.
--

commit dbd1eadaff2c006f6b57d84d5f841a630aa58232
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

mips: Use the common syscall table

This patch migrates MIPS to use the common syscall table from number 403
onwards, taking advantage of the shared numbers across architectures. It
merges the N32 and N64 syscall tables into a single syscall_n.tbl file and
updates the Makefile rules for generation, maintaining functional parity for
the O32, N32, and N64 ABIs.

> diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscal=
ls/Makefile
> index 1bfc2346d1009..aaa5443ea9068 100644
> --- a/arch/mips/kernel/syscalls/Makefile
> +++ b/arch/mips/kernel/syscalls/Makefile
[ ... ]
>  quiet_cmd_sysnr =3D SYSNR   $@
>        cmd_sysnr =3D $(CONFIG_SHELL) $(sysnr) \
>  		  --prefix $(sysnr_pfx_$(basetarget))_Linux_ $< $@

[Severity: Medium]
Should this command also include the --abis flag like cmd_syshdr does? Since
cmd_sysnr runs on the common table without filtering by ABI, it seems it
might extract the highest syscall number across all ABIs. If a 32-bit-only
syscall is added later, couldn't this make __NR_64_Linux_syscalls larger th=
an
the actual generated N64 table?=20

A mismatch like this might allow an out-of-bounds read during the syscall
bounds check in scall64-n64.S. Also, because $(src_$*) is missing here, any
local syscalls wouldn't be counted either.

>  quiet_cmd_systbl =3D SYSTBL  $@
> -      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) $< $@
> +      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) \
> +		   --common-tbl $(systbl_common) \
> +		   --abis $(abis_$*) $(src_$*) $@
> =20
>  $(uapi)/unistd_%.h: $(src)/syscall_%.tbl $(syshdr) FORCE
>  	$(call if_changed,syshdr)

[Severity: Low]
Does this rule need to be updated to use $(src_$*) instead of
$(src)/syscall_%.tbl? Since this patch deletes files like syscall_n32.tbl a=
nd
syscall_n64.tbl, Kbuild might fail with a "No rule to make target" error wh=
en
trying to build unistd_n32.h because it will still look for the deleted
tables.

[ ... ]
> -$(kapi)/syscall_table_%.h: $(src)/syscall_%.tbl $(systbl) FORCE
> +$(kapi)/syscall_table_%.h: $(systbl) $(systbl_common) FORCE
>  	$(call if_changed,systbl)

[Severity: Low]
Is it intentional to drop the local table variable $(src_$*) from the
prerequisites here? Without it, Kbuild might not trigger incremental rebuil=
ds
if the local syscall table gets modified.

> diff --git a/arch/mips/kernel/syscalls/syscall_n.tbl b/arch/mips/kernel/s=
yscalls/syscall_n.tbl
> new file mode 100644
> index 0000000000000..e3d278f715b7e
> --- /dev/null
> +++ b/arch/mips/kernel/syscalls/syscall_n.tbl
[ ... ]
> +124	common	capset				sys_capset
> +125	common	rt_sigpending			sys_rt_sigpending	compat_sys_rt_sigpending
> +126	common	rt_sigtimedwait			sys_rt_sigtimedwait_time	compat_sys_rt_sigt=
imedwait_time32

[Severity: Low]
Could there be a typo in the native entry point name here? The kernel funct=
ion
is sys_rt_sigtimedwait, so sys_rt_sigtimedwait_time seems likely to cause an
unresolved symbol error when linking the N64 ABI.

> +127	common	rt_sigqueueinfo			sys_rt_sigqueueinfo	compat_sys_rt_sigqueuei=
nfo
> +128	common	rt_sigsuspend			sys_rt_sigsuspend	compat_sys_rt_sigsuspend
> +129	common	sigaltstack			sys_sigaltstack		compat_sys_sigaltstack
> +130	common	utime				sys_utime		sys_utime32
> +131	common	mknod				sys_mknod
> +132	common	personality			sys_personality		sys_32_personality
> +133	common	ustat				sys_usta		compat_sys_usta

[Severity: Low]
Is it possible that the trailing 't' was accidentally truncated on these en=
try
points? Using sys_usta and compat_sys_usta instead of sys_ustat and
compat_sys_ustat will likely break the build with undefined references for
both N32 and N64 ABIs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-tonyk-sysc=
all_table-v6-0-fdd358456cf1@igalia.com?part=3D9

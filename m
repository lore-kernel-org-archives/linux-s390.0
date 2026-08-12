Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03216480DCB
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558207; cv=none; b=fjkY1Mje0mc85/Yee2zRhmbupKgq0q29Jigi/TBbHYuJS7rNn4ErTAKit9+a7G98LBopup3GxoX7HGbF7zOEt0XBkoRcUNhffuIiOKyW7I008PXPq4usl1iaUJxHpvbCZpi9m/mx6FXk7rCpNWUXQFa2I7BiYemrC4M6c+EdV3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558207; c=relaxed/simple;
	bh=6WEFSiD3ZQTZYkFueD+0KNcF+91/IFKGmaeXG5gfbqg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CVAL8mLxvugAAxtVX1C5SW36aiT/Cxod4wauB3X7rnT3tdUwKHioI9xg/n3Ib52p6+SoW8i9wI4xzDlNFAGK+U1guekQ70fJS61/8e8vPWxaCwpoYPxhxvG77LySKGxjbLJZAQoHXiUYHwtbrF7RvS0sCa+EYyDaMr4o+1yTjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iceDLi3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iceDLi3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59DB1F000E9;
	Wed, 12 Aug 2026 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786558204;
	bh=td193d6Tmfquog1HrFbmsxDTxVt1CrE/ZzPZ4g4ZXVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iceDLi3+mWtFF4+SgQHFzR6KOLmgmkCu+lkQYp7jAhtJEqbE/DtA7DyURtQuwC4QN
	 AwA/2HnbkTGrrwllwh+9FwSwvPAJVKtPIa6/h8C/lB5KY3/wenYMAHR/MtDmcgIP5p
	 MpSxGXbrZst+s4//6AimZf1EeHWVwPkmntSltjM8xScVmgSFPCmlr3t9sXRD5s6z6y
	 JSnpqC5h7al11IaKQWSlQKDqybAdhJSP97kwoNH0xuvDxkaBWNxlYDAnSbwKQk12qC
	 S1A2zqas/lw90nAMX1SPTQFKY6QgLxi7C2yJOp6KTuoRVsjTw/R1l9nOUGPs0Nz5Lu
	 rerbfuxxkfFHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/13] arm: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812-tonyk-syscall_table-v5-4-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
 <20260812-tonyk-syscall_table-v5-4-3d383927c609@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 18:10:03 +0000
Message-Id: <20260812181003.D59DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Using the common syscall table on 32-bit ARM breaks OABI compatibi=
lity for several time64 and wait syscalls due to missing or weak-linked `co=
mpat_sys_*` entry points.
- [High] Process substitution `< <(...)` breaks POSIX `/bin/sh` compatibili=
ty, causing kernel build failures on systems using dash.
--

--- Patch [4]: [PATCH v5 04/13] arm: Use the common syscall table ---
commit 4446b58b5d8e69028beb1ab8dad93b78f955eb73
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

arm: Use the common syscall table

This commit updates the ARM architecture to use the common syscall table.
It replaces duplicated ARM-specific syscalls with the common ones by pulling
in syscall_common.tbl and updating the ABI list.

> diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
> index 28b6da8ac5f64..fd73bf6db3bfe 100644
> --- a/arch/arm/tools/Makefile
> +++ b/arch/arm/tools/Makefile
[ ... ]
> @@ -38,11 +40,13 @@ $(kapi)/mach-types.h: $(src)/gen-mach-types $(src)/ma=
ch-types FORCE
>  	$(call if_changed,gen_mach)
> =20
>  quiet_cmd_syshdr =3D SYSHDR  $@
> -      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --abis common,$* \
> +      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --abis $(abis),$* \
> +		   --common-tbl $(syscalltbl_common) \
>  		   --offset __NR_SYSCALL_BASE $< $@

[Severity: High]
Does this execute scripts containing non-POSIX bashisms?

The scripts/syscallhdr.sh script uses process substitution which requires b=
ash:

scripts/syscallhdr.sh:gen_hdr() {
    ...
    done < <(grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input")
}

scripts/syscalltbl.sh also uses a similar construct in gen_tbl().

This breaks POSIX /bin/sh compatibility and can cause kernel build failures
reporting "Syntax error: redirection unexpected" on distributions that use
dash as their default shell.

>  quiet_cmd_systbl =3D SYSTBL  $@
> -      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
> +      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) --abis $(abis),$* \
> +		   --common-tbl $(syscalltbl_common) $< $@

[Severity: High]
Does pulling in the common syscall table break OABI compatibility for
32-bit ARM?

The common table populates the compat column with compat_sys_* functions
intended for CONFIG_COMPAT, for example:

scripts/syscall_common.tbl:
    413  32  pselect6_time64  sys_pselect6  compat_sys_pselect6_time64

However, ARM OABI redefines __SYSCALL_WITH_COMPAT to use the compat column
specifically for its own OABI wrappers, not for 64-bit-on-32-bit compat
wrappers:

arch/arm/kernel/entry-common.S:sys_oabi_call_table() {
    #undef __SYSCALL_WITH_COMPAT
    #define __SYSCALL_WITH_COMPAT(nr, native, compat) __SYSCALL(nr, compat)
}

This clash causes build failures like "undefined reference to
compat_sys_pselect6_time64" during linking when CONFIG_OABI_COMPAT is enabl=
ed.
For syscalls with weak stubs in kernel/sys_ni.c (like io_pgetevents_time64),
the build succeeds but OABI binaries will silently receive -ENOSYS at runti=
me.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-tonyk-sysc=
all_table-v5-0-3d383927c609@igalia.com?part=3D4

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997228;
	b=cxsx4qPz8eQQxZTT1PGOMsJbgTrg4GQFMvCDUd0VBTMvDH3qqSmW3FyTNZsw4DiovWS1
	 xSO8p5Wr9T8AkauIFscaFSp0XBjM9uInTsCvOGvglCh8/4D2dRMuykE2h8M/gajXoj511
	 4eo9JaCX19mNqTnAXCDORBUUdOmYzZ/VyRPM8uXipECq/JBTGjp1uw1j2XHYd4SxtzDd0
	 bZjQHqA1NTFT9eOLCOSwZe81OG4s0BeY9Pbnqv9S38dEY8Et2O7dojpexzyDOD7h18xXY
	 bS5jJFJTvEaP8SD1FA2AGq9Poi1VcnWdLTC0204qTnd2Jbx+F3Wodc9yDKNE5icou1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997228;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y0HE2WoOUooJZsk8MBhpeVE91XrH4bDn1VveDmcxCjc=;
	b=ycPcQnEtp1Xa5ujw6VDy6Gz9ZyJlCXUMVpxcEvxKVfKrsK3Syv+6k+3y07r1cm6jFgBA
	 EjM3ijyQBjnmYGRcqAh1+4YbCZjyONOxDm1u82S67amMFUKTyEOf10awR9axZvaTrlyjq
	 P3vuLpnChI6A2giTadj1/eaEBFHmjrlrV7mEn3OqgUWeIxGoXVaexStxjnY0gW80bNwn4
	 JG3VBp8aedAovlT7IMt6sg/QnoqJIiq2lwBjVzka036R8yEVBZ9VhJVLWht7sAKM/I0pm
	 TDMueG/tozLaR4Bohazso7WSeyj4R3qJn3DJRSiMrim8Jgkvy7P5FrD51T0gdjr0Q3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3G5bUk3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBC606A334;
	Fri,  6 Nov 2026 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3G5bUk3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BC91F0089F;
	Fri,  6 Nov 2026 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997227;
	bh=Y0HE2WoOUooJZsk8MBhpeVE91XrH4bDn1VveDmcxCjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a3G5bUk3DTKKIeKkMKf3Jqu5ffYoFAZCH7GtYtkOCRSOoVFUhk+xkZYBuR9TpE4Ok
	 pU4GY2rKdMGkospQ6pkIc9UGNj0yCdr5PdfeXFrYlZp344qrWBQDo1t6Jirl0jK0ei
	 M23Ukd4hozO+JiB/EHbKAfyJ+CQ2X+5Ujwkrdkahxhu+H5Yj0cUOgwkV3oXTCjzJez
	 j+8RxjaCFnSknmQIxZ9WTF83AM/NjTxMuTjx0g4GobMU8Q9JZaGtpG2OPX/qq1bBfy
	 +/5QQOJMWYYGTFM+23nUJFTlI9e/YJ/jLjc/I5BcftiMjdCdORlFJkKjcUd+dn2dvT
	 pZW+ZBeBEJonA==
Message-ID: <sashiko-outbox-202228@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 15/15] arm: Use common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Arnd Bergmanon" <arnd@arndb.de>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, nathan@kernel.org, nsc@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-15-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-15-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:46 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] arm: syscalls: missing oabic entry for sys_syscall() breaks
  OABI syscall(113)
- [Low] arm: syscalls: gen-y overwrite in arch/arm/tools/Makefile breaks
  !CONFIG_AEABI
--

commit d6fa13c999788d3882cc5cb046177290257ed17e
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

arm: Use common syscall table

This commit switches arch/arm to use the shared scripts/syscall_common.tbl
for common syscall numbers 403 and above, updating arch/arm/tools/Makefile
and removing the duplicated entries from arch/arm/tools/syscall.tbl.

> diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
> index cde235b382bdc..6fed368c3df77 100644
> --- a/arch/arm/tools/Makefile
> +++ b/arch/arm/tools/Makefile
> @@ -12,6 +12,8 @@ syshdr :=3D $(srctree)/scripts/syscallhdr.sh
>  sysnr :=3D $(src)/syscallnr.sh
>  systbl :=3D $(srctree)/scripts/syscalltbl.sh
>  syscall :=3D $(src)/syscall.tbl
> +syscalltbl_common :=3D $(srctree)/scripts/syscall_common.tbl
> +abis :=3D common,clone3,32
> =20
>  gen-y :=3D $(gen)/calls-oabi.S
>  gen-y :=3D $(gen)/calls-oabic.S

[Severity: Low]
Does assigning gen-y :=3D $(gen)/calls-oabic.S with :=3D instead of +=3D he=
re in
arch/arm/tools/Makefile break builds when CONFIG_AEABI is disabled?

Because :=3D overwrites gen-y, $(gen)/calls-oabi.S is dropped from both
targets and the kapi prerequisites in arch/arm/tools/Makefile:

    gen-y :=3D $(gen)/calls-oabi.S
    gen-y :=3D $(gen)/calls-oabic.S
    gen-y +=3D $(gen)/calls-eabi.S
    ...
    targets :=3D $(patsubst $(src)/%,%,$(kapi-hdrs-y) $(uapi-hdrs-y) $(gen-=
y))

    PHONY +=3D kapi uapi
    kapi:   $(kapi-hdrs-y) $(gen-y)

When building a non-AEABI kernel (such as rpc_defconfig or assabet_defconfi=
g),
sys_call_table in arch/arm/kernel/entry-common.S includes <calls-oabi.S>:

    #ifdef CONFIG_AEABI
    #include <calls-eabi.S>
    #else
    #include <calls-oabi.S>
    #endif

Since arch/arm/include/generated/calls-oabi.S is no longer generated, the
build fails with a missing header error. Should the second assignment use
+=3D instead?

[ ... ]

> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 944f11030ab4a..36c1e5cc3e022 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -463,72 +463,3 @@
>  400	common	migrate_pages		sys_migrate_pages
>  401	common	kexec_file_load		sys_kexec_file_load
>  # 402 is unused

[Severity: High]
With the switch to calls-oabic.S for CONFIG_OABI_COMPAT earlier in this
series (commit f142c55483ad), is syscall 113 (sys_syscall) missing an oabic
entry in arch/arm/tools/syscall.tbl?

Currently arch/arm/tools/syscall.tbl only defines syscall 113 for oabi:

    # syscall to call a syscall!
    113	oabi	syscall			sys_syscall

In arch/arm/kernel/entry-common.S, sys_oabi_call_table (built under
CONFIG_OABI_COMPAT) now includes <calls-oabic.S>, which is generated with
--abis $(abis),oabic:

    	syscall_table_start sys_oabi_call_table
    #undef __SYSCALL_WITH_COMPAT
    #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
    #include <calls-oabic.S>
    	syscall_table_end sys_oabi_call_table

And sys_syscall in arch/arm/kernel/entry-common.S explicitly handles OABI
indirect syscalls by clearing __NR_OABI_SYSCALL_BASE and indexing into tbl:

    sys_syscall:
    		bic	scno, r0, #__NR_OABI_SYSCALL_BASE
    		cmp	scno, #__NR_syscall - __NR_SYSCALL_BASE
    		cmpne	scno, #NR_syscalls	@ check range

Without a matching oabic entry for syscall 113 in arch/arm/tools/syscall.tb=
l,
calls-oabic.S emits __SYSCALL(113, sys_ni_syscall), causing indirect
syscall(2) invocations from OABI user-space binaries under CONFIG_OABI_COMP=
AT
to fail with -ENOSYS.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D15

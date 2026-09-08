Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733D38F957
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851909; cv=none; b=Owrcp9wq5eScE5KFSPswSmT/pOgbNeK3JmiS9qN6haJEQK0VnGwNHz8Lx+d5taBtnV2EzSY7eZVJuP72wtXkoMV1yWCtI3VCis5dqpQF7MHbznipFy89uGpHcYwmteGjkpgtay45arxbkWHs7bQ3ZiR069zI+nypqqTzbp7+g40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851909; c=relaxed/simple;
	bh=4sboBnRxZLzaQdz6XniOnt49Dbt/4pRCkMZXw/7rZTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BqbrsswbV7cGMNZM/EMeWFwnH6R8KdAp/yKBVRFMY5Q60g2vh3W/a3mx2B49wB+0BXA135aXm85f8R6qBH3RMTNqmJmiS3claBarLnA4SdWrO2Xrd3C0Tgb9wxo9SrhVYSAxIsHFO7GP2HhCuoh6lSso2eNEL5uyhvrhvrwIA8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h84neVXO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h84neVXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3382E1F00A3D;
	Tue,  8 Sep 2026 07:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788851907;
	bh=QRXMJ9o1NAhNQZtra9jx0z5Ij0M1rYYYr7/lCshPBvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h84neVXOSUtf0hXbIoSEwLxKAdtr7j/5+fnS4xjHx0aTSlvHnunJVQhloa/BxyVT5
	 q/5U+NWFTHZLUAyg7Pjjv+Yq6eUbNWpBGvAVWhpEaYhchUvAM3WQvmUO1Gqbmirm6f
	 I4t5CMZR7tF46/6tiPqRHbADaUIm3mCtMFU7A+X2J1a9cLyd5RTf+WaiMFrUXNZCYG
	 J4LVCATrGKCEX/40cH7r/xpcIflI258YViZMiVhQzqvChux5861iU2xpBcS+QpT1BF
	 7mwm/qtt9iXPO04ooM6355LXTEtbapXv+rH1ohycC9ICTLMPN/AonBwmj74rmTbEDG
	 Dz4WmTDRDkXfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 24/24] vDSO: Automatically enable VDSO_CHECK
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, ojeda@kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-24-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-24-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:18:26 +0000
Message-Id: <20260908071827.3382E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The vDSO validation tool (vdsocheck) is silently disabled for ar=
chitectures that build a vDSO without generic vDSO support, such as 32-bit =
RISC-V and certain MIPS configurations.
--

commit e3e25811a83a299ee06c24876df0a2be2333e202
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

vDSO: Automatically enable VDSO_CHECK

This patch removes the explicit selection of VDSO_CHECK from architecture
Kconfigs and attempts to enable it automatically via GENERIC_GETTIMEOFDAY a=
nd
VDSO_GETRANDOM.

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 6cd04a9d52813..a06f243173060 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -107,7 +107,6 @@ config MIPS
>  	select TRACE_IRQFLAGS_SUPPORT
>  	select ARCH_HAS_ELFCORE_COMPAT
>  	select HAVE_ARCH_KCSAN if 64BIT
> -	select VDSO_CHECK

[Severity: Medium]
Does this removal silently disable vDSO validation for some MIPS
configurations? MIPS unconditionally selected VDSO_CHECK prior to this patc=
h,
but now it will only get it if MIPS_GENERIC_GETTIMEOFDAY is enabled, which
depends on specific hardware clocksources like CSRC_R4K or CLKSRC_MIPS_GIC.
Without it, the build system falls back to a weaker legacy readelf script a=
nd
misses the deeper object-file validation provided by the Rust-based vdsoche=
ck
tool.

[ ... ]

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e123068e15d4c..019fb47999438 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -226,7 +226,6 @@ config RISCV
>  	select THREAD_INFO_IN_TASK
>  	select TRACE_IRQFLAGS_SUPPORT
>  	select UACCESS_MEMCPY if !MMU
> -	select VDSO_CHECK if MMU
>  	select VDSO_DATASTORE if MMU
>  	select VDSO_GETRANDOM if MMU && 64BIT

[Severity: Medium]
Will 32-bit RISC-V lose VDSO validation here? 32-bit RISC-V with MMU selects
VDSO_DATASTORE, but does not select GENERIC_GETTIMEOFDAY or VDSO_GETRANDOM
(since the latter requires 64BIT). Removing VDSO_CHECK here leaves 32-bit
architectures without the deeper object-file validation provided by
vdsocheck.

[ ... ]

> diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
> index 112b42a5aeb1a..12a640c78b72f 100644
> --- a/lib/vdso/Kconfig
> +++ b/lib/vdso/Kconfig
> @@ -6,6 +6,7 @@ config VDSO_DATASTORE
>  config GENERIC_GETTIMEOFDAY
>  	bool
>  	select VDSO_DATASTORE
> +	select VDSO_CHECK
>  	help

[Severity: Medium]
Is it intentional to tie a generic validation tool like VDSO_CHECK strictly
to specific vDSO features like GENERIC_GETTIMEOFDAY and VDSO_GETRANDOM? As
noted above, this seems to miss architectures that build a vDSO without
generic vDSO support but still rely on vdsocheck.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D24

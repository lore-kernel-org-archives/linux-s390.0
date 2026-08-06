Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251C023E33D
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997560; cv=none; b=Z1mc8C9ewcVOvL3RQ8HDx99NryYoa0ooUkFjjIOvV2bn6Iio4T22tuTroOKR/KDDXEV9RhQcthJJY1sW5TaUg8KnH/Id3iKhqtO4Er2Pz/PKb75nLMw8F+1IhJ4LLTqZCjVqzdYC1tSZlkaSnedAk/c3zsplyN7KqcmM+R5f6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997560; c=relaxed/simple;
	bh=B6U2zwD9/FPET9gE7G0V9jpMaK2cl+wx81CM5c3SIHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qnZaxwpOAp1Ch/AqI4sZmcuz9sp5wgWjAonEo6xH5KYn1xoZlPvBrp+uGqYrVr1DFsoG1BI202DllWA8/lsMC4PwfGJd6sJlSAORBDJ3V4krhwcCOS0pXdAXPRlFjj5FCVO+t6NjHWoCWZ1GCJwHBue9Hyx3HOLRLhJL0aQAtKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM7xFZPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM7xFZPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DD01F000E9;
	Thu,  6 Aug 2026 06:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785997558;
	bh=5wNR10o39tBbn3nvWi1DM+K0NILIyGYoVCeAjPEYfpA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YM7xFZPxuCKU1NHSrOokouvNrsz9qOavx1kbYhqOlHaD2Mq7g9m/5Z6+upK36+Wq0
	 vqqVTIsrD7Kkqk9uvfNvBIJ1JB6AQIWUyzX+8vBAIWghuKuIlMqgAUl2DEKKM5aZG1
	 g1uHiTu+DtGKnFsAJg6zZ2tlXy9cEX/DsiVmFLojmtbSk11gNIwoinkTIeKJ9L6pp1
	 OVg4IPsPbb1379vVVuDA5A3S8PO1ZVl4o9inRMjOh+km6wN+l96iw4QYxGsQxdMe2b
	 NjviusNPqLmyIkvTeN3mpKOWaKhSAT6SBV6DC4QpLt2vD1Ny88WIhQxRw8rwBbWxRY
	 Bs6SiC7nJicKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] arch: use CONFIG_COMMAND_LINE_SIZE across all
 architectures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wilson Felipe Pereira" <wfelipe@google.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260806061429.474992-3-wfelipe@google.com>
References: <20260806061429.474992-1-wfelipe@google.com>
 <20260806061429.474992-3-wfelipe@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 06:25:57 +0000
Message-Id: <20260806062558.68DD01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] RISC-V default command line size is silently truncated from 2048 t=
o 1024 bytes.
- [High] Exposing COMMAND_LINE_SIZE to Kconfig allows deterministic stack e=
xhaustion in the ARM boot decompressor.
- [High] Configurable COMMAND_LINE_SIZE causes stack exhaustion during earl=
y boot on m68k Atari.
--

--- Patch [2]: [PATCH 2/3] arch: use CONFIG_COMMAND_LINE_SIZE across all ar=
chitectures ---
commit 86e4b8b798d614166a3d212659ea7796c8a7ee99
Author: Wilson Felipe Pereira <wfelipe@google.com>

arch: use CONFIG_COMMAND_LINE_SIZE across all architectures

This commit updates every architecture's setup.h to define COMMAND_LINE_SIZE
using CONFIG_COMMAND_LINE_SIZE for the kernel. The historical hardcoded
defaults are retained in user-space API headers by wrapping the definition
in an #ifdef __KERNEL__ guard.

> diff --git a/arch/arm/include/uapi/asm/setup.h b/arch/arm/include/uapi/as=
m/setup.h
> index 8e50e034fec73..4aa93558af1e7 100644
> --- a/arch/arm/include/uapi/asm/setup.h
> +++ b/arch/arm/include/uapi/asm/setup.h
> @@ -17,7 +17,11 @@
> =20
>  #include <linux/types.h>
> =20
> -#define COMMAND_LINE_SIZE 1024
> +#ifdef __KERNEL__
> +#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
> +#else
> +#define COMMAND_LINE_SIZE	1024
> +#endif

[Severity: High]
Does exposing COMMAND_LINE_SIZE to Kconfig allow deterministic stack exhaus=
tion
in the ARM boot decompressor?

The ARM boot decompressor uses a fixed 4KB stack (.L_user_stack in
arch/arm/boot/compressed/head.S), and merge_fdt_bootargs() allocates:

arch/arm/boot/compressed/atags_to_fdt.c:merge_fdt_bootargs() {
    ...
	char cmdline[COMMAND_LINE_SIZE];
    ...
}

If a user configures CONFIG_COMMAND_LINE_SIZE to a value larger than ~3KB,
will this stack allocation deterministically crash on boot?

[ ... ]

> diff --git a/arch/m68k/include/uapi/asm/setup.h b/arch/m68k/include/uapi/=
asm/setup.h
> index 25fe26d5597cc..2d5b24a5345f9 100644
> --- a/arch/m68k/include/uapi/asm/setup.h
> +++ b/arch/m68k/include/uapi/asm/setup.h
> @@ -12,6 +12,10 @@
>  #ifndef _UAPI_M68K_SETUP_H
>  #define _UAPI_M68K_SETUP_H
> =20
> -#define COMMAND_LINE_SIZE 256
> +#ifdef __KERNEL__
> +#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
> +#else
> +#define COMMAND_LINE_SIZE	256
> +#endif

[Severity: High]
Can a configurable COMMAND_LINE_SIZE cause stack exhaustion during early bo=
ot
on m68k Atari?

atari_switches_setup() allocates an array locally on the limited kernel sta=
ck:

arch/m68k/atari/config.c:atari_switches_setup() {
    ...
	char switches[COMMAND_LINE_SIZE];
    ...
}

Will tying this to an unbound Kconfig option introduce deterministic stack
exhaustion on boot for m68k Atari kernels?

[ ... ]

> diff --git a/arch/riscv/include/uapi/asm/setup.h b/arch/riscv/include/uap=
i/asm/setup.h
> index eb4f0209c6960..a6c1f4b0987e3 100644
> --- a/arch/riscv/include/uapi/asm/setup.h
> +++ b/arch/riscv/include/uapi/asm/setup.h
> @@ -3,6 +3,10 @@
>  #ifndef _UAPI_ASM_RISCV_SETUP_H
>  #define _UAPI_ASM_RISCV_SETUP_H
> =20
> +#ifdef __KERNEL__
> +#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
> +#else
>  #define COMMAND_LINE_SIZE	2048
> +#endif

[Severity: High]
Is the RISC-V default command line size silently truncated from 2048 to 1024
bytes?

The Kconfig default in init/Kconfig erroneously groups RISC-V with ARM and
PARISC (1024):

init/Kconfig:
	default 1024 if ARM || PARISC || RISCV

By replacing the kernel definition with CONFIG_COMMAND_LINE_SIZE here, does
this create a dangerous discrepancy where userspace headers claim the limit
is 2048, while the kernel internally enforces 1024 and truncates existing
boot configurations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806061429.4749=
92-1-wfelipe@google.com?part=3D2

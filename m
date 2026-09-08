Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B0B379EC6
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849955; cv=none; b=Xi0nsQN1az6PEeym++Vd/YoQP9FdMhYviR9ojwuC9piQLYVXIp05NcgkmtWk2JntWbgpDVVFPtI12FYbXIdpf4egviwlPXy7qirCdE+0jAsE6KeDp9OkIkHDFry2hyA6fe/T+09gh9n0jAbKtdzQJoMKR/xVuWO870bCdX/y4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849955; c=relaxed/simple;
	bh=naDPw0IAjsAAuq/Sj5QVtLaAWnD3o9qREoamMbkdfzU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N73PA31zCfgWUAUu+wq3w7TBpgQKFYjdUSAAsxkveawfbcmICKXkANXUSOBmepJKB2QcziEBZ3ZaCfwk1LO80j/ZIW+dsApYgPABpAW8EA9ZzeA7UA2gJXY9+fHggfvcbgoCRCxLGGi7cMiP/mmIM4pLtzquaq4Oltou1K3lSQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9vidqXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9vidqXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653671F00A3A;
	Tue,  8 Sep 2026 06:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788849953;
	bh=QM3Bhl9IgCQblBmyYDEoBOkCj+2SfmRlbCEyD9eHXFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D9vidqXDhv0Ti04qEjSiO+CHeswHWgk71p6zYfFwf9BmXVKpHcq8lzJqATEzvHrHm
	 IyVTKHiPdKXz4yIKs0uZKgJThebnDQM6mMaKZMzuNR1FY8MayP1mu7VjeRY6bHSZIr
	 pENSxADWgK+rE+Ce6vCB3lAGFOreobNj/sVL8gTklneu6Azqtw4xVbKPWvMXtgjLhg
	 MtEfPetfXDt6zlzruyCBdqok4JsK6s29aj7F9q1Wg+EjLjFxT6ds8J2qFmzhd1/+9r
	 IWjlCHi+wMg1T+VCX52WsUk7yZZZ+if9rRJJK3ciZLIaJ6tE+OuYqatB5xYG6BRClV
	 0N2yWHNpU9GYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/24] riscv: elf: Move relocation constants to UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, ojeda@kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-6-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-6-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:45:53 +0000
Message-Id: <20260908064553.653671F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removal of RISC-V relocation constants from `<asm/elf.h>` breaks s=
ource compatibility for userspace programs.
--

commit 058952432dc810f9a4ca2865a477a44513567043
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

riscv: elf: Move relocation constants to UAPI

This commit moves the RISC-V relocation constants from the RISC-V
architecture-specific header to the general uapi elf-r.h header.

> Move them from the kernel-private architecture-specific header to the UAP=
I.

[Severity: High]
Is arch/riscv/include/uapi/asm/elf.h actually a kernel-private header?
Files in the uapi/ directory are public and explicitly exported to userspac=
e.

> diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/=
asm/elf.h
> index 11a71b8533d57..05cf74a4a5357 100644
> --- a/arch/riscv/include/uapi/asm/elf.h
> +++ b/arch/riscv/include/uapi/asm/elf.h
> @@ -32,70 +32,4 @@ typedef union __riscv_fp_state elf_fpregset_t;
>  #define ELF_RISCV_R_TYPE(r_info)	ELF32_R_TYPE(r_info)
>  #endif
> =20
> -/*
> - * RISC-V relocation types
> - */
> -
> -/* Relocation types used by the dynamic linker */
> -#define R_RISCV_NONE		0

[ ... ]

> -#define R_RISCV_PLT32		59
> -#define R_RISCV_SET_ULEB128	60
> -#define R_RISCV_SUB_ULEB128	61
> -
> -
>  #endif /* _UAPI_ASM_RISCV_ELF_H */

[Severity: High]
Does removing these constants without adding a fallback #include <linux/elf=
-r.h>
break source compatibility for userspace programs?

Any downstream userspace build relying on <asm/elf.h> and referencing const=
ants
like R_RISCV_NONE could fail to compile against the new headers, as this
header is part of the exported UAPI.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D6

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE128DB54
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850271; cv=none; b=sCwxDOUN0Z1fnUkQUX841vnuSFnaW2wTPfzvLJkziUzqA6sAOfrB2rlznQsy0g+K121tXIZSIXc63egW07MGOrYqpMkLCGY5NwP6I/a+R+H2GCtjBItS4mjM6ZE152BGHUiQP9LhZyRKGI42+SBLZVcaU4Q94CdZ4j/F1Ww7iLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850271; c=relaxed/simple;
	bh=sAT4fKoYKgex+b8aRR/FJ+PlZyvJ45Dzb1ig0ua7Ks8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jx1pZeFHgx+1Esd/AmLXezSM7jf/t9/E9DvSHhQfXlcgAgPVJI7rfGfIJm0K/9q5chzaerP7BpdHPW0rJZRRlmE7d+inJYr2YQHUtml8z11oQBDedmdulKZ9TJDC88yzzYdFXQQCxKSe7piXIEkdMqTed9UlI9fMBxrWEW/AipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0/i1Y6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0/i1Y6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726E91F00A3A;
	Tue,  8 Sep 2026 06:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788850269;
	bh=EWdHjF7MxNbwZTu5FvBtSo1/m1cnWcamI/bjye1HgKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J0/i1Y6aCuTV/Pf6o7+Fo0hIl08IfPXSarz25Fz++UFtkWTtfW8gEGGrs2byVbqvY
	 C+cicz13ElDPxxRsePPfO4DQMNrA16yH/BR7zynvUKwyVgulYU+ndDt5oMlOI7wK+O
	 cYT7O+L/y8c7qfBRtAXf12tJVpbMpVRK/A8g7h97t7wY6rh7W3ZvwHihRGaneaA+sZ
	 FZTnN0+gkb1j8FiqKNZGDQFhvSyVe8UTwGsEMyhCkHGqSD7UrW/xFJ3DSB7699xDfs
	 1bC87wDTfOlm8TNFPxNuXZKRBGa7RY3vJmSABj9qz5Xj9N3B1viNvloSA6lmccZzvb
	 s5WVpda8ILx4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/24] tools headers UAPI: Sync ELF headers with the
 kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, ojeda@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-11-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-11-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:51:08 +0000
Message-Id: <20260908065109.726E91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete synchronization of tools/include/uapi/linux/elf.h, mi=
ssing RISC-V user CFI definitions.
--

commit 9c71e774bdcb446428ed39c9dd1d611efda1f5d1
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

tools headers UAPI: Sync ELF headers with the kernel sources

Pick up changes from the UAPI ELF header files.
This picks up general changes to elf.h, elf-em.h which was forgotten
previously and the new elf-r.h.

> diff --git a/tools/include/uapi/linux/elf.h b/tools/include/uapi/linux/el=
f.h
> index 5834b83d7f9a4..88bdcbb526c16 100644
> --- a/tools/include/uapi/linux/elf.h
> +++ b/tools/include/uapi/linux/elf.h
[ ... ]
> @@ -376,101 +387,180 @@ typedef struct elf64_shdr {
[ ... ]
> +#define NN_RISCV_VECTOR	"LINUX"
>  #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
> +#define NN_RISCV_TAGGED_ADDR_CTRL "LINUX"
>  #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control=
 (prctl()) */
> +#define NN_LOONGARCH_CPUCFG	"LINUX"

[Severity: Medium]
Are NN_RISCV_USER_CFI and NT_RISCV_USER_CFI missing from this synchronizati=
on?

The commit message indicates that this patch syncs ELF headers with the ker=
nel
sources, but the RISC-V user CFI definitions appear to be present in the
core kernel's include/uapi/linux/elf.h and missing here. Could this omission
lead to build failures if userspace tools attempt to use NT_RISCV_USER_CFI =
for
inspecting shadow stack state?

>  #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
> +#define NN_LOONGARCH_CSR	"LINUX"
>  #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers=
 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D11

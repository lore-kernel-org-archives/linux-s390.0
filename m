Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069300;
	b=lGd9TKZ4j1NulqsztSJX/59yfWf7O12fhUW+wUFcvDk8YmAvO5DPXaq/SV0hVGR+Ci4p
	 lfFwxj4Q25vaU0YyjIZWGZ8s/S+c5E9IbVw81u0KCeWyyVK/AIkxM/MB2CmCdVtLmMHPS
	 t9mXjK2SB4aP/S3JkuS5OvU3CLSJeCFxdIe3tIeua4JqxB9xT9vBhgB4nzdjBPDP6Hsas
	 NazqcmB0//yfdVWst4/zdMVWO/hPU4Vm5O0iVr/wZXCppLfiZ5hcleopIidW3qMymyLcZ
	 zyIvnLGDaWLJNGfcH9766P9dZgO0IHUMvO4in7Qux5wN0VWQIPOq/HGcZC2B0ntsfEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069300;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AriJadNSG2kNLT0g5wkctcMWz1vv7s2SwXN26U9rybA=;
	b=WkmYuGHYbI/eqJxjrQzs7+eMtrhFN5j/GJhfZdz6edYIjUS6t/CqmAcfpLFPKHpp3JMv
	 00XUyXRyu5m6Sp3PnFQzpXMFF7D/GbOV8pUikFwUsz/7ExxiJLprFnd18PFY0eM3+r/Wj
	 /xTOyBtuK1ree5hgLkSeWWG30Ytj8VriHR5T/phbJwE65bjYfbdHobjK0gKgmqlyivuA+
	 xOJk+WGt7zWW7Y6tLi86SpDyOS9xv234+mhojN0S2E6cqQJBKCW8R2t546fCJ/e5skdJS
	 xm5eyfQLIwZtDjYF9t9KTb2WPa3xxoROoLA5pTe9hGp/Ckn9v3uD5PU9rYS06cd80sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPVXEORV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF06B606A326
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 06:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPVXEORV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701831F000C4;
	Thu, 19 Nov 2026 06:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795069300;
	bh=AriJadNSG2kNLT0g5wkctcMWz1vv7s2SwXN26U9rybA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cPVXEORVfoKfE4hqfzqMZ5/v6aVOKnkqC9RQU2F6G8V1zWVCVXzIHG5dUYo0ZmZg9
	 XjICuQcxUWyfXx9igNhR9lYp2xcNv1nFkOzaKbdxNWu3mS5KF+IAxbcBKoSYlcLvV9
	 R2uHTrqBbN1Zf/ro2J0cVS+sSd2y85b0uvG0x8O4m2x98cjJkV+Xxi/WTY92ACuFNQ
	 Nb2D6cDqkMjwrk1+E4DKVk+ckIIdPZkgjXDk7sWj1axvGL60xbZXLgQV8DgXSWaXA0
	 NJbhBiYrHxFvGHfRiT5pMy/nsRxqUznrEyE9brA58EKFW2vXMumyRabBuAJpa+EM2o
	 yo/LHncp7L1Fw==
Message-ID: <sashiko-outbox-222519@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities
 in Kconfig.kexec
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baoquan He" <baoquan.he@linux.dev>, "Borislav
 Petkov" <bp@alien8.de>, "Catalin Marinas" <catalin.marinas@arm.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Helge Deller" <deller@gmx.de>, "Huacai Chen" <chenhuacai@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "John
 Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Paul
 Walmsley" <pjw@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Rich
 Felker" <dalias@libc.org>, "Russell King" <linux@armlinux.org.uk>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, "Thomas Gleixner" <tglx@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Will Deacon" <will@kernel.org>, "Yoshinori
 Sato" <ysato@users.sourceforge.jp>, x86@kernel.org
Cc: "Alexandre Ghiti" <alex@ghiti.fr>, "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 =?utf-8?b?Q2hyaXN0b3BoZSBMZXJveSAoQ1MgR1JPVVAp?= <chleroy@kernel.org>, "Cong
 Wang" <cwang@multikernel.io>, "Mark Rutland" <mark.rutland@arm.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>, "H.
 Peter Anvin" <hpa@zytor.com>, =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "WANG
 Xuerui" <kernel@xen0n.name>, kexec@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
 <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 06:21:38 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] riscv: missing ARCH_KEEP_MEMBLOCK and HOTPLUG_CPU selects for
  KEXEC_FILE [1]
--

commit 72fcff7ceb4b8dc27b8490a2ed5edc55973e96f8
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

arch, kexec: declare kexec and crash capabilities in Kconfig.kexec

This commit moves the architecture capability options for kexec and crash
dumps into kernel/Kconfig.kexec and updates each architecture to select
them.

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e7891a2a89da6..3fc73c99d06f1 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
[ ... ]
> @@ -65,9 +67,14 @@ config RISCV
>  	select ARCH_STACKWALK
>  	select ARCH_SUPPORTS_ATOMIC_RMW
>  	select ARCH_SUPPORTS_CFI
> +	select ARCH_SUPPORTS_CRASH_DUMP
> +	select ARCH_SUPPORTS_CRASH_HOTPLUG
>  	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
>  	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
>  	select ARCH_SUPPORTS_HUGETLBFS if MMU
> +	select ARCH_SUPPORTS_KEXEC
> +	select ARCH_SUPPORTS_KEXEC_FILE		if 64BIT
> +	select ARCH_SUPPORTS_KEXEC_PURGATORY	if 64BIT
>  	select ARCH_SUPPORTS_LTO_CLANG if CMODEL_MEDANY
>  	select ARCH_SUPPORTS_LTO_CLANG_THIN
>  	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
> @@ -1105,38 +1112,17 @@ config RISCV_BOOT_SPINWAIT
> =20
>  	  If unsure what to do here, say N.
> =20
> -config ARCH_SUPPORTS_KEXEC
> -	def_bool y
> -
>  config ARCH_SELECTS_KEXEC
>  	def_bool y
>  	depends on KEXEC
>  	select HOTPLUG_CPU if SMP
> =20
> -config ARCH_SUPPORTS_KEXEC_FILE
> -	def_bool 64BIT
> -
>  config ARCH_SELECTS_KEXEC_FILE
>  	def_bool y
>  	depends on KEXEC_FILE
>  	select HAVE_IMA_KEXEC if IMA
>  	select KEXEC_ELF

[Severity: High]
This problem wasn't introduced by this patch, but should KEXEC_FILE (or
KEXEC_CORE) also select ARCH_KEEP_MEMBLOCK and HOTPLUG_CPU if SMP
[1]?

config RISCV only has "select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC", and
only ARCH_SELECTS_KEXEC selects HOTPLUG_CPU if SMP.  When KEXEC_FILE=3Dy and
KEXEC=3Dn:

- Without ACPI, memblock_discard() frees the reserved regions array before
  reserve_memblock_reserved_regions() registers them in iomem_resource, so
  kexec_file_load() can place kexec segments over reserved memory.

- On SMP without another option enabling HOTPLUG_CPU,
  smp_shutdown_nonboot_cpus() in machine_shutdown() and
  cpu_ops_sbi.cpu_stop are compiled out, leaving secondary harts running
  in the old kernel during kernel_kexec().

[1] https://sashiko.dev/#/bug/linux-78e86ad1-8753-462c-a044-1d3b3f2cab21

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-arch-kconf=
ig-v1-0-37c276fe4d26@kernel.org?part=3D2

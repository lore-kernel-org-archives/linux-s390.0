Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086077;
	b=AT0xHmqv85pKDzOSN9lx79Xej3mT1Le5PdFBbbMaTXuCf9FKNDZEMYv3QB5NHXOSWkgr
	 BVLegwIgH8TsrKPf6zZccoRj+w5XOwVfFdOYSud+mkhjp6izXNTLl5og5ZBb/p0RHnmFS
	 tyF5J35e3kEpv21rJvzSk/Um2PorNi+h3yRaj28RsDsTGQVb7lCaNtoIBrwQkXGJdXYL1
	 E2bDyReaEuDVJ5tLJJboLy42Uwe3bhYajgK94Nskq0DIJ0Yqru6OJY7wDaiLlzAMKHskG
	 Wnmx5/JDOMHnlV9t6giXqKABR1K/BxOtmSGA4GnJDTQeya2aQik6OaCR5IQZKFTQNtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086077;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=NlUvq2HpnerQLH3flTbOZH1bj0OHRcxRHwUIA48QJc0=;
	b=ciC4Mx6umESihwpLSxiEECTbgzWzWEQ3N0QM5umhsdyY08xjvvF/EBntGC386fuvuIDl
	 L6YBVpxfS8ZGBPjfCAKpoeBdfLYNTxNMiKdi2wBa0acgAyn09nR7Fe0myQ0twWmjNJNSx
	 tCXOzRbribCUbEmgbMsT8lKm2Hy/xlDZDJzI4yS/a17l3FPFjQ8wiTi2BZuveKHtVCNGv
	 4BjYeLIlaXLgKPIfmv7MPiORCH18YHUstUxhGLeAaAJ9B9tq1vjyQjzXsz4cjas/rE5zL
	 Gd6xNhT14N4p7t1MReSKt8fnIlvvXz/BxM+hbBs8ciw9hMUGN1mkR4wosab17CXapJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0w4y3pq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE3606A320;
	Thu, 19 Nov 2026 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0w4y3pq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128761F000C6;
	Thu, 19 Nov 2026 11:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795086077;
	bh=NlUvq2HpnerQLH3flTbOZH1bj0OHRcxRHwUIA48QJc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=K0w4y3pqXsaP3ubeldycHwHdzHusNNZ8UWp+6vQiAMiUx60nPEzsEI6UORCWk2eQM
	 Wr9MQq++PwU5z61f5LSDEP/iq4naKOipL4OMYf3DinFcFig10sjtTbY97erbnHEo4N
	 YUsiICY5uHAbdPH6LrzIgPYWrXrSB9l/2O0n7IlxkCsCvQCLsq4VEjI6XjjyL4rxmv
	 iQPAM4DO3b1e/YXAvLTi7iTezPwfGOpMZZWOUYfE8tL1pN806bFh5j5ih6yGAgPP1a
	 FfTA7G26gf/3dkJHKJphG6zjuFB4DY41xyN0dDytK5Ezt06txmdtB1kzNPaWLRDwgR
	 3LJf+KdeFvAjA==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,  Alexander Gordeev
 <agordeev@linux.ibm.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <baoquan.he@linux.dev>,  Borislav Petkov <bp@alien8.de>,
  Catalin Marinas <catalin.marinas@arm.com>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  Geert Uytterhoeven <geert@linux-m68k.org>,
  Heiko Carstens <hca@linux.ibm.com>,  Helge Deller <deller@gmx.de>,
  Huacai Chen <chenhuacai@kernel.org>,  Ingo Molnar <mingo@redhat.com>,
  "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,  John
 Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,  Madhavan Srinivasan
 <maddy@linux.ibm.com>,  Palmer Dabbelt <palmer@dabbelt.com>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  Paul Walmsley <pjw@kernel.org>,
  Pratyush Yadav <pratyush@kernel.org>,  Rich Felker <dalias@libc.org>,
  Russell King <linux@armlinux.org.uk>,  Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>,  Thomas Gleixner <tglx@kernel.org>,  Vasily
 Gorbik <gor@linux.ibm.com>,  Will Deacon <will@kernel.org>,  Yoshinori
 Sato <ysato@users.sourceforge.jp>,  x86@kernel.org,  Alexandre Ghiti
 <alex@ghiti.fr>,  Christian Borntraeger <borntraeger@linux.ibm.com>,
  "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,  Cong Wang
 <cwang@multikernel.io>,  Mark Rutland <mark.rutland@arm.com>,  Michael
 Ellerman <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,  "H.
 Peter Anvin" <hpa@zytor.com>,  "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>,  Shrikanth Hegde <sshegde@linux.ibm.com>,  Sven
 Schnelle <svens@linux.ibm.com>,  WANG Xuerui <kernel@xen0n.name>,
  kexec@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-m68k@lists.linux-m68k.org,
  linux-mips@vger.kernel.org,  linux-parisc@vger.kernel.org,
  linux-riscv@lists.infradead.org,  linux-s390@vger.kernel.org,
  linux-sh@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
  loongarch@lists.linux.dev
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities
 in Kconfig.kexec
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org> (Mike
	Rapoport's message of "Thu, 19 Nov 2026 08:16:58 +0200")
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
	<20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
Date: Thu, 19 Nov 2026 11:01:06 +0000
Message-ID: <2vxza4n53x1p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 19 2026, Mike Rapoport (Microsoft) wrote:

> The options that let an architecture opt in to kexec and crash dump
> features, like ARCH_SUPPORTS_KEXEC or ARCH_SUPPORTS_CRASH_DUMP, are
> defined in each architecture's Kconfig as def_bool, and most of them are
> copied over several architectures.
>
> Declare these options once in kernel/Kconfig.kexec next to the options
> that depend on them, similarly to how mm/Kconfig does it, and make the
> architectures select them instead.
>
> Selection conditions are preserved, so there is no functional change.
>
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

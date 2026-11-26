Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692178;
	b=IFupF0mmc+6IXuRovWfaJZ8Oob/+JkhlAzxYqVJprwGtVQVe/RGJc78r/sQU1t4nekOK
	 79lNkLCe6CFde1HlFy9w7HTMKL1FfVS+gWbs2PBcQS8l9ytTE4UBgUZKh8Eem4xCdF0zY
	 kj7CHJ6qxFCv/qe6daMU/5Dj6r7gFiJNK+SR7iF6mcAAclkE0OYiwLAcoz295BrJSd8IP
	 NRJWvW3iFRVx6di8QI4XumsBLQC9Zhfw09Uwv3quy4lzP+JOX2TyXnKBTWDJoksHm5R3g
	 go9Ah9lyP6XAFxtmf4iWEjaPSvOOO0T3iJ7VYzuJoFJVKZHgBaRuZMq7EU4hvZVq2/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692178;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=eKUr+0/Ji0+0NqFinQ2LX98LxUecEFKvXWWLdTPhIvY=;
	b=Nyj3w1CQsmMa3A01dPiT8mkohzD3WIbukHI1t8f/d9tBTf88fXdewqbaUUcNhJ2V46sC
	 NBq3T6HxJ7mzHrJiuHvIKfXyy5SmUsf2kj7gn60EpXNujpi7fNkKf5ubiv7KRRl+j+Ohj
	 YfMUR9ZtM9l0S5hopxo+gKj91JKJ1rVpiUTqdlu83NuqKLcEXkGrekkR0JiQ1eeG78V92
	 yJWplW3ZfEHhNm5r6I6elP1s/rOmeLrvSzpDp4XeT+9FVRwVtkKAqCd4YBH+6jWcgBNlf
	 jNz6ySFwPW1vEM2Bbo6bvwRrz2j8LHiTXmP5uxrS3Op763ALrct+fS7+UeCcHDGzpYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dm2c3+DY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF73606A321;
	Thu, 26 Nov 2026 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dm2c3+DY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F0C1F000F2;
	Thu, 26 Nov 2026 11:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692178;
	bh=eKUr+0/Ji0+0NqFinQ2LX98LxUecEFKvXWWLdTPhIvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Dm2c3+DYVRKxMA0zs3xasLS8OkivKgv5DPVGeim/BVShbcjacDNtx+3LechYlp/Op
	 ThMaD/L6hZeU0tf9h1p4vdNlg9eJwD/HQ5DKkLYtUlVMXa5jZB51zTO4XDajG8ySii
	 wDdVkCpfdlAyFHFHhcQRVOJBDOr3P0UU7Ca08L4iRAAPp2+L0HKCxoLX0Z1W5yumBt
	 TqkF242aFp2Kl7rJJyODroSQL1/f8Y7xLMjmBfv3PTeuMzMJae+NcbcLGJU9+jBwEE
	 LadWoZogFWj9c6qH76TOcKMgugfhPlYgvvKxPVlm8M1UiTmkRzwSE7aSWCiTf0+7g5
	 qb0Htg51a2W+g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:15:06 +0200
Subject: [PATCH RFC v2 53/54] arch, mm: enable the generic CPA core with
 ARCH_HAS_SET_MEMORY
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-53-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev

Every architecture that selects ARCH_HAS_SET_MEMORY now uses the generic
CPA core, and a new one should not need to select two symbols to get it.

Enable GENERIC_PAGEATTR for ARCH_HAS_SET_MEMORY on MMU kernels and drop the
selects from the architectures.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm/Kconfig       | 1 -
 arch/arm64/Kconfig     | 1 -
 arch/loongarch/Kconfig | 1 -
 arch/powerpc/Kconfig   | 1 -
 arch/riscv/Kconfig     | 1 -
 arch/s390/Kconfig      | 1 -
 arch/x86/Kconfig       | 1 -
 mm/Kconfig             | 2 +-
 8 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7a7ccc113126..0cc289a7184a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -77,7 +77,6 @@ config ARM
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
-	select GENERIC_PAGEATTR if MMU
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 846fae788b3c..9b08b2457a55 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -138,7 +138,6 @@ config ARM64
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
-	select GENERIC_PAGEATTR
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 455a72b8669d..bad699e2847f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -107,7 +107,6 @@ config LOONGARCH
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
-	select GENERIC_PAGEATTR
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index fbe3a3abeea8..c3b6cd655606 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -211,7 +211,6 @@ config PPC
 	select GENERIC_IOREMAP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
-	select GENERIC_PAGEATTR
 	select GENERIC_PCI_IOMAP		if PCI
 	select GENERIC_SMP_IDLE_THREAD
 	select HAS_IOPORT			if PCI
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0453c665fc64..e7891a2a89da 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -122,7 +122,6 @@ config RISCV
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
-	select GENERIC_PAGEATTR if MMU
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 413b886a9e9a..7138d923d86f 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -180,7 +180,6 @@ config S390
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_PAGEATTR
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IOREMAP
 	select GLOB
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f4aceaceaf65..6cf8f121879a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -178,7 +178,6 @@ config X86
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_RESERVATION_MODE
 	select GENERIC_IRQ_SHOW
-	select GENERIC_PAGEATTR
 	select GENERIC_PENDING_IRQ		if SMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_GETTIMEOFDAY
diff --git a/mm/Kconfig b/mm/Kconfig
index 3948e64dc590..97e152442e1a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1139,7 +1139,7 @@ config GENERIC_EARLY_IOREMAP
 	bool
 
 config GENERIC_PAGEATTR
-	bool
+	def_bool ARCH_HAS_SET_MEMORY && MMU
 
 config STACK_MAX_DEFAULT_SIZE_MB
 	int "Default maximum user stack size for 32-bit processes (MB)"

-- 
2.53.0


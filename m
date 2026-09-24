Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3533A3F4DD2;
	Thu, 24 Sep 2026 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230151; cv=none; b=Eow9qAuEnKiQ0eiiIgqZyMKPn/PKGUlNnsWWjyIebtSfOq9Hv7lvzKT/3P098YZhVJLlUERXyO8bBNovobKcqunuelUtvZhN/fJ2s/UJFaL/ivYOVVnZ78CQSxti0zBs86AfCU2ykq3pl/5okwdZqzkzj85O4HWQvZ30c5Rf99M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230151; c=relaxed/simple;
	bh=4CJEyVcs1k79aNGKjlS207vQIHEMmJ4tXfjSXmeKvKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khm5VYKpKCejmtyoFy+6yAcaSk8qTo2F20jo4bHSNZ6ohwpYFEJEMNtEDyKTvWL6eM2dYa8QCpysD7A0Ql2dFFHEnl60RBVq9Bnu2Nva3hr1hAl1k1PU38fTBR3fhyQcKmUvMUiNwxnWQg57LXuXv1XWprINUYPley1Qqy4ay4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPNqW2n3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPNqW2n3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8231F000FF;
	Thu, 24 Sep 2026 06:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230149;
	bh=scK31GWR2h/dTmEm9pgXi3rZWUkl7hz/7+eEu9rpbOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MPNqW2n3xQPMHb3zk4FZ6ncKB0hS41jziOySyXRP85orS2goMtQH2mm/0L9yaZxJ7
	 uyfxEYDfSKu8jV+fdC4+eGcFWr353MFkOwEd70Y7yLG+AbSEyBgtn2ckcyeoRzGBD+
	 I2tflAOZ4Q1fn7RbuaEgmuUo+/QGXFno6TJ+hS3dXjCIRl3cw4GGfgWF+2qH69vs2P
	 MwZo6Xz45RCXfRm9huH6Y7sEvvHmd8YWAtVSH/kZU0DX+sGsu33lFAv7L2p9isA4MW
	 5TroSKQNx8yklWoYeiNZ44FrEEEF8XAaphtrhBdD4Jpm+EP38YK8c58oQMes/CsBtO
	 qlrJqSzruzYKg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v6 3/8] dma: swiotlb: Track whether the pool size was explicitly set
Date: Thu, 24 Sep 2026 11:37:51 +0530
Message-ID: <20260924060756.1325156-4-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

swiotlb_adjust_size() must not override a pool size supplied through the
swiotlb= command-line parameter.

Currently, it determines whether a size was supplied by comparing
default_nslabs with IO_TLB_DEFAULT_SIZE. This fails when the user
explicitly requests the compiled-in default size, allowing the request
to be overwritten by automatic pool sizing.

Record whether swiotlb= supplied a numeric size in swiotlb_cmdline_size_set
and check that flag directly before adjusting the pool size.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/swiotlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b59dd2a5984e..61efa3244daa 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -100,6 +100,7 @@ static struct io_tlb_mem io_tlb_default_mem;
 
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 static unsigned long default_nareas;
+static bool swiotlb_cmdline_size_set __initdata;
 
 /**
  * struct io_tlb_area - IO TLB memory area descriptor
@@ -253,6 +254,7 @@ setup_io_tlb_npages(char *str)
 		/* avoid tail segment of size < IO_TLB_SEGSIZE */
 		default_nslabs =
 			ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
+		swiotlb_cmdline_size_set = true;
 	}
 	if (*str == ',')
 		++str;
@@ -295,7 +297,7 @@ void __init swiotlb_adjust_size(unsigned long size)
 	 * architectures such as those supporting memory encryption to
 	 * adjust/expand SWIOTLB size for their use.
 	 */
-	if (default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
+	if (swiotlb_cmdline_size_set)
 		return;
 
 	default_nslabs = swiotlb_calc_nslabs(size, default_nareas);
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692093;
	b=SqJ65C3HthK4i/DWlIpFkYuPyLe3nieg3tyK4oE/Q/Gs6j4Pe7Xrn5ObpNY/L3TL+d1I
	 NxMwfVdgj/cDAebiHB3Ufv1jW4lBXQ7+zqdKJfgxRtstQ6Pf1d/+pSAnr0L3pL2ZDoGvO
	 NJJXZSj9EdEyHIPjBq2FplQtxCEMhL23KE5wKzNeJTlvV0+/7vMfl/fmWIOvZATILe7FR
	 NF2HbP5aL9KNTT7MTeWTVuMfZhikaZpqBi6ZFIbM9CwuAijLRqISJ3UoBocdwHZbAxt5s
	 3lA8x3ExpB/wTwUqPIldy/A0UmOOs9b8BF0Yh2P1yiNXfbYO8FbQ0BkZU4xKOnMXJBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692093;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=vigwkAWRONvzPByx/zhPfJ9SVHH2ehEcBxoq+qTMC8E=;
	b=EDHKx5E8EG1PovEpxsSyAdcktOoyNgrCG3cfK7og6hYIV2dzpX8RG4erzv5tXFrs0CV7
	 iREE9Biy/r44jySY25v5SyoSjtzD23HKCMlvRDDEnwLAzY4t2C0Ji9PCNgXsLZy5PellF
	 nAemBkddJefn9GasQVd9cqLRhM5NNVe/LwVMtpSWsm0ZwOsQaiArBopJqgWUOWe9uO83j
	 TktY8U0cYJOy7kKShmF9XOs0wob2PKedPP1N7Bhd5kxHffsxOz2W6rQKTEelA1vvthgMU
	 OP+tYzCpjkf3MFII1yzzTcaLrbXsVmGjrZa0B5kpiOe+gLX3eGlJ6poaJRFBuRsvu0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNX3cDEN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895A606A334;
	Thu, 26 Nov 2026 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNX3cDEN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734441F00AD4;
	Thu, 26 Nov 2026 11:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692092;
	bh=vigwkAWRONvzPByx/zhPfJ9SVHH2ehEcBxoq+qTMC8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SNX3cDENiO5DzlG2beALu6yElwtfAJXpHrvTqpxO60LzbbVU27yDaIgMMSFUrC3qK
	 +gif9ob2GHrwxtQZ2uGiKiYmg7Dy16SvDHGHzdFUsr1dSx+qMH8iVYn8rJD5ozxCDu
	 ZLenCOZbN2Wt7s8cZ1jwGUELsfeht4miRfQl7N/J1msWxoJt4085AIm4mT+Ff3Hjww
	 0rvY138mhTHgAPV+UhUHEzrCijrGWuVoJt3D8ag2qDG35f5eTy1vTkHDWY+1GMsIhv
	 Z/IC6JEKsjS2y2gDXBkm1BfHhyIJPZCVGsNCbFMHzeqMQhFUU9ScTYCUcWKZiWuLGQ
	 jEz1spOt2dAIA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:57 +0200
Subject: [PATCH RFC v2 44/54] mm/pageattr: derive direct map counter
 updates from the level sizes
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-44-723f1e33c3d8@kernel.org>
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

The direct map counters add PTRS_PER_PTE entries at the next level for
every split.

That is right on x86, riscv and arm64, where all levels have the same
number of entries and PTRS_PER_PTE is the same as PTRS_PER_PMD.

This is not the case on s390.

An s390 segment table has 2048 entries and a page table has 256, i.e.
PTRS_PER_PMD is 2048 and PTRS_PER_PTE is 256.

A split of a PUD mapping on s390 would add 2048 entries to the PMD
counters.

Replace the hard-coded PTRS_PER_PTE in the counter update with a helper
that derives the number of entries from the sizes of the two levels.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/pageattr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/pageattr.c b/mm/pageattr.c
index e05281a2b169..555e55e7ecea 100644
--- a/mm/pageattr.c
+++ b/mm/pageattr.c
@@ -48,6 +48,11 @@ void direct_map_count_update(enum pgtable_level level, long pages)
 	atomic_long_add(pages, &cpa_direct_map_pages[level]);
 }
 
+static long nr_entries(enum pgtable_level level)
+{
+	return pgtable_level_size(level) / pgtable_level_size(level - 1);
+}
+
 void direct_map_count_split(enum pgtable_level level)
 {
 	if (atomic_long_dec_if_positive(&cpa_direct_map_pages[level]) < 0)
@@ -59,7 +64,7 @@ void direct_map_count_split(enum pgtable_level level)
 		else if (level == PGTABLE_LEVEL_PUD)
 			count_vm_event(DIRECT_MAP_LEVEL3_SPLIT);
 	}
-	atomic_long_add(PTRS_PER_PTE, &cpa_direct_map_pages[level - 1]);
+	atomic_long_add(nr_entries(level), &cpa_direct_map_pages[level - 1]);
 }
 
 void direct_map_count_collapse(enum pgtable_level level)
@@ -71,7 +76,7 @@ void direct_map_count_collapse(enum pgtable_level level)
 		else if (level == PGTABLE_LEVEL_PUD)
 			count_vm_event(DIRECT_MAP_LEVEL3_COLLAPSE);
 	}
-	atomic_long_sub(PTRS_PER_PTE, &cpa_direct_map_pages[level - 1]);
+	atomic_long_sub(nr_entries(level), &cpa_direct_map_pages[level - 1]);
 }
 
 void cpa_report_meminfo(struct seq_file *m, unsigned long levels)

-- 
2.53.0


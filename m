Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904041;
	b=sU2cmBG5JLdV41m/5FxqK0Ajwa6qGCO1nTedNfqxUHrAxnKsNDGE/XpH/L1ubwB+fv1S
	 3FORtEjjDqR2Z/oxrFBvOyrxoF2WtOmwTcbz6fIwAmhaulNFRV0XDPXrbWWNxrnJ20wVk
	 OLRM7Zzsc/z3NYfnXU0m5IyFja0KI2icen9G30iBwAXRpuFwC2uqdz6ndh7wpOPGiym+b
	 U3dakL6bbERWjDnG3JDol3Cjbu4A4DQPw5Iw4+yWCfDoJ+CvrPKOPqDYhhd+PpTtXpBd3
	 8tWLKCQINIpBvWKvmgW4lMKDOwo51oWGz6Ng+w3ViaC6jbhbQllVw/ke6AeZoU18zrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904041;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BW1nQsutnrZitd0IEzC284qt4pUoWTmeWnhpOQZQ17M=;
	b=dYjPJfwwWkaM0wju2+ntk68du7uDf4HaJh7sasLUx0sKFeiinYbghCc9bABIR0mQiyU9
	 IB85DIm/ar2XB4Nb/o6iX/98s/ho+9a/5ovxZt81iS5fQ/TgPajyra0lReMjJyg4Eo+72
	 uCXsiEIHghD8pU8Q+6Aob+5i5yKC9Sn9RPkL5z+ToWIHPRxZYSOG6yIfmXxfPG9sXdxaj
	 HCFyE5sFLlET6I9bCLO5BMK0C3DPe8lHlDq8JyebNs586sgZYUiRJXwTxNizZjpAXna51
	 J97pGIX+z+f73AXGypiW6gosnDxaUnk0d8YvPUwSdYODPK4b/M9GCOpWs7G1ZEO83QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xiFtTF+U;
	arc=none smtp.remote-ip=91.218.175.100
Received: from mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA9606A31B
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 18:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58CA9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xiFtTF+U
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wz3IjU8MmdepamXobqBOtTMChOSj7PBIYvSm39xyfBE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793904038; v=1; x=1794508838;
 b=xiFtTF+Ui1yW1hheZjC/GYAEq7qkv2Pn/Ap+dIotL/UKmFuuwNaxgA3PGhI3gWuvk1j+kRDt
 7UaK0xTSrhxeGop6VjjFG822+hZlOJmPTT9Jwf+C8kYCgXbyourH4IYuvppWPO35RAeLBzxJTf+
 ZN25/Xwwi/rO8Y9VuKrFZ0w0=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 50c412d95539fb94;
	Thu, 05 Nov 2026 18:40:37 +0000
X-Mizu-Trace-ID: 50c412d95539fb94
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	ljs@kernel.org,
	ziy@nvidia.com,
	linux-mm@kvack.org
Cc: chenhuacai@kernel.org,
	ying.huang@linux.alibaba.com,
	Baoquan He <baoquan.he@linux.dev>,
	willy@infradead.org,
	youngjun.park@lge.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	alex@ghiti.fr,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>,
	Liam R. Howlett <liam@infradead.org>,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	nphamcs@gmail.com,
	shikemeng@huaweicloud.com,
	yosry@kernel.org,
	qi.zheng@linux.dev,
	luizcap@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH v9 06/32] s390: mm: add PMD swap-exclusive helpers
Date: Thu,  5 Nov 2026 10:38:50 -0800
Message-ID: <20261105183940.2236717-7-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105183940.2236717-1-usama.arif@linux.dev>
References: <20261105183940.2236717-1-usama.arif@linux.dev>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for keeping a PMD-mapped anonymous THP mapped by a PMD across the
swap round-trip, which makes PG_anon_exclusive have to survive in a swap
PMD and not just in a swap PTE.

s390 is the one architecture where a swap PMD is not a swap PTE in
disguise: it is an RSTE with its own layout, converted to a fake PTE swap
entry for the common code. Give it its own exclusive bit rather than
borrowing the PTE-format macro, and document it in the RSTE swap layout,
where bit 52 was listed as unused.

Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 arch/s390/include/asm/pgtable.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 2d5c2ab06de98..2c6b5205ee3bc 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -333,6 +333,7 @@ void setup_protection_map(void);
 /* Common bits in region and segment table entries, for swap entries */
 #define _RST_ENTRY_COMM		0x0010	/* Common-Region/Segment, marks swap entry */
 #define _RST_ENTRY_INVALID	0x0020	/* invalid region/segment table entry */
+#define _RST_ENTRY_SWP_EXCLUSIVE 0x0800	/* SW exclusive swap bit, see mk_swap_rste() */
 
 #define _CRST_ENTRIES	2048	/* number of region/segment table entries */
 #define _PAGE_ENTRIES	256	/* number of page table entries	*/
@@ -893,6 +894,21 @@ static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
 }
 
 #ifdef CONFIG_ARCH_HAS_PMD_SOFTLEAVES
+static inline bool pmd_swp_exclusive(pmd_t pmd)
+{
+	return pmd_val(pmd) & _RST_ENTRY_SWP_EXCLUSIVE;
+}
+
+static inline pmd_t pmd_swp_mkexclusive(pmd_t pmd)
+{
+	return set_pmd_bit(pmd, __pgprot(_RST_ENTRY_SWP_EXCLUSIVE));
+}
+
+static inline pmd_t pmd_swp_clear_exclusive(pmd_t pmd)
+{
+	return clear_pmd_bit(pmd, __pgprot(_RST_ENTRY_SWP_EXCLUSIVE));
+}
+
 #define pmd_swp_soft_dirty(pmd)		pmd_soft_dirty(pmd)
 #define pmd_swp_mksoft_dirty(pmd)	pmd_mksoft_dirty(pmd)
 #define pmd_swp_clear_soft_dirty(pmd)	pmd_clear_soft_dirty(pmd)
@@ -1900,15 +1916,15 @@ static inline swp_entry_t __swp_entry(unsigned long type, unsigned long offset)
  * Bits 59 and 63 are used to indicate the swap entry. Bit 58 marks the rste
  * as invalid.
  * A swap entry is indicated by bit pattern (rste & 0x011) == 0x010
- * |			  offset			|Xtype |11TT|S0|
+ * |			  offset			|Etype |11TT|S0|
  * |0000000000111111111122222222223333333333444444444455|555555|5566|66|
  * |0123456789012345678901234567890123456789012345678901|234567|8901|23|
  *
  * Bits 0-51 store the offset.
+ * Bit 52 (E) is used to remember PG_anon_exclusive (_RST_ENTRY_SWP_EXCLUSIVE).
  * Bits 53-57 store the type.
  * Bit 62 (S) is used for softdirty tracking.
  * Bits 60-61 (TT) indicate the table type: 0x01 for REGION3 and 0x00 for SEGMENT.
- * Bit 52 (X) is unused.
  */
 
 #define __SWP_OFFSET_MASK_RSTE	((1UL << 52) - 1)
-- 
2.53.0-Meta


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C8444A418;
	Fri, 28 Aug 2026 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918099; cv=none; b=HTDQASdtfC4QZ/Qnn7hiMd1UdY5CMwnwfPtEDgXIZhAKNpYm6Jpe+swunPjP7IvNd72yGaOJA3xFItyCkPWYrx1wVNYBNwciw4/NGgxK1jAvD3W+b1Akobf2Cwpi/oZYNQiJUEehEW3d3Y9EK1nGFY/Uu4M2u0qC1Si7NLDZQ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918099; c=relaxed/simple;
	bh=3FngtgTbuMXZ40qcU84HyhR7+G6Ridtsg1fcvbsn2DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfk3xduLPFacLKV6uAs1x8BaFki6nZCn+T4nEe7V0Bw5c9bmVfm7jF3M+5cCpRY4UKLvN07zI77RvkxXrOMDzf8iO51j3ZGPc4wGiqaSHM0fi8cPGTtqrmLo/DSlNuPllvhH8pjRVz0PBEbs5O4Lb+urLwEhs+QPgVj742n13cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sBLXTmWF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sBLXTmWF"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SAWEN61735097;
	Fri, 28 Aug 2026 11:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+CQgPiou56CTQNfmJ
	w8ncF4wBm2BJO8qaARArfkmTK0=; b=sBLXTmWFknvUWjv5hJtng1ZUg+OSIG23c
	+8ptD9SrJ+N+z3vYxd9A7m3k5nb7SmDkgAzRxtVPH8Ub3ezlgf2NFO2q4sUA8bek
	IR69hKaqo0V5I4nx4U0Y2SDC1QYBiw2XnAIfu6/V5ZN//zgZ0os9KnrLiqq3vGQl
	TaNW+ffEvO6MVTjch1fX8EvYN6R3XDoBN5hMOvh3CUhpqZXwYRJoUF0i/E4GZ0EM
	mUzsc2lCHhqFAklNPE3wOGfuLnSy62VaEKti4xVEIuQM1ZY9ISaQwekEGbLFUfWN
	r8auD/BImstbqrURsWrncqfbG1VuaGrEHsRqmDZzZikfaa8bh4nUg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g5c009-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SBfJsx009435;
	Fri, 28 Aug 2026 11:54:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhnva5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SBsdZ842074388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 11:54:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFF7D2004B;
	Fri, 28 Aug 2026 11:54:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB0D92004D;
	Fri, 28 Aug 2026 11:54:39 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 11:54:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 1/8] KVM: s390: Fix dirty marking in adapter_indicators_set*()
Date: Fri, 28 Aug 2026 13:54:32 +0200
Message-ID: <20260828115439.145885-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828115439.145885-1-imbrenda@linux.ibm.com>
References: <20260828115439.145885-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Kf6Qk55tAkrdcvk9hgBUJqpMrcQ1RNjc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX/t1uX2X3yNCN
 KuJHjnA6o+o1FDVSHJZ0FSznpfWnAidf+6j7ocUf4HpIaBewTBMW6kfhHBF+frU4qccKoGlfk9l
 NWJbSAEHCpefyw5AMJeE7+iFDH2bT5M=
X-Proofpoint-GUID: Kf6Qk55tAkrdcvk9hgBUJqpMrcQ1RNjc
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a917707 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=EkfAVvxasnAm74aL7hAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX2ODoIlG5OsVa
 HPiKi8MKzhp0901NbPQ6XLvUR7IVY8OPzUT1KKoC2TAOplcwQmMdV2+wvQDWtmJkR3alHmqdp1g
 JVUxKYVwNNkWmwn6KAbaGlOBIs72R5Ne0I9GXCjDJ97Oeafj2/UuZWoq0xMda060DMIUFCheo8o
 fcU5jF1j5ZEu3yAA6ZV3Ge1Oj5RXaiLpAw0fjxBHvEfiI+JiWBIr2RVp6R32MnZT2MDhEGMqZeZ
 kaZoh42Ef5aownPfmOGqH1f8R9MiiWMbL/9oeb7mrgXHGpdQ04Xk1bVkAIZ9IY+iUMc4rDAOJtW
 S8OXeN29+gF2G6+Cpnl3QQkdzXXOQYpvqyj5A8spNinm5l2XDQOFXZM/QL9RnZAkVodMtufRsKz
 VfcrDgNRXBicO9jGpi1xKIBa5pcc5hDeMC7NwOfRBME9280Dshr4+WC+GLAfGCWF3mGNDyoLr2b
 Zl7v22lsWn2RedrYCtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280099

When the indicator and/or summary bits are set in the guest, the
accessed page was only marked dirty in KVM if the access was performed
using the slow path; accesses through the new kvm_arch_set_irq_inatomic
fast inject path would not mark the page as dirty.

Fix by adding/moving the missing calls to mark_page_dirty(). Note that
for the inatomic path set_page_dirty{,_lock}() is not needed as the
page stays pinned; the unpin path correctly marks it as dirty.

Opportunistically reorder the local variables to be in reverse
Christmas tree order and refactor to use guard().

Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use mapped pages")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/interrupt.c | 75 +++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/arch/s390/kvm/s390/interrupt.c b/arch/s390/kvm/s390/interrupt.c
index 0381ae981703..49b4e233e791 100644
--- a/arch/s390/kvm/s390/interrupt.c
+++ b/arch/s390/kvm/s390/interrupt.c
@@ -2984,61 +2984,58 @@ static int adapter_indicators_set(struct kvm *kvm,
 				  struct s390_io_adapter *adapter,
 				  struct kvm_s390_adapter_int *adapter_int)
 {
-	unsigned long bit;
-	int summary_set, idx;
 	struct s390_map_info *ind_info, *summary_info;
-	void *map;
 	struct page *ind_page, *summary_page;
-	unsigned long flags;
+	unsigned long bit;
+	int summary_set;
+	void *map;
 
 	ind_page = NULL;
 
-	spin_lock_irqsave(&adapter->maps_lock, flags);
-	ind_info = get_map_info(adapter, adapter_int->ind_addr);
+	scoped_guard(spinlock_irqsave, &adapter->maps_lock) {
+		ind_info = get_map_info(adapter, adapter_int->ind_addr);
+		if (ind_info) {
+			map = page_address(ind_info->page);
+			bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
+			set_bit(bit, map);
+		}
+	}
 	if (!ind_info) {
-		spin_unlock_irqrestore(&adapter->maps_lock, flags);
 		ind_page = pin_map_page(kvm, adapter_int->ind_addr, 0);
 		if (!ind_page)
 			return -1;
-		idx = srcu_read_lock(&kvm->srcu);
 		map = page_address(ind_page);
 		bit = get_ind_bit(adapter_int->ind_addr,
 				  adapter_int->ind_offset, adapter->swap);
 		set_bit(bit, map);
-		mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
 		set_page_dirty_lock(ind_page);
-		srcu_read_unlock(&kvm->srcu, idx);
 		unpin_user_page(ind_page);
-	} else {
-		map = page_address(ind_info->page);
-		bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
-		set_bit(bit, map);
-		spin_unlock_irqrestore(&adapter->maps_lock, flags);
 	}
+	scoped_guard(srcu, &kvm->srcu)
+		mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
 
-	spin_lock_irqsave(&adapter->maps_lock, flags);
-	summary_info = get_map_info(adapter, adapter_int->summary_addr);
+	scoped_guard(spinlock_irqsave, &adapter->maps_lock) {
+		summary_info = get_map_info(adapter, adapter_int->summary_addr);
+		if (summary_info) {
+			map = page_address(summary_info->page);
+			bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
+					  adapter->swap);
+			summary_set = test_and_set_bit(bit, map);
+		}
+	}
 	if (!summary_info) {
-		spin_unlock_irqrestore(&adapter->maps_lock, flags);
 		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
 		if (!summary_page)
 			return -1;
-		idx = srcu_read_lock(&kvm->srcu);
 		map = page_address(summary_page);
 		bit = get_ind_bit(adapter_int->summary_addr,
 				  adapter_int->summary_offset, adapter->swap);
 		summary_set = test_and_set_bit(bit, map);
-		mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
 		set_page_dirty_lock(summary_page);
-		srcu_read_unlock(&kvm->srcu, idx);
 		unpin_user_page(summary_page);
-	} else {
-		map = page_address(summary_info->page);
-		bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
-				  adapter->swap);
-		summary_set = test_and_set_bit(bit, map);
-		spin_unlock_irqrestore(&adapter->maps_lock, flags);
 	}
+	scoped_guard(srcu, &kvm->srcu)
+		mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
 
 	return summary_set ? 0 : 1;
 }
@@ -3048,26 +3045,29 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
 				       struct kvm_s390_adapter_int *adapter_int,
 				       int setbit)
 {
+	struct s390_map_info *ind_info, *summary_info;
 	unsigned long bit;
 	int summary_set;
-	struct s390_map_info *ind_info, *summary_info;
 	void *map;
 
-	spin_lock(&adapter->maps_lock);
+	guard(srcu)(&kvm->srcu);
+	guard(spinlock)(&adapter->maps_lock);
+
 	ind_info = get_map_info(adapter, adapter_int->ind_addr);
-	if (!ind_info) {
-		spin_unlock(&adapter->maps_lock);
+	if (!ind_info)
 		return -EWOULDBLOCK;
-	}
+
 	map = page_address(ind_info->page);
 	bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
-	if (setbit)
+	if (setbit) {
 		set_bit(bit, map);
+		mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
+	}
+
 	summary_info = get_map_info(adapter, adapter_int->summary_addr);
-	if (!summary_info) {
-		spin_unlock(&adapter->maps_lock);
+	if (!summary_info)
 		return -EWOULDBLOCK;
-	}
+
 	map = page_address(summary_info->page);
 	bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
 			  adapter->swap);
@@ -3077,7 +3077,8 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
 		summary_set = test_and_set_bit(bit, map);
 	else
 		summary_set = test_and_clear_bit(bit, map);
-	spin_unlock(&adapter->maps_lock);
+	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
+
 	return summary_set ? 0 : 1;
 }
 
-- 
2.55.0


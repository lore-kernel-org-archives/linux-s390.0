Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7311332601;
	Sun, 31 May 2026 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780254242; cv=none; b=l+umWUJ6zBWwy5lA7/eqmuuMv1F6ckvoUtKy89Jvia+DTViP3JlVmlrdL4stm9Fg8c3x2vLcgFvgg6clsCeUPDx7hB1i8XTWBB5Dxj8OfTN29gJk8tJ0qMvNlu3mkBZFyGKIwvVwZaRNz8gdE1tXwXFDuDgC2msp9VnsCpUaVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780254242; c=relaxed/simple;
	bh=Sbh4BIF2xmBkMbMjU161gog7rKlIaORT/SY1sAxYkWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YD+YLUkXpKeJ3ywbsVQn23Zd9y5w7TS4Np+Yxh4UNsGd67lPO16ffn63ATMdAyVSdxGHgy78lrYM4jHZ3Rj4Ki/UBBEBXHzaL4MT+UUKxGg8flm5oHKTZn3Iy79ZIOAzkAaxejVsG9Fi+Ks8iITvihzrzBmKceBeB5QcxOE3NkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oE9S7KAV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oE9S7KAV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64V5uSDA2914998;
	Sun, 31 May 2026 19:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/LfqDzF7/ovwlg6ZK
	s48e/B+oa0vtHdHDyqM6KUavPU=; b=oE9S7KAV7lnV++vuEVNoYiMvSMGdrmlsI
	ZBQ2BAFip4mfGaUDjrn69IncbwrSc4LO5pNFf+OUcfaxjUbK8t/RoyZt3zTaGp0m
	IXU4x7UIT9iUkPegVkK+Q2pEqcTFyzshgUi73v8FscaCFkO4D/rvogsnf49hEgOa
	7eC/DWi4PxM4IoMHYRvOqJUfuWgSS4ln/sP+kmRlNOWOGBymZG1GXDDC82HQ9jC9
	DN+g11o101/StCjfYJAZdT01iIfCrOGuJZxXxdqz5iFXU0WQ7/HhVAxflEOeQaNn
	L/udLLF7CO4iE+oOKvjm5sAtRkebYhBJS1UyhTLk71bYCa/p/mVZg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd3wjup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 19:03:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VIsC19019316;
	Sun, 31 May 2026 19:03:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqh2qsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 19:03:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64VJ3u2630868136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 May 2026 19:03:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B44525805A;
	Sun, 31 May 2026 19:03:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08CDE58052;
	Sun, 31 May 2026 19:03:56 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 31 May 2026 19:03:55 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v9 2/3] KVM: s390: Enable adapter_indicators_set to use mapped pages
Date: Sun, 31 May 2026 21:03:52 +0200
Message-ID: <20260531190353.204317-3-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531190353.204317-1-freimuth@linux.ibm.com>
References: <20260531190353.204317-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDIwMiBTYWx0ZWRfX10pVwNup+uXB
 Mi9aKZRns2ZJm0ycNpun3TML4lqz0y3VTX6rPKXOjnf8amCDMv1Iz2DJb/RaaCwdd06aU0Hy4Je
 Adze5FmmpGit/9iJqbDGeEYi3lNWtAxxUh/AEJTgFRFnsUlN8CqYEb5KVDnpX2Ouwb/2m+pGvOd
 NSUdMePkucPDx8rue+K150VorIxvvk4Ji/kHgx9KLRdzXBsq55pfB+V9EJBEA9mNPkyuYlmjOVM
 2CHc1NsFreOwo7V/I+DGDZ5qM2x91LXPklFE4q/3kqsWNYhMRoEvQGl+G/xCY6K27N1VCI1lJnK
 shc8AS/xAiuwJUf19O+7apIsQgnzEl2Zir9ceBc4F3OBqR+yGd9+8Pkzv7lTELiy0sCSmQ8+wxR
 EJQE9uafkpjCgRZe/oWrPhxnew4rPq/ve3x3B0SmzUvkM5OIGoR448egQxcKefWu2sKt+hIpuUy
 q2m//XblvlQ7Kug1eBw==
X-Proofpoint-GUID: C4khQbMfmPauZGcLAJSPBR5N9TFqRo1x
X-Proofpoint-ORIG-GUID: C4khQbMfmPauZGcLAJSPBR5N9TFqRo1x
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1c861f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=qkd0NaIHCA_5-goIJGMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310202

The s390 adapter_indicators_set function can now be optimized to use
long-term mapped pages when available so that work can be
processed on a fast path when interrupts are disabled.
If adapter indicator pages are not mapped then local mapping is
done on a slow path as it is prior to this patch. For example, Secure
Execution environments will take the local mapping path as it does prior to
this patch.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 87 ++++++++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 24 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 5ad0b29c8c1b..a7cff4289f4a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2895,41 +2895,80 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
 	return swap ? (bit ^ (BITS_PER_LONG - 1)) : bit;
 }
 
+static struct s390_map_info *get_map_info(struct s390_io_adapter *adapter,
+					  u64 addr)
+{
+	struct s390_map_info *map;
+
+	if (!adapter)
+		return NULL;
+
+	list_for_each_entry(map, &adapter->maps, list) {
+		if (map->addr == addr)
+			return map;
+	}
+	return NULL;
+}
+
 static int adapter_indicators_set(struct kvm *kvm,
 				  struct s390_io_adapter *adapter,
 				  struct kvm_s390_adapter_int *adapter_int)
 {
 	unsigned long bit;
 	int summary_set, idx;
-	struct page *ind_page, *summary_page;
+	struct s390_map_info *ind_info, *summary_info;
 	void *map;
+	struct page *ind_page, *summary_page;
+	unsigned long flags;
 
-	ind_page = pin_map_page(kvm, adapter_int->ind_addr, 0);
-	if (!ind_page)
-		return -1;
-	summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
-	if (!summary_page) {
+	ind_page = NULL;
+
+	spin_lock_irqsave(&adapter->maps_lock, flags);
+	ind_info = get_map_info(adapter, adapter_int->ind_addr);
+	if (!ind_info) {
+		spin_unlock_irqrestore(&adapter->maps_lock, flags);
+		ind_page = pin_map_page(kvm, adapter_int->ind_addr, 0);
+		if (!ind_page)
+			return -1;
+		idx = srcu_read_lock(&kvm->srcu);
+		map = page_address(ind_page);
+		bit = get_ind_bit(adapter_int->ind_addr,
+				  adapter_int->ind_offset, adapter->swap);
+		set_bit(bit, map);
+		mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
+		set_page_dirty_lock(ind_page);
+		srcu_read_unlock(&kvm->srcu, idx);
 		unpin_user_page(ind_page);
-		return -1;
+	} else {
+		map = page_address(ind_info->page);
+		bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
+		set_bit(bit, map);
+		spin_unlock_irqrestore(&adapter->maps_lock, flags);
+	}
+	spin_lock_irqsave(&adapter->maps_lock, flags);
+	summary_info = get_map_info(adapter, adapter_int->summary_addr);
+	if (!summary_info) {
+		spin_unlock_irqrestore(&adapter->maps_lock, flags);
+		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
+		if (WARN_ON_ONCE(!summary_page))
+			return -1;
+		idx = srcu_read_lock(&kvm->srcu);
+		map = page_address(summary_page);
+		bit = get_ind_bit(adapter_int->summary_addr,
+				  adapter_int->summary_offset, adapter->swap);
+		summary_set = test_and_set_bit(bit, map);
+		mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
+		set_page_dirty_lock(summary_page);
+		srcu_read_unlock(&kvm->srcu, idx);
+		unpin_user_page(summary_page);
+	} else {
+		map = page_address(summary_info->page);
+		bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
+				  adapter->swap);
+		summary_set = test_and_set_bit(bit, map);
+		spin_unlock_irqrestore(&adapter->maps_lock, flags);
 	}
 
-	idx = srcu_read_lock(&kvm->srcu);
-	map = page_address(ind_page);
-	bit = get_ind_bit(adapter_int->ind_addr,
-			  adapter_int->ind_offset, adapter->swap);
-	set_bit(bit, map);
-	mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
-	set_page_dirty_lock(ind_page);
-	map = page_address(summary_page);
-	bit = get_ind_bit(adapter_int->summary_addr,
-			  adapter_int->summary_offset, adapter->swap);
-	summary_set = test_and_set_bit(bit, map);
-	mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
-	set_page_dirty_lock(summary_page);
-	srcu_read_unlock(&kvm->srcu, idx);
-
-	unpin_user_page(ind_page);
-	unpin_user_page(summary_page);
 	return summary_set ? 0 : 1;
 }
 
-- 
2.54.0


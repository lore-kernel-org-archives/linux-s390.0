Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC53C09E7;
	Thu,  4 Jun 2026 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601295; cv=none; b=S3tGzqtyEO6Wwy8k8c63EHtyuBJHwdiG9pIeNP62jHBnIaF0rXjE8eKbVMj9ztlxQRSeOeeO6NMGuLiLcCH6TMdiKnQlzDiovvryy8UBGcGC1OIKTj6LQXr/lwbV6HvtOt3IjARqSACK3NQH8zTNkeSZ+Z1Hzd6vvejPzH7KGTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601295; c=relaxed/simple;
	bh=s4YERblC7Bzprp+HMCfOQZctiwGNAQSwq6AX0ysC2bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6HnoAiS0xFCVLoH+fHFz5Upf+GipluiQ6inHlxmm/HGiFYhN9PRgFVbQDNrs0dcPalJeJTueYW0fvMbp1Kw3cyv/rGsemwPb0PkEI4ZUqtBFEb3UpZpJXOrV/kfF1VC96b2UKtsB1YEunf0e7nbCMU3DrItYt01ZANoa57iQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pmrwtob1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pmrwtob1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6548g89f3017986;
	Thu, 4 Jun 2026 19:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KI7LqHwKZfIDrvETq
	gniF+gRa8YgUBqQFM+fBFRd8Qc=; b=pmrwtob1aUHZ4ISa/+SuCE7Y2ZtKtQylu
	XKpPzD4pPVc7O5LqsKUiYbGa+W141a0nhA2HtQAdNWacPO1Njys60hS5VAM0GZVR
	jQvy6db/8nmoRjlIILwbvZyzJ1XCUsF/e3oHMBUV18804OpniocdYJ4al080v50y
	4qbENPQNqYKSp8IYcx1+oWBdFRiz5elzd7hzm8IiqDecX8+v3EINaU78d01Ft9N8
	H5vqVIH+Pma3np2N/B0VWAZWrwoxjkVqbiTa8t4+z0oDgMw9Iug/groe4mf0vjaB
	/dw5EahEmo2q5y/93Nz9INkGdDkieMJ2gNNI3TsWwd755Vz2q2hJg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtgrv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 19:28:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654JOM0D018521;
	Thu, 4 Jun 2026 19:28:04 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhpfuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 19:28:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654JS3Bl18088644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 19:28:03 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C19658055;
	Thu,  4 Jun 2026 19:28:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96AB958043;
	Thu,  4 Jun 2026 19:28:02 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jun 2026 19:28:02 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v10 2/3] KVM: s390: Enable adapter_indicators_set to use mapped pages 
Date: Thu,  4 Jun 2026 21:27:54 +0200
Message-ID: <20260604192755.203143-3-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604192755.203143-1-freimuth@linux.ibm.com>
References: <20260604192755.203143-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H4a6rjXMipybwP0SHELqF501slpyGoCC
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a21d1c5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=qkd0NaIHCA_5-goIJGMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE4NyBTYWx0ZWRfX0IyyvGr/kNDI
 EgFOkE8gJ+ZVgzadcsw9Ts3+FKXyGdzCWYNSZTRMXLqgb9gCcBmTM5nDIFexVPvgaijHO0APZx2
 PTfI4tfZx6rseBR3w05Aya0AWTBMZ51wyWJi2JdR2MvE51UkprYaMxsN2idMTAJzCu5JPt9Fnt5
 /U3BEQCy/J5mMWWV7KWMj8T24hb0Zh+K5V8tSDMK4K4LIoPqHcwOMcldqIIr4rZOheSzQjQxLP3
 w4nyF1G+AJIcTDmFos+6SKcgDQSswdAH4CHWfmJ9b9tzQv4ICuR6fR1F7sOtanQHH6QkYslPo1c
 Ni4yY5FhAQEYdM38U5X6D4k+grJEJShExWukBJncF1xM4Izcw14NpUH/5s7zQFoQ2ynJyntZQmq
 Cqzs/GMz8vt7L7UfDx3UxNTLj3EDmAiQ6q6hm9HJtlRylCPmeCCxNzyvsT4n2HUA3WEgRX1euAP
 tTMarInyyWL4a/J3VAw==
X-Proofpoint-ORIG-GUID: H4a6rjXMipybwP0SHELqF501slpyGoCC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040187

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
index d066a282271e..b5304816aaa0 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2892,41 +2892,80 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
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


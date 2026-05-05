Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9B54A33F7;
	Tue,  5 May 2026 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002661; cv=none; b=jgl8ksep62nM8/nvOoGqE90Whx6T5B2bYE6t6LviDMiYE1VCCZM9MRsScPnh6dM8gdYI+wwKd5hmRIj36OZq9qvdvTYZIJd+V+5JNSZrGAf+MirAbGnkEmVIxOBQMYF8b2D55oBzwhYaH4/47L34tstMP21D70XXzTQNUfDXPDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002661; c=relaxed/simple;
	bh=pFQW+Aavm9YwOjW7scdgeK52dCxNCwJJ498izyw2pvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDnHc/Of9k+eopvN6hQ2LOIwtygnAxqD2RZmmowSW0sg9zwgem2dWhbRy+FB7ImTEVJstQohdespdw8MOdfiYcKc1XpI/JJjAouFg2pkaHQABNbXm9iV+iiaVtqzuWV4xiFoRf2I+WKACHxAzOY7ocdZfpStO0/aWni/ewseqPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qGU3Fvhm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qGU3Fvhm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645FEkd31306776;
	Tue, 5 May 2026 17:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qSlwilqYkCJkECVs3
	s9xr4M0aR96tgG9xeCVSQ+Y/RA=; b=qGU3FvhmGNfyDd2i9dsmLdGaFpp9nQGAr
	b25LSv89s1R2I3BdSp9QO1rXOJDziTn1Lv+79/TX/ZFxlOxs8rGfZ/RDjNbq67SC
	/ja93I50Q0GqfelxK9zFrGqsdSnFSjnOxqTBI9qJ8OsRIavmD3JeHkYx7+Ahgk/U
	ZrCJtaTJP8Tjj5MtOmB1DdM/t/MejrZ7HgQJjMwn0KfyzLAYWyK647SjFV1wY1Mj
	w5tzdardQL7sCQ1lg32lunkkHkszDTNcKnTvY9EShNLunhfP19p7Gan8IBGvXAkN
	jPpCIP0okwDrn19r/8mgJrI5CXbqLnYbc4gCdxsHpqZUhqMeL4usg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4my6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 17:37:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645HOddr000838;
	Tue, 5 May 2026 17:37:34 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yafnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 17:37:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645HbWAc33161812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 17:37:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A30535804B;
	Tue,  5 May 2026 17:37:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90E7E58059;
	Tue,  5 May 2026 17:37:31 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 17:37:31 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v5 2/4] KVM: s390: Enable adapter_indicators_set to use mapped pages
Date: Tue,  5 May 2026 19:37:26 +0200
Message-ID: <20260505173728.160562-3-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505173728.160562-1-freimuth@linux.ibm.com>
References: <20260505173728.160562-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE3MSBTYWx0ZWRfX1xamYbhc9nD8
 ApiA3ApKTNK+BQldzcZDt7I3s2RQZSjZp8i3vJ2NfYxMmRg9jkZNSuZ/Uh9451hvKKECHjxIYHE
 7yGRZHvAj5Ik/xWRR8RFdD9YsoHl2iQDP0B/HC4G1CAPiUyXoIvISndSyxrTrzFfJm+sx4XB4SW
 0za1JFPFiZhTUs2wXQrsu/tx6pg4o+ZGP2puex3tQ0KQYcxczDtiCDycY+9QTz2vr+TNfhbsNkf
 YvIy4PCvBk8UDOFF/kagPbh4sJK5xGGFQBRXi7zuw2b3h62Z2p/Trg5M5U59gAF2UqTbjbuqBzK
 0O/q0fxuz1EFQxndnEsDHMfSa45gakP47F/zvTa5VDFMa/xDY8xhiTdNG4wid4xhI5cTYqzB2w2
 EB76GWb8+rJrj6DM/zvRNfXpV854TB8JUV00iP4ekY2ZAIz38ZUQz3FLFfrXZ6XUEaLBVeoujPY
 NYle/Ng2Lr4JU5mh+sg==
X-Proofpoint-ORIG-GUID: L5KMwgyEnMOOFzexlVCL2lr_XqsyALPY
X-Proofpoint-GUID: L5KMwgyEnMOOFzexlVCL2lr_XqsyALPY
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fa2adf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=HREIBFoc_rC1q7OR-gsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050171

The S390 adapter_indicators_set function needs to be able to use mapped
pages so that worked can be processed,on a fast path when interrupts are
disabled. If adapter indicator pages are not mapped then local mapping is
done on a slow path as it is prior to this patch. For example, Secure
Execution environments will take the local mapping path as it does prior to
this patch.

Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 94 ++++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 25 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index a9b418996225..12d8d38c260d 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2883,41 +2883,85 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
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
-		put_page(ind_page);
-		return -1;
+	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
+	ind_info = get_map_info(adapter, adapter_int->ind_addr);
+	if (!ind_info) {
+		raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
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
+	} else {
+		map = page_address(ind_info->page);
+		bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
+		set_bit(bit, map);
+		raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
+	}
+	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
+	summary_info = get_map_info(adapter, adapter_int->summary_addr);
+	if (!summary_info) {
+		raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
+		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
+		if (!summary_page) {
+			if (!ind_info) {
+				WARN_ON_ONCE(!ind_page);
+				unpin_user_page(ind_page);
+			}
+			return -1;
+		}
+		idx = srcu_read_lock(&kvm->srcu);
+		map = page_address(summary_page);
+		bit = get_ind_bit(adapter_int->summary_addr,
+				  adapter_int->summary_offset, adapter->swap);
+		summary_set = test_and_set_bit(bit, map);
+		mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
+		set_page_dirty_lock(summary_page);
+		srcu_read_unlock(&kvm->srcu, idx);
+	} else {
+		map = page_address(summary_info->page);
+		bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
+				  adapter->swap);
+		summary_set = test_and_set_bit(bit, map);
+		raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
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
+	if (!ind_info)
+		unpin_user_page(ind_page);
+	if (!summary_info)
+		unpin_user_page(summary_page);
 	return summary_set ? 0 : 1;
 }
 
-- 
2.52.0


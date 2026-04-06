Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F730F7F3;
	Mon,  6 Apr 2026 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775457872; cv=none; b=tUaM6+IkxvnySoZwj/66X0TvZGxHCN83kNIc8bOe4IHod0eVffo9bIBSc35j7TGU70qn1ntKvMq/uMLUKQND+ivrFxpPCYb132pXQhwohf66o/NBSMg4gl/JUERAmyV8XhYLEj/kI32HhHzQwlYLEAh1SxWDjiVNUPs/QnLKM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775457872; c=relaxed/simple;
	bh=Ceo3umb562I4ul6Gc1yTKdDTRwk1D76OOZUTjBWjArg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0EdDYiegFuOFHmVnHv51+hI5psaWd4pNCyDcMcKRI/pV/plfJ4wghsrevXt02VbvCjNJCPvOS0WYLwYQpI1dC+NFF0s5TCFz52chaBTj7BApF722cbFFjCK1FLC/UrNzaUg2e+/EA/IUJ4Ogs2n29JIdTOHAtE4ZcYAhy/UYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sJWfJS1g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sJWfJS1g"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63611me1680208;
	Mon, 6 Apr 2026 06:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=m6IqFkveI+874/6rv
	g0vXNiZwnZ3MwW5fYrKRAtDJPQ=; b=sJWfJS1gLQXctVRMYtwvSlW046qfNv0tO
	A7BvHaDS7EIHEiMkugKBICMiOjTS+KO7T2lCmOBw4UcIpV5RrCimwx5OX4MD4/8m
	GZi+WXgNXlwdeGEJUZWFxiikRh2W4TjnI/qSU2IcWXpR++SC5G+kVU1vJ66FlN7O
	8HYJin9V69EjH7Hh+eGCRY2cl8Gpq6bAe3l8mGLmUakfihSWbGDvzL6Ql15aH5Jr
	ZGeExIDC4NTwiORPtpXDZ4rTsLLwy5c8zzht2d4EYI1u5cOIgd21nksf1YPMm070
	AG4j3IQXRLMiyc9kUabfDk5fln2jme/z6KqDecNb7snXzz2779zkg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat9rd1by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 06:44:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6366GAQf022945;
	Mon, 6 Apr 2026 06:44:26 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbefkbkxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 06:44:26 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6366iOQs24248862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 06:44:25 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC65658062;
	Mon,  6 Apr 2026 06:44:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D35958057;
	Mon,  6 Apr 2026 06:44:24 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 06:44:23 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v3 2/3] KVM: s390: Enable adapter_indicators_set to use mapped pages
Date: Mon,  6 Apr 2026 08:44:18 +0200
Message-ID: <20260406064419.14384-3-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260406064419.14384-1-freimuth@linux.ibm.com>
References: <20260406064419.14384-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0LzzhHE353WOIxmce9JJxk7kQjjKykVR
X-Proofpoint-ORIG-GUID: 0LzzhHE353WOIxmce9JJxk7kQjjKykVR
X-Authority-Analysis: v=2.4 cv=bLYb4f+Z c=1 sm=1 tr=0 ts=69d3564b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=DOZO3_vCJS9djEhVyToA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA1OCBTYWx0ZWRfXwvSgTsuKBgEj
 aDyNYrixBPEMOPPVmyDCJVjZOv6T2DE58qZ8xGeogUxsP1jCahLBdr2pwOBh3LONO6XqhWRpaEi
 7fFvhcwlnUm8Yd4CRVRh548d1Q/vZGpix2rfJ7pPYvKahr4prvK8v6KImUhtiRwGZytw0uKsCfz
 ojJw9/6XiGo6PtIZrR0phY7VXeP4GNqhLkgxhBjmTfz3LFE0Bx/VSydH/eia3q/mHpxUrBo8C8v
 QD6RtK0B5W0Z+WJgoAJRBBtZbRmh33fMEn34PohQNas4a0Lpbj94ECcIG9GoboTeexcwsphPKQk
 xtp4HS8LSO11fiAR4oG/AvD/dULN51aJRW0SNJTjRpXVKJihvXx7GooGK4GfUTwzrVd7KefzYM4
 egUZm489WXXcXvxz/CkLfgKRAUzkv7elXFmj8JNN9MKH9GXvXuBMvUa6hB0uw1UkMBruQCAh4SN
 jY7c8Xt6XxPPVu2/a2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060058

The S390 adapter_indicators_set function needs to be able to use mapped 
pages so that worked can be processed,on a fast path when interrupts are
disabled. If adapter indicator pages are not mapped then local mapping is 
done on a slow path as it is prior to this patch. For example, Secure
Execution environments will take the local mapping path as it does prior to
this patch.

Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 91 ++++++++++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 25 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 47bd6361c849..f3183c9ec7f1 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2847,41 +2847,82 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
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
+		if (map->guest_addr == addr)
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
 
-	ind_page = get_map_page(kvm, adapter_int->ind_addr);
-	if (!ind_page)
-		return -1;
-	summary_page = get_map_page(kvm, adapter_int->summary_addr);
-	if (!summary_page) {
-		put_page(ind_page);
-		return -1;
+	spin_lock_irqsave(&adapter->maps_lock, flags);
+	ind_info = get_map_info(adapter, adapter_int->ind_addr);
+	if (!ind_info) {
+		spin_unlock_irqrestore(&adapter->maps_lock, flags);
+		ind_page = get_map_page(kvm, adapter_int->ind_addr);
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
+		spin_unlock_irqrestore(&adapter->maps_lock, flags);
+	}
+	spin_lock_irqsave(&adapter->maps_lock, flags);
+	summary_info = get_map_info(adapter, adapter_int->summary_addr);
+	if (!summary_info) {
+		spin_unlock_irqrestore(&adapter->maps_lock, flags);
+		summary_page = get_map_page(kvm, adapter_int->summary_addr);
+		if (!summary_page && !ind_info) {
+			put_page(ind_page);
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
-	put_page(ind_page);
-	put_page(summary_page);
+	if (!ind_info)
+		put_page(ind_page);
+	if (!summary_info)
+		put_page(summary_page);
 	return summary_set ? 0 : 1;
 }
 
-- 
2.52.0


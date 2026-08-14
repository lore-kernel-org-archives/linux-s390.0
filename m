Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB40472F72;
	Fri, 14 Aug 2026 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725246; cv=none; b=clhog21GHekOnzp3k/9CqF1yDM/9LJ3KRAOqMQAZZnlZ1B0zsHxaK+Q+2TWPp2rEXzvLpyUZ+pb7zS8BKfudtwlPCTSnnKIIh421WLmDjuH76xncLHy9xoROzB/DGS7RLFOCdh2A1efalM6PX6100zNBThkPFr3Zf09aKBidlOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725246; c=relaxed/simple;
	bh=38WLb7tJBA54vnYXwUGVTGPnr/7/N2hZdYahs0DftHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beic1Xj0Fhby0NQOKhdCp08eM+C2ccTdmrtX2whcHd9F/pmChYGtuXECGZkewlba9Tt0XKIoGeOmJSa1+1HNBKLt6/DxFsGyg/ysf4gaRmKGtJCpuMYFOPPICFxuy/Ai/UlFxM2K2TvcUQy6eIigYRKn2y5U8QBPzsQBrhZ2qz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jqh2AB9B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jqh2AB9B"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5WWC1289635;
	Fri, 14 Aug 2026 16:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Kly62Bl/mmZtytbLO
	I2Iw+g+MeZCeCzbeA6vm4lyVKs=; b=Jqh2AB9BQKimndRjXRrSl4/6DKR0RQxB5
	oIWJMbMPn+Dqo34ed93SQHYNjuAF6i1sKZNEP3U3NcGsrs9kCO1Np7QBhKcfwJuu
	yuNJcxSxA9n/8+ogSyDgACdWlI8bekSzErrq23Lgokrzb4Rx/uu7oJ8YjbUs+5Nr
	45CyF7JvqUuak8O/e+ZQTkAplXy+f1X13g6JFZ/dwXjR5npnw+/NSsXu6U/Drby3
	LtkHk2vZLz1Xe5w9rFJT9JiBozDUxDykIX7qX8dEZpV90ULvS9/98l/H1ExbAFf2
	O0YsBBAKDXsl7W3HUjq5DHbQXZvlznjSDDK8A3EfQhBPRlRkj6HIA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9wpk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 16:34:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EGQGUD027864;
	Fri, 14 Aug 2026 16:34:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gqww5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 16:34:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EGXuxf39911808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 16:33:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FC3520040;
	Fri, 14 Aug 2026 16:33:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 075C42004B;
	Fri, 14 Aug 2026 16:33:56 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 16:33:55 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 1/6] KVM: s390: Fix dirty marking in adapter_indicators_set*()
Date: Fri, 14 Aug 2026 18:33:50 +0200
Message-ID: <20260814163355.227191-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814163355.227191-1-imbrenda@linux.ibm.com>
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7aow7-kxfsF0Hy3cZG603c0HWe_sL_9K
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7f437b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=erwwKp9ikJBr0o1lINgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEyNiBTYWx0ZWRfX1daKWaCOn2yl
 CMsZxmpmIoljYQDu/bm0IImaEMNAeMYGrX6H5KJ+V9TcEfyabI34ubd4iNzzVsOCks49XqEG/iz
 LC+SLkTPpHCsdQuo/jc4UXePt6AelZpozCqleTuC3z9Jg+4KsymYiz14FwLHkNiDPpumA9BSlt+
 EUeflX9tGM8fcO9jOvi+4F4h/LOXu3L6vLPfDzYoXhj7KTUOnItAthFay+P6BYLbVuOo/8t97ov
 YgBmMBrCkEyA4Juy7ed6Hq4nvmEkz0O5ggI/qx7lG1OtyyU6YOeE4xJcuvEV2/6JpJGJhAM1txy
 M4RAu5dk1baKQgVMT6YXEnun3X0frQvRhk+DzX/Wi0EM5s8wFUHwEKboM36HSs1TqNeruVsIDuO
 ak+Tw243zwXgRLpan+ySfWLcMSpKI97tqK5KIlEsRWQy5b6zqZ+a4MP+NNhivh6SCGdQ71JdvaS
 WNct27RzfEfXbcJxsxw==
X-Proofpoint-ORIG-GUID: 7aow7-kxfsF0Hy3cZG603c0HWe_sL_9K
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEyNiBTYWx0ZWRfXz4KT40WkpJpO
 ulQCTe0gbV0oeMwx9E+mu7aoH1pA8TnQKhzhKbUyVLgoKLgLHCAdcOrYuASWR6zpFgHlHGNNwe/
 gw2OPY88Ol1tzEM11tIQdT7lncQ4QHw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140126

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
 arch/s390/kvm/interrupt.c | 40 ++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index da740a378a8c..fc4d1f8193d9 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2984,12 +2984,14 @@ static int adapter_indicators_set(struct kvm *kvm,
 				  struct s390_io_adapter *adapter,
 				  struct kvm_s390_adapter_int *adapter_int)
 {
-	unsigned long bit;
-	int summary_set, idx;
 	struct s390_map_info *ind_info, *summary_info;
-	void *map;
 	struct page *ind_page, *summary_page;
 	unsigned long flags;
+	unsigned long bit;
+	int summary_set;
+	void *map;
+
+	guard(srcu)(&kvm->srcu);
 
 	ind_page = NULL;
 
@@ -3000,14 +3002,11 @@ static int adapter_indicators_set(struct kvm *kvm,
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
 	} else {
 		map = page_address(ind_info->page);
@@ -3015,6 +3014,7 @@ static int adapter_indicators_set(struct kvm *kvm,
 		set_bit(bit, map);
 		spin_unlock_irqrestore(&adapter->maps_lock, flags);
 	}
+	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
 
 	spin_lock_irqsave(&adapter->maps_lock, flags);
 	summary_info = get_map_info(adapter, adapter_int->summary_addr);
@@ -3023,14 +3023,11 @@ static int adapter_indicators_set(struct kvm *kvm,
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
 	} else {
 		map = page_address(summary_info->page);
@@ -3039,6 +3036,7 @@ static int adapter_indicators_set(struct kvm *kvm,
 		summary_set = test_and_set_bit(bit, map);
 		spin_unlock_irqrestore(&adapter->maps_lock, flags);
 	}
+	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
 
 	return summary_set ? 0 : 1;
 }
@@ -3048,26 +3046,29 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
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
@@ -3077,7 +3078,8 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
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


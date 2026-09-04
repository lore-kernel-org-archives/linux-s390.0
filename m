Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C830C160;
	Fri,  4 Sep 2026 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502020; cv=none; b=sJHBOMiYWsEzno/9sta7Iakzm2YboGQTWXguAIzJhSHlztSFWVpmna0Vig6ehJy2K/napcNsup4+r0f1r6Ai8/pz4Tg+/KKSzv5dhl4WUWLLCDnCzMsQeZBlPXcXFd6zMag4mDC5sqeJ/smwPf7rYMjm2vx7bcp59vcnw43bJhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502020; c=relaxed/simple;
	bh=jn5bChniuImaJjUA17NI7W438lIKbEn+KD96LqAb1bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGM/1uvGxW71WjkV7nng3SD5hq0iZ7IAXCYGN/YjQGvSkvj/F5qC0StFQ7hoyHUUCfLHQK36m4GZjcNzyX02LAapDnYHyfI9U8QwL/g6uNMJ0R4jyr+jOUaD+c7Q0F6KEZYoOXnHN45G16qR7/FDuJH8S8Ecj9RjYXXDD/hP0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qurcmuTR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qurcmuTR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464lbH984391;
	Fri, 4 Sep 2026 06:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lqK7fTBlMfJKNc/gp
	IwaMi6HkkXGE2Bq46P9jN/jwlM=; b=qurcmuTRSMQ8ISULcSn2CNDpNMfL9DwGK
	vgDYsXT7QujCqxnV8koY40qoRX+or6k52GMp1FJVLYxFKrl8OZSjfyZLpBZgjlkY
	5LXO30fCm6gNx4zKDHm2VVMeReAn7/IES0E0EYutq191LVOWg12AwyIFdcyPEhy6
	glW1zG8HtjBI7gs3KhNzCH8EYZKCjwK6jGJBYI3g/X4dVPC4vUZc7xXngxoAcPh3
	PnWxyvrIR31su4mXO9CKNNuVZ0xRcqnu9qJ+Zh5ZjO0rEJzmTM4cFb2SjnGQ3iVj
	KTqtNmgrWlIPcFBlsBki3gblrx/f54yurn4Q74Xxvj1ny4dC4O3Fg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2trb9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uHfR015867;
	Fri, 4 Sep 2026 06:06:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjauv3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68466nWF37552410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:06:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED8A420049;
	Fri,  4 Sep 2026 06:06:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9402F20040;
	Fri,  4 Sep 2026 06:06:48 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.53.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 06:06:48 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 01/11] KVM: s390: Fix dirty marking in adapter_indicators_set*()
Date: Fri,  4 Sep 2026 08:06:37 +0200
Message-ID: <20260904060647.562443-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904060647.562443-1-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9a6000 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=EkfAVvxasnAm74aL7hAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX3e3fuIYmOg+N
 U2Q5puhod5Tgp3MLR3hS8J+BAwIMrvKCH9zvRBgk+v6SGWVYszdQKI3rP6UDRl9Kq4QOHo9qKJt
 Q5NgLqUSkEHs2Im9vjGhCVkn82scids=
X-Proofpoint-ORIG-GUID: 4psIJeCtmf88fOy31GetXnHFs0w84WU8
X-Proofpoint-GUID: 4psIJeCtmf88fOy31GetXnHFs0w84WU8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXzm0gG7kMtsru
 EkuJrfz+qSaMQpgJRJqmAzCtpMupzW95d+DXcq5SROxlXFlwkbHXLzirp7C32bot32pReOpWUd2
 TSICiLrxVBMy69ffeI4GY12WAeOzZvJ72jppJmRGGqj62lnpM5casACKFNMvzhLS/TcQwGm2kwR
 eZi6ehXW/WjVICltz3kUByJj+fi6VCyEVILUr2Q1d4mmBhUuW2CjQcn4dnwtLIXthrB/mmGUKGc
 p9HH+90q0wf1PoARV/KFEP9tFbtyKLWc/UZle5J6EkGZoGJZoj96Z9YL6oYDL6k4aDDyApOAQd9
 i+v9SUSFjruGKLU8BquQ/nC8i1kcBfRFlZCCCvHQsx+58kZ5VGppgsbuKmgsTex/CJelP8KL/qU
 TXXsqa4ibBWD6ZSMWPNFkiXm8D4OgeUfvUaH+6HZ0EweImbj2dEzSNl+jPLuJo1dz3UxiYSu++a
 7j18HdS4Sz3MDvvzW5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040054

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
Message-ID: <20260828115439.145885-2-imbrenda@linux.ibm.com>
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


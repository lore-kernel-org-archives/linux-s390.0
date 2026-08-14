Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B9476CC6;
	Fri, 14 Aug 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718458; cv=none; b=S3e6wnMJrsjMHI6HgRD0+5ukjlSCyiYR6mpzEd9djLOwAcxm7dtvDb933K6xlJ5fB30jWi3GvD+uUGiJEknXZ1NWgiTC9Yg2QGleTuJZlj326NLUBxLeEXAD0imGmK9NyKUDoO6vc3Mr+leBIIkTafc9WlTLBDBb4hAOn4pM/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718458; c=relaxed/simple;
	bh=38WLb7tJBA54vnYXwUGVTGPnr/7/N2hZdYahs0DftHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwHxuHkWCCzkUh3mEZJfS4R+qMvL0aVRyhCqXoo9C0HZkVbqIEDUF61dwzoq8Zayyh/DjvPrSwJ7KPiTr0Q5MUbUACLeKAu5aHlDu120vhxI1WqnseeVL/m+MX5HRDKBeK0Cr4TwCowpcRVfVl2Zz3M1hA/0JZ7j78uzzZdfA8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ptvlZajY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ptvlZajY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5jQ41370431;
	Fri, 14 Aug 2026 14:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Kly62Bl/mmZtytbLO
	I2Iw+g+MeZCeCzbeA6vm4lyVKs=; b=ptvlZajYv0Nn/iFzJfZfp14nsyTWUSrkA
	IAK7xF+HyL+jZ4ZmQwzcZ9GDwz9/HSmlhoPO2zQIEfDEozPv9FYxYINkNkRDE2uh
	CcjWsBnRan8E+jpDchPHVHuhLamc9OVHaSa8KEckmPjppkFZ/otqUlCjQROkgfnO
	oAffAsTalkocc3StwixecVIZb9KlxYmJWWSmry4AbKNO2M5cZGucNYLnyYZyGoVl
	UbHbjncugUstcaOXvbyuFCwFfGURRUNkfFSeoAOFRwIwNQltLtkRNQTNUWlnZ/6+
	aL67sk0ZJSMjapTZy6en0czgubKq0y2vIH9i+Fmv2HRG7/lOQWSSA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwm2wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 14:40:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EEQJmA004015;
	Fri, 14 Aug 2026 14:40:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk7n6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 14:40:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EEegRX37880206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 14:40:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62E9820040;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C8A82004B;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 1/6] KVM: s390: Fix dirty marking in adapter_indicators_set*()
Date: Fri, 14 Aug 2026 16:40:36 +0200
Message-ID: <20260814144041.169025-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814144041.169025-1-imbrenda@linux.ibm.com>
References: <20260814144041.169025-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7f28f1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=erwwKp9ikJBr0o1lINgA:9
X-Proofpoint-GUID: Go7x-9ahecc0UR7BdG9hxYdw3ciebVtV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfX+gvyftSF2Wo4
 VjywaFksegEgkjK1n6/YMdZ86umu4Ab0uN42FVwM/5mYfg1GgrxxeCVTuJnvUIXYpaZRrkG9qud
 aqYaOWeWqfnMOHGKPEKCGax2Yggo5DHQ+aYQuXa6f+siv8LgnYwtmrCQw5p2UGyFUN5lFpqhIG2
 THmVea8Kdna8Sifhmue0plJRWUeM0gK7j+sBKwt3n7yVh1AMtLTTjLIG8x7iBM2Wd9rQaDOkTR/
 ypjha2vY+5YA4qUTuP7PnHfqaNhbU8pKn/HKYMce9RwrEKONv4LXdHVSMKN5DqNDUmGQCgHGsb7
 8d4X3NqPONgOmkruc1LGodhGwALp1Q9FDphewrPvuGByUpF/moz3govVSt5sfLWLqm8KR86ZeWI
 JOvNjHwFIWX7usoE+7ESQ6pyCTKC/FMaaSRe8BEFlrBWp7Wg/AebdTC9AB3nzxvHX+pLUUH9Sh4
 Tz6p77itBC8nyvJiR4A==
X-Proofpoint-ORIG-GUID: Go7x-9ahecc0UR7BdG9hxYdw3ciebVtV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfXw8eW405SONi9
 hiLTOhzf8OSsyh1qeFPppO680sNa4agmfZnCoDN3IztzxluQtCeLfxXO0x71BwPx5Dj8bwV8g8e
 XiFBCknN85wybYAXFUNC591pMbNr4Kc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140111

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


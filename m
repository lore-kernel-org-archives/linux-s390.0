Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6347C3C1411;
	Tue, 11 Aug 2026 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463817; cv=none; b=HQc29ZLuaerlp0usf/sWWnyUJOMcnHB3VrJPEXNwPGzcMVsugisH2vxFDfwW++EN9003SNA7RRQGIBKDdbObrK01utrV3ffbq/CFHERk15zeEbih9yxgH61+qpAik7Xc7dHko+3+jS4qd3/Yu4dQsmEfFgnRTz24yYJTKIx+078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463817; c=relaxed/simple;
	bh=M+/husYVJLF1oieDU13yrjsntpdbGoxAxvTFpnDqAQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V62iT8d1IVuxkyVQOW53tG/pogJtzNAYA3bp3+zSxRhl5EjqHPdDStaEZx2UYTQfxbK+GqSLRXZdHbUrt5xQiccZhyEEeq+bCtVLMpQItWdZ9YH6vc5tZFOCDQXqaVr0m2pOhIPIhF2rMOPvr2CbA/EFU9Fm69/G3Tzi2myXhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S9ZT/g/z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S9ZT/g/z"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXAbd3634704;
	Tue, 11 Aug 2026 15:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Smvn94HOZetefxrmH
	ydfEmdWUI20sGeoiLPeRQ2o7H8=; b=S9ZT/g/zuPApS2LbU1Ytmew4rSeU5PZFG
	Vjfji1KNp0XFT6LeqX3VyCEhLmCa6qxdvq0yFCu+ypUYtVRuKROxraT95mrlu3CU
	DyojYaZN8p6OOuARaRQ2mKUZ1JKqZRsXOdSKM/wzHQppYj3m1BgMfqk1UMNqfL4m
	2PXq07CuImIC8/FDEYELEG4qrnjccAzeodaggrJbH4+qTJhJ+CwIia5i1Pv2swNy
	D4PzJq7XDC9AQBvq//TmvHNwNSlliBuRzXVrrhx7IrCrmOkhsWQWoLj97d560lAT
	xeCpbxvLnB+Tz8anpCYNd5LPb1fxTclAx8kflGIwXNodLOmCZGLEg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23pgg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFuKcC016169;
	Tue, 11 Aug 2026 15:56:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1d80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFuhnG37290338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:56:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AA8820040;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 061142004D;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:56:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 04/11] KVM: s390: Fix dirty marking in adapter_indicators_set*()
Date: Tue, 11 Aug 2026 17:56:34 +0200
Message-ID: <20260811155641.219777-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155641.219777-1-imbrenda@linux.ibm.com>
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b4642 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=5CEK7-iOHuguGwIWKbsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX+gOI4tyC/V88
 Ci7KViEhPDG2c2H8pQ0oH1t0WNq1FqCmCY2xGhIWp8koxJqJ4NimE/k2MN37xCREdlcYbb689J9
 2kYVWUbwVG6ZTHEyKiTKAe5jwNnTT4eKUptjwGjh4nSDPXOb9FdLnCykRQHoahWQh8NDSKk+YfR
 7YBUECVZwmYUw2sPMm5EgOc7C1CvbWSlu8J/PLqegrtLyUxUQuf0pclZYM9P+lCnN88YHliFuNS
 Uh0kxFWYXJ5BkU2YvWrerBUx9FWsihgTjjkbHXgWhOlAUH7qzyIOcvrlKztn1ldjB7MBRhd3bNy
 cuoUmp4DbT7d3Az1F3gQmdfEMjDj0vS2k5QKtYh+zLfcTosB0MwbeMHdNh6vFhAiZzkgTWhYbIU
 QWvmgD6E+5sxoKoqCucjKkiq6nSNCi1S3orOxiXczCn5go16SgJNq4JJlKr/asq1iUUd6wUFEd/
 YCNPMN7tdO2+YLAWqpw==
X-Proofpoint-ORIG-GUID: TvKrkgWxxvh7PzYpa-kbyjaR6otH0ogR
X-Proofpoint-GUID: TvKrkgWxxvh7PzYpa-kbyjaR6otH0ogR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX1qx0CSrOXYQA
 KoP+6WqgeN7WT7vK707ucFnXTXBC0S1hTmfdcc7LMfH3n2fSAbC/igMbele5bp8z6vmCBcsn1dh
 IQ65QP7sWcCxR8jEnRCkasfQM5kAnw0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110130

When the indicator and/or summary bits are set in the guest, the
accessed page was only marked dirty if the access was performed using
the slow path; accesses through the new kvm_arch_set_irq_inatomic fast
inject path would not mark the page as dirty.

Fix by adding/moving the missing calls to set_page_dirty_lock() and
mark_page_dirty().

Opportunistically reorder the local variables to be in reverse
Christmas tree oder.

Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use mapped pages")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 84 +++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 30963e05e0e6..400ce7195b87 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2943,12 +2943,14 @@ static int adapter_indicators_set(struct kvm *kvm,
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
 
@@ -2959,21 +2961,20 @@ static int adapter_indicators_set(struct kvm *kvm,
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
 		bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
 		set_bit(bit, map);
 		spin_unlock_irqrestore(&adapter->maps_lock, flags);
+		set_page_dirty_lock(ind_info->page);
 	}
+	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
 
 	spin_lock_irqsave(&adapter->maps_lock, flags);
 	summary_info = get_map_info(adapter, adapter_int->summary_addr);
@@ -2982,14 +2983,11 @@ static int adapter_indicators_set(struct kvm *kvm,
 		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
 		if (WARN_ON_ONCE(!summary_page))
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
@@ -2997,7 +2995,9 @@ static int adapter_indicators_set(struct kvm *kvm,
 				  adapter->swap);
 		summary_set = test_and_set_bit(bit, map);
 		spin_unlock_irqrestore(&adapter->maps_lock, flags);
+		set_page_dirty_lock(summary_info->page);
 	}
+	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
 
 	return summary_set ? 0 : 1;
 }
@@ -3007,37 +3007,51 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
 				       struct kvm_s390_adapter_int *adapter_int,
 				       int setbit)
 {
-	unsigned long bit;
-	int summary_set;
 	struct s390_map_info *ind_info, *summary_info;
+	int summary_set = -1;
+	unsigned long bit;
 	void *map;
 
-	spin_lock(&adapter->maps_lock);
-	ind_info = get_map_info(adapter, adapter_int->ind_addr);
-	if (!ind_info) {
-		spin_unlock(&adapter->maps_lock);
-		return -EWOULDBLOCK;
+	guard(srcu)(&kvm->srcu);
+
+	scoped_guard(spinlock, &adapter->maps_lock) {
+		ind_info = get_map_info(adapter, adapter_int->ind_addr);
+		if (!ind_info)
+			return -EWOULDBLOCK;
+
+		map = page_address(ind_info->page);
+		bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
+		if (setbit)
+			set_bit(bit, map);
+
+		summary_info = get_map_info(adapter, adapter_int->summary_addr);
+		if (!summary_info)
+			goto out;
+
+		map = page_address(summary_info->page);
+		bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
+				  adapter->swap);
+		/* If setbit then set summary bit. Else if falling back to the slow path */
+		/* with setbit==0 then clear the summary bit so the slow path re-injects */
+		if (setbit)
+			summary_set = test_and_set_bit(bit, map);
+		else
+			summary_set = test_and_clear_bit(bit, map);
 	}
-	map = page_address(ind_info->page);
-	bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
-	if (setbit)
-		set_bit(bit, map);
-	summary_info = get_map_info(adapter, adapter_int->summary_addr);
-	if (!summary_info) {
-		spin_unlock(&adapter->maps_lock);
-		return -EWOULDBLOCK;
+
+out:
+	if (setbit) {
+		mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
+		set_page_dirty_lock(ind_info->page);
 	}
-	map = page_address(summary_info->page);
-	bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
-			  adapter->swap);
-	/* If setbit then set summary bit. Else if falling back to the slow path */
-	/* with setbit==0 then clear the summary bit so the slow path re-injects */
-	if (setbit)
-		summary_set = test_and_set_bit(bit, map);
-	else
-		summary_set = test_and_clear_bit(bit, map);
-	spin_unlock(&adapter->maps_lock);
-	return summary_set ? 0 : 1;
+
+	if (summary_set >= 0) {
+		mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
+		set_page_dirty_lock(summary_info->page);
+		return !summary_set;
+	}
+
+	return -EWOULDBLOCK;
 }
 
 /*
-- 
2.55.0


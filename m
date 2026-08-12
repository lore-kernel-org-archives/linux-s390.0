Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD2429CD8;
	Wed, 12 Aug 2026 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531489; cv=none; b=j6yuRG7F8zHttDGUjgzZMzgYrVzg1Ks5nKxS2omgo2h0cU34L7at9n1hhxJY+Zp5b5Pmsrk4cpQFq3cw5hyi1wnqlKusZKPslEvwQPde6ZbBHDXdVeDPDrhQ7LI8w+k1XsV2qvaSdnUiUPNpPBvwwjya9OzSsWarj2Jozjkyae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531489; c=relaxed/simple;
	bh=xW+1IeqlL6HH16GGS/xkmOqepVaV0vu4C9oC8N5wgOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsE+aBkleZ68dGsAI/JcZ8xGReO2Vfk5UHjhb/mve6EImxdNainda71VKxq3eYkV+FG8tg17eWQPz9zrlUm8Yv3Lg+19K/DBpA98Cs+O8NzcpPVPNPZWJTKodUMcf7HHZ/7MCueAdh/QHfTpMUidnF4yqnBVfI33LkfPmNZKbiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WeLrXBZu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WeLrXBZu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CA1caH3206611;
	Wed, 12 Aug 2026 10:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ojuOI7ZpoHWiTpTVd
	olaxx0BYCQuLoRUO3U1AYMLDII=; b=WeLrXBZucDL80N6boJw/OiTNUa9vf3YpV
	uZekg8gHbt0BOzJYyxiVGTfjBC++qwv4cz1TwAACxFA546KWBnFfxdwvX3XznBxA
	B58Bs+xhJBtedxoSZOfcIoSAL1h367spGd4gsMJ4rLj4jwuoUAsds63wS0A66HaO
	kIvPfDyIkY5wMkZ+oHULOqfya3C13DE0e+jbv0r51pwHjckI/VE7NWSPJVL50vBQ
	CQQ+iPb1Ufz/ENmGouO3CLJUDe/edRtI0eWwANZkkC1WnuSOVCTILNl+zUOwuQgt
	BZKB47EzQpl96/U7qYzO9JWj+43iz84QDjEjAD17CQD15CSdapD7w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw976d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CAfHJn025114;
	Wed, 12 Aug 2026 10:44:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h5hxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CAibsf27787916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 10:44:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C93DF20043;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1F172004D;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 4/9] KVM: s390: Fix dirty marking in adapter_indicators_set*()
Date: Wed, 12 Aug 2026 12:44:31 +0200
Message-ID: <20260812104436.109741-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812104436.109741-1-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c4e9b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=SmIaXW2kmnaYJitNQKcA:9
X-Proofpoint-GUID: DqIIHd-ZbYhHZEhWjUFIwKM52-sSlpcS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX6RMYV9GuHjEo
 BheTOIiFUEpSmolnLXpAvSF9JKnY1Fhq5hKl0VlLlS0rbsMOlpPOp+tFt0P48/m7tZEskCbMVmA
 wZjYEDoHNlpWdVZtz1rjBdh8SPl+1O85rTbOqI3HwVpu0DjwTnzbA2kClvUjCv7Sx9RyPsOp8la
 59SqctM5zJ0iBla33i6PPuIEODt9TmVp8GA5FZm6R72B2pTx0XtIBCRQtkyg8n1nT9dQ02eDPzj
 oWfL+7DYbAukRbuIdzmGiiFWT72TzPCxapSyJfvHMKFNyZUSd2cZJ/tZqqFsv0RtYF1OIjLuNgY
 Mf+Gl0u67DXdqY6S9tDXCi/tcYbToN1FHtmhdGQT7vTOl7bA1VqYmtfaXDXYc+xGn5902z2NL8s
 k6dfAv9NPDntQFIoWMZX3ZOBS+sZc2O8J6kubs+6QBLesNzqLhP429ScScu0N24q+ZNnVp3Coft
 80VZFspFP+qNIo/7NcQ==
X-Proofpoint-ORIG-GUID: DqIIHd-ZbYhHZEhWjUFIwKM52-sSlpcS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfXy+81emevzNk2
 uRMM+qYxjPEOSiawoVH9BOT+domuxwyKB4Qv8jIrZA7FjwV8uAdqJnp9D39PzbxDn9HQNa/ewJz
 LnhL1BP7p6zylRqLeCtCzP5D1MPS5jM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120084

When the indicator and/or summary bits are set in the guest, the
accessed page was only marked dirty if the access was performed using
the slow path; accesses through the new kvm_arch_set_irq_inatomic fast
inject path would not mark the page as dirty.

Fix by adding/moving the missing calls to set_page_dirty() and
mark_page_dirty().

Opportunistically reorder the local variables to be in reverse
Christmas tree order.

Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use mapped pages")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 48 ++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 61e75d10110e..8e4b88bce31f 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2953,12 +2953,14 @@ static int adapter_indicators_set(struct kvm *kvm,
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
 
@@ -2969,21 +2971,20 @@ static int adapter_indicators_set(struct kvm *kvm,
 		ind_page = pin_map_page(kvm, adapter_int->ind_addr, 0);
 		if (!ind_page)
 			return -1;
-		idx = srcu_read_lock(&kvm->srcu);
 		map = page_address(ind_page);
 		bit = get_ind_bit(adapter_int->ind_addr,
 				  adapter_int->ind_offset, adapter->swap);
 		set_bit(bit, map);
-		mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
-		set_page_dirty_lock(ind_page);
-		srcu_read_unlock(&kvm->srcu, idx);
+		set_page_dirty(ind_page);
 		unpin_user_page(ind_page);
 	} else {
 		map = page_address(ind_info->page);
 		bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
 		set_bit(bit, map);
+		set_page_dirty(ind_info->page);
 		spin_unlock_irqrestore(&adapter->maps_lock, flags);
 	}
+	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
 
 	spin_lock_irqsave(&adapter->maps_lock, flags);
 	summary_info = get_map_info(adapter, adapter_int->summary_addr);
@@ -2992,22 +2993,21 @@ static int adapter_indicators_set(struct kvm *kvm,
 		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
 		if (WARN_ON_ONCE(!summary_page))
 			return -1;
-		idx = srcu_read_lock(&kvm->srcu);
 		map = page_address(summary_page);
 		bit = get_ind_bit(adapter_int->summary_addr,
 				  adapter_int->summary_offset, adapter->swap);
 		summary_set = test_and_set_bit(bit, map);
-		mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
-		set_page_dirty_lock(summary_page);
-		srcu_read_unlock(&kvm->srcu, idx);
+		set_page_dirty(summary_page);
 		unpin_user_page(summary_page);
 	} else {
 		map = page_address(summary_info->page);
 		bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
 				  adapter->swap);
 		summary_set = test_and_set_bit(bit, map);
+		set_page_dirty(summary_info->page);
 		spin_unlock_irqrestore(&adapter->maps_lock, flags);
 	}
+	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
 
 	return summary_set ? 0 : 1;
 }
@@ -3017,26 +3017,30 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
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
+		mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
+		set_page_dirty(ind_info->page);
 		set_bit(bit, map);
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
@@ -3046,7 +3050,9 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
 		summary_set = test_and_set_bit(bit, map);
 	else
 		summary_set = test_and_clear_bit(bit, map);
-	spin_unlock(&adapter->maps_lock);
+	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
+	set_page_dirty(summary_info->page);
+
 	return summary_set ? 0 : 1;
 }
 
-- 
2.55.0


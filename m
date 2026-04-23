Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E43D8916;
	Thu, 23 Apr 2026 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776988414; cv=none; b=EEvtiVotEjnG5113w9CYNBlv0YyD/u/hOR4Uyl/liUt5MAX4bepT8/4ftSlDfF0QakHEpIr/k8lBDZdHTw6lryzXqH1qpaKixkgPz885pbqKJY7zmQdguFWmtDWA4n04LtOxv8tZJiLXznPM/8eRCvmA7kmgOH3E2735v1PCrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776988414; c=relaxed/simple;
	bh=8S4JePW7asyI+JIQ4VQ2bZPNNeRV1scapHALSYOM+FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSgWigcXnesGQW+NtSeO1QdcycOrJQUKsH7evVVooChl/GPYT9vXxA8JlKVBb33aYBPoqJtLWVOTL6bmXaql9mwla7jkQba98L41A28BoeKwpmEWAYErFkvtQhVoSQQWoT3KhkxcJ3Km3m+duObXRDs8TeyFsTBir+3q8sLCeAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WPNgGLGJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WPNgGLGJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NKGbKL3515186;
	Thu, 23 Apr 2026 23:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YsTGqYZaqQffIs6YQ
	Iardms4Vk/q4RHSdTccoC7KfeI=; b=WPNgGLGJ3yPbKKcZTm9ilCglmYqEnmaHa
	VIgWKD3kv9HYcwSk/nMiKQf6ig2vIvOzXIgXdKIquOhbqqnasBi8CnKDCBaIhXEW
	BQvH9WRzQl3VV09ZrgaJbKeTTVnrecZSjOhNZud6xDKeKOJYZWIIvlTwqo1DiB1P
	0MqQTmBCUKMMYNmY0ap+4CnYCgbYlnc52iBJHHqe7hJKD0tRMZBKBtIppFewd/Cs
	1eYSNzAz1sjvDJjEEtlz8RHJcjV6TXG6dMq7lrRuNRtv9mVT/CPCAcUW1ilXby8Q
	yy2ffAIrh4FFS21Hyesrleym6KLU+xj3aqCThL+8KtYgGoi7f8jxQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2badx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 23:53:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NNoTM9009740;
	Thu, 23 Apr 2026 23:53:28 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky8q8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 23:53:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NNrRsk30343828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 23:53:27 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C70FB58056;
	Thu, 23 Apr 2026 23:53:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19A9458052;
	Thu, 23 Apr 2026 23:53:27 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 23:53:27 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v4 2/3] KVM: s390: Enable adapter_indicators_set to use mapped pages
Date: Fri, 24 Apr 2026 01:53:15 +0200
Message-ID: <20260423235316.3665-3-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423235316.3665-1-freimuth@linux.ibm.com>
References: <20260423235316.3665-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDIzMiBTYWx0ZWRfXz5lTAuzJZvzZ
 JVB89riWq6diaYYLX3/+SyBzDp+GvqWJUo8zzL/9C3QFPZcHDOplj3Unnp6kZrK4kb6qALxt7Gq
 pfICd0ccYo3s1gSC+waz1n3Dd8euBCqQAyKvDUAZUSD32VB+qDec1H/gPUnVDrLYMzHtZbW+9GX
 +mQD9x7qMTMD/PFAzB8aaa2bC5nO08up0wYEhR1FwhBmaEbkoXmeT87ER6WxySYc5g8+uZ1kl3N
 tyg8e58dnXiJfvXf1+f+xMCdVAEtw0ITCz+grrFmvtqLafUFZCtdMxUz8+WsA2r8egVt1J+EKkg
 ll1+0jYF2DdtwQT9gjJvIrQXIwAnmbU6cShtHpj9E2aNipgPcQudWdo68BQJJPZOrXp/L4fkbUu
 AHz3NHI2OkXm3+xLT7wN7c5uk5Zvavwc3+BJUAsvt7hqS56SiV7qU68bKrwM8mxfgJETlun0uAF
 sCre4U2zPhKfz+ihWGQ==
X-Proofpoint-ORIG-GUID: MSrQk4kIPYBOvIG0RaN-Z-cknRnJzD2W
X-Proofpoint-GUID: MSrQk4kIPYBOvIG0RaN-Z-cknRnJzD2W
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69eab0f9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HREIBFoc_rC1q7OR-gsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230232

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
index 49c95c1eb9b1..c75fb3f19bb0 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2857,41 +2857,85 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
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
 
-	ind_page = get_map_page(kvm, adapter_int->ind_addr);
-	if (!ind_page)
-		return -1;
-	summary_page = get_map_page(kvm, adapter_int->summary_addr);
-	if (!summary_page) {
-		put_page(ind_page);
-		return -1;
+	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
+	ind_info = get_map_info(adapter, adapter_int->ind_addr);
+	if (!ind_info) {
+		raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
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
+		raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
+	}
+	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
+	summary_info = get_map_info(adapter, adapter_int->summary_addr);
+	if (!summary_info) {
+		raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
+		summary_page = get_map_page(kvm, adapter_int->summary_addr);
+		if (!summary_page) {
+			if (!ind_info) {
+				WARN_ON_ONCE(!ind_page);
+				put_page(ind_page);
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


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997BE30F547;
	Wed, 20 May 2026 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293093; cv=none; b=rrrMArMzEHpRRyZMY/WGCWnTu33Y+Hv1dPg7SAUXm3oJTtC1ZvCyso41F7XOcl3SjNHKdEt1nwzOlV8dRyJ8dJb6TuPUHzNoRShnaiQL7BXhw6+seM1E0aic9Mq6pRjYCexvWQ/u2fofjxxxgQ8u+jWPmrkHg3cnwU2ZHeujcwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293093; c=relaxed/simple;
	bh=ct8nvLX9/pI4KBisTrE/IeTUtTpbRktwrIlmhxhktXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9DbCOyM5MYAjiFRqg9L5XNXWlgpfiJ8Xe5N03INzo1srrHv1vw6jlYNMyg8PliFX/cA+gfH9nRGcAw8ZqyXntQtoJoGdbXo90EWTumuzLBEmZlMRvfyc2CWd4mqxv71dOPQzW2/LyzcLNl591RVQmtWjOqdQA8Wrub5oo6iB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LvEWMIN1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LvEWMIN1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KA6I2Z2070048;
	Wed, 20 May 2026 16:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6WIrPnYgVzHP4YbXv
	oPSclgFnqehtIT26Fq980VzC+M=; b=LvEWMIN1eCkgHNuyQOSbGTtB7WmoYn9dI
	Tz9o3qRKwj/EpOA3Wnt/ay7ASKpXBvxbiRINFE9A66gtSmiQfJDaUBFDxbagWzKo
	ZD9HkckoBF9J5oY4qALZwDaZrzkkSySrSsF/rUZxHLowUMA9vDSinWV4jWkpppzu
	n1p3z32dZm8XObpdF17bS9TCh7eSmIibSyU9v43QZQ0RLhWfnIWFglbeGRu4q4/G
	cYGPkzihQgO+6fmnaxLOyXlZAEMM846WIC/31HbhR/WRhuOu0ypfQ2GD2oFX7l8p
	b//bzMFCug4iV52RUaiKOCcn7sGFRBcVNrPUTqxhNrJCTLvcrZY2Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88hwg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 16:04:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFsAYJ027501;
	Wed, 20 May 2026 16:04:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhr09k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 16:04:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KG4jdL25559606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 16:04:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94C445805A;
	Wed, 20 May 2026 16:04:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F01175803F;
	Wed, 20 May 2026 16:04:44 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 16:04:44 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v7 2/3] KVM: s390: Enable adapter_indicators_set to use mapped pages
Date: Wed, 20 May 2026 18:04:41 +0200
Message-ID: <20260520160442.1051999-3-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520160442.1051999-1-freimuth@linux.ibm.com>
References: <20260520160442.1051999-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DoriHDaAsalYIgoPHSGJOSFezS-M3lzk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1MSBTYWx0ZWRfXzCscYuCnN59N
 nDy0ro01XpB/7Rx/V0HdSSOhbzjLoZMdT8Nzf+EU7v8zwub+DS0JwGAALXh0V+q78YGfqeXkK3j
 1roLcFYCiPA3BO/+Xqj8plSQx6ggZreKubCbfQkH4s5km+yIDFKsR+K1OyNbytu4N6LTCm9nWsR
 y7rBp7tguSw6VkMlO9DQxuvLi6JLJLS5DwcKI76ZWaT2Uj5GhP/Lkuay5UguYbhjruDmGZ/Zmn9
 OVg7u2UeceiI10wO1wRWWKhwWAvJA3UwY90KwN3wpuTvB2E1kW9/DrXQNdB2cfbjy/OBptXE3go
 sOPo0CxDtF6wOc/5YeY2TfWu7TvjS7JE71ckTmCgQ9XlpWHjH8pj0JBxDjoBT7ZJSSieLjmhiOe
 BCTtZvADS8PmuKFQ1m2ak0XH6rHjjq3cdqLklf9n5qIlr6j/yZUGnPdQOmIWPbZwzQFnoOP6+Rd
 2IDtdv4n+U8B1c+U56g==
X-Proofpoint-GUID: DoriHDaAsalYIgoPHSGJOSFezS-M3lzk
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0ddb9f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=qkd0NaIHCA_5-goIJGMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200151

The s390 adapter_indicators_set function can now be optimized to use
long-term mapped pages when available so that work can be
processed, on a fast path when interrupts are disabled.
If adapter indicator pages are not mapped then local mapping is
done on a slow path as it is prior to this patch. For example, Secure
Execution environments will take the local mapping path as it does prior to
this patch.

Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 89 ++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 24 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 654c37e5e898..c41461b6f365 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2885,41 +2885,82 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
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
+		if (!summary_page) {
+			WARN_ON_ONCE(ind_page || ind_info);
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


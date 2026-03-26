Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24485394495;
	Thu, 26 Mar 2026 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774489379; cv=none; b=UXpKwQ6f9IiMUBNyHbltRgflX9yCc9UEJIv+QfkjM4eOkQ3qR1BaEv9crqQvQ9+b2LjKLr6DkSm09AqdGN5bK/4/QK7rt/lRIJg3+el14UBoIfldHd7fVD80KMtYMT0evXquPRtX92eBv248weNJQMswhWBwzpLa39enS5J/htg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774489379; c=relaxed/simple;
	bh=afPRp4x94XGwxgInUP+X/RUVx6ROFKYJCRbIFW9cHv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dd5inu4nb/1ngH4IWYg5seKyO9uYhwAw7aa3B8Y7RQDpfo7BZhXi7WvdpliL08Sm1D6gjdDL2DVL9LKS0L+vXR7aM1G80xrkKyuAZEUjozbGwcm9j+499jGkLAi7G2HDQ2INfEpeEMhCCjZhPLIYZj7pst3JdteQ/WxGPnbeae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R7DTKg2I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R7DTKg2I"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PMOCN5030995;
	Thu, 26 Mar 2026 01:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PG8Kd96BdHsp4PrBw
	aNn6nCUNz/Ux1DzIl3Ayz6ZFjY=; b=R7DTKg2IpoJXzmivGig+RXkKdC5PFErGF
	rsefTbHRk2PKaL1yVwp2j7/a4yntVo++1O3g1n2wUgNs1aOrUIqZCKHV5oAaWF+e
	b70ewTye8zp/WAwGadd8Ju2bAkYpbM9kj3M1D8oaYb5vbRkwCpufyTMSdqyeB+uJ
	C2q4alwu6IaE8VZWiq6zL40lZPvSwMrSdGlBXrgiE0Q31caiZTjglHZc+VW/odpO
	vrGQYnZAbcLSH4eXDqCAYhZxjAWxtvF1nhGzxVV9Q8MvU5zzbdJYvW+VXZ6dA77h
	MW7xcFPD+nB2sFaaxhQWnwqPataXEPR6oR62TFMRSxa6MF2u+l3BA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty34ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 01:42:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q1cE7G026900;
	Thu, 26 Mar 2026 01:42:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m0xgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 01:42:54 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62Q1gqiV32572072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 01:42:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE84E5805B;
	Thu, 26 Mar 2026 01:42:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A31458059;
	Thu, 26 Mar 2026 01:42:51 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 01:42:51 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v2 2/3] KVM: s390: Enable adapter_indicators_set to use mapped pages
Date: Thu, 26 Mar 2026 02:42:46 +0100
Message-ID: <20260326014247.2085-3-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326014247.2085-1-freimuth@linux.ibm.com>
References: <20260326014247.2085-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c48f1f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=3iJqRUJyZzJvN4CYUNoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDAwOCBTYWx0ZWRfX5t4P4Q8u92qs
 Ep28azTZJYfEO1VlHd5l/I39FaZBcb/QZYk8aySWA7Q2dITqxReXOSnLvgp6lZ1DVaf7/4/bpHb
 9mwtq3eFzimxxiXzO1B9a1yxfTKiTrjeW6pSp44SfKXOIXNJZgUPChtr95MBp1VukOY5Vhohpgs
 i61EC7ezhoBRGRC4VkLzXRzmGBhmvfLusdhSkdTAfdr92yHUcZgC+qw8AlWdSAunivgyOj4z1gD
 SigZ4jpIt1Z5x5Pb8Un9aVa/qy9QIyqbQSI6NdbkZb4sww23UOQftFx24gat/4EOWF+xv+qyacM
 VmTndl2c5WBZMJdFa/sMwgmyq4NG9XR9irv6lUYG0kdWkUUjBSq6F+MVLWMd+VVrHw8UN27jkf6
 ye430H0Y3V51CIk5D3cjudT9jlJ8QFO1VmaiS3x4fyw5f+dlXctAr8xlNk2dtMxV+YVGpU0+V1t
 UwvOmdzzaYLoztGbeIA==
X-Proofpoint-GUID: _bxw2XOB4QAa7ZOZfMiAvrfX473at8TC
X-Proofpoint-ORIG-GUID: _bxw2XOB4QAa7ZOZfMiAvrfX473at8TC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_07,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260008

The S390 adapter_indicators_set function needs to be able to use mapped 
pages so that worked can be processed,on a fast path when interrupts are
disabled. If adapter indicator pages are not mapped then local mapping is 
done on a slow path as it is prior to this patch. For example, Secure
Execution environments will take the local mapping path as it does prior to
this patch.

Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 87 ++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 25 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index fce170693ff3..48d05a230416 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2841,41 +2841,75 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
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
 
-	ind_page = get_map_page(kvm, adapter_int->ind_addr);
-	if (!ind_page)
-		return -1;
-	summary_page = get_map_page(kvm, adapter_int->summary_addr);
-	if (!summary_page) {
-		put_page(ind_page);
-		return -1;
+	ind_info = get_map_info(adapter, adapter_int->ind_addr);
+	if (!ind_info) {
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
+	}
+	summary_info = get_map_info(adapter, adapter_int->summary_addr);
+	if (!summary_info) {
+		summary_page = get_map_page(kvm, adapter_int->summary_addr);
+		if (!summary_page) {
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
 
@@ -2890,6 +2924,7 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
 {
 	int ret;
 	struct s390_io_adapter *adapter;
+	unsigned long flags;
 
 	/* We're only interested in the 0->1 transition. */
 	if (!level)
@@ -2897,7 +2932,9 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
 	adapter = get_io_adapter(kvm, e->adapter.adapter_id);
 	if (!adapter)
 		return -1;
+	spin_lock_irqsave(&adapter->maps_lock, flags);
 	ret = adapter_indicators_set(kvm, adapter, &e->adapter);
+	spin_unlock_irqrestore(&adapter->maps_lock, flags);
 	if ((ret > 0) && !adapter->masked) {
 		ret = kvm_s390_inject_airq(kvm, adapter);
 		if (ret == 0)
-- 
2.52.0


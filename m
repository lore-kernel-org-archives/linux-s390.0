Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352B3377025;
	Wed, 18 Mar 2026 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821187; cv=none; b=m4fTWnPhroOUyj4IHeqPO1p7wJcewiaPy/syu5jxESWoFHCq/9hioob9sdWPxeSFYSTPfRyionxMcwdNTbw2RlzevNsN1FL5QBVMJm/jPViwqx7VmbiQCit7fUJcozONqiI2tIVVu3r4/ipa6eKO+ccuUuVCs2q6/X00/pd4wfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821187; c=relaxed/simple;
	bh=09oEAEWRKH5QIQvgC6ThODPE8DgBuXuM023RUs/1RQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4xNDTMqNBLp9yLbbf4PmBSbOanC+lttCM9c1SbuGwKsHqW/Ss2GpBYgsmG7QFJe1ljH2egNxwp12sSSrvGIndt1KZWooZRy2PejM41Y73c6OvJKHNs3on/2VZETPAJmejr7X6ZtH6x94s5tS1xpwtmhI9l7jt38wJKPvWMFspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HOymWsG7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HOymWsG7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HIfx1A656394;
	Wed, 18 Mar 2026 08:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7qQH2koDbHjK+rZR6
	lMnOPhUTNE46Tt5MN2Yscz2xmo=; b=HOymWsG7iEjn9QsCocXCHM690ORAH8MHB
	BQ2meqCpfYzoqemmOBuWhYMRkqqkZUb2TUqMpfgC/EninxTUSr9PRYM0ZXeScDAb
	qJ0d4y0Ko4j9fpPI0GoP+mtReYcnyy7oIE2zFVcH0go76wGFjTWcEC7OGSYtny88
	f8fSDqMOiZZHpSUBn4mpoO5QosViulssZoAFgkyqZQ0+TJhxfZYREjTzExo4ekzC
	ijMvN33F+vODNZJU206EH5bBIvfVVK6XoDefufQsIXrfBDGgdeJ2zi7fj6R+mYtC
	9dRI4f2+JBmnI+0/8CqOeqTOlbjoh1J2HBkZ4k0aHfS/yxxnTy4UQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64rxxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:06:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I4WGVl015648;
	Wed, 18 Mar 2026 08:06:19 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nd1f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:06:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I86HVc31523440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 08:06:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2601B58058;
	Wed, 18 Mar 2026 08:06:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A69958063;
	Wed, 18 Mar 2026 08:06:15 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ibm.com.com (unknown [9.111.93.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 08:06:14 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [GIT PULL 3/6] KVM: s390: Limit adapter indicator access to mapped page
Date: Wed, 18 Mar 2026 09:06:03 +0100
Message-ID: <20260318080606.2450514-4-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318080606.2450514-1-borntraeger@de.ibm.com>
References: <20260318080606.2450514-1-borntraeger@de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qCwAp0ey2SLUdb1U_EpjJQnjyzf7tKv4
X-Proofpoint-GUID: qCwAp0ey2SLUdb1U_EpjJQnjyzf7tKv4
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69ba5cfc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=9wiM4PGeI6ry-y9bcyQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2NCBTYWx0ZWRfX0N9Ym1dleGo0
 N6HgbAW9BSEC9rmU+rafdFMEcttYO+ucI9MC0cMSGlIy4upo4jaIwR4VHx/4kfbry6YYeryQ3cl
 TNH1UGLfQPxyLD1sQO8jB339iC8G+3UOHgyD2xEoeBm0a4r0HLrmsDCuqZyeq0Hxk0muw7ccV4G
 ysKk83KTH/D0WnK/1rBt+CSMC64BoV4MCfCHz9AVRxrMu+lfCNiMSVvu+JXRUgP+jfh+GSCFckl
 bg35HKYkpGRquApmq/VDoVYa2NRhGEuGV+wBUeSVORqB/SkNMzPGTB9E31x1XHOyTVLBDtyCD4F
 tgFY6/CpPONvGtt8/lIeHV2gRclI3i9abYBkM8MV2Dz0SjV+Nnxidzl9jIeAtMtNXJLNKS/mBFv
 +9Yp/szN6mbEMFFHQa3IOkWm+jPixgxWzEnlqe11eJBuFUtnuyYtSRbwTHRDP1VxcePBcKAay0B
 8IoXRhJzB0xcLEV04iA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180064

From: Janosch Frank <frankja@linux.ibm.com>

While we check the address for errors, we don't seem to check the bit
offsets and since they are 32 and 64 bits a lot of memory can be
reached indirectly via those offsets.

Fixes: 84223598778b ("KVM: s390: irq routing for adapter interrupts.")
Suggested-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 18932a65ca683..1a702e8ef574c 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2724,6 +2724,9 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
 
 	bit = bit_nr + (addr % PAGE_SIZE) * 8;
 
+	/* kvm_set_routing_entry() should never allow this to happen */
+	WARN_ON_ONCE(bit > (PAGE_SIZE * BITS_PER_BYTE - 1));
+
 	return swap ? (bit ^ (BITS_PER_LONG - 1)) : bit;
 }
 
@@ -2852,6 +2855,7 @@ int kvm_set_routing_entry(struct kvm *kvm,
 			  struct kvm_kernel_irq_routing_entry *e,
 			  const struct kvm_irq_routing_entry *ue)
 {
+	const struct kvm_irq_routing_s390_adapter *adapter;
 	u64 uaddr_s, uaddr_i;
 	int idx;
 
@@ -2862,6 +2866,14 @@ int kvm_set_routing_entry(struct kvm *kvm,
 			return -EINVAL;
 		e->set = set_adapter_int;
 
+		adapter = &ue->u.adapter;
+		if (adapter->summary_addr + (adapter->summary_offset / 8) >=
+		    (adapter->summary_addr & PAGE_MASK) + PAGE_SIZE)
+			return -EINVAL;
+		if (adapter->ind_addr + (adapter->ind_offset / 8) >=
+		    (adapter->ind_addr & PAGE_MASK) + PAGE_SIZE)
+			return -EINVAL;
+
 		idx = srcu_read_lock(&kvm->srcu);
 		uaddr_s = gpa_to_hva(kvm, ue->u.adapter.summary_addr);
 		uaddr_i = gpa_to_hva(kvm, ue->u.adapter.ind_addr);
-- 
2.53.0


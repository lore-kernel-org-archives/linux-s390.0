Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A0E3BD241;
	Mon, 13 Apr 2026 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077278; cv=none; b=gdyEPUGt7HNlKLkZ8YgOiLpDN5NfBmG5Da5fAnphqtmM5oxxnoBvo+tM/Vn/Xmo1CZi8kmRIqJjCPO99tUA1Lbi6xU4ONyCnVEZQ/mZGoS2cGd4DbMdR+r1zBWCs28FeGKYeq7frBmKwZvu02WyPZ551zGFFuTo2fbpK7qamBQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077278; c=relaxed/simple;
	bh=rdbPB6gIUMSxkfMpRkNjCDOOHCV6WJbXYdqBvcUboyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQUe84uZba60lpPiEBmoE8ldoDxp0YuoIEozBI3vGNs5hEb3fleXTw0ke0x+yZ8V2IsnqACNhJYLU+hz7uf9UEwHlTiyGUfqm1SIAbo02EWUara2a1287OwBIQ4UorXIVinPz/bGV3YR5VY/mRE1ki+gr/V/ebdB2nybe+ooExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=meoJAEjv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="meoJAEjv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CLSYZF3431327;
	Mon, 13 Apr 2026 10:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=L1osTNW0JfDT7xEoN
	Yb4gOYAgB04wxda5HR8IYB43SU=; b=meoJAEjvShRUg+7bOHYnbOTOXP74ReDlG
	k9O313YcnE2JkQqQ0thqlI7nK8qIvzJMithkFul7kA0K+AOALqlQ85A9zOcEjWki
	gDBCXY2/nDMy4NdFgJXIXKFarq3k3Sq6Z6nujyxgPfRKH9Jedud96e9kMp1xLBT9
	2X04C7WBg0SCpCL2EcutzUooIfvUjVIY80Liq1Ks1HUv/tMB2TTdW6lM9cJR0K0v
	t/z62F6Tfv/iAtqNkiFTY64Q8vsCrQfr67PtnASSY0BYqRgb5JoLOfGEXWWsHn62
	7LKz4ACMc+kuPfAJq9p78uAzxy4JdG+MLchl1/HrtatyqowOEqCHQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdt3q90r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D85fgP031240;
	Mon, 13 Apr 2026 10:47:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10y4wgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DAlmQn25494172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 10:47:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1D022004B;
	Mon, 13 Apr 2026 10:47:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D39620040;
	Mon, 13 Apr 2026 10:47:47 +0000 (GMT)
Received: from li-9fd7f64c-3205-11b2-a85c-df942b00d78d.ibm.com.com (unknown [9.111.7.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 10:47:47 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        Eric Farman <farman@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [GIT PULL 05/12] KVM: s390: vsie: Accommodate ESA prefix pages
Date: Mon, 13 Apr 2026 12:46:33 +0200
Message-ID: <20260413104721.203024-6-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104721.203024-1-frankja@linux.ibm.com>
References: <20260413104721.203024-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DceM1CGFUk_Xd9HzOVOgwiRDFDmhRvvI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwNiBTYWx0ZWRfX6Tt666nOw0DI
 6IsODP87t/tBVeuaQAMNyuqFpTAZwkKODdKBqRvLB7L+RK9aM4TlnssIH+DOVyl0BEtjAmPlVQP
 9HAaz0pJz3WsuPAe28enfyPXHMmhOBHmcNlOVrHBVEHcW7vN5ocB3BBskea+2r9qOi+ZIVCk6H9
 Lln5FRvLEptd1HAmWCntJWyc/eig0U2HKsPq5QAMplKuGAp5u0dpVxoiQnH0XY2gYH79JYGvmZ8
 dCRAd4Rv4qFx2dcCgv/7T1CuuxpfJuUaPz9gFjMQNY+3XjhTzzLsXDBX3NYDyN+mYzv9JDD1ed/
 STsVV/qetupOzuvq+VG+HK4wAVQCdbxsWtQbXX8KcOVhO16hvgvncFYDVyVIIIMb5r5yDEJs/z9
 MrmAEge9PB1aLQ1d5mrq0lzjo2dojiPPSMNRH8uTJt9r3k6LM+jT1J0XkzrvM6siu3q+AxR6Lxx
 W8o0a0FFK7ojPtMkEiA==
X-Proofpoint-GUID: DceM1CGFUk_Xd9HzOVOgwiRDFDmhRvvI
X-Authority-Analysis: v=2.4 cv=WpEb99fv c=1 sm=1 tr=0 ts=69dcc9d9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=KWLFWdVBFI_PnIVkQWQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130106

From: Eric Farman <farman@linux.ibm.com>

The prefix page address occupies a different number
of bits for z/Architecture versus ESA mode. Adjust the
definition to cover both, and permit an ESA mode
address within the nested codepath.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_types.h | 3 +--
 arch/s390/kvm/kvm-s390.h               | 5 ++++-
 arch/s390/kvm/vsie.c                   | 7 ++++++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/asm/kvm_host_types.h
index 1394d3fb648f..3f50942bdfe6 100644
--- a/arch/s390/include/asm/kvm_host_types.h
+++ b/arch/s390/include/asm/kvm_host_types.h
@@ -137,8 +137,7 @@ struct mcck_volatile_info {
 struct kvm_s390_sie_block {
 	atomic_t cpuflags;		/* 0x0000 */
 	__u32 : 1;			/* 0x0004 */
-	__u32 prefix : 18;
-	__u32 : 1;
+	__u32 prefix : 19;
 	__u32 ibc : 12;
 	__u8	reserved08[4];		/* 0x0008 */
 #define PROG_IN_SIE (1<<0)
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index bf1d7798c1af..dc0573b7aa4b 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -122,7 +122,9 @@ static inline int kvm_is_ucontrol(struct kvm *kvm)
 #endif
 }
 
-#define GUEST_PREFIX_SHIFT 13
+#define GUEST_PREFIX_SHIFT 12
+#define GUEST_PREFIX_MASK_ZARCH 0x7fffe
+#define GUEST_PREFIX_MASK_ESA   0x7ffff
 static inline u32 kvm_s390_get_prefix(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.sie_block->prefix << GUEST_PREFIX_SHIFT;
@@ -133,6 +135,7 @@ static inline void kvm_s390_set_prefix(struct kvm_vcpu *vcpu, u32 prefix)
 	VCPU_EVENT(vcpu, 3, "set prefix of cpu %03u to 0x%x", vcpu->vcpu_id,
 		   prefix);
 	vcpu->arch.sie_block->prefix = prefix >> GUEST_PREFIX_SHIFT;
+	vcpu->arch.sie_block->prefix &= GUEST_PREFIX_MASK_ZARCH;
 	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	kvm_make_request(KVM_REQ_REFRESH_GUEST_PREFIX, vcpu);
 }
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 2ce406861d22..3f43fe05afd3 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -479,7 +479,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	/* READ_ONCE does not work on bitfields - use a temporary variable */
 	const uint32_t __new_prefix = scb_o->prefix;
-	const uint32_t new_prefix = READ_ONCE(__new_prefix);
+	uint32_t new_prefix = READ_ONCE(__new_prefix);
 	const bool wants_tx = READ_ONCE(scb_o->ecb) & ECB_TE;
 	bool had_tx = scb_s->ecb & ECB_TE;
 	unsigned long new_mso = 0;
@@ -527,6 +527,11 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	scb_s->icpua = scb_o->icpua;
 
+	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_ZARCH))
+		new_prefix &= GUEST_PREFIX_MASK_ESA;
+	else
+		new_prefix &= GUEST_PREFIX_MASK_ZARCH;
+
 	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_SM))
 		new_mso = READ_ONCE(scb_o->mso) & 0xfffffffffff00000UL;
 	/* if the hva of the prefix changes, we have to remap the prefix */
-- 
2.53.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E05486E78;
	Thu, 27 Aug 2026 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846004; cv=none; b=Iiz6ptvrCXJ7syp1/Af2CRh6RQs25vOYDxKhTXAqPS4spDT9JDX7EWukEFm91CBEmo3y26kMQaYiA3bRY541RSGXLEZ/EiKlhbTx5nKvPtjev+PCTQ0mvSmeb4CATNqnZVDsZJM3dZlWhRX8zOoBmyVDCkX8unZfO7yEUUnjRRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846004; c=relaxed/simple;
	bh=y+BMtNsUF3HbpXypD10aRXelMH/+47CDcIux6TBbroA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rRi++8g2Myq2czZ4QEPItolmE+Iy/oYx3AqR3Cmc9X4iEnoWn5F89EX6ezlwzMwzebLYY7qQOo3x4DI203k/roU8H6scI8LGkqJaoOyPl6bajnT+CI+JLDpllcL24eGHO0yt4dQeGT73dH5Y8oY0r3kCypYnKmDJ8GFQV+9YNjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jh09Jj2s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jh09Jj2s"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF5DcZ2224800;
	Thu, 27 Aug 2026 15:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hMpB2I
	7VjBkoTqC4U0nouZPyCpVUR8IMoiI1Iz8SsS4=; b=Jh09Jj2sOb7yaL+horDqdQ
	AOWeJhMDT5M8AfJuGJRrg3Lo/vYg2AUmWsL+j8g6+zdM74kyhTEmxTYGTc5Tz/jd
	k/0b+u9Nsmb7qQuK2OYYBKzUouCqk2v5k2oMGq/1T7v+Yw9seD4EEB9K5urw/fNH
	AtZ0BXToJFHeOUCb+0KrkcVm37PDZhDkElN31bP54QM46lf4Uy9JU6L/Oe4aXIYq
	hagj6+ZAxkPhihPFjcE1Cl8PHgYmodibBkbVz+izMmC/b9gwzg4bD8uX9LWS7tD6
	npG3Q0EIewHhHqfE38r1N+UFQivsaoG7ovgbZF0R+nFQFMDr1gZZ2lfDS4wBryrA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ex8tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFfjmb015149;
	Thu, 27 Aug 2026 15:53:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwh00p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFr8dW33816876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:53:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 666AA2004F;
	Thu, 27 Aug 2026 15:53:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5ED62004B;
	Thu, 27 Aug 2026 15:53:07 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:53:07 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:58 +0200
Subject: [PATCH v6 18/21] KVM: s390: vsie: Add VSIE max shadow
 configuration
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-18-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3001;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=y+BMtNsUF3HbpXypD10aRXelMH/+47CDcIux6TBbroA=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYkPU+j0WP9hROS38nsUHy4DIYIOPv//wRb26sfvRr
 5Ouy3rbO0pZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZhIpyfDf6dD2kc3SIoe/X2q
 5KsAh/PLrt8fN+le7Uh/WiY6ZZk5AyfDb5aXFgVTSyqmaS5501HxwU9lUcHEGU7mRlMVim3DrP6
 X8QMA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a905d6c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=NT-WFI3kCPxDzj7wveAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX+ZwtsjNtaGZK
 nXgPftCmMiz6rYl0uh5iQWrGE8OqVRDlrnVbCw5DGUMSfTjVxDazD1N8clXwM2clWZ9XB/kU3t6
 /yla5S2DFkWmxUm5QcrAvP7/Or3s4Wo=
X-Proofpoint-GUID: EJCXwns4Uzk9btmTcGjY4eIoEx5Y94ha
X-Proofpoint-ORIG-GUID: RDZZ__VFMwD01qSMwStYF5XdMunSy_OL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX6CUX7ksy99zl
 J96a9fCC/KeGORUnC14f+nVYDGNLjlgHONyhtGPIKcBnsUilbA+0IXz5eMoJK8SkiE1K6zGJBhU
 wHpSOhzqF0u/CRTKB1d80Y9xNbSufklZ6pH/Su8Cspq82PcEJGOShFmNLBci0eOqIk4drng30ih
 XBhLG7BWp7EiTEKGujSsnrVMimcGnTcSkzz83/fRWpmKu6RwiuGjp1KAoQnBs/SG1yyoJXskkUF
 PgBqCyr19zQS41BZnUaZJaLoBSrycs2ecrAm/pRpwKA+gIeivdEisAPZ7ZUke5pETyHoiYLhJwe
 HUd9V6+4D0D7/ayrddopMbcq3Y8SMbuz6lZlyh6rlrobLimk/JENVy8DLfi+yIS+mMCaA2v2Zfx
 Ao/huI7iRHiyhWJtg2zYQC1WSvjTIVfszg5Zsu2J4X2c6QAW+rJFiaE3VM2hy9qTetqmeA2i50a
 aW6nHcoNU0MiWOiNc2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

Introduce two new module parameters allowing to keep more shadow
structures

* vsie_shadow_scb_max
  Override the maximum number of VSIE control blocks / vsie_pages to
  shadow in guest-1 that are not using the SSCA. KVM will either use
  this value or the number of current VCPUs. Either way the number will
  be capped to 256. This is the number of guest-3 control blocks / CPUs
  to keep shadowed to minimize the repeated shadowing effort.

* vsie_shadow_sca_max
  Override the maximum number of VSIE system control areas / SSCAs to
  shadow in guest-1. KVM will use a minimum of the current number of
  vCPUs and a maximum of 256 or this value if it is lower.
  This is the number of guest-3 system control areas / VMs to keep
  shadowed to minimize repeated shadowing effort.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index bfd5df1f8b9c..3a839154fdfe 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -107,6 +107,16 @@ struct vsie_sca {
  */
 static_assert(!(offsetof(struct vsie_sca, ssca)));
 
+/* maximum vsie shadow scb */
+static unsigned int vsie_shadow_scb_max = 1;
+module_param(vsie_shadow_scb_max, uint, 0644);
+MODULE_PARM_DESC(vsie_shadow_scb_max, "Maximum number of VSIE shadow control blocks to keep. Values smaller number VCPUs uses number of VCPUs; maximum 256");
+
+/* maximum vsie shadow sca */
+static unsigned int vsie_shadow_sca_max = 1;
+module_param(vsie_shadow_sca_max, uint, 0644);
+MODULE_PARM_DESC(vsie_shadow_sca_max, "Maximum number of VSIE shadow system control areas to keep. Values smaller number of VCPUs uses number of VCPUs; maximum 256");
+
 static inline hpa_t sca_o_hpa(struct vsie_sca *vsie_sca)
 {
 	return vsie_sca->sca_o_pages[0].hpa | (vsie_sca->sca_gpa & ~PAGE_MASK);
@@ -1086,7 +1096,8 @@ static int get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_block *scb_o,
 	 * We want at least #online_vcpus shadows, so every VCPU can execute the
 	 * VSIE in parallel. (Worst case all single core VMs.)
 	 */
-	max_vsie_sca = MIN(atomic_read(&kvm->online_vcpus), KVM_S390_MAX_VSIE_VCPUS);
+	max_vsie_sca = min_t(unsigned int, max_t(unsigned int, atomic_read(&kvm->online_vcpus),
+			     vsie_shadow_sca_max), KVM_S390_MAX_VSIE_VCPUS);
 
 	if (kvm->arch.vsie.sca_count < max_vsie_sca) {
 		vsie_sca_new = alloc_vsie_sca();
@@ -1969,7 +1980,8 @@ static int get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr,
 		put_vsie_page(vsie_page);
 	}
 
-	max_vsie_page = atomic_read(&kvm->online_vcpus);
+	max_vsie_page = min_t(unsigned int, max_t(unsigned int, atomic_read(&kvm->online_vcpus),
+			      vsie_shadow_scb_max), KVM_S390_MAX_VSIE_VCPUS);
 
 	/* allocate new vsie_page - we will likely need it */
 	if (kvm->arch.vsie.page_count < max_vsie_page) {

-- 
2.55.0


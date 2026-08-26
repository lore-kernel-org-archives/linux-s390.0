Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266284503E3;
	Wed, 26 Aug 2026 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756734; cv=none; b=ahlZHClDqOKQTUk7ZEv/ica+sVw37IlCWt2La3sVzE7Vsy77BzAkT4aHYF5VYCk3SmaMimfJycr0+KKC8D+IyRZ0VAuP9RAg1jXYzFMdfz5rYddLOtjImNeAUfaJQn/pNqQnbUbmrTyw6Bk5ymGjMBo1y4sA4OEFj1tYb1e7ogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756734; c=relaxed/simple;
	bh=p7pQvUoIW+eQoaGvy1CGDR/mpyTkFo/sNyIL1U9zg40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbaBbfI7nZMRmCPvmGhcRVQLT3wT6WH8hagYC760LJ/kPdePEgblYNZQuPPGps/ZCcL+p1PpRqNs12d7nioxE2e/BNzRxd3ue/OipEfjn4Phm8YiTmHBbC38icjeH4aqtLYEObqg57DsKGllVWPKJnV/Q2yHQloVyJlNre+3B2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jn6ygvcB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jn6ygvcB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1VZh4184812;
	Wed, 26 Aug 2026 15:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Xa6Dq7
	BhFODXcitqn82ib/JMuY5xneBTOFevzw6Ec4w=; b=Jn6ygvcBBIRkCKZE3OD60C
	YhQlPbELmlfDCxXdRch96y5eyqkCrOGVy3PJ2bioC6j1XutwMYlOhmF7YgC7qCsp
	4wwG6tiDfYwbjteck6fYwetoucDUTZCDapz70j3xeRreeMvjSJPV4U/eSITk0BYX
	AWqMOScnzMhhOPRI+ojCzZ/DlHI7gEgiZvvq8g1f67mzxPrfjumuUhOAgiF5SEl/
	hza3/i1y6oYGDRKAX/LKbsH/TtQQOvlY3YNFwnJAWshR1itdXFkwxYuHoHcwKt6K
	XwOzLFZGTWOPTWyGl78Y0HLMEy3jAqHUOSig7p18C7NvDRTIWzt87vBgJ4eMTvUw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73947ewx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuMOY017204;
	Wed, 26 Aug 2026 15:05:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qat0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5KVN45351412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B845120040;
	Wed, 26 Aug 2026 15:05:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A1EA2004D;
	Wed, 26 Aug 2026 15:05:20 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:20 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:20 +0200
Subject: [PATCH v5 18/21] KVM: s390: vsie: Add VSIE max shadow
 configuration
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-18-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3014;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=p7pQvUoIW+eQoaGvy1CGDR/mpyTkFo/sNyIL1U9zg40=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DGtWMOkIN6yJ9/4Zsqg4jePevFzfHYbLVyRV73CK7
 ZL6J1jUUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwESY7BgZ/ln5Pfv568WCta4T
 Hq3vU3q0e6axeIw9b/HO1uXHq04HmTEynH+0/fkWL5XOTUmT2tym3llW5fDU7aOZp9gxV9a6L26
 /eAE=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: xHRSR25EsKKdd4mtZjaFfoazWNDcA-Tz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfXxOFyUh0wR4Z3
 WpwXGhGXvmYANq9kprlmBSiMDkh61BYbrmHWNq1CfN8m8W2o3zaBsTqUadOA4VJDGHOW5nrvghj
 mY8rtEm+06IyDYGKZFq23Lo0i0PUuMe1q1MdaOtDcIf+suwA0NyVJdMkvTgkowDVwEkaCA2dczT
 IjDbRzLoe9DeuTTY7jIzVmsLhDkJ+SHC7AA25CF2HBX+NIjPaz1XUVLgOyXi6/NJ/p0OKHHMvXt
 l4fp+h9i/hIIzl+j5AytfRac//HsF8DjsuYiz/dZ84ZcaS8dp0J9PMaaqYt+ddkox08KfBC4Qkj
 WURSx7aGAqCnARAo7edyoqD4c4GaIZ22sNUXCcN8S0JYqWTYa2MwfVSx70a+o4Sxe7K4b47R+eP
 TMjg2JBuKhpJORk6srMi7o7StF+rSjG+7d4vQX6eEngt3hyiTX35uGn9XT3dcwpu5kXjYFRn7iR
 9JueeCEq9QL//1G5Oww==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8f00b5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=NT-WFI3kCPxDzj7wveAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfXyI1xmFE8aX6t
 DO029BdrZL7vFc7mLgmDiLPdsqHeR3bNOycDWFY9exdIko8y0AZB3ikL0dFlh73u0ivGVGoCCD0
 KN1CvFjckJilxeWU+zqfcJw+5Kd+lFg=
X-Proofpoint-ORIG-GUID: t7XBP-WK5fjckf7qoztqNU7EQZI8OTOD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

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
index 6e42b00206bd..fe94587511b0 100644
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
@@ -1085,7 +1095,8 @@ static struct vsie_sca *get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_
 	 * We want at least #online_vcpus shadows, so every VCPU can execute the
 	 * VSIE in parallel. (Worst case all single core VMs.)
 	 */
-	max_vsie_sca = MIN(atomic_read(&kvm->online_vcpus), KVM_S390_MAX_VSIE_VCPUS);
+	max_vsie_sca = min_t(unsigned int, max_t(unsigned int, atomic_read(&kvm->online_vcpus),
+			     vsie_shadow_sca_max), KVM_S390_MAX_VSIE_VCPUS);
 
 	if (kvm->arch.vsie.sca_count < max_vsie_sca) {
 		vsie_sca_new = alloc_vsie_sca();
@@ -1962,7 +1973,8 @@ static struct vsie_page *get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr
 		put_vsie_page(vsie_page);
 	}
 
-	max_vsie_page = atomic_read(&kvm->online_vcpus);
+	max_vsie_page = min_t(unsigned int, max_t(unsigned int, atomic_read(&kvm->online_vcpus),
+			      vsie_shadow_scb_max), KVM_S390_MAX_VSIE_VCPUS);
 
 	/* allocate new vsie_page - we will likely need it */
 	if (kvm->arch.vsie.page_count < max_vsie_page) {

-- 
2.55.0


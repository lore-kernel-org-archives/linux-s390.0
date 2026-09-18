Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508C74FECF6;
	Fri, 18 Sep 2026 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744185; cv=none; b=pAAF5Xpfiv0dxQe8Z4i9sHGQjX3pkIb8EhSZM25BdHtdr20Uts8jzAq3p33noUHYSSIXNqHZl17Q1DIls1fNVDGMairPY4lGoN4pi4snWNS4LBYh35OOWXfHi7i671Z96zGbF0NpkdrHoRA/tMu/4rWRWnuHQRfGJ4ntN+Q31Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744185; c=relaxed/simple;
	bh=K2ume1ITvfSkKR+lVWxa9TWIGiMEQV2JgPLGotv+YqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llt5S+qqlzGPvKPjVslVXW1+kYbLyb9vLkUsz1ieHVkKrRZMLM0hSPR8jBNyiAy7Qqd3jMns3HWAgN0iTqhNY/02YO5tRTCQKL+biEXj+XlNUkTPhz0io5gIEpv0hSdJaESXAnB++f9qkmI9RLQVHivVZFsVx5z2uJYdeYEhq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nQ09cdrl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nQ09cdrl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVm7N1421501;
	Fri, 18 Sep 2026 15:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XhjZ0g
	S2DLWx8YK+qAFYBLyGK9ellWkfqzb7Ss5fO20=; b=nQ09cdrlAxpGG+GMvcrzmy
	KPcNizhnvXgR3YgVQdpy/jibQY1FUBCit70wBP6ZKRt9HIJzCES2pxL9w2XEovOm
	V4bp6oBEqzWM8kfU/XtnPAkpJ7Zomvxu43/MDoG5WcZgu1octk7N9ZmKgcH1J/nC
	+5ao2K8xv7hZkPd3E3Q64WtgB2QhBp+7MIRdpm32soh6At0wwl0cu8uY3u6ehU2f
	6As2evWIFbqB76lmlK0S1UmPByShMKmMGLigQGb7zW1tbEVCj0a0z9Ph+Ob1rAn2
	xcpHZANLiJR89dapuqsMqorKaU/kGzwRii1ken5w1lBhaM1wsa+eKPESGfjcCD5A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvg4v5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNqrW1684357;
	Fri, 18 Sep 2026 15:09:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gs4tv8puw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9Q1D55706022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DECEF2004B;
	Fri, 18 Sep 2026 15:09:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69B5020043;
	Fri, 18 Sep 2026 15:09:26 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:26 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:23 +0200
Subject: [PATCH v7 06/21] KVM: s390: vsie: Move pin/unpin_scb methods
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-6-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2587;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=K2ume1ITvfSkKR+lVWxa9TWIGiMEQV2JgPLGotv+YqI=;
 b=kA0DAAoWFCoo09c8J9MByyZiAGqtVCHItE1RvJjn+GViQILWAFLH/CMv5PlXCJVBbhvAN6qzs
 Ih1BAAWCgAdFiEEexc7bnqOhaWcwTnWFCoo09c8J9MFAmqtVCEACgkQFCoo09c8J9NqTQD9Gxtd
 cw+rTgBKk8pIWb2KBcu5N9+0jhlslZ+dWGldWyABAMFCPLR9MKF6o+OSnPIPlVNvchFqaEkoQaj
 AuWnzdhQG
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX4YcOIklRmQQn
 Ie+BNH7DuQOGH+UCcAFeg0d2cwqcrSZ5RvotShv4mSmZXpsp8mU3JyKyyHbCa+uK9weVHmLRGEo
 TnFndHmoIYvCqSqTfJq5WJhpmcoQRg0=
X-Proofpoint-ORIG-GUID: 97CuPObP79gMqfXAZl4VZnrVJmcYdaaQ
X-Proofpoint-GUID: MyBVuqgRe9iKXKvWlLOQo6_N-6SgD-bO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXzSn3qxVC9AQQ
 WZ9mSQ8ffcfyCt1vXEKBHrM9JwKcI1CVlMsjofVOtu0/+q+aa7uD/62luYgB2x5tBpV8S5Tycms
 h3qtnRf2fJxkpYQxX+E2xhrcv9i46dWD9Nma8DQ4TPbjWNKTBV61jUALB5YJFshjq7K6U7wdcl2
 l7cEjtN3dQGJdBweCwA7gjhYg5DiExkbbcOGfT8xmu8HVZYav6jmPdHcWmAlor2yIj47CTPQZKg
 dnPUkqrnokMENyB4z4iTbUS6ccKmYnpe0vIl9yF4hfPEtg9xm3gSOGSGx6zisqtLQfb+MH/UQ/0
 qFVvSHegPP4vuW+N0roiIRyeJjTMuXtNDZommZqWJnmRm61VrDaWoCue9jktt6jmoGLcORfuTWh
 rv3uFH0C3mvLz+TpqTaNcx2FirBW5eBiuTScag5sDCrpfaI7Kef9ST+1GEoJi2OvHwwK4aKqsz4
 sRzT0il4H6QCZvxJMYA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad542b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=7EIyOw4XjRUV76RzNM0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180214

Move {,un}pin_scb() up in preparation for the next patches to avoid
having to resort to forward declarations later on.
No change intended.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 66 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index e867d96917dd..55e9399b9b30 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -686,6 +686,39 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return rc;
 }
 
+/* unpin the scb provided by guest 2, marking it as dirty */
+static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+		      gpa_t gpa)
+{
+	hpa_t hpa = virt_to_phys(vsie_page->scb_o);
+
+	if (hpa)
+		unpin_guest_page(vcpu->kvm, gpa, hpa);
+	vsie_page->scb_o = NULL;
+}
+
+/*
+ * Pin the scb at gpa provided by guest 2 at vsie_page->scb_o.
+ *
+ * Returns: - 0 if the scb was pinned.
+ *          - > 0 if control has to be given to guest 2
+ */
+static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+		   gpa_t gpa)
+{
+	hpa_t hpa;
+	int rc;
+
+	rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
+	if (rc) {
+		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+		WARN_ON_ONCE(rc);
+		return 1;
+	}
+	vsie_page->scb_o = phys_to_virt(hpa);
+	return 0;
+}
+
 void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, gpa_t start, gpa_t end)
 {
 	struct vsie_page *cur, *next;
@@ -910,39 +943,6 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return rc;
 }
 
-/* unpin the scb provided by guest 2, marking it as dirty */
-static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
-		      gpa_t gpa)
-{
-	hpa_t hpa = virt_to_phys(vsie_page->scb_o);
-
-	if (hpa)
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
-	vsie_page->scb_o = NULL;
-}
-
-/*
- * Pin the scb at gpa provided by guest 2 at vsie_page->scb_o.
- *
- * Returns: - 0 if the scb was pinned.
- *          - > 0 if control has to be given to guest 2
- */
-static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
-		   gpa_t gpa)
-{
-	hpa_t hpa;
-	int rc;
-
-	rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-	if (rc) {
-		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		WARN_ON_ONCE(rc);
-		return 1;
-	}
-	vsie_page->scb_o = phys_to_virt(hpa);
-	return 0;
-}
-
 /*
  * Inject a fault into guest 2.
  *

-- 
2.55.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934F367B61;
	Thu,  9 Jul 2026 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610135; cv=none; b=ZgWGTzmwmvvBvrVcUab8H9dNFoQNpURycSiR/5FiR+NQDNItPqWTOvVZPsL9LJCeYUS5DcUjlqmv6CyIJmG7ngHfmmPDdCcysqSUFwcJGgH6RHCqoSvv92jh3QSTbi7iGYc8DN8dkAuNM/3YcQFWfCXx+n40mZazu7YSol9UhFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610135; c=relaxed/simple;
	bh=IDr7UpH8VBUCYDsLJ5Dn4mvf66KRXI82Py24cmn8yF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hOOn2r/CgwWw1FsN5L18nICPHtpOYf0RWebFBiqogic/gjqx2SJrD5npb2vxExWArk/5dcw+cLAjPh5lN9vAIpTbagOgvvJfRAK3Yf45k0juDbfNIqMIIIjdGeMzE3DEpTB50V0pqofLFFccdulmStIDgj7OKd7SdnQuNNVMhn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ceowZfpn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ceowZfpn"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIc4M2552155;
	Thu, 9 Jul 2026 15:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UIWIP2
	ElPDL2k+T8nA+PbokbMtBn6Zld6RIEo1/1JVk=; b=ceowZfpn/SWpZKktUNukSm
	2OxryX6lSjbD1PWk7mA61UZpyRRb4/ot+jrKPaY4CnblaZZKKg/Q2a8uEQ5V3GhX
	0+GA4RUMbkALHUweRe2r2iWBnU5POAsgmYcP6YQsggWq7MSbNk2H4Bpjn7wINpsp
	J0D1tp40Lxq0t0whdJioIN707q0DhTmZI1hUT+EyVN1/ZSqnyZATegyYRQclDrU7
	nsxyrFz8nOMUL9WvesajcZTyXLtSqH/x0eEY7mIgvel9w5euXcCejHOKyPiIF6/L
	Wt0U5Gvh/bQk4CYY78+Nm6pFusIES6Nr8/W5paP6sg+iKpIq05WEVq+1FVxBpToA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknsspv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669F4dDh026920;
	Thu, 9 Jul 2026 15:15:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwdvd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFOjZ44892448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B744620063;
	Thu,  9 Jul 2026 15:15:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C91E2004D;
	Thu,  9 Jul 2026 15:15:24 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:24 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:08 +0200
Subject: [PATCH 08/21] KVM: s390: vsie: Move pin/unpin_scb methods
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-8-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Eric Farman <farman@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=IDr7UpH8VBUCYDsLJ5Dn4mvf66KRXI82Py24cmn8yF8=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u5mVIzf8EqxeIrstIFl1zf3s4ANnju/6rnFr059JK
 rrhjmL2HaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzkcB7D/1L/56evzmM64bpX
 6Dbve51tT/o9JRYek1nM9yhlsVPaM0tGhnvh/bmnWCcFPpr6K+qDydoj63UvSNkw2/veqencdLR
 UkxMA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4fbb11 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=7EIyOw4XjRUV76RzNM0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _PK5npYX6Is9iZcmj1CY0cz-rV0cSqUs
X-Proofpoint-ORIG-GUID: _PK5npYX6Is9iZcmj1CY0cz-rV0cSqUs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX/SzIx85+tEKY
 XtDWIqNQv9kx1J8A1SpeM1HLQG22ueB4LK6sHLtcLWgCxtVvGjg28Vh0V3qHCM/LQQU1wMkit95
 ZnVinDH5dvjMDOHFaeWNsJWPixQQN5I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX8AI4Y85dOfj9
 6bRPCzJ6HYGx0vOY6YRiJqDxEasekfqQPaDH4gGNffeTE9d/U6exD0pInETri1zV0/14UcrnXbN
 S0KHIoJdQh5DrG8tjCTdWVXdh1lprGCaurDndkLWduO8oWV/sXPSpz0G2ZPhJAqKxg8jyac4q0o
 RC0PxNSWxbId0J89PVyghgpx/OkuNnFnAv7xH+mOqfKBb1RvQyJNCGuXUC/k89su3X1dl/cIIjw
 qEbTCZaQvX5bmW3fcjY1luCeJW6F72bcQZ4N8DtLDQt8cT5OYq2TX1T0qO7f6uFYp6QA3iDeKH5
 tLb4gaurGz573E1RDsMriyLpL7abEvVsDhF1Y9v0vPkMMwIfa45CckhmpbA3CVXa2cV4VIvElCA
 /2b2/39euAuSSAIFD59LH0TtnXq+4n/eU4RIy0EJQ7fYka0lA1oNItZYoXgsGLpfdyXjy+J1PXn
 GWCXhYDQ2sc9UHigV2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

Move {,un}pin_scb() up in preparation for the next patches.
No change intended.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 66 ++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 97581b748a94..d663df90af1f 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -660,6 +660,39 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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


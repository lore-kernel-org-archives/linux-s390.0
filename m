Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A572D3225;
	Tue, 11 Aug 2026 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455425; cv=none; b=RybHoKbUZuk9XYOwjPp8ApqZUl8xM4EFNSIfPccP0GBTGa29JJ61qgZQ3ytJ8VhjjF83DKYyKw0rs/hnPi9HwXMNJY1Dh7orcQBC/xf4MyyayjhQenz4EqoAWFv9i3Op8wRrETGg9JydgnDubBBwk05RgbkO901Lwm8t3DRubXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455425; c=relaxed/simple;
	bh=KLISK/Vl8Z3HiphdEbmJ5XNIa0ySZZhQRiGmVRt3Wb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgjYeEkKkZScFcggQdM2p2erHXX+wQ6qlCmx2+orF8WRT9SoLNyqppyTjzjRMH7CalDmzrfQ+Dw7Hd9vq4jQyZQ3TMUx3HPcddx5HmRUvvNf3/52MR77/W78+Rut5ZpWZ37mbi37+YQumLyBBmgImWxNKxVYiXrtXE0vfQ3Rg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kHQ3//gi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kHQ3//gi"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWPEf2864434;
	Tue, 11 Aug 2026 13:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W4ZFwV
	3h+rLYRAOaxIzRwxfHftWe5rEttkOD2jujtK0=; b=kHQ3//gi+BGiF2VK+cNKtc
	Lw9DDJayRZAzvA6ZRpuWaJklZF9RvhtXHelYo9zFiC9V/l74rTqJ29T1InzOf/Fe
	hCMTZl27F7HhZZZ/hz2AYNwONv+CGXStJvSUyS6zEboadHsdKdH1WZlwM8+IJuZo
	eX/lCtDFkZwTqGBG6NH792NNwsSIIgzVcQ9jGu4wYBI3o9ppbGn6reEJF/7qP21g
	WDjrYt+RZhkkA39L5cV9GH1Vf8LeF3mRq+m5zKTl9vC+uRZtIlRWy3NqjdHnjP1X
	lmdYSoCwjUznrOA20FV3Oh6+sG1vFnA+64zkK2k4b2NTeDlgRz2ywf/IYljsmi4w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyw486-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQGEW012034;
	Tue, 11 Aug 2026 13:36:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjs3kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDaVPC52822456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C54842004B;
	Tue, 11 Aug 2026 13:36:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DF452004D;
	Tue, 11 Aug 2026 13:36:31 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:31 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:36:20 +0200
Subject: [PATCH v3 05/20] KVM: s390: vsie: Move pin/unpin_scb methods
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vsie-sigpi-v3-5-45aa1ab07c7c@linux.ibm.com>
References: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
In-Reply-To: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=KLISK/Vl8Z3HiphdEbmJ5XNIa0ySZZhQRiGmVRt3Wb0=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqpFvFkhFBH2Ttu8sPPna8iLfHeWS1kC7p7If/9qqP
 X3NxSbRUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwEW2MzK8SH+8ylpz0xVG+ezY
 SPlZS9NPay9VcP/36PY1IbN9LVl8jAzNM3y5vlnlvLlxevO3uV9Fcu3vb13MZxb+r7llunnPDXE
 +AA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX3TArva/DUH17
 f/HBw8FQRjmY7/HQzSQOui++Z4wmd1girKNhouOv8ze6U9w2a9uDlLorqRXi6BWh9pBSL1997FY
 5p/yEbr8ZwWDpsRTF19IIwLX2BahL/CEvpJBRdxOhHonO5Y2xyqei5lkSYSSbjpYLHGxwQkhGqB
 WnfukkGlx9cPknyC5rdZMnYn6Mrp9DkjjOVdUpe8EulshoRLLxt8xT0uBDXctOZIl1yHU0F0kzK
 jtiDt8/pynr2VeVM5tri+OpUJO4AJNpRCbfrdkQ6+MoiXjk8ExaH3h6R7k4rAsReZu7yk5Jezr6
 pfjAYRiIk9YoOhekAlHpuCEMHmb81md+wMbKhmK6qne/nVDOrhXA8KZwb1Q1WEZjFqw2W2LWFgU
 61Q+Sj5atdc1soaGHTdTTVrtSwcHbHnFMhC6c+9cKIYKW9y2TaPvjcCbH5UFrLWyjR7tZGfCwUj
 Bqx5eKFbL/JwYRxZbpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX8H0oz1F7stmG
 zaYvoJYkPmJvJWB4jp7xG8YYpCRIS8tzaV2LSM9r5jFgQnJTpY64LSQo1Xo4hh1YUgzcsHf1d4P
 /lHtqlYYoH/M8qUwqSv9dp9yvXdAa1E=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b2564 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=7EIyOw4XjRUV76RzNM0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 13Y16plwMHm-K2v8V_4yNqq-z-VoW7V_
X-Proofpoint-ORIG-GUID: 13Y16plwMHm-K2v8V_4yNqq-z-VoW7V_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110113

Move {,un}pin_scb() up in preparation for the next patches.
No change intended.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 66 ++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 6aa44362033c..3f49d2e6986d 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -659,6 +659,39 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
@@ -909,39 +942,6 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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


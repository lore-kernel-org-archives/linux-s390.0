Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF23B43A80C;
	Wed, 26 Aug 2026 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756732; cv=none; b=QxaJkKW6I2evE9Wdj2p9BHCVHPyKVxREIBhgf7NrNtJrRvvRPISubQ7BkE41sC6oKDp8f7+b1r8Tfidz5BXWOCg8GB2TBPHShHjD+HuRl+/LuyT0R2+R45aiM/BwznuPIPziN2C/s6lv9QwPRiCeOqnPWN9VpEFa/pTR45TK1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756732; c=relaxed/simple;
	bh=DKQxICjKjZGpSAZdFvMqRVzAZOQV7Gw1zlGcnwWUS+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MfPuxEXU7+6Z4OG4LdA67Fj0Yqdfe4oxeF6VsNDomWpC23pAkwtd9A2eATS8mAdFEUFigjwALLOZ43xAejU6SNPbtGPJom3A20D97kFcxPqk5GsaSff7LsmHAHUXykWClXyUxLqbM2tK8nWTM/cgUvNRARogepz/2AIHvGcZKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mCSrtyt4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mCSrtyt4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1cZ63084603;
	Wed, 26 Aug 2026 15:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UyXygP
	P7R+K49NyxC4nSzyOBjFGa4yvWe3KLGvqr6x8=; b=mCSrtyt43knGwnqRVpIHxt
	n4TPLhHkAJOtZESRSf4Kkb3M3LZINUNABe9yMdqEddCjHhnvInZNgGmpERk4llSY
	dB5Pk2Kz1kiG//XnrZ/7KHD5MDwftnMCNo71ZZZbmpK/y09csNRbqnOBMgA0J4CI
	w2+WJ/MqwfAB7HDMGYScTfmAIWTOx6TNZ2ExTBNnnS9wW0QUU0H0yx8GT5wcoSA/
	Qmsa2GV0UlbDjNssYbFxcMKniOmNNYyeUrWQawvk1nBhhexgFAG4Vj/ZjMKWEU58
	2sNIm0rgxu53CInBK+JcKPi9FezRBOIvLbhiaw+xfGx4mXTk7UtW6jueAARmlkxg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726eqbw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuHMM017914;
	Wed, 26 Aug 2026 15:05:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k2k8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5IXi33292782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29B5D20040;
	Wed, 26 Aug 2026 15:05:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE4C62004D;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:08 +0200
Subject: [PATCH v5 06/21] KVM: s390: vsie: Move pin/unpin_scb methods
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-6-cf471edb46b2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2527;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=DKQxICjKjZGpSAZdFvMqRVzAZOQV7Gw1zlGcnwWUS+Q=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKumM80sCI0qUvYSE53/vN1FS9RIvSLgZ2XPnq5XI
 eILHWZ3lLIwiHExyIopslSLW+dV9bUunXPQ8hrMHFYmkCEMXJwCMJENWxgZ5oc8Er3sK71aa8vb
 mlMGwVaL9rx3lvvMtqraRy9o6VstT0aG1xL9Levz9n3+fLP/5JHwTQf6Yxa8aJPeFRO+SMpe+e8
 MLgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8f00b3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=7EIyOw4XjRUV76RzNM0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX0069YqWuoRw8
 KSFEp357Hys8C1zXyfllE9nYPTLq3wGVFWYgsDVYElqBfNhWW2fja4UNbG+4V26mIFKU8CbfiWa
 NfAzyuueP8xW81z55DjPtOSZ4a/CHRE=
X-Proofpoint-GUID: Rz1HDEI15KjsgIJ1eXyeGGcA1TT3n_zn
X-Proofpoint-ORIG-GUID: 09iNCWAhdZgocoGEREjSILNiY8m0tVvb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX/ZoLAdrRsE6W
 43Z0k9AX8pwqUK/tBRRhF8IqaGMvzyiTzujjQRS9dqZk1nlRGTNPtvQAbnuMlQ+GkuaVqPCMoia
 s/1gTUAQKjH53NnTb58bbcPF6XSRps340wrVYLgFoDmLOG04iYZfBbFYmXle8fI047hUKYw/FYx
 L5MFz92QDZY20XmD8ycLbOKN42O0Ow9vOqZt8P3MQheeKR+G+SGvg4jqBGadX1LT3ABQDIvmi33
 ZQNYON6BXPgFhU3dwoKYFDFkoLlGgikVFOxF7gnUBknNt2hqf6uK3LMBFDSpBGSOIPacHJnQMr6
 ek/rtIvAAvoG550myeEiSidc1vsrWxm/SOYzds2JpNbXDtFZO2f15kf3CpAaV5rsQ+kbgO9Sl4s
 WvNZwvYkt9OBkoueDP/4YMQPn7iew/t7H+1Vd5hjC+w84Q2pvyS45QhdsvUa1h6pkaXMeaO8Pw2
 wr8jFCOD3n7xqTyopow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

Move {,un}pin_scb() up in preparation for the next patches.
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


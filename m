Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF94457BF;
	Wed, 26 Aug 2026 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756733; cv=none; b=EJj7dPeCgUaFnqQFakGPdSRzLeDOHgFtZgrTCWmzM7Mrdah67+9LLCaSUSvqyV4cSlgB70BzJKESiVXSHgeo5hIqR9m16dWdUTtP/2i6D2KZMtIFBb45Q2FFVgw+eU9RxkyhrDXqLOsRKzr/Gxio1txTWaNCfz2Wpuk56F6U03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756733; c=relaxed/simple;
	bh=QobfvpGVVQeS8jCpLKMes+wDFv3Dy+mE85EHPJgN5Is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rP5/XpzEW6RY3ldZhaGnO5JL6BZYGp0bJMHTh9lUekZCsbvvziO1xXH6DdGq5i731+gX/ojIGVlK1Nd5n2K8il63cUuxze/krHIBjJNqPovasPUDP0PGALe9d/AJB0OGypk2oJBZWJTWyLDlpoob6PEuCbB5FYBnBKWAmmeAuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q0zK28Oh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q0zK28Oh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1cHe070317;
	Wed, 26 Aug 2026 15:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pNZQ45
	DjGY70ChWSvdHUVUu9BcpTta17HEBofJUV6ZY=; b=q0zK28OhXsNg40e7Xc5B0R
	P7SH3Tta5Mj5kCqh9EUGHcWic4mNQKaQXbUy+k3Oc9MExvQvnfgWIFGuPJjcBCH0
	uj6qf+5Eeam5R7HAa6ftYB1f3iwNSFpFFsNCDLDSMmhJEdI8aQdSR+x3e3flRiZH
	pMF7afuKDt1pfvW/FevJs6dxD+8gBlstOlgFriIiPbTfKg5La5ntnAIEi6fxld21
	6NFnZVedCY/5noum1aQEyaAm3NVUJjds7ZODTSMDRhE+nM6Wg1dkRZPCXM0vSjqS
	YK2GY5aTfANKzsXdsgZR96wQKkOh/Xy05g5cvexL2BjsNQ+8qWAPMRshKgl9+KIw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxf4f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuHFj020657;
	Wed, 26 Aug 2026 15:05:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwaq24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5JhP43909478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64BE120040;
	Wed, 26 Aug 2026 15:05:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 340522004B;
	Wed, 26 Aug 2026 15:05:19 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:19 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:14 +0200
Subject: [PATCH v5 12/21] KVM: s390: vsie: Add helper unshadow_intercept()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-12-cf471edb46b2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2387;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=QobfvpGVVQeS8jCpLKMes+wDFv3Dy+mE85EHPJgN5Is=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKsvi85M4+nkdUk+udMxdLXzzDkTU1a9t/k5e7GJd
 s/8L0FWHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzkaT0jw+EtH/XF4i93/Ni3
 aeqPsLMGB2vmfVfae/NIGlc2z9dlQcaMDMt2ukyK4z6+lu/4olqTuNZt33k3H9p48/1n76/navd
 +8+cFAA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX4zrLY3fkfnaN
 TFq89zPjA6O+7PURQe5M6XfW9dtvkW1FKLtQNX00zIDM/6q0rE/CZnP5ooi5mosHD1wOsE2U7Z5
 +yCa408COFRunmHSyNB0BlR9sHikpNo=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8f00b4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=iW0MwhF_9mvIdrGbKFAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jihsCzmL7BaV0RuLXEUCSr9WWq-La94J
X-Proofpoint-GUID: q1JiR8XOuNBC0-A3maKQqBR7EcD_Acp1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX6tXMKaWA8noo
 tRYdoxV08fT6adzDQpCYk242xA4RWTRkRQsenomLGl4pkS1A09wqoAPu2sgYkuwpCIxVHs8RFen
 8Xo52Ps+NKEBAOVdnTZEJuuQqnp5CbzVmnvGrsEVJDNgPqkk3g29WFmxRkIw8qy/oXnZdzxJbwk
 IqYRjLqZan7B8wtKNZHW4s26gkqXp77ll26HHsH0n5OPFWPuxP2NAk+cmnrmug8p4Lwf0uIlfXD
 z9CnMTMRuQ1L4H1oAEjoZWkSRvCD/NBbP2rgpBsmGtwltQG/aJPOYbitgTWlEUldNpbmxS9zXbA
 w3Jo/BRhSPJChbC0b2A37+uXhV+DBIq7i5NxePkDFmBO+Fcu8X/LjKDR5Zzb6fnbZHxglqdgRXK
 HR/KexPBUr93sXz890aCMnWyx+FsbgEtw708TIFu3JnJjhaNve7mZH5BDo20WH8RdR7xNWMP6Ff
 X6LAGKeKz1RIDpNkZDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260125

Extract helper method from existing code to reuse in new code.

unshadow_intercept() acts like unshadow_scb() but only copies intercept
information. Used where the rest of the scb is not yet shadowed.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 5c4f13777178..988370f491bf 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -565,18 +565,27 @@ static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	}
 }
 
-/* unshadow the scb, copying parameters back to the real scb */
-static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+/*
+ * Only write the interception fields back; avoid clobbering the timer and
+ * guest-state fields in scb_o.
+ */
+static inline void unshadow_intercept(struct kvm_s390_sie_block *scb_o,
+				      struct kvm_s390_sie_block *scb_s)
 {
-	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
-	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
-
-	/* interception */
 	scb_o->icptcode = scb_s->icptcode;
 	scb_o->icptstatus = scb_s->icptstatus;
 	scb_o->ipa = scb_s->ipa;
 	scb_o->ipb = scb_s->ipb;
 	scb_o->gbea = scb_s->gbea;
+}
+
+/* unshadow the scb, copying parameters back to the real scb */
+static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+
+	unshadow_intercept(scb_o, scb_s);
 
 	/* timer */
 	scb_o->cputm = scb_s->cputm;
@@ -641,7 +650,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	rc = prepare_cpuflags(vcpu, vsie_page);
 	if (rc)
-		goto out;
+		goto out_validity;
 
 	/* timer */
 	scb_s->cputm = scb_o->cputm;
@@ -755,10 +764,13 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	prepare_ibc(vcpu, vsie_page);
 	rc = shadow_crycb(vcpu, vsie_page);
-out:
 	if (rc)
 		unshadow_scb(vcpu, vsie_page);
 	return rc;
+
+out_validity:
+	unshadow_intercept(vsie_page->scb_o, &vsie_page->scb_s);
+	return rc;
 }
 
 /* unpin the scb provided by guest 2, marking it as dirty */

-- 
2.55.0


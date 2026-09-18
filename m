Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E624ED19C;
	Fri, 18 Sep 2026 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744189; cv=none; b=nujuxt6CdnBX1nSBluNwhKVsc6AwLeI9qk0KyMVsu1yiIbM78QreZ2eGhQn9CVEbmoAr6juk+0bhv6OqXXtGbl9qfJ3pbSMuOmgJ3ny8Sh0ZNbPMCtaJOn9uUq3ZM+QDQHCj50vrBjeJNTp578cx5Y0M+b61l5BlTF8AvW4yWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744189; c=relaxed/simple;
	bh=aLaB3JbC68o/lfKoiZLIi7D6VH6RdcwhTmKaukWkxLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fThQRuf/dUHGRI7e1Ygvj0gOozo2rYTxQLihT/vvzKkUexI401d/X9/OZtV2dWU3SX9/huHSu35Jv9wrt53/WcrsjQuvbFK+3LnRELfKXv/wHgmbx5jyidUkJ+B1gm2bphX6zKzaTWa3KD68QVm3JanImBVGzV6x+s8ncTnWap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qekCRmkL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qekCRmkL"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVl0c1421489;
	Fri, 18 Sep 2026 15:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+xfGSo
	RMOfeI3i0n9g0kyek9xzLfbjD2WB1TbWzIOn8=; b=qekCRmkLhPQ0wktnySNStt
	WRmmH5jcTYtiiOxJSle0qhRkaTj0OeHUMTO8FQA2HhKV+a1q7Vdrdl2tFwCzQsDj
	KwjbPXqRmxc7DdZsgWXCPQKFMiXVtnaigotiijAUKvq76c8dHGfsi5pfgIsoJyPX
	4w/nDLCoUxpnUIVGpg5/Ru3Dm2PpD25yqe+Cap0a3mYhfS/9lQit5kcy2YYGw38K
	Kx/KZ0sgk9sAIbdCe8kNWbSsAbovCb071Gm/RSjZhd1bz17nQAaea25VlH0VlkCJ
	amxHwwzP45AD1IKL42C9JyrUE96IFDJUGfoFEE146dRW5mPuQA/k+1Ql7Vt6k1vQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvg4vm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNqgW739423;
	Fri, 18 Sep 2026 15:09:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gs56q8m9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9UdD37093874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B0F320040;
	Fri, 18 Sep 2026 15:09:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99F4520043;
	Fri, 18 Sep 2026 15:09:29 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:29 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:29 +0200
Subject: [PATCH v7 12/21] KVM: s390: vsie: Add helper unshadow_intercept()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-12-f39806eaae37@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2387;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=aLaB3JbC68o/lfKoiZLIi7D6VH6RdcwhTmKaukWkxLc=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQxQP6ydyqC8QStOYcjX4wcuoDJMTQts7GJ+82shud
 nf+t1DOjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACaSspeRYfe7dx4rhSYyvrDf
 V1LFb2hzueOr0+qkyOOqxedsbU9NuMXIsKk4gf/2O5NJJ7IbA7ZoL/K3uzvrgdP682/t9Hm+uxc
 oMQIA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX2UgDeGTEz/9c
 Bas+QkBj0JDxZZo88tmeLd05fv1m983AajeTLHFYuRj+iSC+3OK4CJvJLiZpeZ3Ib/ciSv+BLFE
 bkECassFlswslf4gVp2BmqJ0nAboiEU=
X-Proofpoint-ORIG-GUID: xq_Q0AHQYF4gr2Es9B0hcTzWeoQnt42x
X-Proofpoint-GUID: azoOLKg7uqNTBndkIRE96VF409IcQMNt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXzz66mdjYBcw+
 Vea+MRwAH9uFbdKYzkKIpuekbfYjct9LFk6fIzY7CGyjzQVfra/Js7z37li0py81pDk32IT3n0A
 MpmPTvbTUjl5M8qlYlLAOzBoqVz9HjYm3+aYG77R1nQSoI+112rXTh2r5uGSNzSq++BsnRGlfID
 QR1GOkMBo/VXhab35xRTPeoa2tZSxUPsnFdqmZX7NZsfFKcs3i9U+QktivXxuF21UPsSPPrP3NL
 TYLhtYc1twWaIOGLZ1liuFPedgpKt0+OdGTp8/qZCcYfMuhNftihvGLO8TduVfMWsX55s9/TN1w
 jO4kX2bdjD1KBOqkSjaBGFIOOwatEBD6ZfoLl9fPYLOkOOQwd8d4OhQjivf/iD6wtZ/6GcphV8h
 VZ9cLmdSRadmMIjqkUWIrICtfmf23Gq1BjnxaZ7N11pHBUHjNC5EPpWJhgLZ68xSqaxXLXUsmn3
 a55R1qYA9Dfji/vCfJg==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad542f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=iW0MwhF_9mvIdrGbKFAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180214

Extract helper method from existing code to reuse in new code.

unshadow_intercept() acts like unshadow_scb() but only copies intercept
information. Used where the rest of the scb is not yet shadowed.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 95baac9a1ccb..c42e2df4c0ab 100644
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


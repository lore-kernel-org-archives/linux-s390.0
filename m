Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601560;
	b=HOyIKisy0O/wKV2f4rZ0DDazYfyzW7YLfZDDbEv5lhrN995OCCZVIyANJzlvP+f826Jk
	 MCZm/CU+iBx8f8agYUjctGzoyeMsoVNpI5rWnuDYG+PsGYR1zI8B0Vkr245h/UKX4tmhY
	 G37jEyYAeXsNZePncEXa+iOffKMq/aseY2poZIjGA+5vE4JXiko4plwEPb7mIZ5X23tA7
	 GFyRUN/PVKffQySPpASiyAdOu2GlGcaOJcT9hq10s+MYNnLXTHPxeV/Z83r1uD8IejJvc
	 Hbawo+5t/weQPTKV83cOu+2EnZ7amnEG2Hmqj/S1yJ+gIYwhshm5Ur34HuevWhFgB2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601560;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XNjKeJl5YO6PA0Gu/9gtvtwySF/SfgoV2euHhmYrXjk=;
	b=rmRlxgYvvMD+UjAMCDrKy3FFBOBnh0IGbBShjgqg4pt9VPRzgnfEJwYsxe5BrrKoK4oN
	 xUWAreax9yNE6HZyOjInhuTlFDjtlYc8VUs6aRoLu4a8tT9g6OVMZyJ5dlV6unNRd0j/m
	 82i1FGgA4wH0GtbG5ndrkPkoJzBOZS0kYYfoCTgt3741s7Betf1HFn9YKW1PgptQPcR4J
	 fp70O9zgFWVWm5TiJr8jEgBraE+Gq38QzkZO98fc9NUlvnoFb8H5vBK7tHnqoNGAxE3a0
	 YLornHSUvzZf6AQsrEAgjoCAb9BWmfqj5ui4QKYD77xXhhf41Bof0wXevWVVchDg0hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M7XgzlXZ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCD5606A326;
	Wed, 25 Nov 2026 10:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCCD5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M7XgzlXZ
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APA4ZeT1019684;
	Wed, 25 Nov 2026 10:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=XNjKeJl5YO6PA0Gu/9gtvtwySF/S
	fgoV2euHhmYrXjk=; b=M7XgzlXZ8lbAKuOr/Fx03i17I+fu8R0UOWG7AFi69fuN
	YiofsO5GFAGwHe39zy1w4L2GTw3K/BJPaZ+iU+ak3fnBpN9FrEbLPw3QYdwEpDaK
	RdRFGMRQpaPlL2v5KcyK2tbUEAIeJbCMnp4kmwkQXZ6UhpcA5m5GL97LfiewnNE9
	iT8qzevYgiQv5QooaaqDIcUJz2gQ0wPhRxllFt92FyjLXe1vY4HzQMwWdBy0pk6z
	TjSc131sdCnvMhiQD0jUaEPV8mCJhV8umUOmsV9qXh4rUloTGmfJTB+yK+z5APGg
	mvJ0aqrCJ2MGxXbtYbt0rqAi7ii9wvbHOf0kBF3G4Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkkudu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 10:12:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nXO91684280;
	Wed, 25 Nov 2026 10:12:26 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4he07k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 10:12:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APACO3a43450842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 10:12:25 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE6E25805A;
	Wed, 25 Nov 2026 10:12:24 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 022F958056;
	Wed, 25 Nov 2026 10:12:23 +0000 (GMT)
Received: from a46lp21.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 10:12:22 +0000 (GMT)
From: Andreas Grapentin <gra@linux.ibm.com>
Date: Wed, 25 Nov 2026 11:12:15 +0100
Subject: [PATCH] KVM: s390: arm64: Stub kvm_vgic_put/load to prepare for
 kvm_vcpu_wfi
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-kvm_vgic_stubs-v1-1-c53ca2c5959a@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNT3eyy3Piy9Mzk+OKS0qRi3VTDRMPU1CSTRANzUyWgpoKi1LTMCrC
 B0bG1tQA7JlxQYAAAAA==
X-Change-ID: 20261125-kvm_vgic_stubs-e1a1eeb4a075
To: Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Andreas Grapentin <gra@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=gra@linux.ibm.com;
 h=from:subject:message-id; bh=Dtuw31VNJ4W6bZ7dzwDwAAU+tT81jIC3l9DkhrIas9Q=;
 b=kA0DAAoBdSDW3STySicByyZiAGsGtIWh+lrDIQKaB+A+GhDtevARt71ruYNVJ1iFtQmsYUyPl
 4kCMwQAAQoAHRYhBGsqSt4axwvZW+U+LHUg1t0k8konBQJrBrSFAAoJEHUg1t0k8konSPEQAKP/
 tWdZ6KblsFgJ0iEaM966wHUtc5H7QtU//y3Io1NkltsmQoXHDop6aP2AVlDN75TzQd15A5+IQO4
 vyUOzZI0j1jtz0i/6DvGZu9JfftQKBBRKSQZZtt0pZU92sPPFajYeRoBoVMm0ydca5e9DAojHXS
 mYsN98zIkR4v8+fw4ecbWYDO7F/Qw8EsWp4zNtVikUqypKv9Brk/PHsTL5e8iIVOGIu1i1Goe+v
 BWvQxyfMNNwL3D2Q8qe6Frb6xd8soKNmijD9hBIFTTx2hkXarwHMMbfjuMZVEwXwbprFgqXl+by
 9ah1uiQHDVpSouISUxmnsaJetfEgBSmL9qIrMGW5+j+rdDosZ9D0+/6yxvU7vfNlLE/U/mCdcMX
 3idEia1Zz/YNjuk3O3ARPgGyFO2VJNBGbEiEQr2ojT4Z/d6AV9RyDnC8w2NVVJaxK7Sc0KzFxQn
 DiKkYK9Y4lRr4Kt/JbJP1xnaRsQXBOknuqVoVAzY/yNkAteKtq6atTvgbx02X3kbQgrBvKwWrRO
 Nx1JpwJgTUiYKa0duDsukg1ip/jZK1hMY7kyFeXa9hUut+P43QRObNNwI1cZ5ato7XGW7TmV/UU
 u/U5SAXMYXvjIeGk8vALcgpvQbswIG8kgZsYyWZHsHpj96R5wQAU3vSJ9jbsK5Y+o8dGiE0G3/3
 StZdB
X-Developer-Key: i=gra@linux.ibm.com; a=openpgp;
 fpr=3B910193D094AA78FD974A04D8BFC37DD553D93F
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX6vThq5tb6/hP
 wfNrxQfZb/qSCoPubIcBRNk94nw1Jo+IO4SkxA0t9xXIQM73rmPuZ0UVc0Cr+BhPhRMdovcWliu
 01HEq+36EGXaPWnQe/n2JEtR8TflRAPGB9o45dBr92HatxXTfAXdfpqcZJjJgOCR29T7nG+jsdF
 RJV/CJWu57yuupmbM2NoonekgzOeZMhJ++dfxtmo37Aum4ibJZJ6QyMJ0+xlbKNdoHEIkh05ULi
 fW9UIfQ0EL+cDOSbZPub+qkEjyoAMPM5TvOQCnkWlMuOsf2gQgHmSz3+hUDU1hw0ePPRsvs7oQT
 ALiZYidQamXcpB1c1jHlZwFu4DJ1W4+W1FRZjp04KXtfsygwxy1nYKBmufUPATTHCS/wglaxkd2
 qosZL6ZS4DflYc6vr92BC5eephpFvCjTGlJnV/7K3KuuLaMDA/yVEQD2/LDyvW0Ut4l5c3xaUPA
 7/Zp7juhKMtAWl+9SmQ==
X-Proofpoint-ORIG-GUID: Zxs6bmiwhOR6RXdYYJ5NrLlBApiwXRzI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX2l/tIofhNrhI
 KUKDPbhP2fUXboN6E6izsB6AKKcR2D4OtxwwmMXiRU1uC6c9Do3lXFjpeC0zmraeazFWfFgq1Ub
 v1aJRPuWxxWWzxiKtTN0gMrxaFFxxa4=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b06b48b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=K-9A4lQVGEtsJpC5Rw4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Zxs6bmiwhOR6RXdYYJ5NrLlBApiwXRzI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250040

In order to be able to share kvm_vcpu_wfi with arm, we need definitions
for kvm_vgic_put and kvm_vgic_load. Add these as empty stubs now to
reduce baggage in future series.

Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/s390/kvm/arm64/arm.h b/arch/s390/kvm/arm64/arm.h
index 760230685ca1..871fc853675d 100644
--- a/arch/s390/kvm/arm64/arm.h
+++ b/arch/s390/kvm/arm64/arm.h
@@ -55,4 +55,15 @@ static __always_inline int kvm_s390_vm_stop_migration(struct kvm *kvm)
 	return -EINVAL;
 }
 
+/* temporary stubs */
+static inline void kvm_vgic_put(struct kvm_vcpu *vcpu)
+{
+	/* Current state of the implementation: no in-kernel gic and no vhe -> noop */
+}
+
+static inline void kvm_vgic_load(struct kvm_vcpu *vcpu)
+{
+	/* Current state of the implementation: no in-kernel gic and no vhe -> noop */
+}
+
 #endif /* ARCH_S390_KVM_ARM64_H */

---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261125-kvm_vgic_stubs-e1a1eeb4a075

Best regards,
-- 
Andreas Grapentin <gra@linux.ibm.com>


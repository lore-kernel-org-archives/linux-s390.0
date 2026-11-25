Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624738;
	b=l4IzwOIskZQAc27g3r2xkr6JkzK8RPmfhjU94J9ab8qPpu9FhNQB8s1NvnXsPderuOD6
	 XTmyre1+vbRmC1bmhmbO9uo+b8gj9MMP7hM5Izeg3SzOxTabETzckI2JfqGtubMkE8prc
	 GRnyX5GW20AfCvifN1OazWWEVXdXoljHycQLlzWQERa8/e/Qz1mNlJei7and/JN4zCqAZ
	 oG68zJQIkb/tRYL/pMPL9+E0eUoTavA0tyZIGQ6AkhbosKneR5ZRFbPKu0rN9S7RY4PCI
	 ItuYOGFqTHbQ/wXx8ENYN0b69Iv29IOVVE7OzlVToLq+eBQq5zE3EmO8ctQ/HziMgJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624738;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=T0yXC6BqDWQMRszcHiMjykyrOCyOHdNEMTFVlj6tW34=;
	b=YtKmy3LOT3czFp2SUeXVgGU7/8YpkeVwaOTnm6myu+AU/h6z41mQePaVYOEyGfWXD/7D
	 wvMgPO6KPdDFpgCa7/ZrfJSbfuGo1SPTXkslMiL3Uaof2o0SpmZyk5BPO0Y4r6jL4HOsT
	 DGyzUkqjd5NTT5x71mtCoT9vXU0/2rv1OIYHs5X9b/nkL8JEb6JbVMdmQeBbf2xerrc+B
	 WiYelH9bx9i5IUpwHiYs3mxtH1OvdNxHQ01OE82l/+ZBK4kh217sTqMOFXLFA1ZHYC8Tk
	 EpxZoFn9otqLGotwKIJd+J1MZ8mZVzuWeT+mbGhlEEAKClolCv3KXiDSjD1ht43vgJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P+guVOsX;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12FB606A33F;
	Wed, 25 Nov 2026 16:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F12FB606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P+guVOsX
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYXK31852433;
	Wed, 25 Nov 2026 16:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T0yXC6
	BqDWQMRszcHiMjykyrOCyOHdNEMTFVlj6tW34=; b=P+guVOsXWdzo43TxN+Gxcf
	mtatLzwIis9xv+r0AmQ2RuHJJC3Eg2Q1oVOCStK2AJmECh2BZh8hncWNvXQfP1PA
	NXXRIAULWe1TsbZcB4x31xOsq072FU4Zdx+uJnRMSXw0ZzLqP+Ss3JS+AniUs1xa
	/xawQ5JpNEZ/vs6cNvpx14mPCxxHseqp8NtPSecacafTWM+UH1Y5BPjmQkswXUA/
	yuxtanS6hBQxyvrS4gOlB+fLGdQafFaMDRcID7gUN8g6gs48xGiBzCtGduR1LzWn
	70GF7OOCFU48UKlBWiw/j0TT+upKPjlSDlOWPshyj/Ys/tRhRBY6BdrskIrtHKiQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g1cxk0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 16:38:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYF7h4082063;
	Wed, 25 Nov 2026 16:38:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfa2sx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 16:38:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APGcgak46137706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 16:38:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25C0220040;
	Wed, 25 Nov 2026 16:38:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F38C62004E;
	Wed, 25 Nov 2026 16:38:41 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 16:38:41 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Wed, 25 Nov 2026 17:38:37 +0100
Subject: [PATCH 2/2] KVM: s390: Enable the generic vCPU kick infrastructure
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
Message-Id: <20261125-vcpu_kick-v1-2-a203b01ab957@linux.ibm.com>
References: <20261125-vcpu_kick-v1-0-a203b01ab957@linux.ibm.com>
In-Reply-To: <20261125-vcpu_kick-v1-0-a203b01ab957@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.comu>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 62tE0ym7dlsHrq1RqQzytJKLA_-fem_S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2NiBTYWx0ZWRfXyG7U6KYUJZJb
 TjEDUx7UlgF6vHX/9qIJmDdZF1SFpfQWhly0Ike0lIr3rMimlmIhA+G0VIidc/csNqIzvxxBWiz
 WD+5G1w5uPWiRTxUrvi8/T5SxaacH90=
X-Proofpoint-GUID: 62tE0ym7dlsHrq1RqQzytJKLA_-fem_S
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b070f16 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=6jl2ing_zu90jmN24vYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2NiBTYWx0ZWRfXwbUXobTjJRJF
 QPWb3OYadBO8r8beQeVovQZyNjmLfOsdDQHbeAa34NIvhsGsIoXbly8YahII4G5mPitDc1HVLxN
 +QP1r8ryqW3BkgkbivEH2Kq4LLOeau0SHldQFXzK8u8rb/IeMLdcCSbOd6UtPANETdBK0QIAsmf
 HqZHs4CXtLpJApEDZ4oK9BldTkgtUE0p2DGMz+tUmhzGNbzuODiG9booHtabhmcniCjYLe0E31k
 84aopfjDglkSVddLgG2wT+wKhtMo9xesnEBrpfK7BIF320aik8CDyD/MdzB1FLAu575SG5UpaXc
 uYa9sItNC2+DTakIlY29w58/ytwVRg+pVlVRb2O3MPe3q25HokZdi1I0K6a9Dei12t5dmmHT4f5
 j3qAYA7QQ/3V5SaOzxi+xmWV42vwokvbALVhAT2KDRw1ucnOfZKFzhQDE7hAOIjl9jXUPVQSRai
 h2XZB2yS11r2eoVr33A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250066

Drop the #ifndef CONFIG_S390 around __kvm_vcpu_kick() and its inline
wrappers so that arm on s390 can use the vCPU kick infrastructure.

Commit 0266c894b51c ("KVM: put back #ifndef CONFIG_S390 around
kvm_vcpu_kick") added the guard around the kick itself for exactly one
reason: kvm_vcpu_kick() calls smp_send_reschedule(), which s390 did not
export, and so the s390 KVM module failed to link.

KVM for arm64 guests on s390 builds on the shared arm64 KVM code, which
relies on the generic kick infrastructure. s390 will have a user for the
kick infrastructure. Let's activate it.

Native KVM/s390 is unaffected by the guards going away. It keeps its own
wakeup and request paths and gains no callers of the generic kick.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 include/linux/kvm_host.h | 4 ----
 virt/kvm/kvm_main.c      | 2 --
 2 files changed, 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index fe300a22ab0f..aaade63f1b5a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1590,14 +1590,12 @@ void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu);
 
-#ifndef CONFIG_S390
 void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, int request, bool force);
 
 static inline void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 {
 	__kvm_vcpu_kick(vcpu, 0, false);
 }
-#endif
 
 int kvm_vcpu_yield_to(struct kvm_vcpu *target);
 void kvm_vcpu_on_spin(struct kvm_vcpu *vcpu, bool yield_to_kernel_mode);
@@ -2331,13 +2329,11 @@ static __always_inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
 	__kvm_make_request(req, vcpu);
 }
 
-#ifndef CONFIG_S390
 static inline void kvm_make_request_and_kick(int req, struct kvm_vcpu *vcpu)
 {
 	kvm_make_request(req, vcpu);
 	__kvm_vcpu_kick(vcpu, req, false);
 }
-#endif
 
 static inline bool kvm_request_pending(struct kvm_vcpu *vcpu)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 83e727bf6452..f2499f809fdc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3903,7 +3903,6 @@ bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_wake_up);
 
-#ifndef CONFIG_S390
 /*
  * Kick a sleeping VCPU, or a guest VCPU in guest mode, into host kernel mode.
  */
@@ -3959,7 +3958,6 @@ void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, int req, bool force)
 	put_cpu();
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_vcpu_kick);
-#endif /* !CONFIG_S390 */
 
 int kvm_vcpu_yield_to(struct kvm_vcpu *target)
 {

-- 
2.56.1


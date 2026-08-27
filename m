Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6B485CED;
	Thu, 27 Aug 2026 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845992; cv=none; b=Tzc2r6lDwuibMot1MJWbmbk7gJOZTYQf7h7kN1y8I+kCN95fN5xuY32/kwnT5bTKocUPG8vmU32a8oH4ZqD1uUtdfvLKFxxGwcyQMudVVCcngjHW7WkfwX5aQfrQKilXBdas0E3V7rInqP87Y9itmxhUN8YK2q/CA0Ud9JB4/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845992; c=relaxed/simple;
	bh=P/LmN4MM+6R98D0Tq3Ow3CDbAM9lxiRlHAosyGNhDus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADaKoFmn+tHmvLTSVV3O7ZYBo999dyfEaxd8BVZGzoxvfOgzu5R8zUdxUeB+x+//2npRfg8dRQNtFYBXqTqO/iC2P5ID3yCXhKRMlLsL2xmUcV1adtddVFrF6Ht4G2HXye3MpBnm3rrESsEFFDNiEnCMx59zP+rneoStR2IQ6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hLqUFtfu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hLqUFtfu"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF57lB1478387;
	Thu, 27 Aug 2026 15:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t9Kmck
	FuF+objL/wtH7yWdv0YdU5IY10M1oq9Rshquo=; b=hLqUFtfubxA/RyCFinroNK
	SEay7kYmwsn112/SDhzI+dv7EV9sexH9TRJPqLzFck7nts9645b72fhlrHLRsL+N
	tKWII2ley1gO+D8h9Eyzi22WKprZ0iZxtIVQLwxJOblaXuq/P/8E/hhI++k1zCst
	qorS3Ro997No6aCkjPMrzP0FdfMmFDS5Nc7xil5u9oDOrLnzOQqHA5ycPAi5K58h
	bNsvRVK120+d21zwFKz3xA2NsFTzKEUhQrMAva31sp7uAFi0CySix2WMPi99dupS
	Pe9kGPJi0hPdco1E3rjvt9mx3nYY9ANksnLHjxpqd7JGgNSjJhB1P4P/deWEh/ng
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er6b8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFflH6006069;
	Thu, 27 Aug 2026 15:53:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragrqtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFr28431195494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:53:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F358E20043;
	Thu, 27 Aug 2026 15:53:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44DAC20040;
	Thu, 27 Aug 2026 15:53:01 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:53:01 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:50 +0200
Subject: [PATCH v6 10/21] KVM: s390: vsie: Refactor kvm_s390_vsie_destroy
 and extract reusable methods
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-10-8020bb53be52@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3615;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=P/LmN4MM+6R98D0Tq3Ow3CDbAM9lxiRlHAosyGNhDus=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYoN7Gj6W3i3x31uT9lV6Wtumkhl1VnpKS1YnvFq4Q
 mz1atkNHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAExEdh7D/1DLgooztZMd3fY2
 LN36L0N3ad7jmWJv/pZayd/QnJ5pvIfhN5vjB/51hW+KudJX7jsgLM6ReXGX/cMLJ1rVfs7+dv/
 UFwYA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ZGVF2txUlvoaNyYjBF3DHGt2B8TLBfgW
X-Proofpoint-ORIG-GUID: Qm6aSI6R2yWzsLFR0QEW9SewiUwc7ju_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX2S0QbGnPfh1Z
 xUT9Og/kVAYl2t9+EgwOKIv7JDWBfP/LkJB8/zDe74TJttyGNhcKrZ5pgJwAcHcMVrkxESUE96h
 0zpkksByz0M2M7lRFhenW+B+/fyqMITn6HL8I2z6oqMfNq9LQMwbswHbXWRYHaJFPZog/BOQdrh
 gPWsi+ilJMMg0rVBMY2Q9kyD9717A+pkAnpejQMKmw9xSu/M6DO5bprIzo/avewhJAt9GbCtHfl
 y1V8b7j6fzeza08hb1DktrbsnW4b2Me/bVKr0XohOnGKG3hj3UjFbZkKTavgDeYK6QVaYE11n/W
 W0MmmQUAeQaRPdh/1gu4gEgX8FKKcYf9IcHPneuZe+PhF7jhUTE9Gkzl89anGnenlRLhT5mUP3j
 VDgtGqbW6AJMChDr1AHFtW5N2h6InCEej0CDzDP6tfl/bLIEZUQ/BvqNUe0eNWmiCwOwN2dAFLF
 89iXwsqDweGgLjh3r+g==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a905d63 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=C3qc6nhzasBXDdIxPSYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX63pTFLvbagD/
 tuJALLaon8aZpVnDEIhCfMqTbcn3F9OLrMTIvwkl7A07k2ofmGwbPGnEl8onB5IL9fCyKyNH32I
 0LiJiUXKrVgQpvENgkAQJGo4V1TJFBI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

Create a helper method release_gmap_shadow_safe() to simplify releasing
the gmap shadow of a vsie_page and a method kvm_s390_vsie_destroy_page()
reduce nesting.
Both methods will be called from multiple places in upcoming patches.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 75676f493ab2..78d59fc535f7 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -164,6 +164,17 @@ static void release_gmap_shadow(struct vsie_page *vsie_page)
 	}
 }
 
+static void release_gmap_shadow_safe(struct kvm *kvm, struct vsie_page *vsie_page)
+{
+	if (!vsie_page->gmap_cache.gmap)
+		return;
+
+	guard(spinlock)(&kvm->arch.gmap->children_lock);
+
+	if (vsie_page->gmap_cache.gmap)
+		release_gmap_shadow(vsie_page);
+}
+
 static struct gmap *acquire_gmap_shadow(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	union ctlreg0 cr0;
@@ -751,13 +762,13 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 }
 
 /* unpin the scb provided by guest 2, marking it as dirty */
-static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+static void unpin_scb(struct kvm *kvm, struct vsie_page *vsie_page,
 		      gpa_t gpa)
 {
 	hpa_t hpa = virt_to_phys(vsie_page->scb_o);
 
 	if (hpa)
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		unpin_guest_page(kvm, gpa, hpa);
 	vsie_page->scb_o = NULL;
 }
 
@@ -1585,11 +1596,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	mutex_unlock(&kvm->arch.vsie.mutex);
 
 	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
-	if (vsie_page->gmap_cache.gmap) {
-		scoped_guard(spinlock, &kvm->arch.gmap->children_lock)
-			if (vsie_page->gmap_cache.gmap)
-				release_gmap_shadow(vsie_page);
-	}
+	release_gmap_shadow_safe(kvm, vsie_page);
 	prefix_unmapped(vsie_page);
 	vsie_page->fault_addr = 0;
 	vsie_page->scb_s.ihcpu = 0xffffU;
@@ -1644,7 +1651,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 out_unshadow:
 	unshadow_scb(vcpu, vsie_page);
 out_unpin_scb:
-	unpin_scb(vcpu, vsie_page, scb_addr);
+	unpin_scb(vcpu->kvm, vsie_page, scb_addr);
 out_put:
 	put_vsie_page(vsie_page);
 
@@ -1658,24 +1665,29 @@ void kvm_s390_vsie_init(struct kvm *kvm)
 	xa_init_flags(&kvm->arch.vsie.addr_to_page, XA_FLAGS_ACCOUNT);
 }
 
+static void kvm_s390_vsie_destroy_page(struct kvm *kvm, struct vsie_page *vsie_page)
+{
+	unpin_scb(kvm, vsie_page, vsie_page->scb_gpa);
+	release_gmap_shadow_safe(kvm, vsie_page);
+	free_vsie_page(vsie_page);
+}
+
 /* Destroy the vsie data structures. To be called when a vm is destroyed. */
 void kvm_s390_vsie_destroy(struct kvm *kvm)
 {
 	struct vsie_page *vsie_page;
 	int i;
 
-	mutex_lock(&kvm->arch.vsie.mutex);
+	guard(mutex)(&kvm->arch.vsie.mutex);
+
 	for (i = 0; i < kvm->arch.vsie.page_count; i++) {
 		vsie_page = kvm->arch.vsie.pages[i];
-		scoped_guard(spinlock, &kvm->arch.gmap->children_lock)
-			if (vsie_page->gmap_cache.gmap)
-				release_gmap_shadow(vsie_page);
 		kvm->arch.vsie.pages[i] = NULL;
-		free_vsie_page(vsie_page);
+		kvm_s390_vsie_destroy_page(kvm, vsie_page);
 	}
-	xa_destroy(&kvm->arch.vsie.addr_to_page);
+
 	kvm->arch.vsie.page_count = 0;
-	mutex_unlock(&kvm->arch.vsie.mutex);
+	xa_destroy(&kvm->arch.vsie.addr_to_page);
 }
 
 void kvm_s390_vsie_kick(struct kvm_vcpu *vcpu)

-- 
2.55.0


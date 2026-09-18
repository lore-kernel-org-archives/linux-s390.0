Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F750128B;
	Fri, 18 Sep 2026 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744184; cv=none; b=kM6bCMq0gikNwyGodLLczaILpiUiVNjC5wM0n2ZCn1FRi5Xe+aoFrhRVIAPp6dB3d5HfICOce1vTYnzKhgi5sqzXS9n0TlDj4lJpmj4eTa/dO7lk6+bkDXZMZTUUCfA/4xWsrx5omrBnZbVqjPyZtfmvRLJBhCG/s1xxeIcjeL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744184; c=relaxed/simple;
	bh=P/LmN4MM+6R98D0Tq3Ow3CDbAM9lxiRlHAosyGNhDus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZb2fF5EeTuC8p8wSoZR1+ew2v7QYiLgktOuyIkWlxnQtmQ97S/vWs9YFDj6SqjhOw/bLl9D71K7fKyJPDxKvBPjz2GmmFFv6igKXeHGRAYviM3yPwTTDgbZKEWsPYoQAiA4pQAo0hi4fSOEYFyzpGZjHcMeda2y4dRBjT1U5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MtwUB1Ob; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MtwUB1Ob"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVcpM1421254;
	Fri, 18 Sep 2026 15:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t9Kmck
	FuF+objL/wtH7yWdv0YdU5IY10M1oq9Rshquo=; b=MtwUB1ObhdTvyJvtSqfCfa
	4t/E09iWAU4ZodO3SOjqRU7lFL/gckn7AnuMATKr8TFpqlWETIjApm4ZLj5hdvP+
	5yDvcCbXqN4xPrMYGAogJ6AKBUc0n+aP+oNE92AvhsX2pTPfGV6uW63VU1Gq10Az
	UXjpaHtncgJO0ib2CXcNIDBU7hBbb+ZLICGlKdtGDDTNcrVSJdaOminzGgn06aqT
	PDDAagYV5429+97gFUdMZ2iaVbjGecjwDPRHHRg0+vy/lmp7WUOu6XZA5hgm+S6S
	moSHYW/RovXXDUbvpGyVTUHcUE6MbqxXjbW7TwqnXtFw00+aDvzP3WFVWe6Ju9/A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvg4vg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNqk6722677;
	Fri, 18 Sep 2026 15:09:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjqv7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9TWw42008882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A39220040;
	Fri, 18 Sep 2026 15:09:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A2B820043;
	Fri, 18 Sep 2026 15:09:28 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:28 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:27 +0200
Subject: [PATCH v7 10/21] KVM: s390: vsie: Refactor kvm_s390_vsie_destroy
 and extract reusable methods
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-10-f39806eaae37@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3615;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=P/LmN4MM+6R98D0Tq3Ow3CDbAM9lxiRlHAosyGNhDus=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQxQ92mLEZNVZDGfmT2r1TWuX9n386tDvn7MCo5/ku
 Ckf99jcUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwERSNRkZtviXF2z8tVto5Qv7
 pCWT3J6JvdnfVN628YP+r5fnr8ayPGX4n7mbc/vKv+JZdqaOAjFFieVBz6z7/syv3a5zha18eTI
 3FwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX1IamUl/pQjgC
 nI3sOUs6DHD4W4+/ubUy9CVk1vEu37qOWAP4g0+nmYu7XMm4dzsSJ8xlLgSoENcT9eiNEMuGn5d
 19ajo2hqPqObFfiwkRouDlxJiolA2JM=
X-Proofpoint-ORIG-GUID: lKt93g8Q9vLdHcJwYNJk4O7hbrAx75dK
X-Proofpoint-GUID: g2C2I7fjulkwFCbmPZuqHZI9W8uoEPPU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX5WuUwLwC/Bw6
 SesOkpAThBbsRZZJbQcwHVZTe85GELTmaVx92I7IK2rOUBa/gcevJj2SekLdihV5pYN1jF9J0xv
 RPhprz6qF562tUPelMHCi9IVbfh/mbZ38Ka8TUCVYJWbXwsFVuyxNSnq8g6psT/D17a4H4g/2Ez
 bhGjSlcDn0MfkyY6F49Xb75J58hgTOmQks+AJWFhv4L4JHmMlnGqCgd71M7FQYPWE+KqLXDB2MH
 HrjrhQnZWso+DnaRNbVS9whiLgdYk2bCix5wUJZyEaBZ1K77CIr/UGvT1QFYxnQ//KWr/sUc24M
 nINcazgEpx7hQIO9uOXxW+3U5gOEGTbLC8rJ/d3HuC6qTCGpNBLLPM4oUCGKGV4P/D7VHzoD5fI
 37ynygXfzs0qauKS3OsIw4Hj+YmmsjwhKM8RkL0/wlbIiXETsgnfwLS3TfQDjzq2vLRlj5vcWop
 yy1+ZYsGjuB8GU8+Hzw==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad542d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=C3qc6nhzasBXDdIxPSYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180214

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


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166403655C9;
	Thu,  9 Jul 2026 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610137; cv=none; b=GOp5POU4vYfFx+MGrNaqOzsiu0j+exd07QwBuQUMQ6jHdQ9irAP7WR4B4aOmfHkneqs9HltY5ezR0fr42MA5dltCcQnxuetc7XjO9XMRP3etWQ31VYoxosiJ5ZgzbFa7bGT9FCLJfRyAQBC/PGpvHabFqBWVUrXB5XDjasWKx1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610137; c=relaxed/simple;
	bh=JweEI5MCE3bleAabS0uIVsYHqkz6jWVTRb1Hsry+izc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S1mCjxkFXjEaXaohimHgjzD3j0K5cIZg9iCXw+d2KFhNb3y6h+zvO+6iHJUxVUs7CTPjL/meKKFkMycPKlnOCW0P0bW8kBTz0Gads4okU4qXVyUMLc/RfyEBug+hjp6N7Q1VK0kVB/v5+LTpqxs0C2H3U6xSArzUUiROGePv9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AufQKLAN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AufQKLAN"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIWNd2171600;
	Thu, 9 Jul 2026 15:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OKsf6w
	2iwyA3w4yyMrwb59pfVn66lVlhM556ybWi41I=; b=AufQKLANiMJI2sK2Hwp6td
	XncECYaMEiapN+UMUwbohEg0i1Nt9Zc5X3jgDZTB9+58JdK9bPdbqJp+WMYvTLXI
	BlB8uQJmH4lBdPnAaBgt2AwVph285k2dQ47En7d2VNPRMRAbtT+zzt5sm1hZJYgS
	vKLUQUAoaMH1e1zmJpwkfa79SVh4Lt4ZEXZYkAMDb2NJf4FFIWhxlBBbJHMxLkEy
	fWzQVjrYMdjs8xW0NVdECxp4l8u3s+tQA8Cmymed5CULKwHzNvfHbN6o4qQWHlr2
	S+uf7QwzuC70kGDgkqp4YRILCbefpwQTpd/AkYqSx0Nanblc6G6xRX7u4J70mAQw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw52bvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669F4jrY025139;
	Thu, 9 Jul 2026 15:15:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hnk5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFR8131851218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72CAE20040;
	Thu,  9 Jul 2026 15:15:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D15BC20043;
	Thu,  9 Jul 2026 15:15:26 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:26 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:12 +0200
Subject: [PATCH 12/21] KVM: s390: vsie: Replace radix_tree with xarray
 addr_to_page
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-12-ea9f12066408@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3945;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=JweEI5MCE3bleAabS0uIVsYHqkz6jWVTRb1Hsry+izc=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u1ma6y99O3K0ljs9P03M+ILqsljNR/ksp45snLg17
 +5bvn17OkpZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZgI9x2GfzZf2aaJ9v+c6aBy
 UdZ5U+Xy55NUu6753FDp+Jv0dr2RzTSGfwpLZQ1rbHeq9q+oPS7BqbN+vbVQv6fZBV8GuZtZMQo
 7WAE=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9w8BKKL07ucte78JHLy5w4n_ITPjzoBl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXzVf3bQczLhTr
 IwPz/ubJEamwIYfX6/oE+jZYvAzp8MM3q1Aoa+ztriFUXuLIZC4zkyg+HSfgQV1ak8hZnubONq+
 Lg1Uu4XL7fnUx+QMc5D4+vI/FGx+yLBSnLfi6FzQd2shpbrn569HvwaztuLMg4zplfcYA4QtrxP
 L42HZ24WiIfcddLR4Hamsv2/DAhlJ/zziVGWtfns2D2e4EXYG+nxbNDISS1FBD3b0PtTKoe28Gy
 66SPUHwQLvU1nPPrvWDDbfqANjgGmUrxNIWFBls80dqFN1yg7VfN3BlTjxPtNhHe8cjfN2n/cwi
 sIdLsthcIN7DR+nGEcXgF0f2hynepxWCO8KpNelTt72pSYTKMgAOJUGkWV/uxpwvf2zpTRumfYH
 uILxYWRLpZAI+4lpmTNxUBACZSOUqEMZRQ08sq5E9PMddIhFRwp5wESb7CH3kl3ERvTZiion+0s
 RzCqOx1mt7ECbuQ7tkQ==
X-Proofpoint-ORIG-GUID: 9w8BKKL07ucte78JHLy5w4n_ITPjzoBl
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4fbb14 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=OIv39ysXCM8_XdHbMy4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX1Y0xNbwNXBtJ
 nkcARa0IYDa7GdXn0w/Ibarh1KHZmXjNVn062mdktj7xpGmUFycCgLh/S28GhaobGzkVcv7foGB
 0ihIVHRQIbxvDSoIWVMaFYjyVgT22ns=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

The underlying implementation of radix_tree is xarray since v4.20.
Changing to the xarray API directly relaxes some of the locking
obligations and provides more symmetry with the next vsie changes in
the series.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 +-
 arch/s390/kvm/vsie.c             | 36 ++++++++++++++----------------------
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index f10f8940bd48..1439f9496bd0 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -624,7 +624,7 @@ struct vsie_page;
 
 struct kvm_s390_vsie {
 	struct mutex mutex;
-	struct radix_tree_root addr_to_page;
+	struct xarray addr_to_page;
 	int page_count;
 	int next;
 	struct vsie_page *pages[KVM_MAX_VCPUS];
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 4090b4019f21..1734215ae73a 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -59,8 +59,7 @@ struct vsie_page {
 	gpa_t sdnx_gpa;				/* 0x0250 */
 	/*
 	 * guest address of the original SCB. Remains set for free vsie
-	 * pages, so we can properly look them up in our addr_to_page
-	 * radix tree.
+	 * pages, so we can properly look them up in our addr_to_page map.
 	 */
 	gpa_t scb_gpa;				/* 0x0258 */
 	/* the shadow gmap in use by the vsie_page */
@@ -1533,19 +1532,15 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	struct vsie_page *vsie_page;
 	int nr_vcpus;
 
-	rcu_read_lock();
-	vsie_page = radix_tree_lookup(&kvm->arch.vsie.addr_to_page, addr >> 9);
-	rcu_read_unlock();
-	if (vsie_page) {
-		if (try_get_vsie_page(vsie_page)) {
-			if (vsie_page->scb_gpa == addr)
-				return vsie_page;
-			/*
-			 * We raced with someone reusing + putting this vsie
-			 * page before we grabbed it.
-			 */
-			put_vsie_page(vsie_page);
-		}
+	vsie_page = xa_load(&kvm->arch.vsie.addr_to_page, addr >> 9);
+	if (vsie_page && try_get_vsie_page(vsie_page)) {
+		if (vsie_page->scb_gpa == addr)
+			return vsie_page;
+		/*
+		 * We raced with someone reusing + putting this vsie
+		 * page before we grabbed it.
+		 */
+		put_vsie_page(vsie_page);
 	}
 
 	/*
@@ -1574,14 +1569,13 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 			kvm->arch.vsie.next %= nr_vcpus;
 		}
 		if (vsie_page->scb_gpa != ULONG_MAX)
-			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
-					  vsie_page->scb_gpa >> 9);
+			xa_erase(&kvm->arch.vsie.addr_to_page, vsie_page->scb_gpa >> 9);
 		/* Mark it as invalid until it resides in the tree. */
 		vsie_page->scb_gpa = ULONG_MAX;
 	}
 
 	/* Double use of the same address or allocation failure. */
-	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, vsie_page)) {
+	if (xa_store(&kvm->arch.vsie.addr_to_page, addr >> 9, vsie_page, GFP_KERNEL)) {
 		put_vsie_page(vsie_page);
 		mutex_unlock(&kvm->arch.vsie.mutex);
 		return NULL;
@@ -1660,7 +1654,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 void kvm_s390_vsie_init(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.vsie.mutex);
-	INIT_RADIX_TREE(&kvm->arch.vsie.addr_to_page, GFP_KERNEL_ACCOUNT);
+	xa_init_flags(&kvm->arch.vsie.addr_to_page, XA_FLAGS_ALLOC);
 }
 
 /* Destroy the vsie data structures. To be called when a vm is destroyed. */
@@ -1676,10 +1670,8 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 			if (vsie_page->gmap_cache.gmap)
 				release_gmap_shadow(vsie_page);
 		kvm->arch.vsie.pages[i] = NULL;
-		/* free the radix tree entry */
 		if (vsie_page->scb_gpa != ULONG_MAX)
-			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
-					  vsie_page->scb_gpa >> 9);
+			xa_erase(&kvm->arch.vsie.addr_to_page, vsie_page->scb_gpa >> 9);
 		free_vsie_page(vsie_page);
 	}
 	kvm->arch.vsie.page_count = 0;

-- 
2.55.0


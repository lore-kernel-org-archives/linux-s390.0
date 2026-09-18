Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531D4FDA45;
	Fri, 18 Sep 2026 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744193; cv=none; b=umUNahxkSY3VqDXGHveowjbUMTJPBwW2Vor6RHlZEXmt0eZGbXihDdwff37qb70lNIobUBqaZl/wyZxPBUbTkPPP3GsW5tvk/l8GlUSACGrbYGTifoHkCcPU+eevKhsKTARJUOfmzBlapqFiiSwp4lvki0HvSqTu6o2NNKZb+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744193; c=relaxed/simple;
	bh=lNNHVzf554vkZnuGEewJIiO82X2OhAE/2Ul9STgX1Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z16chtOCx31Ldm9Hk1yoBqeK6nb32SSAVeKVXyYF5pAyW0I2mudaMeXdOxui7C2i7s0BzA18oURk9aaIA1+vri0INbVG+7sQd0tXRKXAQ8fC4fBej43RZCj67eUGuodiTT9exjVjAf32SqEa0urAP5M+f/t5UcX5dP7Sb0Ecy9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X56pMa2q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X56pMa2q"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVO903708349;
	Fri, 18 Sep 2026 15:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0brYTj
	etYDtE6UsSi4vhQ+MxhyyPY8AL3sZOSiCsws0=; b=X56pMa2qLBgMAGev81XMxq
	JwCZ4NkZB9NFXIOTY/Yezs31CJu6mZ98PyL2mJ8RVP3ujQP7tl7Cv7NCEOttLNtZ
	H2cS/aJ2fzbertCn+hpXyzr24SnDVKXl5Vg6FUNCzvvXOKQhQxh7s19HD0/O7XJt
	PgCWqpW8m9vP5zahzdjFvAojGMVX1Utrogv93QMcDSvTby3yQyYSSGFFgA4bNsrr
	mHSDJkh/QXcA0pxR6c9TuM+MG8rNyP9RTF6V22lFle2DNR5HCg9ObDtHqzGBZ+Cg
	6cQrCwPZaWm91D8VCtU352LV7Qg1yC4kbkbVEgoKJuMgDKg3ogfJjAcCZYtHjOYg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqrsqb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNt5C1684373;
	Fri, 18 Sep 2026 15:09:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gs4tv8pv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9UfR46334384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7A2320040;
	Fri, 18 Sep 2026 15:09:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 270D12004B;
	Fri, 18 Sep 2026 15:09:30 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:30 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:30 +0200
Subject: [PATCH v7 13/21] KVM: s390: vsie: Lazily keep original scb pinned
 after vsie exit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-13-f39806eaae37@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9374;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=lNNHVzf554vkZnuGEewJIiO82X2OhAE/2Ul9STgX1Fk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQ5Tyeiyn78v+yXpAyuNvgX9b4KUtYXIXX39zWPr8N
 kP0pZwDHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzELo2R4cupvb7m+c2fD/6x
 unjkcoJg3QEXodVOLFsd3/ySd/vDpMTwhy8p4kjXSuFfBUru227ZL/y7KUjww4VPhfZLrTnYLJa
 5cAAA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX+5Q0o4Xuy25X
 38yxprJhAtJhK3MKMJ2KxIYTIsNxq/M4W8XGUT9TN9iWzTd9Qm1jW5LbptSAC4bJgKBsibJac5w
 TrqxmrI8M6c4KshQIP36aIGhu9wokQSCYIBaVDj9T4xifo/ic/y/YY0rLMr2kuir/FyXeYckT1k
 ZNFHo/I6Q6HZnRsf0GfsuAFFaxGyh7F9JpuexD98bfpheYyxXow2TVFsgZG6LL7sW85QipRtIjL
 svDc3srU1UgvgjBXbcjAITNxrQeFFJRZj4iUdetGHNUt1nafoCu05saICk+sfC5+spLqwIC5mTd
 P33Jhr5+2lZv6eg0FIH/sG33W1K6vKULthlZ4ZqCQ4mIkQ3mTmYYvHNd04Moffbqahr/ObMf0a2
 pnw6FjCysQHVk1eBuy/V6/7xVtGkAACwmHTKZPO8B3Fd4AnH4PXjTM3jB0hS319aau2QTsg8LkC
 3Q03Kd6caP9UmRdUBZw==
X-Proofpoint-GUID: t6_subKXkyYb5KXdb56Fdm8kyZQ0GeA2
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aad542f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=qz25wtrU6i-00Mf3T4MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iw_xzi3YKpgCIN9rf6GtScIhQPv7Ujmn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX84eHwDNcFM75
 XLYKqesfWOeRH85IqWgMHGInq+lo5E3GNNBjGHC99GxuzwO2UYEn475BaewLmFQApxROWpWwmsv
 hlzXpIuvFbvweUoBZ1ODWWyWF439ZjY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180214

Keep the original SIE control block (SCB) pinned and only lazily unpin
it on reuse of the vsie_page for a different SCB.

- Pinned pages are tracked and will be unpinned on VM destruction
- Memory pressure is not significantly impacted as the number of
  pinned SCBs is bounded by the number of vCPUs
- Reuse detection ensures stale pins are released when needed

{,un}pin_scb() methods are extended to track the pin status in the
vsie_page->flags.
A new vsie_page_init() method is created to allow reuse for common tasks
in following patches.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 160 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 111 insertions(+), 49 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index c42e2df4c0ab..1b88470efd4a 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -29,6 +29,7 @@
 
 enum vsie_page_flags {
 	VSIE_PAGE_IN_USE = 0,
+	VSIE_PAGE_SCB_PINNED = 1,
 };
 
 struct vsie_page {
@@ -774,14 +775,18 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 }
 
 /* unpin the scb provided by guest 2, marking it as dirty */
-static void unpin_scb(struct kvm *kvm, struct vsie_page *vsie_page,
-		      gpa_t gpa)
+static void unpin_scb(struct kvm *kvm, struct vsie_page *vsie_page)
 {
-	hpa_t hpa = virt_to_phys(vsie_page->scb_o);
+	hpa_t hpa;
+
+	if (!test_bit(VSIE_PAGE_SCB_PINNED, &vsie_page->flags))
+		return;
 
+	hpa = virt_to_phys(vsie_page->scb_o);
 	if (hpa)
-		unpin_guest_page(kvm, gpa, hpa);
+		unpin_guest_page(kvm, vsie_page->scb_gpa, hpa);
 	vsie_page->scb_o = NULL;
+	clear_bit(VSIE_PAGE_SCB_PINNED, &vsie_page->flags);
 }
 
 /*
@@ -790,19 +795,22 @@ static void unpin_scb(struct kvm *kvm, struct vsie_page *vsie_page,
  * Returns: - 0 if the scb was pinned.
  *          - > 0 if control has to be given to guest 2
  */
-static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
-		   gpa_t gpa)
+static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	hpa_t hpa;
 	int rc;
 
-	rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
+	if (test_bit(VSIE_PAGE_SCB_PINNED, &vsie_page->flags))
+		return 0;
+
+	rc = pin_guest_page(vcpu->kvm, vsie_page->scb_gpa, &hpa);
 	if (rc) {
 		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		WARN_ON_ONCE(rc);
 		return 1;
 	}
 	vsie_page->scb_o = phys_to_virt(hpa);
+	set_bit(VSIE_PAGE_SCB_PINNED, &vsie_page->flags);
 	return 0;
 }
 
@@ -1542,6 +1550,22 @@ static struct vsie_page *alloc_vsie_page(struct kvm *kvm)
 	return vsie_page;
 }
 
+static int init_vsie_page(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, unsigned long scb_gpa)
+{
+	int rc;
+
+	vsie_page->scb_gpa = scb_gpa;
+	rc = pin_scb(vcpu, vsie_page);
+	if (rc) {
+		vsie_page->scb_gpa = ULONG_MAX;
+		return rc;
+	}
+
+	vsie_page->sca_gpa = read_scao(vcpu->kvm, vsie_page->scb_o);
+
+	return 0;
+}
+
 /* Reset shadow state after a vsie_page has been (re)initialised for a new SCB. */
 static void reset_vsie_page(struct kvm *kvm, struct vsie_page *vsie_page)
 {
@@ -1555,19 +1579,28 @@ static void reset_vsie_page(struct kvm *kvm, struct vsie_page *vsie_page)
 /*
  * Get or create a vsie page for a scb address.
  *
- * Returns: - address of a vsie page (cached or new one)
- *          - NULL if the same scb address is already used by another VCPU
- *          - ERR_PTR(-ENOMEM) if out of memory
+ * Original control blocks are pinned when the vsie_page pointing to them is
+ * returned.
+ * Newly created vsie_pages only have vsie_page->scb_gpa and vsie_page->sca_gpa
+ * set.
+ *
+ * Returns: - -EBUSY if the same scb address is already used by another VCPU
+ *          - -ENOMEM if out of memory
  */
-static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
+static int get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr,
+			 struct vsie_page **vsie_page_out)
 {
-	struct vsie_page *vsie_page;
-	int nr_vcpus;
+	struct vsie_page *vsie_page, *vsie_page_new = NULL;
+	struct kvm *kvm = vcpu->kvm;
+	unsigned int max_vsie_page;
+	int rc, pages_idx;
 
 	vsie_page = xa_load(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT);
 	if (vsie_page && try_get_vsie_page(vsie_page)) {
-		if (vsie_page->scb_gpa == addr)
-			return vsie_page;
+		if (vsie_page->scb_gpa == addr) {
+			*vsie_page_out = vsie_page;
+			return 0;
+		}
 		/*
 		 * We raced with someone reusing + putting this vsie
 		 * page before we grabbed it.
@@ -1575,51 +1608,80 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 		put_vsie_page(vsie_page);
 	}
 
-	/*
-	 * We want at least #online_vcpus shadows, so every VCPU can execute
-	 * the VSIE in parallel.
-	 */
-	nr_vcpus = atomic_read(&kvm->online_vcpus);
+	max_vsie_page = atomic_read(&kvm->online_vcpus);
+
+	/* allocate new vsie_page - we will likely need it */
+	if (kvm->arch.vsie.page_count < max_vsie_page) {
+		vsie_page_new = alloc_vsie_page(kvm);
+		if (!vsie_page_new)
+			return -ENOMEM;
+		__set_bit(VSIE_PAGE_IN_USE, &vsie_page_new->flags);
+	}
 
 	mutex_lock(&kvm->arch.vsie.mutex);
-	if (kvm->arch.vsie.page_count < nr_vcpus) {
-		vsie_page = alloc_vsie_page(kvm);
-		if (!vsie_page) {
+	vsie_page = xa_load(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT);
+	if (vsie_page && try_get_vsie_page(vsie_page)) {
+		if (vsie_page->scb_gpa == addr) {
 			mutex_unlock(&kvm->arch.vsie.mutex);
-			return ERR_PTR(-ENOMEM);
+			if (vsie_page_new)
+				free_vsie_page(vsie_page_new);
+			*vsie_page_out = vsie_page;
+			return 0;
 		}
-		__set_bit(VSIE_PAGE_IN_USE, &vsie_page->flags);
-		kvm->arch.vsie.pages[kvm->arch.vsie.page_count] = vsie_page;
+		/*
+		 * We raced with someone reusing + putting this vsie
+		 * page before we grabbed it.
+		 */
+		put_vsie_page(vsie_page);
+	}
+
+	if (kvm->arch.vsie.page_count < max_vsie_page) {
+		pages_idx = kvm->arch.vsie.page_count;
+		vsie_page = vsie_page_new;
+		vsie_page_new = NULL;
+		WRITE_ONCE(kvm->arch.vsie.pages[kvm->arch.vsie.page_count], vsie_page);
 		kvm->arch.vsie.page_count++;
 	} else {
 		/* reuse an existing entry that belongs to nobody */
 		while (true) {
-			vsie_page = kvm->arch.vsie.pages[kvm->arch.vsie.next];
+			pages_idx = kvm->arch.vsie.next;
+			kvm->arch.vsie.next++;
+			kvm->arch.vsie.next %= kvm->arch.vsie.page_count;
+			vsie_page = kvm->arch.vsie.pages[pages_idx];
 			if (try_get_vsie_page(vsie_page))
 				break;
-			kvm->arch.vsie.next++;
-			kvm->arch.vsie.next %= nr_vcpus;
 		}
 		if (vsie_page->scb_gpa != ULONG_MAX)
 			xa_erase(&kvm->arch.vsie.addr_to_page,
 				 vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
+
+		unpin_scb(kvm, vsie_page);
 		/* Mark it as invalid until it resides in the tree. */
 		vsie_page->scb_gpa = ULONG_MAX;
 	}
 
-	/* Double use of the same address or allocation failure. */
-	if (xa_insert(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT, vsie_page,
-		      GFP_KERNEL_ACCOUNT)) {
-		put_vsie_page(vsie_page);
-		mutex_unlock(&kvm->arch.vsie.mutex);
-		return NULL;
+	rc = init_vsie_page(vcpu, vsie_page, addr);
+	if (!rc) {
+		rc = xa_insert(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT, vsie_page,
+			       GFP_KERNEL_ACCOUNT);
+		if (rc == -EBUSY)
+			rc = -EAGAIN;
 	}
-	vsie_page->scb_gpa = addr;
+
 	mutex_unlock(&kvm->arch.vsie.mutex);
+	if (vsie_page_new)
+		free_vsie_page(vsie_page_new);
+	if (rc) {
+		unpin_scb(kvm, vsie_page);
+		vsie_page->scb_gpa = ULONG_MAX;
+		put_vsie_page(vsie_page);
+		return rc;
+	}
 
 	reset_vsie_page(kvm, vsie_page);
 
-	return vsie_page;
+	*vsie_page_out = vsie_page;
+	return 0;
 }
 
 int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
@@ -1645,21 +1707,23 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	vsie_page = get_vsie_page(vcpu->kvm, scb_addr);
-	if (IS_ERR(vsie_page)) {
-		return PTR_ERR(vsie_page);
-	} else if (!vsie_page) {
-		/* double use of sie control block - simply do nothing */
-		kvm_s390_rewind_psw(vcpu, 4);
-		return 0;
+	rc = get_vsie_page(vcpu, scb_addr, &vsie_page);
+	if (rc) {
+		if (rc == -EBUSY) {
+			/* double use of sie control block - simply do nothing */
+			kvm_s390_rewind_psw(vcpu, 4);
+			return 0;
+		} else {
+			return PTR_ERR(vsie_page);
+		}
 	}
 
-	rc = pin_scb(vcpu, vsie_page, scb_addr);
+	rc = pin_scb(vcpu, vsie_page);
 	if (rc)
 		goto out_put;
 	rc = shadow_scb(vcpu, vsie_page);
 	if (rc)
-		goto out_unpin_scb;
+		goto out_put;
 	rc = pin_blocks(vcpu, vsie_page);
 	if (rc)
 		goto out_unshadow;
@@ -1669,8 +1733,6 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 	unpin_blocks(vcpu, vsie_page);
 out_unshadow:
 	unshadow_scb(vcpu, vsie_page);
-out_unpin_scb:
-	unpin_scb(vcpu->kvm, vsie_page, scb_addr);
 out_put:
 	put_vsie_page(vsie_page);
 
@@ -1686,7 +1748,7 @@ void kvm_s390_vsie_init(struct kvm *kvm)
 
 static void kvm_s390_vsie_destroy_page(struct kvm *kvm, struct vsie_page *vsie_page)
 {
-	unpin_scb(kvm, vsie_page, vsie_page->scb_gpa);
+	unpin_scb(kvm, vsie_page);
 	release_gmap_shadow_safe(kvm, vsie_page);
 	free_vsie_page(vsie_page);
 }

-- 
2.55.0


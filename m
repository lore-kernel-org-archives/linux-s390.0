Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277744C658;
	Wed, 26 Aug 2026 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756737; cv=none; b=ab3Rk0jjA2lVjfkgKkpsdtKjyfrDIIKpEBm3ob85+13frix/VDf7lfdON8xd6o3smlCMK1HNum58do++UOXIWg/u8l+T62ahspMKJRv9j2QIoBup+5s4jIOCTarxgwI2eEFrla6lmIRP+1nH1XDlnLQ7TEC+U7sEpO0R+WbiRBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756737; c=relaxed/simple;
	bh=BmvisAttc+GMtmKWkjoFiQZh+iKoFnBNK5PviqWkOVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAZZPpxNDYapIHwgF8oGsDNUrzK2n/XvJgAUJcDqGcL3FJbZsEuv1DCfiOvlOMWE8WGitQNav6KyE3FaNaBwJ0x5cw3owhTv41mRGvSm/s8/gsKzGMkH+Wv9TwUWFvndh/GXRKhhbkTs273GrK9kXvUJjK24koOaCpa0npL98eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xn/3D2WZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xn/3D2WZ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1Y3G2333813;
	Wed, 26 Aug 2026 15:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kyOvkM
	gzPPwseHXnaDP6xZoKawlbGGTYH1Y1OyuJrcY=; b=Xn/3D2WZJBitWbh4sT2Wne
	Qsv0VTjXcL+G+r7zF1/a45j1d6TT8cgWMkKM6egb6xdGwBz89rN8egFTfJ79bgZZ
	7EOfBVwteQ2fXTU5apS79glbWUxkQUfEJFvMotbwnFX5xmKnSeEB+AXOEBE/Rc5o
	f4CiAGR9wPv9MjIo2rHXk8PyR4gs1jgRNAakW6M+4cAt9POz7tANNtJm47DTDUSm
	zjr3rQg4DYRVLyAM4G6sBB4nSiIFpMPyzXM1WdX48+R+mJKxUOsMJZRSALLyhZP5
	En1+KAloaF9izk3ZLcl199qbm4Sc4x6UmmZuUnB3qlIvE9Jap1jpPrjhRep2qq8g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqycg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuHD2015599;
	Wed, 26 Aug 2026 15:05:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhagwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5J6K43909480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F16F20040;
	Wed, 26 Aug 2026 15:05:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 687BB20043;
	Wed, 26 Aug 2026 15:05:19 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:19 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:15 +0200
Subject: [PATCH v5 13/21] KVM: s390: vsie: Lazily keep original scb pinned
 after vsie exit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-13-cf471edb46b2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8249;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=BmvisAttc+GMtmKWkjoFiQZh+iKoFnBNK5PviqWkOVk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKvl9rAv9NFe8k1ZNK+UZcWOGw9+XfG7dS046bhYt
 mWk5hvBjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACYybyYjw53ot1/3r58X6n/x
 zf0HS160v9/xaL3rxPraFwEn3HpWWX1lZOjrnRy82Cdl8fwlJrdbdq+Zp/1Zm+OEaaXPf7aA53M
 1NXgA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 451WJapqXaeJYwc5c8-Ixhj06J-V3QhQ
X-Proofpoint-ORIG-GUID: 5p5XsyN0E02N3dFFGuLdmQY7rq_JWT10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX3C/hNxVKNEev
 Jkt9M3XRgTw8/9RIE4PO4NQdoSdKbWJk4FwlKegPA765/1S6JwX43khrOp/l2NmAq5PRgHgGkJi
 uOBO3WiIQzlAMScD5sxaBzanzf/hVvOOiOXej6ewiKISnVVTuTI2KijcuYja+lSlBKZzjhMoo4o
 ospk8ddigu2yOfLo+RKrg+sYiHdOellMT6c/fMgT5CuEutQicU5eTc5yjorytetQZ2M25WSbb+i
 HPlTMZzE6fvW3V3AP+/yZx54DHx+TCFt/DCqtUcCkC4tXUSZiiHOuJbXTCJ93Li7y67D9JynLx5
 /jKUnqkFcPNP5vz7CPaRrZku3Tu+P+2osvOCM8Ar9vcX4GadYeDFDR0P9dmBoRmugl50ubDB4ZT
 kDYQvJltICOJfjiXfensNPH8w5kkFuSTGrrAd5Mie8DrLoFSyd6DuBeqH0tZgCGjndzs0HN939m
 DLgqPz0bzaj5TooE3EQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f00b5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=hGNzB2WuafbODkyvo-kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX+OTFHr/d5lIr
 Dzsyvkg7ZqJxFm3vnNRKfefEpNR6mUoNgaXbIw/9m5My+zS2ZwI4lv1ARW7yZj2rznMXS92cgxB
 8lJyFUivc9IpdyqiQVJUP/skFYR8UpE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

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
 arch/s390/kvm/s390/vsie.c | 129 +++++++++++++++++++++++++++++++---------------
 1 file changed, 88 insertions(+), 41 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 988370f491bf..24af48af89cd 100644
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
-static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
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
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		unpin_guest_page(kvm, vsie_page->scb_gpa, hpa);
 	vsie_page->scb_o = NULL;
+	clear_bit(VSIE_PAGE_SCB_PINNED, &vsie_page->flags);
 }
 
 /*
@@ -790,19 +795,22 @@ static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
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
@@ -1555,14 +1579,21 @@ static void reset_vsie_page(struct kvm *kvm, struct vsie_page *vsie_page)
 /*
  * Get or create a vsie page for a scb address.
  *
+ * Original control blocks are pinned when the vsie_page pointing to them is
+ * returned.
+ * Newly created vsie_pages only have vsie_page->scb_gpa and vsie_page->sca_gpa
+ * set.
+ *
  * Returns: - address of a vsie page (cached or new one)
  *          - NULL if the same scb address is already used by another VCPU
  *          - ERR_PTR(-ENOMEM) if out of memory
  */
-static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
+static struct vsie_page *get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr)
 {
-	struct vsie_page *vsie_page;
-	int nr_vcpus;
+	struct vsie_page *vsie_page, *vsie_page_new = NULL;
+	struct kvm *kvm = vcpu->kvm;
+	unsigned int max_vsie_page;
+	int rc, pages_idx;
 
 	vsie_page = xa_load(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT);
 	if (vsie_page && try_get_vsie_page(vsie_page)) {
@@ -1575,47 +1606,65 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
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
+			return ERR_PTR(-ENOMEM);
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
+			return vsie_page;
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
-		if (vsie_page->scb_gpa != ULONG_MAX)
-			xa_erase(&kvm->arch.vsie.addr_to_page,
-				 vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
-		/* Mark it as invalid until it resides in the tree. */
-		vsie_page->scb_gpa = ULONG_MAX;
+
+		unpin_scb(kvm, vsie_page);
 	}
 
-	/* Double use of the same address or allocation failure. */
-	if (xa_insert(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT, vsie_page,
-		      GFP_KERNEL_ACCOUNT)) {
+	rc = init_vsie_page(vcpu, vsie_page, addr);
+	if (!rc)
+		xa_store(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT, vsie_page,
+			 GFP_KERNEL_ACCOUNT);
+
+	mutex_unlock(&kvm->arch.vsie.mutex);
+	if (vsie_page_new)
+		free_vsie_page(vsie_page_new);
+	if (rc) {
+		vsie_page->scb_gpa = ULONG_MAX;
 		put_vsie_page(vsie_page);
-		mutex_unlock(&kvm->arch.vsie.mutex);
-		return NULL;
+		return rc < 0 ? ERR_PTR(rc) : NULL;
 	}
-	vsie_page->scb_gpa = addr;
-	mutex_unlock(&kvm->arch.vsie.mutex);
 
 	reset_vsie_page(kvm, vsie_page);
 
@@ -1645,7 +1694,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	vsie_page = get_vsie_page(vcpu->kvm, scb_addr);
+	vsie_page = get_vsie_page(vcpu, scb_addr);
 	if (IS_ERR(vsie_page)) {
 		return PTR_ERR(vsie_page);
 	} else if (!vsie_page) {
@@ -1654,12 +1703,12 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 		return 0;
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
@@ -1669,8 +1718,6 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 	unpin_blocks(vcpu, vsie_page);
 out_unshadow:
 	unshadow_scb(vcpu, vsie_page);
-out_unpin_scb:
-	unpin_scb(vcpu, vsie_page, scb_addr);
 out_put:
 	put_vsie_page(vsie_page);
 

-- 
2.55.0


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C0A471276;
	Thu, 27 Aug 2026 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845998; cv=none; b=GcmsLqhCnCD8TXsEfmZNr9Jt28T1X6PSiIpWGf9gOW7BlmbjyCYMJpykmeg3hIhK3VlWlzxuTiM2lMIjPV/woYfAyk4dKumGovF5ILMcm95jjBLSPnJBdeKLiakh31LAoAerLsHRvIJbz4+nAbwc+j52qwluk+8Gw7+D05QsuzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845998; c=relaxed/simple;
	bh=oynNC7+7gkk0NhGQFJujb/8CxiBmLBnJJKCHj+eo818=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SszPK4gIDlaT3doT5LN1RfzDPfomh1oYqo3pbRW9e3LTWtHHxlhUsk1xT2uCqhnxJo8fW8UbiHlKd0D7cPXwBEPEJ7AgB0vOjl6YRo7qV9M4tyuWElaLrnuc07SE+V96EUdPI36VAOWp/tYOvxiDCBFJZiOkhgDmqWy+Rgn4Ahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J+NPRlLn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J+NPRlLn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF52Xj3355177;
	Thu, 27 Aug 2026 15:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JdPprJ
	Yyb2aaSsc+A/2SvsrK08aCJDVwM9AxDzZsfj8=; b=J+NPRlLnfG352ZI5mff9oF
	mwQl3GCOQ6IsU/NECtqxR1Bh1YXQf0k0lTqL876h6s+lOZKUuNgqruIlNDYbmNo9
	RbN6rl/9MZGWw1XrcLHA+XyZFVqSYXHBPfP/eK3cun74vTZdHyCDXx+9YEW/O86F
	2c/tjYqD9aVJz/FgJIhV56ywBBUfBM1OnQIJy/jiIPSFjAhOEUI0OdacRhFkmR5N
	uFQPTK/9Ffx4exqnzv6gyAzTUZWlYldBfBpdp25y4vSOkMbyhmpL1VgEItCQOgZH
	zi0gaYDvY83KhSZk112ua/linXKBVT7hd4Uew9shpc1+cUaAUWOIwOC5oEGHBsxA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g56f44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFffmk026747;
	Thu, 27 Aug 2026 15:53:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qh4ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFr4QQ51708368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:53:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 760E32005A;
	Thu, 27 Aug 2026 15:53:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6AC92004F;
	Thu, 27 Aug 2026 15:53:03 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:53:03 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:53 +0200
Subject: [PATCH v6 13/21] KVM: s390: vsie: Lazily keep original scb pinned
 after vsie exit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-13-8020bb53be52@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9343;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=oynNC7+7gkk0NhGQFJujb/8CxiBmLBnJJKCHj+eo818=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYoO/PLwetu31djOD13L57k3BavyX75xKFK8XdAzue
 28b1JXcUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwERu2jD8ZOyf7jxF8IpWK2f1
 WuUYph3lHMss2xbyc3c7uz0QXaB0kpHh8Nw/i1j+2sXI2kXVvV+euGXdn8ul8uW7X/t+OJZmZlv
 KDgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: vwO7zyiDREIyAuc3aALfDvpq02RIBjYU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX3h6dfbQMAp3V
 w67gAxv1CGmU4kpk4MSpne4EV6CiuucTcieE7n2v4WkyKUwZy258Q6zpdbSZKKyNML3UVvcohrq
 Hy8CNBlBsB13OpNZvLcwsY/2l4Ei26Y=
X-Proofpoint-GUID: a7pXgdVE8A8sugmNSuetGVJKiKHtR_xp
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a905d69 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=qz25wtrU6i-00Mf3T4MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX77PKOnXhOXze
 +i6zPd+lCPc/lieFh+jymlVYjcYvorp4bHuCTHy7CAxfmCPkUY8v5WN59ZUJosnhs9o7aclPAq/
 0XWkk3V8r0HSqYaH9aC5aQG05liG0KQf2K8EmskSUVGzXEEM5gy8yKxyDSivj0byJUcYNJ9nAZV
 X3kFTdWAnUSjoFqKk6RQYkpCOH6XY+qDpsUxXZ4pPaF+Qzus4gAcv2YG1HFR2q3KrmcJNbgRvoH
 PM3xp3Uy8HXT/Nh40PGZjSF9RBa2DC29cyIynfrvLTMVZV8E0WMUukRJ4OLhHl0JT2RgV1Ll8nB
 HF4R10GOi9OGUHfbWacRpFotiMtnffFQ22zeE6mISDi2wNF5JxeH72MqNDrxyEww6xB3vosAAwT
 +RRItrAiXh6B13nrTO5oab8swfh0FGpaznfJnXfmVm49f0mHt5jNZGXD/s/j+YVCE0AE+GT/COW
 d+of0jbqBT33y3/zmfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

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
 arch/s390/kvm/s390/vsie.c | 159 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 110 insertions(+), 49 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index c42e2df4c0ab..cdce4b3b2525 100644
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
@@ -1575,51 +1608,79 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
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
 		/* Mark it as invalid until it resides in the tree. */
 		vsie_page->scb_gpa = ULONG_MAX;
+
+		unpin_scb(kvm, vsie_page);
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
@@ -1645,21 +1706,23 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
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
@@ -1669,8 +1732,6 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 	unpin_blocks(vcpu, vsie_page);
 out_unshadow:
 	unshadow_scb(vcpu, vsie_page);
-out_unpin_scb:
-	unpin_scb(vcpu->kvm, vsie_page, scb_addr);
 out_put:
 	put_vsie_page(vsie_page);
 
@@ -1686,7 +1747,7 @@ void kvm_s390_vsie_init(struct kvm *kvm)
 
 static void kvm_s390_vsie_destroy_page(struct kvm *kvm, struct vsie_page *vsie_page)
 {
-	unpin_scb(kvm, vsie_page, vsie_page->scb_gpa);
+	unpin_scb(kvm, vsie_page);
 	release_gmap_shadow_safe(kvm, vsie_page);
 	free_vsie_page(vsie_page);
 }

-- 
2.55.0


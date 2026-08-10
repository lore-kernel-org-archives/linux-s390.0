Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707833031C;
	Mon, 10 Aug 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377272; cv=none; b=h+eOFLvxG0IoZPq2tccrT+WfEAQJW46tmEsiF46ySa7cZiwG0pcG+h/DYlCDibdK966dzQcfpmqdcOuii56h94xnmQGjJdvIyDYEBVNRUMdwT84Bsf4XBiUTPR5psRJsKsC/AT0iezpTSBX71avdYR0+mAM3Ta0+tfWZ3HX0gEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377272; c=relaxed/simple;
	bh=JdgmHi2N76OhuZ68DvT28QcTO5bCZ5Xos8xOPN2+9lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXFQf94upBjlY7hAjBZ8Bx2PFnE9dtkolfVa6N3R2/RK0XuThn1+2poy82ZsVbW+a/Ks5U9cUs4q81N8S5VabAww5OhyaulRSsAiwdq4EpqpiWkEhrdZBN0IpkvMlNROHzMItNm7D2SshbyObq/yW2jxdtHRzPurB9LjZhi3GzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BbkTEbmy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BbkTEbmy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFWSjq1941729;
	Mon, 10 Aug 2026 15:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=E+bvA2
	/jpsVbrB//ERJHr8Yif5tk235WEkDIq90V0fM=; b=BbkTEbmyr3fuYlCkvdW3kR
	/urgRNb7JuNlmPNeZQZEERn2VpxPEFHyHn8AOzH5QEQO4896UVHul3H93Yct7YwM
	ISmyKvLSss3aUbN0/BxZg2K+Svw417DQ/pxXiyVkkoMQOc5XdtPIeVj6rOKrc3j6
	MgLhf44uCq2VL8TAQOAmMAzgHS5ZmV0bFucCnj6avW9AjFOWhXW03M5RKWeVTtdR
	nfQU0EjcYl1f6FFYq1LmFWr8LGD5TrTp4swab9y5kI951XT1kQAfgziNgYNzLr2O
	OkvxnRUoouQzbPepTz+0wlXb+JC4OyOxsZZiykNk7MYGh655VWdaLrNQ5p8UCVfQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2rdu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AFgXKP027321;
	Mon, 10 Aug 2026 15:54:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g5909-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AFsKCM52756954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 15:54:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9CC32004B;
	Mon, 10 Aug 2026 15:54:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BCE520049;
	Mon, 10 Aug 2026 15:54:19 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.41.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 15:54:19 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 10 Aug 2026 17:53:59 +0200
Subject: [PATCH v2 11/20] KVM: s390: vsie: Lazily keep original scb pinned
 after vsie exit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-vsie-sigpi-v2-11-e8d59a2f2f70@linux.ibm.com>
References: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
In-Reply-To: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9413;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=JdgmHi2N76OhuZ68DvT28QcTO5bCZ5Xos8xOPN2+9lM=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmVX5Rk+2ZkZHnXTp7Y/I1jiWt8zsd1R342pR4w2jNHy
 2De4Vu2HaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzE8hYjw8KVjKdjrf853rKQ
 +yuqopSluElQT3dCpeODaRv3KJ7PDGf4w/OjUrn/WP78PXOuLXEUNrCoMpFa4nzI+jnDxKKepzf
 v8wEA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a79f430 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=qz25wtrU6i-00Mf3T4MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zxF1TL27JqKSwtmhU3cqQhI7Vhe6oTvt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfXz8ameh9kOFWZ
 gURyO43lA1S/kn8mdcJ9USwqKpL/iRCU0pF/ccfFjCmWOi7ESbOm8xGR0ljpYpHTPAkEzaRIonu
 nGQVOk5K2TjH0Qj07m+Dqu0VqgeLNYzH5QSBtvyRVdBIbThhZrEosqBxRX4v+qFrpMn/SUSzdL+
 h1nI73Qvp1rMxB5iSos6L44t1NzTKuEeYTeTZxVKQFiXXryTx0N1PjsOn86uoznpvRNcunHLgCw
 ly/We6JD8nA4EGz7TzR/s8bhKGyvL87zlHvB6CoPEcEI10ewo2sw6dThXCFCr+nvDbVDUdqaodE
 b7U6V3yRF6XcbGqizYN0Y5xHEEbFUJCiV3fQhUIWPT80YtWLv9AUUDm7QfY1jWEprawD8ykabIG
 KtW8eTmeXBtARXGeR55mbE5h8Xrvo96uyI0HxIBc1bUfOgYvZUK7mvzRy1i3HvmjJTqO1jAzU8r
 JFZAh168NpeqJPz5HVQ==
X-Proofpoint-ORIG-GUID: zxF1TL27JqKSwtmhU3cqQhI7Vhe6oTvt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX9vaIhPoKtPjj
 X22roz7b2x1r4w88FkOeCmxGZ6azLLD3qgbBhep5DYvfFo2ayFucfJiALJQa+A5fjXX3wYoi28v
 gc1B3eAWvVk92MJatwtdZCWuUvE50pw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100134

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
 arch/s390/kvm/vsie.c | 149 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 103 insertions(+), 46 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index d0806871885c..4f4d35e0c8c1 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -29,6 +29,7 @@
 
 enum vsie_page_flags {
 	VSIE_PAGE_IN_USE = 0,
+	VSIE_PAGE_SCB_PINNED = 1,
 };
 
 struct vsie_page {
@@ -759,14 +760,18 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
+	__clear_bit(VSIE_PAGE_SCB_PINNED, &vsie_page->flags);
 }
 
 /*
@@ -775,19 +780,22 @@ static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
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
+	__set_bit(VSIE_PAGE_SCB_PINNED, &vsie_page->flags);
 	return 0;
 }
 
@@ -1528,17 +1536,45 @@ static struct vsie_page *alloc_vsie_page(struct kvm *kvm)
 	return vsie_page;
 }
 
+static int vsie_page_init(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, unsigned long scb_gpa)
+{
+	struct kvm *kvm = vcpu->kvm;
+	int rc;
+
+	if (vsie_page->scb_gpa != ULONG_MAX)
+		xa_erase(&kvm->arch.vsie.addr_to_page, vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
+	vsie_page->scb_gpa = scb_gpa;
+	rc = pin_scb(vcpu, vsie_page);
+	if (rc) {
+		vsie_page->scb_gpa = ULONG_MAX;
+		return -ENOMEM;
+	}
+
+	vsie_page->sca_gpa = read_scao(kvm, vsie_page->scb_o);
+	WARN_ON_ONCE(xa_insert(&kvm->arch.vsie.addr_to_page, scb_gpa >> SCB_ALIGNMENT_SHIFT,
+			       vsie_page, GFP_KERNEL_ACCOUNT));
+
+	return 0;
+}
+
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
@@ -1551,53 +1587,69 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
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
+	rc = vsie_page_init(vcpu, vsie_page, addr);
+	mutex_unlock(&kvm->arch.vsie.mutex);
+	if (vsie_page_new)
+		free_vsie_page(vsie_page_new);
+	if (WARN_ON_ONCE(rc)) {
+		unpin_scb(kvm, vsie_page);
+		vsie_page->scb_gpa = ULONG_MAX;
 		put_vsie_page(vsie_page);
-		mutex_unlock(&kvm->arch.vsie.mutex);
-		return NULL;
+		return ERR_PTR(rc);
 	}
-	vsie_page->scb_gpa = addr;
-	mutex_unlock(&kvm->arch.vsie.mutex);
 
 	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
 	release_gmap_shadow_safe(kvm, vsie_page);
 	prefix_unmapped(vsie_page);
 	vsie_page->fault_addr = 0;
 	vsie_page->scb_s.ihcpu = 0xffffU;
+
 	return vsie_page;
 }
 
@@ -1624,7 +1676,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	vsie_page = get_vsie_page(vcpu->kvm, scb_addr);
+	vsie_page = get_vsie_page(vcpu, scb_addr);
 	if (IS_ERR(vsie_page)) {
 		return PTR_ERR(vsie_page);
 	} else if (!vsie_page) {
@@ -1633,7 +1685,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	rc = pin_scb(vcpu, vsie_page, scb_addr);
+	rc = pin_scb(vcpu, vsie_page);
 	if (rc)
 		goto out_put;
 	rc = shadow_scb(vcpu, vsie_page);
@@ -1649,7 +1701,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 out_unshadow:
 	unshadow_scb(vcpu, vsie_page);
 out_unpin_scb:
-	unpin_scb(vcpu, vsie_page, scb_addr);
+	unpin_scb(vcpu->kvm, vsie_page);
 out_put:
 	put_vsie_page(vsie_page);
 
@@ -1663,24 +1715,29 @@ void kvm_s390_vsie_init(struct kvm *kvm)
 	xa_init_flags(&kvm->arch.vsie.addr_to_page, XA_FLAGS_ACCOUNT);
 }
 
+static void kvm_s390_vsie_destroy_page(struct kvm *kvm, struct vsie_page *vsie_page)
+{
+	unpin_scb(kvm, vsie_page);
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


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E3445AE7;
	Tue, 11 Aug 2026 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455445; cv=none; b=npmne+pKDosezcPYzXKkH7ZNr7/JPWAoIlH/DMr8xD+GlDuGdlpUsJzKDTCK5I3Yk270rzAtMS8+alEQjBYJ7DKOkTFSlPccyndyiDVkQ72mNjGmsq8zcr/KzNHRtIYwZIONuDu+PHwInDJ8wevs+bkN+ihfWbq+cGE1rT15DmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455445; c=relaxed/simple;
	bh=svJmrfysde/doLTyJfXmcWpRhoi1ErKpqW2eoXCN6SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jdp0vdU4m3eNyKCg8MSvqJeRZGqy1AEs9KSA88eZBvDXhC8q6ovlh7hD0EcVLtcFMKI52gKLpNyykJk9HpGbgRlJPJAoi+nVwPB3c4UidyVKubrZ2VoN58rG5jCL66HJ5dAax/k/GmXconZyYmFQu9B6yDXcSEA114uknN75CKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iQ+rz/vt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iQ+rz/vt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX8ni569955;
	Tue, 11 Aug 2026 13:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tDtaAl
	FyMDCzmnqbDrESltcRL4VNy+hWyi9imzN7Rmc=; b=iQ+rz/vt575hpcOkxma0o1
	DkII+aCp1XL9O9ToEajDMlc/dFuepggnDFF5vz7jHJhlMhoSQwHupjlPO/V9wlls
	3/LZjNguTsrk2c3z2L1Tk3UqkSm6JtIBOzJ+tpeQV2YumB1QBM5ZQ7c9AiWH+1G2
	PndDchAgrkoly0d5eAa3Lj6+ME3w0PiwiIzmuns/YJiqjD74KO8cwgj/D+GhgRZ/
	vxI+sGyY/F+sXFnVWdNtvYhr8bUiyTzXuzq3UWecVfNZlcIF4HnSH0Fv0mZgFEre
	CarPKvynf0SU4FrRC5RSVM3HA9guXuH+CEx/R1qqJTpvGBWS+d4aCrgL8/cDfG2Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw4fsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQGvP025897;
	Tue, 11 Aug 2026 13:36:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w16uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDachr50397688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D8692004D;
	Tue, 11 Aug 2026 13:36:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 637112004B;
	Tue, 11 Aug 2026 13:36:37 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:37 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:36:29 +0200
Subject: [PATCH v3 14/20] KVM: s390: vsie: Shadow VSIE SCA in guest-1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vsie-sigpi-v3-14-45aa1ab07c7c@linux.ibm.com>
References: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
In-Reply-To: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=23151;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=svJmrfysde/doLTyJfXmcWpRhoi1ErKpqW2eoXCN6SY=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqlGJZ6+zR3uXCC/R+Lsk7esi5TMn2LoeLdJacKj0b
 taELYW/O0pZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZjI4vUMf2VzwkwnNbdX6LvN
 VMirVtia2rPk3SJeyS897zvszovYzWZkuHTqmdf7Y+6SsvP/rZTJ//5jt83NFZbCU3+/mRMUJfc
 ymB8A
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b256a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ZuCD4-MNAaWT269WCmkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IkPRoBaXawq1jpUG1aTVlVmC4FR2Q7l3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX5gyIBeAd+AW7
 3JMu3bCqEk6aI5DXyWzHJV8rg88xPmoFkLZ4y6Jtd39VB+TONs3AXcw8+F0SXN4M8n3LJb3+6Ka
 Y1rS/AFTQjYFKN8JtGY9kO5Zp6+3DEVS0RgHOvXagb1F37DLlQGKnCjkwKYYtEqSoQ8fn+A6ihn
 RdYe55NpMi0uFHbGudn+uvUUy4HfNwv74YBi5m0B+gjpM+SEhvO42LFrKh7WQfM4TZU+Os9Jm4J
 0YLROvOFXbhrIyclBo2CuNfF7A9bEFvkIyQ+QIxyrIZGaN/fBEbaZ1mfiv23bAfdv4KekjOsJ7F
 pAnYmXNFP0MUAnANOPnYrPKRlqe3VZXaZi9TEBb2kWggRPWtNOxJx+bdvAXy55zg9aJ+4G5+j3F
 WuB1OMTASbVX+m1CJLp1fOdG6UHjSL6neN/DwfBx4Sq6xyDfFop72CmJZPHprt1ycqRfuuB5/k0
 mH+FJd3i+RwPbzz40TQ==
X-Proofpoint-ORIG-GUID: IkPRoBaXawq1jpUG1aTVlVmC4FR2Q7l3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX2cQn4db7mmfU
 gyf5ex6e+XV+Ntc4A6laziqSD16sSvXEWCw3gVipjpALLHq9PNbXU89daFobSqxAW65xjlAro3q
 j0g9vgbq7/hELfdxRtnpz/Z8atjXLNI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110113

Restructure kvm_s390_handle_vsie() to create a guest-1 shadow of the SCA
if guest-2 attempts to enter SIE with an SCA. If the SCA is used the
vsie_pages are stored in a new vsie_sca struct instead of the arch vsie
struct.

When the VSIE-Interpretation-Extension Facility is active the shadow SCA
(ssca_block) will be created and shadows of all CPUs defined in the
configuration are created. SCAOL/H in the VSIE control block are
overwritten with references to the shadow SCA.

The shadow SCA contains the addresses of the original guest-3 SCA as
well as the original VSIE control blocks. With these addresses the
machine can directly monitor the intervention bits within the original
SCA entries, enabling it to handle SENSE_RUNNING and EXTERNAL_CALL SIGP
instructions without exiting VSIE. The benefit of this is that the SIGP
calls are handled faster. Additionally the number of required VM exits
and therefore reentries are reduced, reducing the un-/shadowing effort.

The original SCA will be pinned in guest-2 memory and only be unpinned
before reuse. This means some pages might still be pinned even after the
guest 3 VM no longer exists.

References to the existing vsie_scas including the ssca_blocks are also
kept within a map to reuse already existing ssca_blocks efficiently.
The map and array with references to the vsie_scas are held in the
arch vsie struct. The use of vsie_scas is tracked using a ref_count.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h       |  21 +-
 arch/s390/include/asm/kvm_host_types.h |   1 +
 arch/s390/kvm/vsie.c                   | 482 ++++++++++++++++++++++++++++++---
 3 files changed, 464 insertions(+), 40 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 1a1df3ff44fa..9939bdbecaa0 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -621,13 +621,32 @@ struct sie_page2 {
 };
 
 struct vsie_page;
+struct vsie_sca;
 
+/*
+ * vsie_pages, scas and accompanied management vars
+ */
 struct kvm_s390_vsie {
 	struct mutex mutex;
 	struct xarray addr_to_page;
 	int page_count;
 	int next;
-	struct vsie_page *pages[KVM_MAX_VCPUS];
+	struct vsie_page *pages[KVM_S390_MAX_VSIE_VCPUS];
+	/*
+	 * The vsie_sca_lock is used to synchronize access to
+	 * - the kvm_s390_vsie.scas[]
+	 * - the kvm_s390_vsie.osca_to_sca map
+	 * - new vsie_sca creation and initialization
+	 */
+	struct rw_semaphore vsie_sca_lock;
+	struct xarray osca_to_sca;
+	int sca_count;
+	int sca_next;
+	/*
+	 * In addition to the use of the array when entering and exiting vsie the scas[] is
+	 * accessed from the gmap_notifier without any lock held.
+	 */
+	struct vsie_sca *scas[KVM_S390_MAX_VSIE_VCPUS];
 };
 
 struct kvm_s390_gisa_iam {
diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/asm/kvm_host_types.h
index b0421f0a0090..3be723bbf7dd 100644
--- a/arch/s390/include/asm/kvm_host_types.h
+++ b/arch/s390/include/asm/kvm_host_types.h
@@ -13,6 +13,7 @@
 #define KVM_S390_ESCA_CPU_SLOTS 248
 
 #define SCB_ALIGNMENT_SHIFT 9
+#define SCA_ALIGNMENT_SHIFT 6
 
 #define SIGP_CTRL_C		0x80
 #define SIGP_CTRL_SCN_MASK	0x3f
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 1970bfd8135d..6cd8eee9a503 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -83,18 +83,20 @@ enum vsie_sca_flags {
 };
 
 struct vsie_sca {
-	struct ssca_block	ssca;
-	struct {} start_no_clear_fields;
+	struct_group(head,
+		struct ssca_block	ssca;
+	);
 	struct vsie_page	*pages[KVM_S390_MAX_VSIE_VCPUS];
 	/* The mutex is used to synchronize access to the pages[] */
 	struct mutex		mutex;
 	atomic_t		ref_count;
-	struct {} end_no_clear_fields;
-	gpa_t			sca_gpa;
-	unsigned long		flags;
-	u64			mcn[4];
-	unsigned int		sca_o_nr_pages;
-	struct kvm_address_pair	sca_o_pages[KVM_S390_MAX_SCA_PAGES];
+	struct_group(tail,
+		gpa_t			sca_gpa;
+		unsigned long		flags;
+		u64			mcn[4];
+		unsigned int		sca_o_nr_pages;
+		struct kvm_address_pair	sca_o_pages[KVM_S390_MAX_SCA_PAGES];
+	);
 };
 
 /*
@@ -103,6 +105,11 @@ struct vsie_sca {
  */
 static_assert(!(offsetof(struct vsie_sca, ssca)));
 
+static inline hpa_t sca_o_hpa(struct vsie_sca *vsie_sca)
+{
+	return vsie_sca->sca_o_pages[0].hpa | (vsie_sca->sca_gpa & ~PAGE_MASK);
+}
+
 static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
 {
 	return (scb->ecb2 & ECB2_ESCA);
@@ -124,6 +131,17 @@ static void write_scao(struct kvm_s390_sie_block *scb, unsigned long hpa)
 	scb->scaol = (u32)(u64)hpa;
 }
 
+static inline bool use_ssca(struct kvm *kvm, struct kvm_s390_sie_block *scb)
+{
+	if (!kvm->arch.use_ssca)
+		return false;
+	if (!(scb->eca & ECA_SIGPI) && !(scb->ecb & ECB_SRSI))
+		return false;
+	if (!read_scao(kvm, scb))
+		return false;
+	return true;
+}
+
 /* trigger a validity icpt for the given scb */
 static int set_validity_icpt(struct kvm_s390_sie_block *scb,
 			     __u16 reason_code)
@@ -920,6 +938,78 @@ static int pin_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
 	return 0;
 }
 
+static int get_sca_entry_addr(struct kvm *kvm, struct vsie_sca *vsie_sca, u16 cpu_nr, gpa_t *gpa,
+			      hpa_t *hpa)
+{
+	hpa_t cpu_offset, offset;
+	int pn;
+
+	/*
+	 * We cannot simply access the hva since the esca_block has typically
+	 * 4 pages (arch max 5 pages) that might not be continuous in g1 memory.
+	 * The bsca_block may also be stretched over two pages. Only the header
+	 * is guaranteed to be on the same page.
+	 */
+	if (test_bit(VSIE_SCA_ESCA, &vsie_sca->flags))
+		cpu_offset = offsetof(struct esca_block, cpu[cpu_nr]);
+	else
+		cpu_offset = offsetof(struct bsca_block, cpu[cpu_nr]);
+	pn = ((vsie_sca->sca_gpa & ~PAGE_MASK) + cpu_offset) >> PAGE_SHIFT;
+	offset = (vsie_sca->sca_gpa + cpu_offset) & ~PAGE_MASK;
+	if (WARN_ON_ONCE(pn >= vsie_sca->sca_o_nr_pages))
+		return -EINVAL;
+
+	if (gpa)
+		*gpa = vsie_sca->sca_o_pages[pn].gpa | offset;
+	if (hpa)
+		*hpa = vsie_sca->sca_o_pages[pn].hpa | offset;
+	return 0;
+}
+
+static void put_vsie_sca(struct vsie_sca *vsie_sca)
+{
+	if (!vsie_sca)
+		return;
+
+	WARN_ON_ONCE(atomic_dec_return(&vsie_sca->ref_count) < 0);
+}
+
+/*
+ * Try to find the address of an existing shadow system control area.
+ * @sca_o_gpa: original system control area address; guest-2 physical
+ *
+ * Called with lock on vsie_sca_lock.
+ */
+static struct vsie_sca *get_existing_vsie_sca(struct kvm *kvm, gpa_t sca_o_gpa)
+{
+	struct vsie_sca *vsie_sca = xa_load(&kvm->arch.vsie.osca_to_sca,
+					    sca_o_gpa >> SCA_ALIGNMENT_SHIFT);
+
+	WARN_ON_ONCE(vsie_sca && atomic_inc_return(&vsie_sca->ref_count) < 1);
+	return vsie_sca;
+}
+
+/* Try to find and get a currently unused vsie_sca from the vsie struct. */
+static struct vsie_sca *get_reuseable_vsie_sca(struct kvm *kvm)
+{
+	struct vsie_sca *vsie_sca;
+	int i, ref_count;
+
+	lockdep_assert_held_write(&kvm->arch.vsie.vsie_sca_lock);
+
+	for (i = 0; i < kvm->arch.vsie.sca_count; i++) {
+		vsie_sca = READ_ONCE(kvm->arch.vsie.scas[kvm->arch.vsie.sca_next]);
+		kvm->arch.vsie.sca_next++;
+		kvm->arch.vsie.sca_next %= kvm->arch.vsie.sca_count;
+		ref_count = atomic_inc_return(&vsie_sca->ref_count);
+		WARN_ON_ONCE(ref_count < 1);
+		if (ref_count == 1)
+			return vsie_sca;
+		put_vsie_sca(vsie_sca);
+	}
+	return ERR_PTR(-EAGAIN);
+}
+
 static void free_vsie_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
 {
 	free_pages_exact(vsie_sca, sizeof(*vsie_sca));
@@ -939,6 +1029,121 @@ static struct vsie_sca *alloc_vsie_sca(void)
 	return vsie_sca;
 }
 
+/* Clear the vsie_sca struct but keep the vsie_page references, mutex and ref_count */
+static void clear_vsie_sca(struct vsie_sca *vsie_sca)
+{
+	memset(&vsie_sca->head, 0, sizeof(vsie_sca->head));
+	memset(&vsie_sca->tail, 0, sizeof(vsie_sca->tail));
+}
+
+/* Pin and get an existing or new guest-3 system control area.*/
+static struct vsie_sca *get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_block *scb_o)
+{
+	struct vsie_sca *vsie_sca, *vsie_sca_new = NULL;
+	gpa_t sca_gpa = read_scao(vcpu->kvm, scb_o);
+	struct vsie_page *vsie_page_n;
+	struct kvm *kvm = vcpu->kvm;
+	unsigned int max_vsie_sca;
+	int rc, cpu_nr;
+
+	/* validate scb_o as we do not unshadow on error here */
+	rc = validate_scao(vcpu, scb_o, sca_gpa);
+	if (rc)
+		return ERR_PTR(-EINVAL);
+
+	down_read(&kvm->arch.vsie.vsie_sca_lock);
+	vsie_sca = get_existing_vsie_sca(kvm, sca_gpa);
+	up_read(&kvm->arch.vsie.vsie_sca_lock);
+	if (vsie_sca)
+		return vsie_sca;
+
+	/*
+	 * Allocate new vsie_sca, it will likely be needed below.
+	 * We want at least #online_vcpus shadows, so every VCPU can execute the
+	 * VSIE in parallel. (Worst case all single core VMs.)
+	 */
+	max_vsie_sca = MIN(atomic_read(&kvm->online_vcpus), KVM_S390_MAX_VSIE_VCPUS);
+
+	if (kvm->arch.vsie.sca_count < max_vsie_sca) {
+		vsie_sca_new = alloc_vsie_sca();
+		if (!vsie_sca_new)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * Now we're taking the vsie_sca_lock in write mode so that we can manipulate
+	 * the radix tree and recheck for existing SCAs with exclusive access.
+	 *
+	 * In the next lines we try three things to get an SCA:
+	 *   - Retry getting an existing vsie_sca
+	 *   - Using our newly allocated vsie_sca if we're under the limit
+	 *   - Reusing an vsie_sca including ssca to shadow a different osca
+	 */
+	down_write(&kvm->arch.vsie.vsie_sca_lock);
+	vsie_sca = get_existing_vsie_sca(kvm, sca_gpa);
+	if (vsie_sca)
+		goto out;
+
+	/* check again under write lock if we are still under our vsie_sca limit */
+	if (vsie_sca_new && kvm->arch.vsie.sca_count < max_vsie_sca) {
+		/* make use of vsie_sca just created */
+		vsie_sca = vsie_sca_new;
+		vsie_sca_new = NULL;
+
+		kvm->arch.vsie.scas[kvm->arch.vsie.sca_count] = vsie_sca;
+		kvm->arch.vsie.sca_count++;
+		atomic_set(&vsie_sca->ref_count, 1);
+	} else {
+		/* reuse previously created vsie_sca allocation for different osca */
+		vsie_sca = get_reuseable_vsie_sca(kvm);
+		/* with nr_vcpus scas one must be reusable */
+		if (IS_ERR(vsie_sca))
+			goto out;
+		WARN_ON_ONCE(atomic_read(&vsie_sca->ref_count) != 1);
+
+		xa_erase(&kvm->arch.vsie.osca_to_sca, vsie_sca->sca_gpa >> SCA_ALIGNMENT_SHIFT);
+		for (cpu_nr = 0; cpu_nr < KVM_S390_MAX_VSIE_VCPUS; cpu_nr++) {
+			vsie_page_n = vsie_sca->pages[cpu_nr];
+			if (!vsie_page_n)
+				continue;
+
+			/* unpin but keep the vsie_page for reuse */
+			unpin_scb(kvm, vsie_page_n);
+			release_gmap_shadow_safe(kvm, vsie_page_n);
+			memset(vsie_page_n, 0, sizeof(struct vsie_page));
+			vsie_page_n->scb_gpa = ULONG_MAX;
+		}
+		unpin_sca(kvm, vsie_sca);
+		clear_vsie_sca(vsie_sca);
+	}
+
+	if (sie_uses_esca(scb_o))
+		__set_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
+	vsie_sca->sca_gpa = sca_gpa;
+
+	/*
+	 * The pinned original sca will only be unpinned lazily to limit the
+	 * required amount of pins/unpins on each vsie entry/exit.
+	 * The unpin is done in the reuse vsie_sca allocation path above and
+	 * kvm_s390_vsie_destroy().
+	 */
+	rc = pin_sca(kvm, vsie_sca);
+	if (rc) {
+		put_vsie_sca(vsie_sca);
+		vsie_sca = ERR_PTR(rc);
+		goto out;
+	}
+
+	WARN_ON_ONCE(xa_store(&kvm->arch.vsie.osca_to_sca,
+			      vsie_sca->sca_gpa >> SCA_ALIGNMENT_SHIFT, vsie_sca, GFP_KERNEL));
+
+out:
+	up_write(&kvm->arch.vsie.vsie_sca_lock);
+	if (vsie_sca_new)
+		free_vsie_sca(kvm, vsie_sca_new);
+	return vsie_sca;
+}
+
 void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, gpa_t start, gpa_t end)
 {
 	struct vsie_page *cur, *next;
@@ -1005,11 +1210,13 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	hpa_t hpa;
 
-	hpa = (u64) scb_s->scaoh << 32 | scb_s->scaol;
-	if (hpa) {
-		unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
-		vsie_page->sca_gpa = 0;
-		write_scao(scb_s, 0);
+	if (!vsie_page->vsie_sca) {
+		hpa = (u64) scb_s->scaoh << 32 | scb_s->scaol;
+		if (hpa) {
+			unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
+			vsie_page->sca_gpa = 0;
+			write_scao(scb_s, 0);
+		}
 	}
 
 	hpa = scb_s->itdba;
@@ -1048,9 +1255,6 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
  * This works as long as the data lies in one page. If blocks ever exceed one
  * page, we have to fall back to shadowing.
  *
- * As we reuse the sca, the vcpu pointers contained in it are invalid. We must
- * therefore not enable any facilities that access these pointers (e.g. SIGPIF).
- *
  * Returns: - 0 if all blocks were pinned.
  *          - > 0 if control has to be given to guest 2
  *          - -ENOMEM if out of memory
@@ -1063,8 +1267,8 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	gpa_t gpa;
 	int rc = 0;
 
-	gpa = read_scao(vcpu->kvm, scb_o);
-	if (gpa) {
+	gpa = vsie_page->sca_gpa;
+	if (gpa && !vsie_page->vsie_sca) {
 		rc = validate_scao(vcpu, scb_s, gpa);
 		if (rc)
 			goto unpin;
@@ -1073,7 +1277,6 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			rc = set_validity_icpt(scb_s, 0x0034U);
 			goto unpin;
 		}
-		vsie_page->sca_gpa = gpa;
 		write_scao(scb_s, hpa);
 	}
 
@@ -1614,7 +1817,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		 */
 		if (kvm_s390_vcpu_has_irq(vcpu, 0) ||
 		    kvm_s390_vcpu_sie_inhibited(vcpu)) {
-			kvm_s390_rewind_psw(vcpu, 4);
+			rc = -EAGAIN;
 			break;
 		}
 		if (sg)
@@ -1678,11 +1881,10 @@ static struct vsie_page *alloc_vsie_page(struct kvm *kvm)
 
 static int vsie_page_init(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, unsigned long scb_gpa)
 {
+	struct vsie_page *vsie_page_old;
 	struct kvm *kvm = vcpu->kvm;
 	int rc;
 
-	if (vsie_page->scb_gpa != ULONG_MAX)
-		xa_erase(&kvm->arch.vsie.addr_to_page, vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
 	vsie_page->scb_gpa = scb_gpa;
 	rc = pin_scb(vcpu, vsie_page);
 	if (rc) {
@@ -1691,8 +1893,18 @@ static int vsie_page_init(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, un
 	}
 
 	vsie_page->sca_gpa = read_scao(kvm, vsie_page->scb_o);
-	WARN_ON_ONCE(xa_insert(&kvm->arch.vsie.addr_to_page, scb_gpa >> SCB_ALIGNMENT_SHIFT,
-			       vsie_page, GFP_KERNEL_ACCOUNT));
+
+	/*
+	 * store the vsie_page in addr_to_page
+	 * mind that g2 may have reused the sca - make sure we do not remove the sca from
+	 * the new config when reusing the vsie_page_old
+	 */
+	vsie_page_old = xa_store(&kvm->arch.vsie.addr_to_page, scb_gpa >> SCB_ALIGNMENT_SHIFT,
+				 vsie_page, GFP_KERNEL_ACCOUNT);
+	if (WARN_ON_ONCE(xa_err(vsie_page_old)))
+		return 0;
+	if (vsie_page_old && vsie_page_old != vsie_page)
+		WRITE_ONCE(vsie_page_old->scb_gpa, ULONG_MAX);
 
 	return 0;
 }
@@ -1793,11 +2005,145 @@ static struct vsie_page *get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr
 	return vsie_page;
 }
 
+static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie_sca *vsie_sca,
+					      gpa_t scb_gpa, u16 cpu_nr)
+{
+	struct vsie_page *vsie_page, *vsie_page_new = NULL;
+	int rc;
+
+	vsie_page = vsie_sca->pages[cpu_nr];
+	if (!vsie_page) {
+		vsie_page_new = alloc_vsie_page(vcpu->kvm);
+		if (!vsie_page_new)
+			return ERR_PTR(-ENOMEM);
+		vsie_page_new->vsie_sca = vsie_sca;
+		__set_bit(VSIE_PAGE_IN_USE, &vsie_page_new->flags);
+
+		/* be careful to not loose a page here if we raced */
+		scoped_guard(mutex, &vsie_sca->mutex) {
+			vsie_page = vsie_sca->pages[cpu_nr];
+			if (!vsie_page) {
+				WRITE_ONCE(vsie_sca->pages[cpu_nr], vsie_page_new);
+				vsie_page = vsie_page_new;
+			}
+		}
+	}
+	if (vsie_page != vsie_page_new) {
+		if (vsie_page_new)
+			free_vsie_page(vsie_page_new);
+
+		/* not a new vsie_page so get it */
+		if (!try_get_vsie_page(vsie_page))
+			return ERR_PTR(-EAGAIN);
+		vsie_page->vsie_sca = vsie_sca;
+	}
+	if (vsie_page->scb_gpa != scb_gpa || vsie_page->sca_gpa != vsie_sca->sca_gpa) {
+		scoped_guard(mutex, &vcpu->kvm->arch.vsie.mutex) {
+			unpin_scb(vcpu->kvm, vsie_page);
+			rc = vsie_page_init(vcpu, vsie_page, scb_gpa);
+		}
+		if (WARN_ON_ONCE(rc)) {
+			put_vsie_page(vsie_page);
+			return ERR_PTR(rc);
+		}
+	}
+
+	return vsie_page;
+}
+
+static void vsie_sca_update(struct vsie_sca *vsie_sca, unsigned int cpu_nr,
+			    struct vsie_page *vsie_page_n, hpa_t sca_o_entry_hpa)
+{
+	guard(mutex)(&vsie_sca->mutex);
+
+	WRITE_ONCE(vsie_sca->ssca.cpu[cpu_nr].ssda, virt_to_phys(&vsie_page_n->scb_s));
+	WRITE_ONCE(vsie_sca->ssca.cpu[cpu_nr].ossea, sca_o_entry_hpa);
+	WRITE_ONCE(vsie_sca->pages[cpu_nr], vsie_page_n);
+}
+
+/* Fill the shadow system control area used for VSIE SIGPI. */
+static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+		       struct vsie_sca *vsie_sca)
+{
+	bool is_esca = sie_uses_esca(vsie_page->scb_o);
+	unsigned int cpu_nr, cpu_slots;
+	struct vsie_page *vsie_page_n;
+	hpa_t sca_o_entry_hpa;
+	hva_t sca_o_entry_hva;
+	unsigned long *mcn;
+	gpa_t scb_o_gpa;
+	int rc;
+
+	if (is_esca)
+		mcn = phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct esca_block, mcn);
+	else
+		mcn = phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct bsca_block, mcn);
+
+	/* pin and make shadow for ALL scb in the sca */
+	cpu_slots = is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLOTS;
+	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
+		rc = get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_entry_hpa);
+		if (rc)
+			goto err;
+
+		if (vsie_page->scb_o->icpua == cpu_nr) {
+			vsie_sca_update(vsie_sca, cpu_nr, vsie_page, sca_o_entry_hpa);
+		} else {
+			sca_o_entry_hva = (hva_t)phys_to_virt(sca_o_entry_hpa);
+			if (is_esca)
+				scb_o_gpa = ((struct esca_entry *)sca_o_entry_hva)->sda;
+			else
+				scb_o_gpa = ((struct bsca_entry *)sca_o_entry_hva)->sda;
+			if (scb_o_gpa & 0x1ffUL) {
+				rc = -EINVAL;
+				goto err;
+			}
+			vsie_page_n = get_vsie_page_cpu_nr(vcpu, vsie_sca, scb_o_gpa, cpu_nr);
+			if (!vsie_page_n)
+				rc = -EAGAIN;
+			if (IS_ERR(vsie_page_n))
+				rc = PTR_ERR(vsie_page_n);
+			if (rc)
+				goto err;
+			rc = shadow_scb(vcpu, vsie_page_n);
+			vsie_sca_update(vsie_sca, cpu_nr, vsie_page_n, sca_o_entry_hpa);
+			put_vsie_page(vsie_page_n);
+			if (rc)
+				goto err;
+		}
+	}
+	vsie_sca->ssca.osca = sca_o_hpa(vsie_sca);
+
+	return 0;
+
+err:
+	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
+		vsie_sca->ssca.cpu[cpu_nr].ssda = 0;
+		vsie_sca->ssca.cpu[cpu_nr].ossea = 0;
+	}
+	return rc;
+}
+
+/* Shadow or reshadow the SCA on VSIE enter. */
+static int shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struct vsie_sca *vsie_sca)
+{
+	int rc = 0;
+
+	guard(rwsem_write)(&vcpu->kvm->arch.vsie.vsie_sca_lock);
+	if (!vsie_sca->ssca.osca)
+		rc = _shadow_sca(vcpu, vsie_page, vsie_sca);
+
+	return rc;
+}
+
 int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 {
+	struct kvm_s390_sie_block *scb_o;
+	struct vsie_sca *vsie_sca = NULL;
 	struct vsie_page *vsie_page;
-	unsigned long scb_addr;
-	int rc;
+	gpa_t scb_addr;
+	hpa_t scb_hpa;
+	int rc = 0;
 
 	vcpu->stat.instruction_sie++;
 	if (!test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_SIEF2))
@@ -1816,35 +2162,70 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	vsie_page = get_vsie_page(vcpu, scb_addr);
-	if (IS_ERR(vsie_page)) {
-		return PTR_ERR(vsie_page);
-	} else if (!vsie_page) {
+	rc = pin_guest_page(vcpu->kvm, scb_addr, &scb_hpa);
+	if (rc)
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	scb_o = (struct kvm_s390_sie_block *)phys_to_virt(scb_hpa);
+
+	if (!use_ssca(vcpu->kvm, scb_o)) {
+		/* get the vsie_page with pinned scb_o */
+		vsie_page = get_vsie_page(vcpu, scb_addr);
+		if (IS_ERR(vsie_page)) {
+			rc = PTR_ERR(vsie_page);
+			goto out_unpin;
+		}
+		vsie_page->vsie_sca = NULL;
+	} else {
+		/* get the vsie_sca with pinned original sca */
+		vsie_sca = get_vsie_sca(vcpu, scb_o);
+		if (IS_ERR(vsie_sca)) {
+			rc = PTR_ERR(vsie_sca);
+			goto out_unpin;
+		}
+		vsie_page = get_vsie_page_cpu_nr(vcpu, vsie_sca, scb_addr, scb_o->icpua);
+		if (IS_ERR(vsie_page)) {
+			rc = PTR_ERR(vsie_page);
+			goto out_put_sca;
+		}
+	}
+	if (!vsie_page) {
 		/* double use of sie control block - simply do nothing */
-		kvm_s390_rewind_psw(vcpu, 4);
-		return 0;
+		rc = -EAGAIN;
+		goto out_put_sca;
 	}
 
-	rc = pin_scb(vcpu, vsie_page);
-	if (rc)
-		goto out_put;
 	rc = shadow_scb(vcpu, vsie_page);
 	if (rc)
-		goto out_unpin_scb;
+		goto out_put;
+	if (vsie_sca) {
+		/* pin and shadow the sca including all scb_o in the g3 conf */
+		rc = shadow_sca(vcpu, vsie_page, vsie_sca);
+		if (rc)
+			goto out_put;
+	}
+
 	rc = pin_blocks(vcpu, vsie_page);
 	if (rc)
 		goto out_unshadow;
 	register_shadow_scb(vcpu, vsie_page);
+
 	rc = vsie_run(vcpu, vsie_page);
+
 	unregister_shadow_scb(vcpu);
 	unpin_blocks(vcpu, vsie_page);
 out_unshadow:
 	unshadow_scb(vcpu, vsie_page);
-out_unpin_scb:
-	unpin_scb(vcpu->kvm, vsie_page);
 out_put:
 	put_vsie_page(vsie_page);
+out_put_sca:
+	put_vsie_sca(vsie_sca);
+out_unpin:
+	unpin_guest_page(vcpu->kvm, scb_addr, scb_hpa);
 
+	if (rc == -EAGAIN) {
+		kvm_s390_rewind_psw(vcpu, 4);
+		rc = 0;
+	}
 	return rc < 0 ? rc : 0;
 }
 
@@ -1853,6 +2234,8 @@ void kvm_s390_vsie_init(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.vsie.mutex);
 	xa_init_flags(&kvm->arch.vsie.addr_to_page, XA_FLAGS_ACCOUNT);
+	init_rwsem(&kvm->arch.vsie.vsie_sca_lock);
+	xa_init_flags(&kvm->arch.vsie.osca_to_sca, XA_FLAGS_ACCOUNT);
 }
 
 static void kvm_s390_vsie_destroy_page(struct kvm *kvm, struct vsie_page *vsie_page)
@@ -1866,7 +2249,8 @@ static void kvm_s390_vsie_destroy_page(struct kvm *kvm, struct vsie_page *vsie_p
 void kvm_s390_vsie_destroy(struct kvm *kvm)
 {
 	struct vsie_page *vsie_page;
-	int i;
+	struct vsie_sca *vsie_sca;
+	int i, cpu_nr;
 
 	guard(mutex)(&kvm->arch.vsie.mutex);
 
@@ -1877,7 +2261,27 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 	}
 
 	kvm->arch.vsie.page_count = 0;
+	for (i = 0; i < kvm->arch.vsie.sca_count; i++) {
+		vsie_sca = kvm->arch.vsie.scas[i];
+		kvm->arch.vsie.scas[i] = NULL;
+		if (!vsie_sca)
+			continue;
+
+		for (cpu_nr = 0; cpu_nr < KVM_S390_MAX_VSIE_VCPUS; cpu_nr++) {
+			vsie_page = vsie_sca->pages[cpu_nr];
+			vsie_sca->pages[cpu_nr] = NULL;
+			if (!vsie_page)
+				continue;
+			unpin_scb(kvm, vsie_page);
+			kvm_s390_vsie_destroy_page(kvm, vsie_page);
+		}
+
+		unpin_sca(kvm, vsie_sca);
+		free_vsie_sca(kvm, vsie_sca);
+	}
+	kvm->arch.vsie.sca_count = 0;
 	xa_destroy(&kvm->arch.vsie.addr_to_page);
+	xa_destroy(&kvm->arch.vsie.osca_to_sca);
 }
 
 void kvm_s390_vsie_kick(struct kvm_vcpu *vcpu)

-- 
2.55.0


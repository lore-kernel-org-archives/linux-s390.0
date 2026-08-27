Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B39248987A;
	Thu, 27 Aug 2026 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846000; cv=none; b=sv/5yFOA4ZE2WGFmyn6/iV3ywmoOY4AVWCYyj91C13Gvx3v4JG5qI2EVxnFUQOVseJ7DToJCzcdOpuDEGxTjrU5sR1GXUFy/aWdkrmLUQ7wXmjiO07PYp34Dd9HLTRbo6Cc8KwHIKzugOIExhpwnXg9s3zJcyFO/LOxexYa1DMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846000; c=relaxed/simple;
	bh=BTyNHzxH6fbsopItv5ynpgQuiUgyup5oKKkkeJD9/ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I5ZLhlQC8QSTSa/oM1lIYGRJ+6OhFLHqxH2Lere5sLNN1QKFoxyK59CcIGMolRALm8mcDPHWO/0po9EaWKvGDT9FWLkNuj+DxSjNvus0mwgS0zIhro2duQv5Y8lcmQ+q5zndqmMj4tjBvHGaHFY3GBqmdd2k8G3MiF6X76hFcfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n5IWOyfT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n5IWOyfT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF5AMp3328949;
	Thu, 27 Aug 2026 15:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4mpJJs
	ZND4v0B1wR9fNnC3kOU0m2SzSqZgkRdlXNpPw=; b=n5IWOyfT5lwutAOESxQ7DW
	zCb/oIv+6YZJqTQAxbfM5uCOBAdySoW2UdRxhB5RLGbQb+E2pl6gh9gtHfN3ySq5
	0/djng6YBWX4d1jR8xC0lMBmi/g19C9G/KsCiPfAIZwgZb/LRuHH0+marb8W+lG6
	HtfZmRbT5gZftmQUpBMD86Ix+IlN1/m7fdX9DGJXhcyf2SjkmLpUQfTd9ar/8hOD
	IcfNcvPpZMoY0pMmsgCJNc8Uk+MILojZcVef4J4W50H8dIrEOXaashnakQ8nPp/e
	2gIOQIb+TEDLA4RO//ivLXa7gkPg+EROoPJCWzoE3vAJPGlh6Td/6kbPkM1qaB0Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394eefs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFfixB019716;
	Thu, 27 Aug 2026 15:53:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhgtsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFr6dH45875648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:53:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1E8D2004B;
	Thu, 27 Aug 2026 15:53:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1507A20040;
	Thu, 27 Aug 2026 15:53:06 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:53:06 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:56 +0200
Subject: [PATCH v6 16/21] KVM: s390: vsie: Shadow VSIE SCA in guest-1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-16-8020bb53be52@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=22229;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=BTyNHzxH6fbsopItv5ynpgQuiUgyup5oKKkkeJD9/ww=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYoPr3eM4xQ38p896LbVAWE7dXOiD4faIL2WLWeON9
 RWCz1/uKGVhEONikBVTZKkWt86r6mtdOueg5TWYOaxMIEMYuDgFYCJpTxj+57IfCHn2fUX39AWM
 cXNTYsK89bj4Pn7YcDw7+dnBg/UZCowMr5cfZztnoHVnL8PczbNWHOAQKPts7XFDardp6owWPgl
 1JgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: t003xmydii2MccX33luZyS_1rs3eMWCk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX55CCSDaV4i5K
 YX8MOgjFYHeNMpD27CNgwnDV2Z2sboOOtDkVMKBXOsobpiC1AXmpHYMfrje4xHLib6moBgE+FS4
 JFmlqkiZZBOtoobnniKfZT8ZGYmpWnlT/o7tXdjLUvOS8psmrzvzV5yvIpWIdEWUbDEuSs5/PYU
 zgIE8j8DYAd5JMl91YHiMsQPJ3iakDUxjIYhT5SuWwUbbNpKgsn1G+gl42UmnSytAA2sAH5TEel
 zwBK5SxeVSGblnQctpl8SfYoS2x6WHTSjhd6fDqUXSaZQEPLzZTm6dYTlGBm1yg1qBEdqMS8Cus
 i3wgn4DpTENtwyG5Vhh5zU9UJj8KjCTGWdeaNQ1RirHjtrfwnM2HiZHIJvKDzvhZCYMs6U83V7G
 vOIzcaD9M4FR8d7rZYhTeN0/MNqlUZEhzsIggKpgrPVGn/HreUQG26HO7SoksH+8UkHMrDEjIlN
 n3FVBgoLPXhuarcTS/Q==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a905d69 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=16kkdlmzLXXj_dIiwBUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX5cNsO73pi7Ji
 kZPLXYKOu277sww6ChBqfVEtB7oXIEYXsrNxyhsq5O5UjRl9l1mkoHw6LPcjqfMi/aiUCa7QQf9
 v4Vx3hW4GbbIQktabVvjSu78DRYzUKs=
X-Proofpoint-ORIG-GUID: c-S4fKBfwZ1W-WzuuEEBJTaPrASertVl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

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
 arch/s390/include/asm/kvm_host_s390.h       |  21 +-
 arch/s390/include/asm/kvm_host_s390_types.h |   2 +
 arch/s390/kvm/s390/vsie.c                   | 474 ++++++++++++++++++++++++++--
 3 files changed, 468 insertions(+), 29 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index 82bfcc2bec74..9768c9dca27c 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -572,13 +572,32 @@ struct sie_page2 {
 };
 
 struct vsie_page;
+struct vsie_sca;
 
+/*
+ * vsie_pages, scas and accompanied management vars
+ */
 struct kvm_s390_vsie {
+	/*
+	 * protects pages[], page_count, next, addr_to_page
+	 */
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
+	 * - sca_count and sca_next
+	 * - new vsie_sca creation and initialization
+	 */
+	struct rw_semaphore vsie_sca_lock;
+	struct xarray osca_to_sca;
+	int sca_count;
+	int sca_next;
+	struct vsie_sca *scas[KVM_S390_MAX_VSIE_VCPUS];
 };
 
 struct kvm_s390_gisa_iam {
diff --git a/arch/s390/include/asm/kvm_host_s390_types.h b/arch/s390/include/asm/kvm_host_s390_types.h
index 1ac31a54d508..6eef71072b4e 100644
--- a/arch/s390/include/asm/kvm_host_s390_types.h
+++ b/arch/s390/include/asm/kvm_host_s390_types.h
@@ -6,6 +6,7 @@
 #include <linux/atomic.h>
 #include <linux/types.h>
 
+#define KVM_S390_CPU_MASK 0xff
 #define KVM_S390_MAX_VSIE_VCPUS 256
 #define KVM_S390_MAX_SCA_PAGES 5
 
@@ -13,6 +14,7 @@
 #define KVM_S390_ESCA_CPU_SLOTS 248
 
 #define SCB_ALIGNMENT_SHIFT 9
+#define SCA_ALIGNMENT_SHIFT 6
 
 #define SIGP_CTRL_C		0x80
 #define SIGP_CTRL_SCN_MASK	0x3f
diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 69334d4a3231..16273cf5cbff 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -107,6 +107,11 @@ struct vsie_sca {
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
@@ -128,6 +133,17 @@ static void write_scao(struct kvm_s390_sie_block *scb, unsigned long hpa)
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
@@ -939,6 +955,81 @@ static int pin_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
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
+ * Try to find a matching vsie_sca with the correct sca format.
+ * @sca_o_gpa: original system control area address; guest-2 physical
+ * @uses_esca: whether the guest SCB has ECB2_ESCA set
+ *
+ * Called with lock on vsie_sca_lock.
+ */
+static struct vsie_sca *get_vsie_sca_existing(struct kvm *kvm, gpa_t sca_o_gpa, bool uses_esca)
+{
+	struct vsie_sca *vsie_sca = xa_load(&kvm->arch.vsie.osca_to_sca,
+					    sca_o_gpa >> SCA_ALIGNMENT_SHIFT);
+
+	if (!vsie_sca)
+		return NULL;
+	if (uses_esca != test_bit(VSIE_SCA_ESCA, &vsie_sca->flags))
+		return NULL;
+	WARN_ON_ONCE(atomic_inc_return(&vsie_sca->ref_count) < 1);
+	return vsie_sca;
+}
+
+/* Try to find and get a currently unused vsie_sca from the vsie struct. */
+static struct vsie_sca *get_vsie_sca_unused(struct kvm *kvm)
+{
+	struct vsie_sca *vsie_sca;
+	int i, ref_count;
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
@@ -958,6 +1049,135 @@ static struct vsie_sca *alloc_vsie_sca(void)
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
+static int get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_block *scb_o,
+		struct vsie_sca **vsie_sca_out)
+{
+	struct vsie_sca *vsie_sca, *vsie_sca_new = NULL;
+	gpa_t sca_gpa = read_scao(vcpu->kvm, scb_o);
+	bool is_esca = sie_uses_esca(scb_o);
+	struct vsie_page *vsie_page_n;
+	struct kvm *kvm = vcpu->kvm;
+	unsigned int max_vsie_sca;
+	int rc, cpu_nr;
+
+	/* validate scb_o as we do not unshadow on error here */
+	rc = validate_scao(vcpu, scb_o, sca_gpa);
+	if (rc)
+		return rc;
+
+	down_read(&kvm->arch.vsie.vsie_sca_lock);
+	vsie_sca = get_vsie_sca_existing(kvm, sca_gpa, is_esca);
+	up_read(&kvm->arch.vsie.vsie_sca_lock);
+	if (vsie_sca) {
+		*vsie_sca_out = vsie_sca;
+		return 0;
+	}
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
+			return -ENOMEM;
+	}
+
+	/*
+	 * Now we're taking the vsie_sca_lock in write mode so that we can manipulate
+	 * the xarray and arch.vise.scas, etc.
+	 *
+	 * In the next lines we try three things to get an SCA:
+	 *   - Retry getting an existing vsie_sca
+	 *   - Using our newly allocated vsie_sca if we're under the limit
+	 *   - Reusing an vsie_sca including ssca to shadow a different osca
+	 */
+	down_write(&kvm->arch.vsie.vsie_sca_lock);
+	vsie_sca = xa_load(&kvm->arch.vsie.osca_to_sca, sca_gpa >> SCA_ALIGNMENT_SHIFT);
+	if (vsie_sca) {
+		WARN_ON_ONCE(atomic_inc_return(&vsie_sca->ref_count) < 1);
+		if (is_esca == test_bit(VSIE_SCA_ESCA, &vsie_sca->flags))
+			goto out;
+		/* found vsie_sca with matching sca_gpa but wrong format */
+		put_vsie_sca(vsie_sca);
+		xa_erase(&kvm->arch.vsie.osca_to_sca, sca_gpa >> SCA_ALIGNMENT_SHIFT);
+	}
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
+		vsie_sca = get_vsie_sca_unused(kvm);
+		/* with nr_vcpus scas one must be reusable */
+		if (IS_ERR(vsie_sca))
+			goto out;
+
+		/* unused vsie_sca exclusive under vsie_sca_lock write lock */
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
+		set_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
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
+		vsie_sca->sca_gpa = ULONG_MAX;
+		put_vsie_sca(vsie_sca);
+		goto out;
+	}
+
+	rc = xa_insert(&kvm->arch.vsie.osca_to_sca, vsie_sca->sca_gpa >> SCA_ALIGNMENT_SHIFT,
+		       vsie_sca, GFP_KERNEL_ACCOUNT);
+	if (rc == -EBUSY)
+		rc = 1;
+
+out:
+	up_write(&kvm->arch.vsie.vsie_sca_lock);
+	if (vsie_sca_new)
+		free_vsie_sca(kvm, vsie_sca_new);
+	if (vsie_sca)
+		*vsie_sca_out = vsie_sca;
+	return rc;
+}
+
 void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, gpa_t start, gpa_t end)
 {
 	struct vsie_page *cur, *next;
@@ -1024,11 +1244,12 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
+			write_scao(scb_s, 0);
+		}
 	}
 
 	hpa = scb_s->itdba;
@@ -1067,9 +1288,6 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
  * This works as long as the data lies in one page. If blocks ever exceed one
  * page, we have to fall back to shadowing.
  *
- * As we reuse the sca, the vcpu pointers contained in it are invalid. We must
- * therefore not enable any facilities that access these pointers (e.g. SIGPIF).
- *
  * Returns: - 0 if all blocks were pinned.
  *          - > 0 if control has to be given to guest 2
  *          - -ENOMEM if out of memory
@@ -1082,8 +1300,8 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	gpa_t gpa;
 	int rc = 0;
 
-	gpa = read_scao(vcpu->kvm, scb_o);
-	if (gpa) {
+	gpa = vsie_page->sca_gpa;
+	if (gpa && !vsie_page->vsie_sca) {
 		rc = validate_scao(vcpu, scb_s, gpa);
 		if (rc)
 			goto unpin;
@@ -1092,7 +1310,6 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			rc = set_validity_icpt(scb_s, 0x0034U);
 			goto unpin;
 		}
-		vsie_page->sca_gpa = gpa;
 		write_scao(scb_s, hpa);
 	}
 
@@ -1633,7 +1850,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		 */
 		if (kvm_s390_vcpu_has_irq(vcpu, 0) ||
 		    kvm_s390_vcpu_sie_inhibited(vcpu)) {
-			kvm_s390_rewind_psw(vcpu, 4);
+			rc = -EAGAIN;
 			break;
 		}
 		if (sg)
@@ -1827,12 +2044,165 @@ static int get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr,
 	return 0;
 }
 
-int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
+static int get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie_sca *vsie_sca, gpa_t scb_gpa,
+				u16 cpu_nr, struct vsie_page **vsie_page_out)
 {
-	struct vsie_page *vsie_page;
-	unsigned long scb_addr;
+	struct vsie_page *vsie_page, *vsie_page_new = NULL;
 	int rc;
 
+	vsie_page = vsie_sca->pages[cpu_nr];
+	if (!vsie_page) {
+		vsie_page_new = alloc_vsie_page(vcpu->kvm);
+		if (!vsie_page_new)
+			return -ENOMEM;
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
+			return -EAGAIN;
+		vsie_page->vsie_sca = vsie_sca;
+	}
+	if (vsie_page->scb_gpa != scb_gpa || vsie_page->sca_gpa != vsie_sca->sca_gpa) {
+		scoped_guard(mutex, &vcpu->kvm->arch.vsie.mutex) {
+			unpin_scb(vcpu->kvm, vsie_page);
+			rc = init_vsie_page(vcpu, vsie_page, scb_gpa);
+		}
+		if (rc) {
+			put_vsie_page(vsie_page);
+			return rc;
+		}
+
+		reset_vsie_page(vcpu->kvm, vsie_page);
+	}
+
+	*vsie_page_out = vsie_page;
+	return 0;
+}
+
+static void update_vsie_sca(struct vsie_sca *vsie_sca, unsigned int cpu_nr,
+			    struct vsie_page *vsie_page_n, hpa_t sca_o_entry_hpa)
+{
+	guard(mutex)(&vsie_sca->mutex);
+
+	WRITE_ONCE(vsie_sca->ssca.cpu[cpu_nr].ssda, virt_to_phys(&vsie_page_n->scb_s));
+	WRITE_ONCE(vsie_sca->ssca.cpu[cpu_nr].ossea, sca_o_entry_hpa);
+	WRITE_ONCE(vsie_sca->pages[cpu_nr], vsie_page_n);
+}
+
+static int _shadow_sca_cpu(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+			   struct vsie_sca *vsie_sca, hpa_t sca_o_entry_hpa,
+			   unsigned int cpu_nr, bool is_esca)
+{
+	hva_t sca_o_entry_hva = (hva_t)phys_to_virt(sca_o_entry_hpa);
+	struct vsie_page *vsie_page_n;
+	gpa_t scb_o_gpa;
+	int rc;
+
+	if (is_esca)
+		scb_o_gpa = ((struct esca_entry *)sca_o_entry_hva)->sda;
+	else
+		scb_o_gpa = ((struct bsca_entry *)sca_o_entry_hva)->sda;
+	if (scb_o_gpa & 0x1ffUL)
+		return set_validity_icpt(vsie_page->scb_o, 0x0001U);
+
+	rc = get_vsie_page_cpu_nr(vcpu, vsie_sca, scb_o_gpa, cpu_nr, &vsie_page_n);
+	if (rc)
+		return rc;
+
+	rc = shadow_scb(vcpu, vsie_page_n);
+	update_vsie_sca(vsie_sca, cpu_nr, vsie_page_n, sca_o_entry_hpa);
+	if (rc) {
+		/* copy intercept to primary scb_o, no unshadow_scb() on exit */
+		unshadow_intercept(vsie_page->scb_o, &vsie_page_n->scb_s);
+		rc = 1;
+	}
+	put_vsie_page(vsie_page_n);
+
+	return rc;
+}
+
+/* Fill the shadow system control area used for VSIE SIGPI. */
+static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+		       struct vsie_sca *vsie_sca)
+{
+	bool is_esca = sie_uses_esca(vsie_page->scb_o);
+	unsigned int cpu_nr, cpu_slots;
+	hpa_t sca_o_entry_hpa;
+	unsigned long *mcn;
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
+			break;
+
+		if ((vsie_page->scb_o->icpua & KVM_S390_CPU_MASK) == cpu_nr) {
+			update_vsie_sca(vsie_sca, cpu_nr, vsie_page, sca_o_entry_hpa);
+			continue;
+		}
+
+		rc = _shadow_sca_cpu(vcpu, vsie_page, vsie_sca, sca_o_entry_hpa, cpu_nr, is_esca);
+		if (rc)
+			break;
+	}
+
+	if (rc) {
+		vsie_sca->ssca.osca = 0;
+		for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots) {
+			vsie_sca->ssca.cpu[cpu_nr].ssda = 0;
+			vsie_sca->ssca.cpu[cpu_nr].ossea = 0;
+		}
+	} else {
+		vsie_sca->ssca.osca = sca_o_hpa(vsie_sca);
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
+	if (!rc)
+		write_scao(&vsie_page->scb_s, virt_to_phys(&vsie_sca->ssca));
+
+	return rc;
+}
+
+int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
+{
+	struct vsie_page *vsie_page = NULL;
+	struct vsie_sca *vsie_sca = NULL;
+	struct kvm_s390_sie_block *scb_o;
+	gpa_t scb_addr;
+	hpa_t scb_hpa;
+	int rc = 0;
+
 	vcpu->stat.instruction_sie++;
 	if (!test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_SIEF2))
 		return -EOPNOTSUPP;
@@ -1850,35 +2220,60 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	rc = get_vsie_page(vcpu, scb_addr, &vsie_page);
-	if (rc) {
-		if (rc == -EBUSY) {
-			/* double use of sie control block - simply do nothing */
-			kvm_s390_rewind_psw(vcpu, 4);
-			return 0;
-		} else {
-			return PTR_ERR(vsie_page);
-		}
+	rc = pin_guest_page(vcpu->kvm, scb_addr, &scb_hpa);
+	if (rc)
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	scb_o = (struct kvm_s390_sie_block *)phys_to_virt(scb_hpa);
+
+	if (!use_ssca(vcpu->kvm, scb_o)) {
+		/* get the vsie_page with pinned scb_o */
+		rc = get_vsie_page(vcpu, scb_addr, &vsie_page);
+		if (rc)
+			goto out_unpin;
+		vsie_page->vsie_sca = NULL;
+	} else {
+		/* get the vsie_sca with pinned original sca */
+		rc = get_vsie_sca(vcpu, scb_o, &vsie_sca);
+		if (rc)
+			goto out_unpin;
+		rc = get_vsie_page_cpu_nr(vcpu, vsie_sca, scb_addr,
+					  scb_o->icpua & KVM_S390_CPU_MASK, &vsie_page);
+		if (rc)
+			goto out_put_sca;
 	}
 
-	rc = pin_scb(vcpu, vsie_page);
-	if (rc)
-		goto out_put;
 	rc = shadow_scb(vcpu, vsie_page);
 	if (rc)
 		goto out_put;
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
 
@@ -1887,6 +2282,8 @@ void kvm_s390_vsie_init(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.vsie.mutex);
 	xa_init_flags(&kvm->arch.vsie.addr_to_page, XA_FLAGS_ACCOUNT);
+	init_rwsem(&kvm->arch.vsie.vsie_sca_lock);
+	xa_init_flags(&kvm->arch.vsie.osca_to_sca, XA_FLAGS_ACCOUNT);
 }
 
 static void kvm_s390_vsie_destroy_page(struct kvm *kvm, struct vsie_page *vsie_page)
@@ -1900,7 +2297,8 @@ static void kvm_s390_vsie_destroy_page(struct kvm *kvm, struct vsie_page *vsie_p
 void kvm_s390_vsie_destroy(struct kvm *kvm)
 {
 	struct vsie_page *vsie_page;
-	int i;
+	struct vsie_sca *vsie_sca;
+	int i, cpu_nr;
 
 	guard(mutex)(&kvm->arch.vsie.mutex);
 
@@ -1911,7 +2309,27 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
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


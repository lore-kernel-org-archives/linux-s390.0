Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ABC3D88E8;
	Thu, 23 Apr 2026 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776988414; cv=none; b=af9NeWdESdWO/0ScmqMA7Behqs6A96GcZf7ugke7vF4crtH8mNRsX0kSKarhw1RiYMnGpC+lKhZ6kHA+Xns2xg2NW9mNEcqlB07bpnODatbMHKlyripZWb0ZQRecl3MnZmeLQzq85TbRsETsD7lk083q2fv1Gfck3e5/kexYz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776988414; c=relaxed/simple;
	bh=+mO1bkLeOZjlhb765GjstpMREBuR62qTMhN1JeYvXfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCf3US2awMJ2ppX4S3tRy9hYv3bo8y/7NQ2aDPf2FH+GxI2KTw1e7FYQcqpsc+s4Pji8mKCBOQziWRMcvW895/Bq+5BdsQyfQ0e3GQ3BWctQogTv7odrqxMNvmWe0dn/ciZhbTnh5dRvIomggCRDRy1gxbybMLNM8o7upXfsJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ajwB/ZZ7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ajwB/ZZ7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NHYmlQ3229123;
	Thu, 23 Apr 2026 23:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QVMP1zqeZEiMQf26C
	6VKxmr9X92jcvAYW7OCVqSlrhs=; b=ajwB/ZZ7HViOXItl51rcIqmzTQoQmzpwr
	+UUf5852+7QvBgHBVBoZrgDc21hQ19UrxZR3tCcwJVgELuwY69AldUgcFt6arodn
	Q198cye5TiwML+6q3IlfimlJm+JjaJDWPdbx0D3s4KAnekvzQE9kzojpcM+mAFjq
	5c9SXef0vbdza0TIBWH7ph2Ghf37a2A9vBZM1+o5fDfip1o8WGpUKjclFwGKlrrl
	rTYMtMVvS/ErjWAiIWg80ZLjt0uOqJ13BmYfaFB7lGZa09G/oFDapK5XwyaVM2JQ
	fslGDgnSCIlqVjlUfkc9g+qZwddsnoM1zP20DfUmcNmi53KSbZXfg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2b9bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 23:53:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NNoXaa006832;
	Thu, 23 Apr 2026 23:53:29 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky0paa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 23:53:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NNrShm26149546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 23:53:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A17E95805D;
	Thu, 23 Apr 2026 23:53:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DECE358052;
	Thu, 23 Apr 2026 23:53:27 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 23:53:27 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v4 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject
Date: Fri, 24 Apr 2026 01:53:16 +0200
Message-ID: <20260423235316.3665-4-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423235316.3665-1-freimuth@linux.ibm.com>
References: <20260423235316.3665-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tAji8rBexD_B0_pCzBrplPQUFTrBcmrg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDIzMiBTYWx0ZWRfX1bakF1TgDLFO
 3IpbSrfJ5wL/FHIxGtLpkIsuu0TyNi5SrSeiT2iiZkUV8/FuKpM3Knx2cl7I3WGdipxjLJkC0HQ
 ONAAW/CwNoxpdF4p4CE2IyvDZEWeatosdU/HNPVF4taTo9jovp1GAvT6Xj4Z9h7jaWuJbMfwt14
 NslHvwqRPq7jZJ3Wat269DgYQGzXUUQ9OLdHjE2Uu2BJTq+RAMHf05iC9GlU0Z63iNomMoOIumk
 N5utLTXbSmZx5bNi9XlR+Df0dqFArwnjXWirZniDn5x+40rlD/1eBS8SmMJYWLMGipGKmjaYoBW
 j+ZRUfEXFC1ZedQPKPhJnv/aWfeIF90fhZv2jsfr0HOd5cCECtexe6mH6kdwukJr3IwzRyH2glg
 TjUGm2AZ+jeZx3i9QCp5ARuhg5QSFhF7TwNvzYaqoDdhmz32BuQWDkidJH/pACojo0xwtzB5ZjX
 us4IbWCeOHvKlAYRGfg==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69eab0fa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=IXbFIl4MR9N5CccVwUwA:9
X-Proofpoint-ORIG-GUID: tAji8rBexD_B0_pCzBrplPQUFTrBcmrg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230232

S390 needs a fast path for irq injection, and along those lines we
introduce kvm_arch_set_irq_inatomic. Instead of placing all interrupts on
the global work queue as it does today, this patch provides a fast path for
irq injection.

The inatomic fast path cannot lose control since it is running with
interrupts disabled. This meant making the following changes that exist on
the slow path today. First, the adapter_indicators page needs to be mapped
since it is accessed with interrupts disabled, so we added map/unmap
functions. Second, access to shared resources between the fast and slow
paths needed to be changed from mutex and semaphores to raw_spin_lock's.
Finally, the memory allocation on the slow path utilizes GFP_KERNEL_ACCOUNT
but we had to implement the fast path with GFP_ATOMIC allocation. Each of
these enhancements were required to prevent blocking on the fast inject
path.

Fencing of Fast Inject in Secure Execution environments is enabled in the
patch series by not mapping adapter indicator pages. In Secure Execution
environments the path of execution available before this patch is followed.

Statistical counters have been added to enable analysis of irq injection on
the fast path and slow path including io_390_inatomic, io_flic_inject_airq,
io_set_adapter_int and io_390_inatomic_adapter_masked.

Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   6 +-
 arch/s390/kvm/interrupt.c        | 160 +++++++++++++++++++++++++++----
 arch/s390/kvm/kvm-s390.c         |  26 +++--
 arch/s390/kvm/kvm-s390.h         |   3 +-
 4 files changed, 170 insertions(+), 25 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index e84532eca75f..69f456e264b0 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -359,7 +359,7 @@ struct kvm_s390_float_interrupt {
 	struct kvm_s390_mchk_info mchk;
 	struct kvm_s390_ext_info srv_signal;
 	int last_sleep_cpu;
-	struct mutex ais_lock;
+	raw_spinlock_t ais_lock;
 	u8 simm;
 	u8 nimm;
 };
@@ -450,6 +450,10 @@ struct kvm_vm_stat {
 	u64 inject_io;
 	u64 io_390_adapter_map;
 	u64 io_390_adapter_unmap;
+	u64 io_390_inatomic;
+	u64 io_flic_inject_airq;
+	u64 io_set_adapter_int;
+	u64 io_390_inatomic_adapter_masked;
 	u64 inject_float_mchk;
 	u64 inject_pfault_done;
 	u64 inject_service_signal;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index c75fb3f19bb0..f714a3bb7f93 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1963,15 +1963,10 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 }
 
 int kvm_s390_inject_vm(struct kvm *kvm,
-		       struct kvm_s390_interrupt *s390int)
+		       struct kvm_s390_interrupt *s390int, struct kvm_s390_interrupt_info *inti)
 {
-	struct kvm_s390_interrupt_info *inti;
 	int rc;
 
-	inti = kzalloc_obj(*inti, GFP_KERNEL_ACCOUNT);
-	if (!inti)
-		return -ENOMEM;
-
 	inti->type = s390int->type;
 	switch (inti->type) {
 	case KVM_S390_INT_VIRTIO:
@@ -2007,6 +2002,7 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 				 2);
 
 	rc = __inject_vm(kvm, inti);
+	/* memory allocation is done by the caller and inti is passed in, we free it here */
 	if (rc)
 		kfree(inti);
 	return rc;
@@ -2284,6 +2280,7 @@ static int flic_ais_mode_get_all(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 	struct kvm_s390_ais_all ais;
+	unsigned long flags;
 
 	if (attr->attr < sizeof(ais))
 		return -EINVAL;
@@ -2291,10 +2288,10 @@ static int flic_ais_mode_get_all(struct kvm *kvm, struct kvm_device_attr *attr)
 	if (!test_kvm_facility(kvm, 72))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&fi->ais_lock);
+	raw_spin_lock_irqsave(&fi->ais_lock, flags);
 	ais.simm = fi->simm;
 	ais.nimm = fi->nimm;
-	mutex_unlock(&fi->ais_lock);
+	raw_spin_unlock_irqrestore(&fi->ais_lock, flags);
 
 	if (copy_to_user((void __user *)attr->addr, &ais, sizeof(ais)))
 		return -EFAULT;
@@ -2648,6 +2645,7 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 	struct kvm_s390_ais_req req;
 	int ret = 0;
+	unsigned long flags;
 
 	if (!test_kvm_facility(kvm, 72))
 		return -EOPNOTSUPP;
@@ -2664,7 +2662,7 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
 				       2 : KVM_S390_AIS_MODE_SINGLE :
 				       KVM_S390_AIS_MODE_ALL, req.mode);
 
-	mutex_lock(&fi->ais_lock);
+	raw_spin_lock_irqsave(&fi->ais_lock, flags);
 	switch (req.mode) {
 	case KVM_S390_AIS_MODE_ALL:
 		fi->simm &= ~AIS_MODE_MASK(req.isc);
@@ -2677,7 +2675,7 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
 	default:
 		ret = -EINVAL;
 	}
-	mutex_unlock(&fi->ais_lock);
+	raw_spin_unlock_irqrestore(&fi->ais_lock, flags);
 
 	return ret;
 }
@@ -2691,25 +2689,33 @@ static int kvm_s390_inject_airq(struct kvm *kvm,
 		.parm = 0,
 		.parm64 = isc_to_int_word(adapter->isc),
 	};
+	struct kvm_s390_interrupt_info *inti;
+	unsigned long flags;
+
 	int ret = 0;
 
+	inti = kzalloc_obj(*inti, GFP_KERNEL_ACCOUNT);
+	if (!inti)
+		return -ENOMEM;
+
 	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible)
-		return kvm_s390_inject_vm(kvm, &s390int);
+		return kvm_s390_inject_vm(kvm, &s390int, inti);
 
-	mutex_lock(&fi->ais_lock);
+	raw_spin_lock_irqsave(&fi->ais_lock, flags);
 	if (fi->nimm & AIS_MODE_MASK(adapter->isc)) {
 		trace_kvm_s390_airq_suppressed(adapter->id, adapter->isc);
+		kfree(inti);
 		goto out;
 	}
 
-	ret = kvm_s390_inject_vm(kvm, &s390int);
+	ret = kvm_s390_inject_vm(kvm, &s390int, inti);
 	if (!ret && (fi->simm & AIS_MODE_MASK(adapter->isc))) {
 		fi->nimm |= AIS_MODE_MASK(adapter->isc);
 		trace_kvm_s390_modify_ais_mode(adapter->isc,
 					       KVM_S390_AIS_MODE_SINGLE, 2);
 	}
 out:
-	mutex_unlock(&fi->ais_lock);
+	raw_spin_unlock_irqrestore(&fi->ais_lock, flags);
 	return ret;
 }
 
@@ -2718,6 +2724,8 @@ static int flic_inject_airq(struct kvm *kvm, struct kvm_device_attr *attr)
 	unsigned int id = attr->attr;
 	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
 
+	kvm->stat.io_flic_inject_airq++;
+
 	if (!adapter)
 		return -EINVAL;
 
@@ -2728,6 +2736,7 @@ static int flic_ais_mode_set_all(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 	struct kvm_s390_ais_all ais;
+	unsigned long flags;
 
 	if (!test_kvm_facility(kvm, 72))
 		return -EOPNOTSUPP;
@@ -2735,10 +2744,10 @@ static int flic_ais_mode_set_all(struct kvm *kvm, struct kvm_device_attr *attr)
 	if (copy_from_user(&ais, (void __user *)attr->addr, sizeof(ais)))
 		return -EFAULT;
 
-	mutex_lock(&fi->ais_lock);
+	raw_spin_lock_irqsave(&fi->ais_lock, flags);
 	fi->simm = ais.simm;
 	fi->nimm = ais.nimm;
-	mutex_unlock(&fi->ais_lock);
+	raw_spin_unlock_irqrestore(&fi->ais_lock, flags);
 
 	return 0;
 }
@@ -2904,6 +2913,7 @@ static int adapter_indicators_set(struct kvm *kvm,
 		set_bit(bit, map);
 		raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
 	}
+
 	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
 	summary_info = get_map_info(adapter, adapter_int->summary_addr);
 	if (!summary_info) {
@@ -2939,6 +2949,44 @@ static int adapter_indicators_set(struct kvm *kvm,
 	return summary_set ? 0 : 1;
 }
 
+static int adapter_indicators_set_fast(struct kvm *kvm,
+				       struct s390_io_adapter *adapter,
+				       struct kvm_s390_adapter_int *adapter_int,
+				       int setbit)
+{
+	unsigned long bit;
+	int summary_set;
+	struct s390_map_info *ind_info, *summary_info;
+	void *map;
+
+	raw_spin_lock(&adapter->maps_lock);
+	ind_info = get_map_info(adapter, adapter_int->ind_addr);
+	if (!ind_info) {
+		raw_spin_unlock(&adapter->maps_lock);
+		return -EWOULDBLOCK;
+	}
+	map = page_address(ind_info->page);
+	bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
+	if (setbit)
+		set_bit(bit, map);
+	else
+		clear_bit(bit, map);
+	summary_info = get_map_info(adapter, adapter_int->summary_addr);
+	if (!summary_info) {
+		raw_spin_unlock(&adapter->maps_lock);
+		return -EWOULDBLOCK;
+	}
+	map = page_address(summary_info->page);
+	bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
+			  adapter->swap);
+	if (setbit)
+		summary_set = test_and_set_bit(bit, map);
+	else
+		summary_set = test_and_clear_bit(bit, map);
+	raw_spin_unlock(&adapter->maps_lock);
+	return summary_set ? 0 : 1;
+}
+
 /*
  * < 0 - not injected due to error
  * = 0 - coalesced, summary indicator already active
@@ -2951,6 +2999,8 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
 	int ret;
 	struct s390_io_adapter *adapter;
 
+	kvm->stat.io_set_adapter_int++;
+
 	/* We're only interested in the 0->1 transition. */
 	if (!level)
 		return 0;
@@ -3019,7 +3069,6 @@ int kvm_set_routing_entry(struct kvm *kvm,
 	int idx;
 
 	switch (ue->type) {
-	/* we store the userspace addresses instead of the guest addresses */
 	case KVM_IRQ_ROUTING_S390_ADAPTER:
 		if (kvm_is_ucontrol(kvm))
 			return -EINVAL;
@@ -3610,3 +3659,80 @@ int __init kvm_s390_gib_init(u8 nisc)
 out:
 	return rc;
 }
+
+/*
+ * kvm_arch_set_irq_inatomic: fast-path for irqfd injection
+ */
+int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
+			      struct kvm *kvm, int irq_source_id, int level,
+			      bool line_status)
+{
+	int ret, setbit;
+	struct s390_io_adapter *adapter;
+	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+	struct kvm_s390_interrupt_info *inti;
+	struct kvm_s390_interrupt s390int = {
+			.type = KVM_S390_INT_IO(1, 0, 0, 0),
+			.parm = 0,
+	};
+
+	kvm->stat.io_390_inatomic++;
+
+	/* We're only interested in the 0->1 transition. */
+	if (!level)
+		return -EWOULDBLOCK;
+	if (e->type != KVM_IRQ_ROUTING_S390_ADAPTER)
+		return -EWOULDBLOCK;
+
+	adapter = get_io_adapter(kvm, e->adapter.adapter_id);
+	if (!adapter)
+		return -EWOULDBLOCK;
+
+	s390int.parm64 = isc_to_int_word(adapter->isc);
+	setbit = 1;
+	ret = adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
+	if (ret < 0)
+		return -EWOULDBLOCK;
+	if (!ret || adapter->masked) {
+		kvm->stat.io_390_inatomic_adapter_masked++;
+		return 0;
+	}
+
+	inti = kzalloc_obj(*inti, GFP_ATOMIC);
+	if (!inti)
+		return -EWOULDBLOCK;
+
+	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible) {
+		ret = kvm_s390_inject_vm(kvm, &s390int, inti);
+		if (ret == 0) {
+			return ret;
+		} else {
+			setbit = 0;
+			adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
+			return -EWOULDBLOCK;
+		}
+	}
+
+	raw_spin_lock(&fi->ais_lock);
+	if (fi->nimm & AIS_MODE_MASK(adapter->isc)) {
+		trace_kvm_s390_airq_suppressed(adapter->id, adapter->isc);
+		kfree(inti);
+		goto out;
+	}
+
+	ret = kvm_s390_inject_vm(kvm, &s390int, inti);
+	if (!ret && (fi->simm & AIS_MODE_MASK(adapter->isc))) {
+		fi->nimm |= AIS_MODE_MASK(adapter->isc);
+		trace_kvm_s390_modify_ais_mode(adapter->isc,
+					       KVM_S390_AIS_MODE_SINGLE, 2);
+	} else if (ret) {
+		raw_spin_unlock(&fi->ais_lock);
+		setbit = 0;
+		adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
+		return -EWOULDBLOCK;
+	}
+
+out:
+	raw_spin_unlock(&fi->ais_lock);
+	return 0;
+}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d1e1bed42c79..0b3e44f6fa79 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -70,6 +70,10 @@ const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	STATS_DESC_COUNTER(VM, inject_io),
 	STATS_DESC_COUNTER(VM, io_390_adapter_map),
 	STATS_DESC_COUNTER(VM, io_390_adapter_unmap),
+	STATS_DESC_COUNTER(VM, io_390_inatomic),
+	STATS_DESC_COUNTER(VM, io_flic_inject_airq),
+	STATS_DESC_COUNTER(VM, io_set_adapter_int),
+	STATS_DESC_COUNTER(VM, io_390_inatomic_adapter_masked),
 	STATS_DESC_COUNTER(VM, inject_float_mchk),
 	STATS_DESC_COUNTER(VM, inject_pfault_done),
 	STATS_DESC_COUNTER(VM, inject_service_signal),
@@ -2872,6 +2876,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	void __user *argp = (void __user *)arg;
 	struct kvm_device_attr attr;
 	int r;
+	struct kvm_s390_interrupt_info *inti;
 
 	switch (ioctl) {
 	case KVM_S390_INTERRUPT: {
@@ -2880,7 +2885,10 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = -EFAULT;
 		if (copy_from_user(&s390int, argp, sizeof(s390int)))
 			break;
-		r = kvm_s390_inject_vm(kvm, &s390int);
+		inti = kzalloc_obj(*inti, GFP_KERNEL_ACCOUNT);
+		if (!inti)
+			return -ENOMEM;
+		r = kvm_s390_inject_vm(kvm, &s390int, inti);
 		break;
 	}
 	case KVM_CREATE_IRQCHIP: {
@@ -3278,7 +3286,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		mutex_unlock(&kvm->lock);
 	}
 
-	mutex_init(&kvm->arch.float_int.ais_lock);
+	raw_spin_lock_init(&kvm->arch.float_int.ais_lock);
 	spin_lock_init(&kvm->arch.float_int.lock);
 	for (i = 0; i < FIRQ_LIST_COUNT; i++)
 		INIT_LIST_HEAD(&kvm->arch.float_int.lists[i]);
@@ -4399,28 +4407,34 @@ int kvm_s390_try_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clo
 	return 1;
 }
 
-static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
-				      unsigned long token)
+static int __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
+				     unsigned long token)
 {
 	struct kvm_s390_interrupt inti;
 	struct kvm_s390_irq irq;
+	struct kvm_s390_interrupt_info *inti_mem = NULL;
 
 	if (start_token) {
 		irq.u.ext.ext_params2 = token;
 		irq.type = KVM_S390_INT_PFAULT_INIT;
 		WARN_ON_ONCE(kvm_s390_inject_vcpu(vcpu, &irq));
 	} else {
+		inti_mem = kzalloc_obj(*inti_mem, GFP_KERNEL_ACCOUNT);
+		if (!inti_mem)
+			return -ENOMEM;
+
 		inti.type = KVM_S390_INT_PFAULT_DONE;
 		inti.parm64 = token;
-		WARN_ON_ONCE(kvm_s390_inject_vm(vcpu->kvm, &inti));
+		WARN_ON_ONCE(kvm_s390_inject_vm(vcpu->kvm, &inti, inti_mem));
 	}
+	return 0;
 }
 
 bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
 				     struct kvm_async_pf *work)
 {
 	trace_kvm_s390_pfault_init(vcpu, work->arch.pfault_token);
-	__kvm_inject_pfault_token(vcpu, true, work->arch.pfault_token);
+	WARN_ON_ONCE(__kvm_inject_pfault_token(vcpu, true, work->arch.pfault_token));
 
 	return true;
 }
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index bf1d7798c1af..2f2da868a040 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -373,7 +373,8 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_float_irqs(struct kvm *kvm);
 int __must_check kvm_s390_inject_vm(struct kvm *kvm,
-				    struct kvm_s390_interrupt *s390int);
+				    struct kvm_s390_interrupt *s390int,
+				    struct kvm_s390_interrupt_info *inti);
 int __must_check kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 				      struct kvm_s390_irq *irq);
 static inline int kvm_s390_inject_prog_irq(struct kvm_vcpu *vcpu,
-- 
2.52.0


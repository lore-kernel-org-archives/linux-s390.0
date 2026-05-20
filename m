Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0257225A38;
	Wed, 20 May 2026 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293093; cv=none; b=BhlcSQn2myPIHnXDMKqeQs1aMNgTsK7sW/Oz/4bXf8Y6M2eDRnwB99hQC9bqLg1G56qBn09WVvUgGkqCB3GsmMZUC4xbBWhxvmIoYsE4LOT4MAb+dfLO14MmG+11rNjg2qvfksEHtFs0kRZvxHGUVEAW9dbjoj8tCsAZFjucEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293093; c=relaxed/simple;
	bh=vnY8HtY3ZfdtxwnogJs9WQylaKX5H/hAn9QTZf2VUfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0+PIX8lgb1CQJfnljtvAjCxzmsIIUd6NEbg2jDPaf4lUBXsjmSEYY5nHySUuz7SPd5btbFNgCR7DvcjceOUX5mW9lYqjlZpQRgllAE9q+PXewTw3PVbv488LWE7okfhz7aU28NkIqoyz9QnXaIacMpGFOgVnfIDbgiZCjf21dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cf42gLtT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cf42gLtT"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K4UGaG3760653;
	Wed, 20 May 2026 16:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CrLuAEqAkjQjKspuU
	cHnQvniDbCAohrCTV/tWWrDQAQ=; b=cf42gLtTpRwi1PQ8yXke3w1rfbdwNhf5/
	h1LiLlqwACiQOc/1A2XP1975eE7f0JJ5Pu94jLEgRA9Znu2NH9SZOiSmubamoOkB
	wWYEbfXvbfEdHvahuawFttafjYVquFB2u6buZXW6q+twLQWmWbfILhi+3NjeibLp
	pbxQR+9umDFOd32An/IuHvqTNUbv7zxtnT/hpJeZa5KsPf0sZEu8zWs7PJ3jA2UL
	zu85bFEZroD/eHRacmVzRK2sl0t3lDuMz7L/c4khAHwzMEZbUNBswQJnkfoiOYC+
	Wty7UlY6dCMsrSESZqNBiMTWPwyR70AFEDwk72wK5YopqmiJAFDMw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h752wad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 16:04:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFs4uj007963;
	Wed, 20 May 2026 16:04:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq89u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 16:04:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KG4kQm20447922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 16:04:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A4E75805A;
	Wed, 20 May 2026 16:04:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8FDE5803F;
	Wed, 20 May 2026 16:04:45 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 16:04:45 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v7 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject
Date: Wed, 20 May 2026 18:04:42 +0200
Message-ID: <20260520160442.1051999-4-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520160442.1051999-1-freimuth@linux.ibm.com>
References: <20260520160442.1051999-1-freimuth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0ddba0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=IXbFIl4MR9N5CccVwUwA:9
X-Proofpoint-ORIG-GUID: -nI-oUhp1RXUf9UCV3zEwFz4gMT2npz1
X-Proofpoint-GUID: -nI-oUhp1RXUf9UCV3zEwFz4gMT2npz1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1MSBTYWx0ZWRfX9WxatKHofE2I
 Y/DfvVDxIUJZ2RvcDb7dXxhbiZiHKzXCBXPW53ZGjGFgGxUNtc36waPZFFZH9PZ7cEuBdwo72tx
 54vc7O47jAp1Ar5f2Km973+W/iAfK8V//HiZzGtkoyod3qSTOP6Ar++/v3PHviDJM+h2QZWOnnV
 g6N/1AK1TPPH0PGb7mQMRgx8h+hQWP3neuInMcpNoCP9rk0JAu7SFowhRI/s79GjpSD7ojAIPL0
 qMXpRgbgvlGpwDY41ZL96cSZVurplMKihFgcunuuEyx/msnSFRkR+CbWGuS2l7HYmL7jmI65cfw
 bZOMBG1TKTB8dFa89dqLK0MtCUI9YTGh3/AwZn4HiOYZdHI6p9KeGamPeJ2oxiosFnk4rEUSn4i
 l6kraHoHunpR9lVmDGXT/VI7sQin6UsQvqfI2oa6ml3HGxtDGYziqpCyrP8wCeXtA42QppajFXC
 n9tXwCw5/wFYB55a97A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200151

s390 needs a fast path for irq injection, and along those lines we
introduce kvm_arch_set_irq_inatomic. Instead of placing all interrupts on
the global work queue as it does today, this patch provides a fast path for
irq injection.

The inatomic fast path cannot lose control since it is running with
interrupts disabled. This meant making the following changes that exist on
the slow path today. First, the adapter_indicators page needs to be mapped
since it is accessed with interrupts disabled, so we added map/unmap
functions. Second, access to shared resources between the fast and slow
paths needed to be changed from mutex and semaphores to spin_lock's.
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
 arch/s390/kvm/interrupt.c        | 181 +++++++++++++++++++++++++++----
 arch/s390/kvm/kvm-s390.c         |  27 ++++-
 arch/s390/kvm/kvm-s390.h         |   3 +-
 4 files changed, 189 insertions(+), 28 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 0056cc9414a0..714c83897416 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -359,7 +359,7 @@ struct kvm_s390_float_interrupt {
 	struct kvm_s390_mchk_info mchk;
 	struct kvm_s390_ext_info srv_signal;
 	int last_sleep_cpu;
-	struct mutex ais_lock;
+	spinlock_t ais_lock;
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
index c41461b6f365..35ce66f98983 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1966,15 +1966,10 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
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
@@ -2010,8 +2005,7 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 				 2);
 
 	rc = __inject_vm(kvm, inti);
-	if (rc)
-		kfree(inti);
+
 	return rc;
 }
 
@@ -2287,6 +2281,7 @@ static int flic_ais_mode_get_all(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 	struct kvm_s390_ais_all ais;
+	unsigned long flags;
 
 	if (attr->attr < sizeof(ais))
 		return -EINVAL;
@@ -2294,10 +2289,10 @@ static int flic_ais_mode_get_all(struct kvm *kvm, struct kvm_device_attr *attr)
 	if (!test_kvm_facility(kvm, 72))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&fi->ais_lock);
+	spin_lock_irqsave(&fi->ais_lock, flags);
 	ais.simm = fi->simm;
 	ais.nimm = fi->nimm;
-	mutex_unlock(&fi->ais_lock);
+	spin_unlock_irqrestore(&fi->ais_lock, flags);
 
 	if (copy_to_user((void __user *)attr->addr, &ais, sizeof(ais)))
 		return -EFAULT;
@@ -2676,6 +2671,7 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 	struct kvm_s390_ais_req req;
 	int ret = 0;
+	unsigned long flags;
 
 	if (!test_kvm_facility(kvm, 72))
 		return -EOPNOTSUPP;
@@ -2692,7 +2688,7 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
 				       2 : KVM_S390_AIS_MODE_SINGLE :
 				       KVM_S390_AIS_MODE_ALL, req.mode);
 
-	mutex_lock(&fi->ais_lock);
+	spin_lock_irqsave(&fi->ais_lock, flags);
 	switch (req.mode) {
 	case KVM_S390_AIS_MODE_ALL:
 		fi->simm &= ~AIS_MODE_MASK(req.isc);
@@ -2705,7 +2701,7 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
 	default:
 		ret = -EINVAL;
 	}
-	mutex_unlock(&fi->ais_lock);
+	spin_unlock_irqrestore(&fi->ais_lock, flags);
 
 	return ret;
 }
@@ -2719,25 +2715,41 @@ static int kvm_s390_inject_airq(struct kvm *kvm,
 		.parm = 0,
 		.parm64 = isc_to_int_word(adapter->isc),
 	};
+	struct kvm_s390_interrupt_info *inti;
+	unsigned long flags;
+
 	int ret = 0;
 
-	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible)
-		return kvm_s390_inject_vm(kvm, &s390int);
+	inti = kzalloc_obj(*inti, GFP_KERNEL_ACCOUNT);
+	if (!inti)
+		return -ENOMEM;
 
-	mutex_lock(&fi->ais_lock);
+	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible) {
+		ret = kvm_s390_inject_vm(kvm, &s390int, inti);
+		if (ret)
+			kfree(inti);
+		return ret;
+	}
+
+	spin_lock_irqsave(&fi->ais_lock, flags);
 	if (fi->nimm & AIS_MODE_MASK(adapter->isc)) {
 		trace_kvm_s390_airq_suppressed(adapter->id, adapter->isc);
-		goto out;
+		spin_unlock_irqrestore(&fi->ais_lock, flags);
+		kfree(inti);
+		return ret;
 	}
 
-	ret = kvm_s390_inject_vm(kvm, &s390int);
+	ret = kvm_s390_inject_vm(kvm, &s390int, inti);
+
 	if (!ret && (fi->simm & AIS_MODE_MASK(adapter->isc))) {
 		fi->nimm |= AIS_MODE_MASK(adapter->isc);
 		trace_kvm_s390_modify_ais_mode(adapter->isc,
 					       KVM_S390_AIS_MODE_SINGLE, 2);
 	}
-out:
-	mutex_unlock(&fi->ais_lock);
+
+	spin_unlock_irqrestore(&fi->ais_lock, flags);
+	if (ret)
+		kfree(inti);
 	return ret;
 }
 
@@ -2746,6 +2758,8 @@ static int flic_inject_airq(struct kvm *kvm, struct kvm_device_attr *attr)
 	unsigned int id = attr->attr;
 	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
 
+	kvm->stat.io_flic_inject_airq++;
+
 	if (!adapter)
 		return -EINVAL;
 
@@ -2756,6 +2770,7 @@ static int flic_ais_mode_set_all(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 	struct kvm_s390_ais_all ais;
+	unsigned long flags;
 
 	if (!test_kvm_facility(kvm, 72))
 		return -EOPNOTSUPP;
@@ -2763,10 +2778,10 @@ static int flic_ais_mode_set_all(struct kvm *kvm, struct kvm_device_attr *attr)
 	if (copy_from_user(&ais, (void __user *)attr->addr, sizeof(ais)))
 		return -EFAULT;
 
-	mutex_lock(&fi->ais_lock);
+	spin_lock_irqsave(&fi->ais_lock, flags);
 	fi->simm = ais.simm;
 	fi->nimm = ais.nimm;
-	mutex_unlock(&fi->ais_lock);
+	spin_unlock_irqrestore(&fi->ais_lock, flags);
 
 	return 0;
 }
@@ -2935,6 +2950,7 @@ static int adapter_indicators_set(struct kvm *kvm,
 		set_bit(bit, map);
 		spin_unlock_irqrestore(&adapter->maps_lock, flags);
 	}
+
 	spin_lock_irqsave(&adapter->maps_lock, flags);
 	summary_info = get_map_info(adapter, adapter_int->summary_addr);
 	if (!summary_info) {
@@ -2964,6 +2980,44 @@ static int adapter_indicators_set(struct kvm *kvm,
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
+	spin_lock(&adapter->maps_lock);
+	ind_info = get_map_info(adapter, adapter_int->ind_addr);
+	if (!ind_info) {
+		spin_unlock(&adapter->maps_lock);
+		return -EWOULDBLOCK;
+	}
+	map = page_address(ind_info->page);
+	bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
+	if (setbit)
+		set_bit(bit, map);
+	summary_info = get_map_info(adapter, adapter_int->summary_addr);
+	if (!summary_info) {
+		spin_unlock(&adapter->maps_lock);
+		return -EWOULDBLOCK;
+	}
+	map = page_address(summary_info->page);
+	bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
+			  adapter->swap);
+	/* If setbit then set summary bit. Else if falling back to the slow path */
+	/* with setbit==0 then clear the summary bit so the slow path re-injects */
+	if (setbit)
+		summary_set = test_and_set_bit(bit, map);
+	else
+		summary_set = test_and_clear_bit(bit, map);
+	spin_unlock(&adapter->maps_lock);
+	return summary_set ? 0 : 1;
+}
+
 /*
  * < 0 - not injected due to error
  * = 0 - coalesced, summary indicator already active
@@ -2976,6 +3030,8 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
 	int ret;
 	struct s390_io_adapter *adapter;
 
+	kvm->stat.io_set_adapter_int++;
+
 	/* We're only interested in the 0->1 transition. */
 	if (!level)
 		return 0;
@@ -3044,7 +3100,6 @@ int kvm_set_routing_entry(struct kvm *kvm,
 	int idx;
 
 	switch (ue->type) {
-	/* we store the userspace addresses instead of the guest addresses */
 	case KVM_IRQ_ROUTING_S390_ADAPTER:
 		if (kvm_is_ucontrol(kvm))
 			return -EINVAL;
@@ -3634,3 +3689,85 @@ int __init kvm_s390_gib_init(u8 nisc)
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
+	if (!inti) {
+		setbit = 0;
+		adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
+		return -EWOULDBLOCK;
+	}
+
+	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible) {
+		ret = kvm_s390_inject_vm(kvm, &s390int, inti);
+		if (ret == 0) {
+			return ret;
+		} else {
+			setbit = 0;
+			adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
+			kfree(inti);
+			return -EWOULDBLOCK;
+		}
+	}
+
+	spin_lock(&fi->ais_lock);
+	if (fi->nimm & AIS_MODE_MASK(adapter->isc)) {
+		trace_kvm_s390_airq_suppressed(adapter->id, adapter->isc);
+		spin_unlock(&fi->ais_lock);
+		kfree(inti);
+		return 0;
+	}
+
+	ret = kvm_s390_inject_vm(kvm, &s390int, inti);
+	if (!ret && (fi->simm & AIS_MODE_MASK(adapter->isc))) {
+		fi->nimm |= AIS_MODE_MASK(adapter->isc);
+		trace_kvm_s390_modify_ais_mode(adapter->isc,
+					       KVM_S390_AIS_MODE_SINGLE, 2);
+	} else if (ret) {
+		spin_unlock(&fi->ais_lock);
+		setbit = 0;
+		adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
+		kfree(inti);
+		return -EWOULDBLOCK;
+	}
+
+	spin_unlock(&fi->ais_lock);
+	return 0;
+}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0d39c1375de2..98bd0cbbf023 100644
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
@@ -2851,6 +2855,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	void __user *argp = (void __user *)arg;
 	struct kvm_device_attr attr;
 	int r;
+	struct kvm_s390_interrupt_info *inti;
 
 	switch (ioctl) {
 	case KVM_S390_INTERRUPT: {
@@ -2859,7 +2864,12 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = -EFAULT;
 		if (copy_from_user(&s390int, argp, sizeof(s390int)))
 			break;
-		r = kvm_s390_inject_vm(kvm, &s390int);
+		inti = kzalloc_obj(*inti, GFP_KERNEL_ACCOUNT);
+		if (!inti)
+			return -ENOMEM;
+		r = kvm_s390_inject_vm(kvm, &s390int, inti);
+		if (r)
+			kfree(inti);
 		break;
 	}
 	case KVM_CREATE_IRQCHIP: {
@@ -3257,7 +3267,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		mutex_unlock(&kvm->lock);
 	}
 
-	mutex_init(&kvm->arch.float_int.ais_lock);
+	spin_lock_init(&kvm->arch.float_int.ais_lock);
 	spin_lock_init(&kvm->arch.float_int.lock);
 	for (i = 0; i < FIRQ_LIST_COUNT; i++)
 		INIT_LIST_HEAD(&kvm->arch.float_int.lists[i]);
@@ -4379,19 +4389,28 @@ int kvm_s390_try_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clo
 }
 
 static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
-				      unsigned long token)
+				     unsigned long token)
 {
 	struct kvm_s390_interrupt inti;
 	struct kvm_s390_irq irq;
+	struct kvm_s390_interrupt_info *inti_mem = NULL;
+	int ret = 0;
 
 	if (start_token) {
 		irq.u.ext.ext_params2 = token;
 		irq.type = KVM_S390_INT_PFAULT_INIT;
 		WARN_ON_ONCE(kvm_s390_inject_vcpu(vcpu, &irq));
 	} else {
+		inti_mem = kzalloc_obj(*inti_mem, GFP_KERNEL_ACCOUNT);
+		if (WARN_ON_ONCE(!inti_mem))
+			return;
+
 		inti.type = KVM_S390_INT_PFAULT_DONE;
 		inti.parm64 = token;
-		WARN_ON_ONCE(kvm_s390_inject_vm(vcpu->kvm, &inti));
+		ret = kvm_s390_inject_vm(vcpu->kvm, &inti, inti_mem);
+		if (ret)
+			kfree(inti_mem);
+		WARN_ON_ONCE(ret);
 	}
 }
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 7ba885cb6bd1..6d2842fb71a3 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -376,7 +376,8 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
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
2.54.0


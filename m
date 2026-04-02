Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE06F35AC20;
	Thu,  2 Apr 2026 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103720; cv=none; b=BG9UbisHfC1orXaDzE10jDEUPhc5K5ixyS+612j54wnzoDM9XfCMJ9KHXD7uN4KQ5obfOTi3KXCF/g53AhgO5OC23yG1Ko/ulvr3bMRhbFjTQzOQz1483CoiAg9j2V6bCMc0xmNCzKWcNO5xZ9C0wyxPqYWPiaGuS+lpI6EnfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103720; c=relaxed/simple;
	bh=Izvf2qUrQ0icvulY1nfPJFiMb8CmJ7O1gKF0hZ09NWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3GSrlaB4rKonSOuS7htLjtTZPUnck1OxSMLa73BAqYbVRVRWwBdgikSoaIlBAxEgvtr+NqBYljZHzoHT2aj3w4x1BVlONg9+HT3WhCzq8sXL5NIErAsFcRUJe4NNsYh2wJ5g09jvy1w4SMZVuzUGGzy+23xRDxpBWhNRi62UD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rko/DeGG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rko/DeGG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631HURiK2903666;
	Thu, 2 Apr 2026 04:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9fzCODy95V1TQUD+W
	UGs6bhrpfOjqEZmbSInszcweVo=; b=rko/DeGGG7vhDeXrtMg7dS9UKMcGjjK2N
	7g6kVPSGSRT2pnp9dhtYzXb3Nlu7+TAcUYlIKQ9HkDcfANeV5NJW4XXilp4jYgJR
	967HrzOjZoW8VlsNEGYZ4mv4u5eh9lzg8/uV6k3cFThWM0KLKirv1IYdS+rT/mlh
	8v0fhRt7u/lWr3aQRlMhWkwRxYDcAcgNNKitPYMw8gUDd8bmGZxdYdVo033Ay/H3
	X+TnvYA03NamijuVmXrFtfSI5xzKRlZDkxnBLjAMV6xY4eic3ZbOBGYjpNvMCFM7
	Uv0ViDkMQhHVTkWOynLVnK7tSbmxRWAeIjWmf59kAMZcAT/aMG+QQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnu7su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63212o7j030990;
	Thu, 2 Apr 2026 04:21:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk0ee0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LRtL35324310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36FF920043;
	Thu,  2 Apr 2026 04:21:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E087B2004B;
	Thu,  2 Apr 2026 04:21:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 04:21:26 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <Andreas.Grapentin@ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v1 03/27] KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio
Date: Thu,  2 Apr 2026 06:20:59 +0200
Message-ID: <20260402042125.3948963-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402042125.3948963-1-seiden@linux.ibm.com>
References: <20260402042125.3948963-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hQBMhy9HLCCQzxvZtKP_zmRNQVxIyBUJ
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cdeecb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=Iid1VeoRPhL8jyw1u-UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfXxRFLOg61Tfgd
 r3j6Kfo7hL2jY55oEhYtWiMqNkPghLtwGjOQ2OH54mLzLprTA8BxCqXBVd5GDI2GNVn/GBKFaWo
 72btgVmGMYyyqqwQRNirCd1pBFPvN9XdNPZGrhn26A7PCarfSdi81e3QIfDOyPD7JnVC2u8Ohi2
 8qRrsqyaTIJmPm1RXzWXLn0E8P0xhGL7hFtYrrYzE6K7pVDTcUV90pzAEAp9vhuhhvgCZmY73vs
 3bCBrMoyRE/LcDuADMPrQ4oWhCKPcP5kk+N1pA0hLxoQxl45GoJER2N1B+cmG2RwDxVlVYhgFAe
 7mDAapmOtic4S1x01/Ymn74AMROIuThySzGlUYKKKor/p6vVveDS8x4P6f/g1dUbh/7xxXxWv/E
 jF+900F6Gm+DTecd67/iImwQZMV/qKy355cwJ942/ndxeP9gaq9Pt2gKVzMLYL1EV0bL79aGEer
 O7qnA68CJ3mFVzX8o5A==
X-Proofpoint-ORIG-GUID: hQBMhy9HLCCQzxvZtKP_zmRNQVxIyBUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020034

From: Paolo Bonzini <pbonzini@redhat.com>

Right now, KVM and VFIO are using symbol_get to access each other's
symbols because of a circular reference between the modules, as well
as to avoid loading them unnecessarily.

The remaining use in VFIO is for kvm_put_kvm, which is not inline
because it needs to call kvm_destroy_vm.  However, storing the
address of kvm_destroy_vm in the "struct kvm" is enough to remove
the dependency from VFIO.

This also makes it possible to direct kvm_put_kvm to different
implementations of kvm_destroy_vm.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 drivers/vfio/vfio_main.c  | 29 +++++------------------------
 include/linux/kvm_host.h  |  1 -
 include/linux/kvm_types.h |  9 +++++++++
 include/linux/vfio.h      |  1 -
 virt/kvm/kvm_main.c       |  9 ++-------
 5 files changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 42f515519d87..e9c6353c74d8 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -17,7 +17,7 @@
 #include <linux/idr.h>
 #include <linux/iommu.h>
 #if IS_ENABLED(CONFIG_KVM)
-#include <linux/kvm_host.h>
+#include <linux/kvm_types.h>
 #endif
 #include <linux/list.h>
 #include <linux/miscdevice.h>
@@ -436,9 +436,6 @@ EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm,
 			      struct module *kvm_module)
 {
-	void (*pfn)(struct kvm *kvm);
-	bool ret;
-
 	lockdep_assert_held(&device->dev_set->lock);
 
 	if (!kvm)
@@ -447,19 +444,10 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm,
 	if (!try_module_get(kvm_module))
 		return;
 
-	pfn = symbol_get(kvm_put_kvm);
-	if (WARN_ON(!pfn))
-		return;
-
-	ret = kvm_get_kvm_safe(kvm);
-	if (!ret) {
-		symbol_put(kvm_put_kvm);
-		return;
+	if (kvm_get_kvm_safe(kvm)) {
+		device->kvm = kvm;
+		device->kvm_module = kvm_module;
 	}
-
-	device->put_kvm = pfn;
-	device->kvm = kvm;
-	device->kvm_module = kvm_module;
 }
 
 void vfio_device_put_kvm(struct vfio_device *device)
@@ -469,15 +457,8 @@ void vfio_device_put_kvm(struct vfio_device *device)
 	if (!device->kvm)
 		return;
 
-	if (WARN_ON(!device->put_kvm))
-		goto clear;
-
-	device->put_kvm(device->kvm);
-	device->put_kvm = NULL;
-	symbol_put(kvm_put_kvm);
-
-clear:
 	module_put(device->kvm_module);
+	kvm_put_kvm(device->kvm);
 	device->kvm_module = NULL;
 	device->kvm = NULL;
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index dc18ee99bba4..13f903993ed0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1065,7 +1065,6 @@ static inline void kvm_irqfd_exit(void)
 int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module);
 void kvm_exit(void);
 
-void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
 
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index add7cc2016e8..aadee536771a 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -144,6 +144,7 @@ struct kvm_vcpu_stat_generic {
 
 struct kvm_refcount {
 	refcount_t users_count;
+	void (*destroy)(struct kvm *kvm);
 };
 
 static inline void kvm_get_kvm(struct kvm *kvm)
@@ -164,6 +165,14 @@ static inline bool kvm_get_kvm_safe(struct kvm *kvm)
 	return refcount_inc_not_zero(&rc->users_count);
 }
 
+static inline void kvm_put_kvm(struct kvm *kvm)
+{
+	struct kvm_refcount *rc = (struct kvm_refcount *)kvm;
+
+	if (refcount_dec_and_test(&rc->users_count))
+		rc->destroy(kvm);
+}
+
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __KVM_TYPES_H__ */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 69a8d527b0e8..5c69532d6127 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -65,7 +65,6 @@ struct vfio_device {
 	unsigned int open_count;
 	struct completion comp;
 	struct iommufd_access *iommufd_access;
-	void (*put_kvm)(struct kvm *kvm);
 	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cb5e01f92503..642f9e9638cc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -120,6 +120,7 @@ static struct dentry *kvm_debugfs_dir;
 
 static const struct file_operations stat_fops_per_vm;
 
+static void kvm_destroy_vm(struct kvm *kvm);
 static long kvm_vcpu_ioctl(struct file *file, unsigned int ioctl,
 			   unsigned long arg);
 #ifdef CONFIG_KVM_COMPAT
@@ -1154,6 +1155,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 		goto out_err_no_irq_routing;
 
 	refcount_set(&kvm->rc.users_count, 1);
+	kvm->rc.destroy = kvm_destroy_vm;
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		for (j = 0; j < 2; j++) {
@@ -1316,13 +1318,6 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	mmdrop(mm);
 }
 
-void kvm_put_kvm(struct kvm *kvm)
-{
-	if (refcount_dec_and_test(&kvm->rc.users_count))
-		kvm_destroy_vm(kvm);
-}
-EXPORT_SYMBOL_GPL(kvm_put_kvm);
-
 /*
  * Used to put a reference that was taken on behalf of an object associated
  * with a user-visible file descriptor, e.g. a vcpu or device, if installation
-- 
2.51.0


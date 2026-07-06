Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844E047AF6C;
	Mon,  6 Jul 2026 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328000; cv=none; b=OXu5ldqqjMzIihsnM2A0jP5s6BuayCWImZC1Eh4bdi5el7/0Digk4+1t6ZbNBEzyTSswQO8kzdtx4zYhGUvppkAnotMyWUhK4SwHt1A4iGZcXFkVSkIPiuJHPJ2LfHYMsDrQpTxWsNyMgP1Ve0g1MvSwfsaeEv57ppuoVZ1FHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328000; c=relaxed/simple;
	bh=zL8phE3G7Xbv3LgqttCQ/eBISgNOG9xNpRqsjGmb08g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7TALq87hmumC89+6qYioe2wD1jAn6vidayjg3as9l8bDhLlKIOsBu5c2xaIKz/z2UmtffyRHSr4cAsGT7mBUALnSRf2afODIYC+OHcPlsRFpcGRKgZnJMuC1ht91r+LAk+DEbpyAgXXHRGGRj5V0qtcmQeqYVvbzfO2bXQrt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IK4cPMj2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IK4cPMj2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIBW02197637;
	Mon, 6 Jul 2026 08:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VhyXP5vSSTAH6Llcs
	HqRNXbRvToXpKcr3B3MWyVvrzM=; b=IK4cPMj2uHlwPuAkAQG4TTz1zW967Sv8k
	CpI3CuBV1vHDy9y3AkXIbYG5SMQfJN50ETPbN8PdN9g2xWEeKcGajeiww0JoMuNF
	DDm3D+E8UaV7M6F9KMDD/xvYFa4zxF2aTFfabpm/ElyEwGODEfIfyj/nbDNVG283
	QKRobjC5oqSjLnwFu08TaZHKDR7oG1HSOsP0gvQie6f8FQ5/+n4JS2kE05ujAT5m
	xW6etnsOfayHqWlYCREWrUSxTmguHGVJZY8MTBsPgQpIzppmCCiWpsDHVTZQSY68
	yj8p7nWpDhe+U4cvAsIjJq4u6UG61SYVOI1W0t5jWDxK0yF8upm7Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4ghew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668ndrp023223;
	Mon, 6 Jul 2026 08:52:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvvyh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qVbU25887390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28B7F20040;
	Mon,  6 Jul 2026 08:52:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C290E2004E;
	Mon,  6 Jul 2026 08:52:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:30 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v4 03/27] KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio
Date: Mon,  6 Jul 2026 10:52:03 +0200
Message-ID: <20260706085229.979525-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706085229.979525-1-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hJi40U7MfPaskyH7CtMQyiFhKQ7HXHzv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX3Ws4NFA6EA1l
 gRblKAaCLgPzILuk5ivIJa0isWOw37HKT6ly3FC4VST6rWsrlTeEXgom9Urdxl8X5b0OFMGGy9D
 QRYjtAaPqS7Mnk3jMaYvhc6HvgE1WGqKjM7UEoYXkEPY2cQsSZ8AW9a/PH4ERI5nPhdTdVex7pZ
 JmgYQuat64pOeTh6QRCL4/Uh+Y7eikHo9+r9+CM42peAu+y8MWggtbxEs35Y0OgRJ/aoR70YsFf
 aIG5VSKK5/vFN8iBcGgufU5smE7mKUA/cNsfGcRxsQNQYe0IpDR5nqZPmJy8qH4bhGFIrP89CW3
 ofkH0f6JZwryLQWEhHR32HetWm1tay4odATafKy8nosdNN2wLU9Cpy6sQiyHdVjkZ3YoHv3MwTf
 J6EzKsv06aL5WMbLR6/0yUnmk/4KSgacQjKRuDLIBiq3DgByA0ly0gnYbTFL2AtjMrQQPIblzzP
 aR8Zb1kK1W26GV1IIGQ==
X-Proofpoint-ORIG-GUID: hJi40U7MfPaskyH7CtMQyiFhKQ7HXHzv
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4b6cd8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=Iid1VeoRPhL8jyw1u-UA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX6dTeKarU6+Dl
 rXEsQpvzX0dp0ZJU6qUxA7JpXUtzfh801V5PbZaUXbmKDmZzt9sahlvWGltEuOXaRxKWdxDC4NO
 MZEEVnW16ZqkUrAUzGlJT/t28uJP7Vk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

From: Paolo Bonzini <pbonzini@redhat.com>

Right now, KVM and VFIO are using symbol_get to access each other's
symbols because of a circular reference between the modules, as well
as to avoid loading them unnecessarily.

The remaining use in VFIO is for kvm_put_kvm, which is not inline
because it needs to call kvm_destroy_vm.  However, storing the
address of kvm_destroy_vm in the "struct kvm" is enough to remove
the dependency from VFIO.

This also makes it possible to direct kvm_put_kvm to either the arm64
or the s390 implementation of kvm_destroy_vm.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Alex Williamson <alex@shazbot.org>
---
 drivers/vfio/vfio_main.c  | 24 +++---------------------
 include/linux/kvm_host.h  |  1 -
 include/linux/kvm_types.h |  9 +++++++++
 include/linux/vfio.h      |  1 -
 virt/kvm/kvm_main.c       |  9 ++-------
 5 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index b7b8b45f1cec..6bddea4d384f 100644
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
@@ -451,9 +451,6 @@ EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm,
 			      struct module *kvm_module)
 {
-	void (*pfn)(struct kvm *kvm);
-	bool ret;
-
 	lockdep_assert_held(&device->dev_set->lock);
 
 	if (!kvm)
@@ -462,21 +459,13 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm,
 	if (!try_module_get(kvm_module))
 		return;
 
-	pfn = symbol_get(kvm_put_kvm);
-	if (WARN_ON(!pfn))
+	if (!kvm_get_kvm_safe(kvm))
 		goto out_put_mod;
 
-	ret = kvm_get_kvm_safe(kvm);
-	if (!ret)
-		goto out_put_sym;
-
-	device->put_kvm = pfn;
 	device->kvm = kvm;
 	device->kvm_module = kvm_module;
 	return;
 
-out_put_sym:
-	symbol_put(kvm_put_kvm);
 out_put_mod:
 	module_put(kvm_module);
 }
@@ -488,14 +477,7 @@ void vfio_device_put_kvm(struct vfio_device *device)
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
+	kvm_put_kvm(device->kvm);
 	device->kvm = NULL;
 	module_put(device->kvm_module);
 	device->kvm_module = NULL;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 015d02018109..1f967b1d68b9 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1072,7 +1072,6 @@ static inline void kvm_irqfd_exit(void)
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
index 5bfec0339804..81f04e60ebfd 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -67,7 +67,6 @@ struct vfio_device {
 	unsigned int open_count;
 	struct completion comp;
 	struct iommufd_access *iommufd_access;
-	void (*put_kvm)(struct kvm *kvm);
 	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7dec697ce35a..271884089f58 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -119,6 +119,7 @@ static struct dentry *kvm_debugfs_dir;
 
 static const struct file_operations stat_fops_per_vm;
 
+static void kvm_destroy_vm(struct kvm *kvm);
 static long kvm_vcpu_ioctl(struct file *file, unsigned int ioctl,
 			   unsigned long arg);
 #ifdef CONFIG_KVM_COMPAT
@@ -1148,6 +1149,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 
 	BUILD_BUG_ON(offsetof(struct kvm, rc) != 0);
 	refcount_set(&kvm->rc.users_count, 1);
+	kvm->rc.destroy = kvm_destroy_vm;
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		for (j = 0; j < 2; j++) {
@@ -1310,13 +1312,6 @@ static void kvm_destroy_vm(struct kvm *kvm)
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
2.53.0


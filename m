Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728152AbgHaJKC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 31 Aug 2020 05:10:02 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v10 2/2] s390: virtio: PV needs VIRTIO I/O device protection
Date: Mon, 31 Aug 2020 11:09:46 +0200
Message-Id: <1598864986-13875-3-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1598864986-13875-1-git-send-email-pmorel@linux.ibm.com>
References: <1598864986-13875-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

If protected virtualization is active on s390, VIRTIO has only retricted
access to the guest memory.
Define CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS and export
arch_has_restricted_virtio_memory_access to advertize VIRTIO if that's
the case, preventing a host error on access attempt.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/Kconfig   |  1 +
 arch/s390/mm/init.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9cfd8de907cb..c12422c26389 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -820,6 +820,7 @@ menu "Virtualization"
 config PROTECTED_VIRTUALIZATION_GUEST
 	def_bool n
 	prompt "Protected virtualization guest support"
+	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
 	help
 	  Select this option, if you want to be able to run this
 	  kernel as a protected virtualization KVM guest.
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 6dc7c3b60ef6..5f289ab1b0d2 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -161,6 +161,16 @@ bool force_dma_unencrypted(struct device *dev)
 	return is_prot_virt_guest();
 }
 
+#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+
+int arch_has_restricted_virtio_memory_access(void)
+{
+	return is_prot_virt_guest();
+}
+EXPORT_SYMBOL(arch_has_restricted_virtio_memory_access);
+
+#endif
+
 /* protected virtualization */
 static void pv_init(void)
 {
-- 
2.25.1

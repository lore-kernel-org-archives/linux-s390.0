Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgIBTqy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Sep 2020 15:46:54 -0400
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v4 1/3] PCI/IOV: Mark VFs as not implementing MSE bit
Date: Wed,  2 Sep 2020 15:46:34 -0400
Message-Id: <1599075996-9826-2-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1599075996-9826-1-git-send-email-mjrosato@linux.ibm.com>
References: <1599075996-9826-1-git-send-email-mjrosato@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, bhelgaas@google.com
Cc: schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, cohuck@redhat.com, kevin.tian@intel.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

Per the PCIe spec, VFs cannot implement the MSE bit
AKA PCI_COMMAND_MEMORY, and it must be hard-wired to 0.
Use a dev_flags bit to signify this requirement.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/pci/iov.c   | 1 +
 include/linux/pci.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index b37e08c..2bec77c 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -180,6 +180,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	virtfn->device = iov->vf_device;
 	virtfn->is_virtfn = 1;
 	virtfn->physfn = pci_dev_get(dev);
+	virtfn->dev_flags |= PCI_DEV_FLAGS_FORCE_COMMAND_MEM;
 
 	if (id == 0)
 		pci_read_vf_config_common(virtfn);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8355306..9316cce 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -227,6 +227,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
 	/* Don't use Relaxed Ordering for TLPs directed at this device */
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
+	/* Device does not implement PCI_COMMAND_MEMORY (e.g. a VF) */
+	PCI_DEV_FLAGS_FORCE_COMMAND_MEM = (__force pci_dev_flags_t) (1 << 12),
 };
 
 enum pci_irq_reroute_variant {
-- 
1.8.3.1

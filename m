Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730854AbgIJPAR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 11:00:17 -0400
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v5 1/3] PCI/IOV: Mark VFs as not implementing PCI_COMMAND_MEMORY
Date: Thu, 10 Sep 2020 10:59:55 -0400
Message-Id: <1599749997-30489-2-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1599749997-30489-1-git-send-email-mjrosato@linux.ibm.com>
References: <1599749997-30489-1-git-send-email-mjrosato@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, bhelgaas@google.com
Cc: schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, cohuck@redhat.com, kevin.tian@intel.com, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

For VFs, the Memory Space Enable bit in the Command Register is
hard-wired to 0.

Add a new bit to signify devices where the Command Register Memory
Space Enable bit does not control the device's response to MMIO
accesses.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/pci/iov.c   | 1 +
 include/linux/pci.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index b37e08c..4afd4ee 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -180,6 +180,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	virtfn->device = iov->vf_device;
 	virtfn->is_virtfn = 1;
 	virtfn->physfn = pci_dev_get(dev);
+	virtfn->no_command_memory = 1;
 
 	if (id == 0)
 		pci_read_vf_config_common(virtfn);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8355306..3ff72312 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -445,6 +445,7 @@ struct pci_dev {
 	unsigned int	is_probed:1;		/* Device probing in progress */
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
+	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
1.8.3.1

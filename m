Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03710C4332F
	for <linux-s390@archiver.kernel.org>; Mon,  6 Sep 2021 09:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE61960E76
	for <linux-s390@archiver.kernel.org>; Mon,  6 Sep 2021 09:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbhIFJur (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Sep 2021 05:50:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20182 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240914AbhIFJup (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Sep 2021 05:50:45 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1869YV8O176205;
        Mon, 6 Sep 2021 05:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1RhAj2yPqcTtzpAhYHgoILpOvqRSQiHtL3i0UrFy258=;
 b=ZMA22G4oaSjr7FX18W8imSWs6MGXNP5Z4TNSKxuEFkchHwIEHc/bYHrgyML3mfM1w+ln
 y8dD1HoSLaM7qFWv6oeKNqYUgWumQ+uXUQ8k4nY+i8rKaHGTReahkBqcIXnHn+gAWrKO
 3ME28Ds8GQ1qYBPr5vF7plKksBQA3r6rMe/x+vOot0DmxaM/zIOwxsTNJZWc60yMmBtQ
 KdeUdT6BWPW5qkPQfFhtWqHBNytD9swunX5VJ/4O5O6LjnfnEaHI/15hCSMfNGc8cNJ5
 1gzZI0ngYevBt8/yhLoNXVZ6ZfuMFlsxnbx6LdSw+75+bT4jSZh/yu2sCSM+ssLhiHrV EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3awfgy9ry8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Sep 2021 05:49:34 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1869Z5BJ185543;
        Mon, 6 Sep 2021 05:49:34 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3awfgy9rxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Sep 2021 05:49:34 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1869lNtk020234;
        Mon, 6 Sep 2021 09:49:32 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3av02ja0py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Sep 2021 09:49:32 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1869nTOc49480136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Sep 2021 09:49:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1C2F42047;
        Mon,  6 Sep 2021 09:49:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 953064204B;
        Mon,  6 Sep 2021 09:49:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Sep 2021 09:49:28 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linas Vepstas <linasvepstas@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH 2/5] s390/pci: implement reset_slot for hotplug slot
Date:   Mon,  6 Sep 2021 11:49:24 +0200
Message-Id: <20210906094927.524106-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210906094927.524106-1-schnelle@linux.ibm.com>
References: <20210906094927.524106-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g1cKEtKk5-qLB1PN_abRNsUK7hLZo1ig
X-Proofpoint-ORIG-GUID: 5eh2NNb6IS0C70HZvJOIVX4Fktg0MvXR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-06_05:2021-09-03,2021-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109060060
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This is done by adding a zpci_hot_reset_device() call which does a low
level reset of the PCI function without changing its higher level
function state. This way it can be used while the zPCI function is bound
to a driver and with DMA tables being controlled either through the
IOMMU or DMA APIs which is prohibited when using zpci_disable_device()
as that drop existing DMA translations.

As this reset, unlike a normal FLR, also calls zpci_clear_irq() we need
to implement arch_restore_msi_irqs() and make sure we re-enable IRQs for
the PCI function if they were previously disabled.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/include/asm/pci.h        |  1 +
 arch/s390/pci/pci.c                | 58 ++++++++++++++++++++++++++++++
 arch/s390/pci/pci_irq.c            |  9 +++++
 drivers/pci/hotplug/s390_pci_hpc.c | 24 +++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 5e6cba22a801..2a2ed165a270 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -208,6 +208,7 @@ int zpci_disable_device(struct zpci_dev *);
 int zpci_scan_configured_device(struct zpci_dev *zdev, u32 fh);
 int zpci_deconfigure_device(struct zpci_dev *zdev);
 
+int zpci_hot_reset_device(struct zpci_dev *zdev);
 int zpci_register_ioat(struct zpci_dev *, u8, u64, u64, u64);
 int zpci_unregister_ioat(struct zpci_dev *, u8);
 void zpci_remove_reserved_devices(void);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index af22778551c1..a6322f45b5bd 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -723,6 +723,64 @@ int zpci_disable_device(struct zpci_dev *zdev)
 	return rc;
 }
 
+/**
+ * zpci_hot_reset_device - perform a reset of the given zPCI function
+ * @zdev: the slot which should be reset
+ *
+ * Performs a low level reset of the zPCI function. The reset is low level in
+ * the sense that the zPCI function can be reset without detaching it from the
+ * common PCI subsystem. The reset may be performed while under control of
+ * either DMA or IOMMU APIs in which case the existing DMA/IOMMU translation
+ * table is reinstated at the end of the reset.
+ *
+ * After the reset the functions internal state is reset to an initial state
+ * equivalent to its state during boot when first probing a driver.
+ * Consequently after reset the PCI function requires re-initialization via the
+ * common PCI code including re-enabling IRQs via pci_alloc_irq_vectors()
+ * and enabling the function via e.g.pci_enablde_device_flags().The caller
+ * must guard against concurrent reset attempts.
+ *
+ * In most cases this function should not be called directly but through
+ * pci_reset_function() or pci_reset_bus() which handle the save/restore and
+ * locking.
+ *
+ * Return: 0 on success and an error value otherwise
+ */
+int zpci_hot_reset_device(struct zpci_dev *zdev)
+{
+	int rc;
+
+	zpci_dbg(3, "reset fid:%x\n", zdev->fid);
+	if (zdev_enabled(zdev)) {
+		/* Disables device access, DMAs and IRQs (reset state) */
+		rc = zpci_disable_device(zdev);
+		/*
+		 * Due to a z/VM vs LPAR inconsistency in the error state the
+		 * FH may indicate an enabled device but disable says the
+		 * device is already disabled don't treat it as an error here.
+		 */
+		if (rc == -EINVAL)
+			rc = 0;
+		if (rc)
+			return rc;
+	}
+
+	rc = zpci_enable_device(zdev);
+	if (rc)
+		return rc;
+
+	if (zdev->dma_table) {
+		rc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
+					(u64)zdev->dma_table);
+		if (rc)
+			return rc;
+	} else {
+		zpci_dma_init_device(zdev);
+	}
+
+	return 0;
+}
+
 /**
  * zpci_create_device() - Create a new zpci_dev and add it to the zbus
  * @fid: Function ID of the device to be created
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 9c7de9089939..ab98e7f5b79b 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -391,6 +391,15 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 		airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
 }
 
+void arch_restore_msi_irqs(struct pci_dev *pdev)
+{
+	struct zpci_dev *zdev = to_zpci(pdev);
+
+	if (!zdev->irqs_registered)
+		zpci_set_irq(zdev);
+	default_restore_msi_irqs(pdev);
+}
+
 static struct airq_struct zpci_airq = {
 	.handler = zpci_floating_irq_handler,
 	.isc = PCI_ISC,
diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
index 014868752cd4..07f28db0eed5 100644
--- a/drivers/pci/hotplug/s390_pci_hpc.c
+++ b/drivers/pci/hotplug/s390_pci_hpc.c
@@ -57,6 +57,29 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
 	return zpci_deconfigure_device(zdev);
 }
 
+static int reset_slot(struct hotplug_slot *hotplug_slot, int probe)
+{
+	struct zpci_dev *zdev = container_of(hotplug_slot, struct zpci_dev,
+					     hotplug_slot);
+
+	if (zdev->state != ZPCI_FN_STATE_CONFIGURED)
+		return -EIO;
+	/*
+	 * We can't take the zdev->lock as reset_slot may be called during
+	 * probing and/or device removal which already happens under the
+	 * zdev->lock. Instead the user should use the higher level
+	 * pci_reset_function() or pci_bus_reset() which hold the PCI device
+	 * lock preventing concurrent removal. If not using these functions
+	 * holding the PCI device lock is required.
+	 */
+
+	/* As long as the function is configured we can reset */
+	if (probe)
+		return 0;
+
+	return zpci_hot_reset_device(zdev);
+}
+
 static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct zpci_dev *zdev = container_of(hotplug_slot, struct zpci_dev,
@@ -83,6 +106,7 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 static const struct hotplug_slot_ops s390_hotplug_slot_ops = {
 	.enable_slot =		enable_slot,
 	.disable_slot =		disable_slot,
+	.reset_slot =		reset_slot,
 	.get_power_status =	get_power_status,
 	.get_adapter_status =	get_adapter_status,
 };
-- 
2.25.1


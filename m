Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366673A1C9;
	Fri, 21 Nov 2025 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703153; cv=none; b=eMnEf8NrpZr2qBo/lb18CwAYC1ysRNgvoBGk9clbHacGL+2X3iSWTXP7rO2ZPdKGVdCmXbK1p4UPv6nniNg8oI7qJhxJ7isaqKFbaYLbefyD7VgQ0Y6BpmX500V4HCxgAdYkMK6IywDLh4nbCshJZirgY2HD9EMsjNyclyFGxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703153; c=relaxed/simple;
	bh=qjHGZdXhzIzKAVVpmYVrm7I3XPpVEhbMsSg7ujkp2m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uFF2rmuwhFSAHqd21WosoeAFiounuXkiCpj8xlnnVrZEtjk4Lsz3FQMrQmpwzYSUL1G4mOvUarQ9BUYrvzcuk3Y8lEJvKPrcnrR4hMk9bnyH9yQFD76ZUltYsq8R1r6PmERkxE2JhIphn1VMLWsDMoLoYt2k/mCe7JwelmLYtdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B0DsM6tG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B0DsM6tG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKNllbx012612;
	Fri, 21 Nov 2025 05:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=imkP9v
	PgNsyc2WHSeqjBXInYs8wju9kT8TWtOgMmgM8=; b=B0DsM6tG4emaxkmaTkaUo2
	dbhCOhgoISRsBWEi1+P7IFTV4NjEsc2linWjPTX8dSqpWsZG0B2oDfa+gIvSJfvb
	ata9hYfVFCHB2nBMp4Vy2Rdv0B9ON5knelQfQdUjTyw4V1jJ5vh1CUxU9KdaKQfq
	XE+mTVIz7ZALIRs2r9psgfkMxkBeQy/kcGf2RVY5DohaJakZlvG3Au71uk94sw0Q
	zXv5qesN+lFFos2rjQSkSfCN2EtgzUZYCY+G9E06DsisxSdcN9RhlSGuLTageONp
	bFe1LytwmVp0/COfEAyDIbg1g+B3md6jNJ7hvyvrLmADzF23aEclstnpxMT8UKfA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejgx8qwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 05:32:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AL5V9uk017381;
	Fri, 21 Nov 2025 05:32:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j2293q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 05:32:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AL5WMZO43778420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 05:32:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CE0120040;
	Fri, 21 Nov 2025 05:32:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0812720043;
	Fri, 21 Nov 2025 05:32:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Nov 2025 05:32:21 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Fri, 21 Nov 2025 06:32:19 +0100
Subject: [PATCH v5 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain API
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-implement-msi-domain-v5-2-d7e717dfd3f7@linux.ibm.com>
References: <20251121-implement-msi-domain-v5-0-d7e717dfd3f7@linux.ibm.com>
In-Reply-To: <20251121-implement-msi-domain-v5-0-d7e717dfd3f7@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Tobias Schumacher <ts@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A96vFSJlaLvTlXTFcw6VCDk9Hy6BBNuE
X-Authority-Analysis: v=2.4 cv=YqwChoYX c=1 sm=1 tr=0 ts=691ff96b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pn-msHsI0j841b3IYMsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: A96vFSJlaLvTlXTFcw6VCDk9Hy6BBNuE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX6aTwBgsh3mPa
 clFVXfwH/VFaXaLs+JTIkz1It+P2Kyw/aaBdwOC1Ytrw1BNjBA6eDrhfOAoJGMC/KSLnyG2WuhX
 35QMppv4KuTSRNWMGdRozMczojfqsd0BvB2rAV0i8VWvWJYiFNOmFr33OVGHjoRHYccxYCJ1NLn
 0Bas8jmG7zi8AjcWW8lwX8hjJOobQBHdkjQVmGBgCBMM6FcG16zSlfRRKnBVI9oStP7mkqD0pRJ
 ic6MT4htA6ILb+nZIZA9tKcRSo8+c5ZxJVLBNeydazUc4LxMfb8BD+i57WZOYQXKblDiaOzcgAb
 r7ABzdAfPOcrwRlCPBqBKsHnhNA0IXBwxF3K/nIAe3BFpvaIg/yonU4JsuigIyxNiZKuk1R/OYC
 jIOAB7L/KOuBp89Y3LYjhoa+ZKAV6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_02,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032

s390 is one of the last architectures using the legacy API for setup and
teardown of PCI MSI IRQs. Migrate the s390 IRQ allocation and teardown
to the MSI parent domain API. For details, see:

https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de

In detail, create an MSI parent domain for each PCI domain. When a PCI
device sets up MSI or MSI-X IRQs, the library creates a per-device IRQ
domain for this device, which is used by the device for allocating and
freeing IRQs.

The per-device domain delegates this allocation and freeing to the
parent-domain. In the end, the corresponding callbacks of the parent
domain are responsible for allocating and freeing the IRQs.

The allocation is split into two parts:
- zpci_msi_prepare() is called once for each device and allocates the
  required resources. On s390, each PCI function has its own airq
  vector and a summary bit, which must be configured once per function.
  This is done in prepare().
- zpci_msi_alloc() can be called multiple times for allocating one or
  more MSI/MSI-X IRQs. This creates a mapping between the virtual IRQ
  number in the kernel and the hardware IRQ number.

Freeing is split into two counterparts:
- zpci_msi_free() reverts the effects of zpci_msi_alloc() and
- zpci_msi_teardown() reverts the effects of zpci_msi_prepare(). This is
  called once when all IRQs are freed before a device is removed.

Since the parent domain in the end allocates the IRQs, the hwirq
encoding must be unambiguous for all IRQs of all devices. This is
achieved by encoding the hwirq using the PCI function id and the MSI
index.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/Kconfig           |   1 +
 arch/s390/include/asm/pci.h |   4 +
 arch/s390/pci/pci_bus.c     |  21 ++-
 arch/s390/pci/pci_irq.c     | 333 +++++++++++++++++++++++++++-----------------
 4 files changed, 227 insertions(+), 132 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 778ce20d34046cad84dd4ef57cab5a662e5796d9..46ab67d607f0db7f5f108106172699a5eebfc8c8 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -251,6 +251,7 @@ config S390
 	select HOTPLUG_SMT
 	select IOMMU_HELPER		if PCI
 	select IOMMU_SUPPORT		if PCI
+	select IRQ_MSI_LIB if PCI
 	select KASAN_VMALLOC if KASAN
 	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_MERGE_VMAS
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index a32f465ecf73a5cc3408a312d94ec888d62848cc..60abc84cf14fe6fb1ee149df688eea94f0983ed0 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 #include <linux/mutex.h>
 #include <linux/iommu.h>
+#include <linux/irqdomain.h>
 #include <linux/pci_hotplug.h>
 #include <asm/pci_clp.h>
 #include <asm/pci_debug.h>
@@ -109,6 +110,7 @@ struct zpci_bus {
 	struct list_head	resources;
 	struct list_head	bus_next;
 	struct resource		bus_resource;
+	struct irq_domain       *msi_parent_domain;
 	int			topo;		/* TID if topo_is_tid, PCHID otherwise */
 	int			domain_nr;
 	u8			multifunction	: 1;
@@ -310,6 +312,8 @@ int zpci_dma_exit_device(struct zpci_dev *zdev);
 /* IRQ */
 int __init zpci_irq_init(void);
 void __init zpci_irq_exit(void);
+int zpci_create_parent_msi_domain(struct zpci_bus *zbus);
+void zpci_remove_parent_msi_domain(struct zpci_bus *zbus);
 
 /* FMB */
 int zpci_fmb_enable_device(struct zpci_dev *);
diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index be8c697fea0cc755cfdb4fb0a9e3b95183bec0dc..9da261b600df805ef76f3331975ac8fce6178908 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
+#include <linux/irqdomain.h>
 #include <linux/jump_label.h>
 #include <linux/pci.h>
 #include <linux/printk.h>
@@ -189,7 +190,7 @@ static bool zpci_bus_is_multifunction_root(struct zpci_dev *zdev)
 static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *fr, struct pci_ops *ops)
 {
 	struct pci_bus *bus;
-	int domain;
+	int domain, rc;
 
 	domain = zpci_alloc_domain((u16)fr->uid);
 	if (domain < 0)
@@ -199,19 +200,28 @@ static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *fr, s
 	zbus->multifunction = zpci_bus_is_multifunction_root(fr);
 	zbus->max_bus_speed = fr->max_bus_speed;
 
+	rc = zpci_create_parent_msi_domain(zbus);
+	if (rc)
+		goto out_free_domain;
+
 	/*
 	 * Note that the zbus->resources are taken over and zbus->resources
 	 * is empty after a successful call
 	 */
 	bus = pci_create_root_bus(NULL, ZPCI_BUS_NR, ops, zbus, &zbus->resources);
-	if (!bus) {
-		zpci_free_domain(zbus->domain_nr);
-		return -EFAULT;
-	}
+	if (!bus)
+		goto out_remove_msi_domain;
 
 	zbus->bus = bus;
+	dev_set_msi_domain(&zbus->bus->dev, zbus->msi_parent_domain);
 
 	return 0;
+
+out_remove_msi_domain:
+	zpci_remove_parent_msi_domain(zbus);
+out_free_domain:
+	zpci_free_domain(zbus->domain_nr);
+	return -EFAULT;
 }
 
 static void zpci_bus_release(struct kref *kref)
@@ -232,6 +242,7 @@ static void zpci_bus_release(struct kref *kref)
 	mutex_lock(&zbus_list_lock);
 	list_del(&zbus->bus_next);
 	mutex_unlock(&zbus_list_lock);
+	zpci_remove_parent_msi_domain(zbus);
 	kfree(zbus);
 }
 
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index e73be96ce5fe6473fc193d65b8f0ff635d6a98ba..b0be21ab56995e81f54339fc77167f5930182542 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -7,6 +7,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/smp.h>
 
 #include <asm/isc.h>
@@ -110,43 +111,41 @@ static int zpci_set_irq(struct zpci_dev *zdev)
 	return rc;
 }
 
-/* Clear adapter interruptions */
-static int zpci_clear_irq(struct zpci_dev *zdev)
+static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *dest,
+				 bool force)
 {
-	int rc;
-
-	if (irq_delivery == DIRECTED)
-		rc = zpci_clear_directed_irq(zdev);
-	else
-		rc = zpci_clear_airq(zdev);
-
-	return rc;
+	irq_data_update_affinity(data, dest);
+	return IRQ_SET_MASK_OK;
 }
 
-static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *dest,
-				 bool force)
+static void zpci_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct msi_desc *entry = irq_data_get_msi_desc(data);
-	struct msi_msg msg = entry->msg;
-	int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	struct zpci_dev *zdev = to_zpci_dev(desc->dev);
 
-	msg.address_lo &= 0xff0000ff;
-	msg.address_lo |= (cpu_addr << 8);
-	pci_write_msi_msg(data->irq, &msg);
+	if (irq_delivery == DIRECTED) {
+		int cpu = cpumask_first(irq_data_get_affinity_mask(data));
 
-	return IRQ_SET_MASK_OK;
+		msg->address_lo = zdev->msi_addr & 0xff0000ff;
+		msg->address_lo |= (smp_cpu_get_cpu_address(cpu) << 8);
+	} else {
+		msg->address_lo = zdev->msi_addr & 0xffffffff;
+	}
+	msg->address_hi = zdev->msi_addr >> 32;
+	msg->data = data->hwirq & 0xffffffff;
 }
 
 static struct irq_chip zpci_irq_chip = {
 	.name = "PCI-MSI",
-	.irq_unmask = pci_msi_unmask_irq,
-	.irq_mask = pci_msi_mask_irq,
+	.irq_compose_msi_msg = zpci_compose_msi_msg
 };
 
 static void zpci_handle_cpu_local_irq(bool rescan)
 {
 	struct airq_iv *dibv = zpci_ibv[smp_processor_id()];
 	union zpci_sic_iib iib = {{0}};
+	struct irq_domain *msi_domain;
+	irq_hw_number_t hwirq;
 	unsigned long bit;
 	int irqs_on = 0;
 
@@ -164,7 +163,9 @@ static void zpci_handle_cpu_local_irq(bool rescan)
 			continue;
 		}
 		inc_irq_stat(IRQIO_MSI);
-		generic_handle_irq(airq_iv_get_data(dibv, bit));
+		hwirq = airq_iv_get_data(dibv, bit);
+		msi_domain = (struct irq_domain *)airq_iv_get_ptr(dibv, bit);
+		generic_handle_domain_irq(msi_domain, hwirq);
 	}
 }
 
@@ -229,6 +230,8 @@ static void zpci_floating_irq_handler(struct airq_struct *airq,
 				      struct tpi_info *tpi_info)
 {
 	union zpci_sic_iib iib = {{0}};
+	struct irq_domain *msi_domain;
+	irq_hw_number_t hwirq;
 	unsigned long si, ai;
 	struct airq_iv *aibv;
 	int irqs_on = 0;
@@ -256,7 +259,9 @@ static void zpci_floating_irq_handler(struct airq_struct *airq,
 				break;
 			inc_irq_stat(IRQIO_MSI);
 			airq_iv_lock(aibv, ai);
-			generic_handle_irq(airq_iv_get_data(aibv, ai));
+			hwirq = airq_iv_get_data(aibv, ai);
+			msi_domain = (struct irq_domain *)airq_iv_get_ptr(aibv, ai);
+			generic_handle_domain_irq(msi_domain, hwirq);
 			airq_iv_unlock(aibv, ai);
 		}
 	}
@@ -278,7 +283,9 @@ static int __alloc_airq(struct zpci_dev *zdev, int msi_vecs,
 		zdev->aisb = *bit;
 
 		/* Create adapter interrupt vector */
-		zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_DATA | AIRQ_IV_BITLOCK, NULL);
+		zdev->aibv = airq_iv_create(msi_vecs,
+					    AIRQ_IV_PTR | AIRQ_IV_DATA | AIRQ_IV_BITLOCK,
+					    NULL);
 		if (!zdev->aibv)
 			return -ENOMEM;
 
@@ -290,146 +297,217 @@ static int __alloc_airq(struct zpci_dev *zdev, int msi_vecs,
 	return 0;
 }
 
-int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+bool arch_restore_msi_irqs(struct pci_dev *pdev)
 {
-	unsigned int hwirq, msi_vecs, irqs_per_msi, i, cpu;
 	struct zpci_dev *zdev = to_zpci(pdev);
-	struct msi_desc *msi;
-	struct msi_msg msg;
-	unsigned long bit;
-	int cpu_addr;
-	int rc, irq;
 
-	zdev->aisb = -1UL;
-	zdev->msi_first_bit = -1U;
+	zpci_set_irq(zdev);
+	return true;
+}
+
+static struct airq_struct zpci_airq = {
+	.handler = zpci_floating_irq_handler,
+	.isc = PCI_ISC,
+};
+
+/*
+ * Encode the hwirq number for the parent domain. The encoding must be unique
+ * for each IRQ of each device in the parent domain, so it uses the devfn to
+ * identify the device and the msi_index to identify the IRQ within that device.
+ */
+static inline u32 zpci_encode_hwirq(u8 devfn, u16 msi_index)
+{
+	return (devfn << 16) | msi_index;
+}
+
+static inline u16 zpci_decode_hwirq_msi_index(irq_hw_number_t irq)
+{
+	return irq & GENMASK_U16(15, 0);
+}
+
+static int zpci_msi_prepare(struct irq_domain *domain,
+			    struct device *dev, int nvec,
+			    msi_alloc_info_t *info)
+{
+	struct zpci_dev *zdev = to_zpci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	unsigned long bit;
+	int msi_vecs, rc;
 
 	msi_vecs = min_t(unsigned int, nvec, zdev->max_msi);
-	if (msi_vecs < nvec) {
-		pr_info("%s requested %d irqs, allocate system limit of %d",
+	if (msi_vecs < nvec)
+		pr_info("%s requested %d IRQs, allocate system limit of %d\n",
 			pci_name(pdev), nvec, zdev->max_msi);
-	}
 
 	rc = __alloc_airq(zdev, msi_vecs, &bit);
-	if (rc < 0)
+	if (rc) {
+		pr_err("Allocating adapter IRQs for %s failed\n", pci_name(pdev));
 		return rc;
+	}
 
-	/*
-	 * Request MSI interrupts:
-	 * When using MSI, nvec_used interrupt sources and their irq
-	 * descriptors are controlled through one msi descriptor.
-	 * Thus the outer loop over msi descriptors shall run only once,
-	 * while two inner loops iterate over the interrupt vectors.
-	 * When using MSI-X, each interrupt vector/irq descriptor
-	 * is bound to exactly one msi descriptor (nvec_used is one).
-	 * So the inner loops are executed once, while the outer iterates
-	 * over the MSI-X descriptors.
-	 */
-	hwirq = bit;
-	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
-		if (hwirq - bit >= msi_vecs)
-			break;
-		irqs_per_msi = min_t(unsigned int, msi_vecs, msi->nvec_used);
-		irq = __irq_alloc_descs(-1, 0, irqs_per_msi, 0, THIS_MODULE,
-					(irq_delivery == DIRECTED) ?
-					msi->affinity : NULL);
-		if (irq < 0)
-			return -ENOMEM;
-
-		for (i = 0; i < irqs_per_msi; i++) {
-			rc = irq_set_msi_desc_off(irq, i, msi);
-			if (rc)
-				return rc;
-			irq_set_chip_and_handler(irq + i, &zpci_irq_chip,
-						 handle_percpu_irq);
+	zdev->msi_first_bit = bit;
+	zdev->msi_nr_irqs = msi_vecs;
+	rc = zpci_set_irq(zdev);
+	if (rc) {
+		pr_err("Registering adapter IRQs for %s failed\n",
+		       pci_name(pdev));
+		if (irq_delivery == DIRECTED) {
+			airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, msi_vecs);
+		} else {
+			zpci_clear_airq(zdev);
+			airq_iv_release(zdev->aibv);
+			zdev->aibv = NULL;
+			airq_iv_free_bit(zpci_sbv, zdev->aisb);
+			zdev->aisb = -1UL;
 		}
+		zdev->msi_first_bit = -1U;
+		return rc;
+	}
 
-		msg.data = hwirq - bit;
-		if (irq_delivery == DIRECTED) {
-			if (msi->affinity)
-				cpu = cpumask_first(&msi->affinity->mask);
-			else
-				cpu = 0;
-			cpu_addr = smp_cpu_get_cpu_address(cpu);
+	return 0;
+}
+
+static void zpci_msi_teardown_directed(struct zpci_dev *zdev)
+{
+	zpci_clear_directed_irq(zdev);
+	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->max_msi);
+	zdev->msi_first_bit = -1U;
+}
+
+static void zpci_msi_teardown_floating(struct zpci_dev *zdev)
+{
+	zpci_clear_airq(zdev);
+	airq_iv_release(zdev->aibv);
+	zdev->aibv = NULL;
+	airq_iv_free_bit(zpci_sbv, zdev->aisb);
+	zdev->aisb = -1UL;
+	zdev->msi_first_bit = -1U;
+}
 
-			msg.address_lo = zdev->msi_addr & 0xff0000ff;
-			msg.address_lo |= (cpu_addr << 8);
+static void zpci_msi_teardown(struct irq_domain *domain, msi_alloc_info_t *arg)
+{
+	struct zpci_dev *zdev = to_zpci_dev(domain->dev);
 
+	if (irq_delivery == DIRECTED)
+		zpci_msi_teardown_directed(zdev);
+	else
+		zpci_msi_teardown_floating(zdev);
+}
+
+static int zpci_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *args)
+{
+	struct msi_desc *desc = ((msi_alloc_info_t *)args)->desc;
+	struct zpci_dev *zdev = to_zpci_dev(desc->dev);
+	struct zpci_bus *zbus = zdev->zbus;
+	unsigned int cpu, hwirq;
+	unsigned long bit;
+	int i;
+
+	bit = zdev->msi_first_bit + desc->msi_index;
+	hwirq = zpci_encode_hwirq(zdev->devfn, desc->msi_index);
+
+	if (desc->msi_index + nr_irqs > zdev->max_msi)
+		return -EINVAL;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &zpci_irq_chip, zdev,
+				    handle_percpu_irq, NULL, NULL);
+
+		if (irq_delivery == DIRECTED) {
 			for_each_possible_cpu(cpu) {
-				for (i = 0; i < irqs_per_msi; i++)
-					airq_iv_set_data(zpci_ibv[cpu],
-							 hwirq + i, irq + i);
+				airq_iv_set_ptr(zpci_ibv[cpu], bit + i,
+						(unsigned long)zbus->msi_parent_domain);
+				airq_iv_set_data(zpci_ibv[cpu], bit + i, hwirq + i);
 			}
 		} else {
-			msg.address_lo = zdev->msi_addr & 0xffffffff;
-			for (i = 0; i < irqs_per_msi; i++)
-				airq_iv_set_data(zdev->aibv, hwirq + i, irq + i);
+			airq_iv_set_ptr(zdev->aibv, bit + i,
+					(unsigned long)zbus->msi_parent_domain);
+			airq_iv_set_data(zdev->aibv, bit + i, hwirq + i);
 		}
-		msg.address_hi = zdev->msi_addr >> 32;
-		pci_write_msi_msg(irq, &msg);
-		hwirq += irqs_per_msi;
 	}
 
-	zdev->msi_first_bit = bit;
-	zdev->msi_nr_irqs = hwirq - bit;
+	return 0;
+}
 
-	rc = zpci_set_irq(zdev);
-	if (rc)
-		return rc;
+static void zpci_msi_domain_free(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs)
+{
+	irq_hw_number_t hwirq;
+	struct irq_data *d;
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		d = irq_domain_get_irq_data(domain, virq + i);
+		hwirq = d->hwirq;
+		irq_domain_reset_irq_data(d);
+	}
+}
+
+static const struct irq_domain_ops zpci_msi_domain_ops = {
+	.alloc = zpci_msi_domain_alloc,
+	.free  = zpci_msi_domain_free
+};
+
+static bool zpci_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				   struct irq_domain *real_parent,
+				   struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	info->ops->msi_prepare = zpci_msi_prepare;
+	info->ops->msi_teardown = zpci_msi_teardown;
 
-	return (zdev->msi_nr_irqs == nvec) ? 0 : zdev->msi_nr_irqs;
+	return true;
 }
 
-void arch_teardown_msi_irqs(struct pci_dev *pdev)
+static struct msi_parent_ops zpci_msi_parent_ops = {
+	.supported_flags   = MSI_GENERIC_FLAGS_MASK	|
+			     MSI_FLAG_PCI_MSIX		|
+			     MSI_FLAG_MULTI_PCI_MSI,
+	.required_flags	   = MSI_FLAG_USE_DEF_DOM_OPS  |
+			     MSI_FLAG_USE_DEF_CHIP_OPS,
+	.init_dev_msi_info = zpci_init_dev_msi_info
+};
+
+int zpci_create_parent_msi_domain(struct zpci_bus *zbus)
 {
-	struct zpci_dev *zdev = to_zpci(pdev);
-	struct msi_desc *msi;
-	unsigned int i;
-	int rc;
+	char fwnode_name[18];
 
-	/* Disable interrupts */
-	rc = zpci_clear_irq(zdev);
-	if (rc)
-		return;
+	sprintf(fwnode_name, "ZPCI_MSI_DOM_%04x", zbus->domain_nr);
+	struct irq_domain_info info = {
+		.fwnode		= irq_domain_alloc_named_fwnode(fwnode_name),
+		.ops		= &zpci_msi_domain_ops
+	};
 
-	/* Release MSI interrupts */
-	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
-		for (i = 0; i < msi->nvec_used; i++) {
-			irq_set_msi_desc(msi->irq + i, NULL);
-			irq_free_desc(msi->irq + i);
-		}
-		msi->msg.address_lo = 0;
-		msi->msg.address_hi = 0;
-		msi->msg.data = 0;
-		msi->irq = 0;
+	if (!info.fwnode) {
+		pr_err("Failed to allocate fwnode for MSI IRQ domain\n");
+		return -ENOMEM;
 	}
 
-	if (zdev->aisb != -1UL) {
-		zpci_ibv[zdev->aisb] = NULL;
-		airq_iv_free_bit(zpci_sbv, zdev->aisb);
-		zdev->aisb = -1UL;
-	}
-	if (zdev->aibv) {
-		airq_iv_release(zdev->aibv);
-		zdev->aibv = NULL;
+	if (irq_delivery == FLOATING)
+		zpci_msi_parent_ops.required_flags |= MSI_FLAG_NO_AFFINITY;
+	zbus->msi_parent_domain = msi_create_parent_irq_domain(&info, &zpci_msi_parent_ops);
+	if (!zbus->msi_parent_domain) {
+		irq_domain_free_fwnode(info.fwnode);
+		pr_err("Failed to create MSI IRQ domain\n");
+		return -ENOMEM;
 	}
 
-	if ((irq_delivery == DIRECTED) && zdev->msi_first_bit != -1U)
-		airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
+	return 0;
 }
 
-bool arch_restore_msi_irqs(struct pci_dev *pdev)
+void zpci_remove_parent_msi_domain(struct zpci_bus *zbus)
 {
-	struct zpci_dev *zdev = to_zpci(pdev);
+	struct fwnode_handle *fn;
 
-	zpci_set_irq(zdev);
-	return true;
+	fn = zbus->msi_parent_domain->fwnode;
+	irq_domain_remove(zbus->msi_parent_domain);
+	irq_domain_free_fwnode(fn);
 }
 
-static struct airq_struct zpci_airq = {
-	.handler = zpci_floating_irq_handler,
-	.isc = PCI_ISC,
-};
-
 static void __init cpu_enable_directed_irq(void *unused)
 {
 	union zpci_sic_iib iib = {{0}};
@@ -466,6 +544,7 @@ static int __init zpci_directed_irq_init(void)
 		 * is only done on the first vector.
 		 */
 		zpci_ibv[cpu] = airq_iv_create(cache_line_size() * BITS_PER_BYTE,
+					       AIRQ_IV_PTR |
 					       AIRQ_IV_DATA |
 					       AIRQ_IV_CACHELINE |
 					       (!cpu ? AIRQ_IV_ALLOC : 0), NULL);

-- 
2.48.1


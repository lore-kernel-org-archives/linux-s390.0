Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063413C6A34;
	Tue, 17 Mar 2026 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752355; cv=none; b=j4IVlgFfzFUhzHuyHxIaMVXxYDj3GYiYGvId9/S8lYz8PySk0OHWqalCr6fRkSHAs/LUN+Hmfzn2eK4WY6lqi1+N/fU1aTOUWB1vc7VJ+3/ccqt9/v+1v6+TlKxijcyXL7g3m/XwWNiBnf0L62HhnmAvrg4W0MUrwoz5+AL7BtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752355; c=relaxed/simple;
	bh=Tf84yf/gnBYFSYoHHRb+EoiliRaA3jW9KajQhmyuwuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eFIMfClJq0jIxNVjF6pD5yvcATLDT1If/8p4YI6noUJEsdZycZyA9Ljpb35YzCfN3PwFwC6DMtqBr5IYCGIs7wSDK54ZSgMVqiKv0HukbdOp3Rq1gwqRxwIQHkp8N4WtFVdfdBysuh5CUBI45saX26dy9nfcVPwx4Uz1m004jUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jjnI4ok3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jjnI4ok3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H8GYwC967663;
	Tue, 17 Mar 2026 12:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TXndoh
	DDD/bg7PTmdiZ/Gb+ohaex4Q01Gto83XdCAqM=; b=jjnI4ok3U1UFtdbavAlA+c
	3SZ10UAUoNBvlCFOXg9wX/HM0FU+Xviyg4LujpGPNvSb5OpizT04yGtOc3dJ/FW0
	Zi2F/1YqLxaXdgJ+MAGib57jg8tVb+Ib9lu0YTpLlOOW5b1uDmhWW7ncS+9s+pcj
	saPPMTp6c52AMt6pW/tNA2wu4YLmzUNNRicSO52rWJbfyaXwsWEY3db7RiFDA68q
	5oPC/MT81HGJ3vkoKOaBPJFI0O6tAY3TsK0n8858XaSNoYlY/fZQWK4IDWP68oz2
	FLVfbU8q+4wVEM+k3kLX5l/bfoUHjYytBMtQW95aW7OvDC8pkU4OfurkpvPl+m6A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cvb24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 12:59:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HCD6jq032333;
	Tue, 17 Mar 2026 12:59:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7js224-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 12:59:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HCx3Ep15073598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 12:59:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C29CD20043;
	Tue, 17 Mar 2026 12:59:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68C8720040;
	Tue, 17 Mar 2026 12:59:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 12:59:03 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Tue, 17 Mar 2026 13:58:50 +0100
Subject: [PATCH v5 2/3] vfio/ism: Implement vfio_pci driver for ISM devices
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-vfio_pci_ism-v5-2-b73248b4e576@linux.ibm.com>
References: <20260317-vfio_pci_ism-v5-0-b73248b4e576@linux.ibm.com>
In-Reply-To: <20260317-vfio_pci_ism-v5-0-b73248b4e576@linux.ibm.com>
To: schnelle@linux.ibm.com, wintera@linux.ibm.com, ts@linux.ibm.com,
        oberpar@linux.ibm.com, gbayer@linux.ibm.com,
        Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        julianr@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b9501c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=qDoQYVglVPIJUuxkhcQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExMiBTYWx0ZWRfX24HskeuCXo8X
 OqxO8QeOqQ5YC22L0pldxq3s5Y96ipHl82fxuJu5YWPBX5xCylZm7pwoQXYwTEcbR+bgF9fND5E
 fXg70J55m2I23766GOqf1NG4Z0yFeRbPNDlBBbUgHotqogjzAKxktPKUyeaBbMSyQ9x19+z81ik
 WVDpDn4EYBf9iZ0MxkLEyk9UjxQ8EyUObg3OjGhGvRWYANs251JIJzi8fCCsD2esQqkj91jXUkR
 dJx3NBkA2hTDFEc0K42SEfOLZV5TW/JVcMyikjOMWH7KpPMgtURh6U63CUttqpujgk9GoyjKjvJ
 BAKnrcR98s0d2RT2uPOS+r4rRIuvnx2tbbTRyh4h4xUaAdPaNmejAQKId/Z3G3YeKPWIG5Yipbn
 NnRJGP1Ty42mxiJxsxEWtYASWeEEIPhA1GsvkczJ/gwDw2R9LzYhCYjvKCAt5VKarkFu/G8VSV8
 tubLU6EYzUtHXSkkFXg==
X-Proofpoint-GUID: KTY9m_62K_D8I7hcEkQoUynvufatn0Af
X-Proofpoint-ORIG-GUID: KTY9m_62K_D8I7hcEkQoUynvufatn0Af
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170112

Add a vfio_pci variant driver for the s390-specific Internal Shared
Memory (ISM) devices used for inter-VM communication.

This enables the development of vfio-pci-based user space drivers for
ISM devices.

On s390, kernel primitives such as ioread() and iowrite() are switched
over from function handle based PCI load/stores instructions to PCI
memory-I/O (MIO) loads/stores when these are available and not
explicitly disabled. Since these instructions cannot be used with ISM
devices, ensure that classic function handle-based PCI instructions are
used instead.

The driver is still required even when MIO instructions are disabled, as
the ISM device relies on the PCI store block (PCISTB) instruction to
perform write operations.

Stores are not fragmented, therefore one ioctl corresponds to exactly
one PCISTB instruction. User space must ensure to not write more than
4096 bytes at once to an ISM BAR which is the maximum payload of the
PCISTB instruction.

Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
---
 drivers/vfio/pci/Kconfig      |   2 +
 drivers/vfio/pci/Makefile     |   2 +
 drivers/vfio/pci/ism/Kconfig  |  10 ++
 drivers/vfio/pci/ism/Makefile |   3 +
 drivers/vfio/pci/ism/main.c   | 379 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 396 insertions(+)

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 1e82b44bda1a0a544e1add7f4b06edecf35aaf81..296bf01e185ecacc388ebc69e92706c99e47c814 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -60,6 +60,8 @@ config VFIO_PCI_DMABUF
 
 source "drivers/vfio/pci/mlx5/Kconfig"
 
+source "drivers/vfio/pci/ism/Kconfig"
+
 source "drivers/vfio/pci/hisilicon/Kconfig"
 
 source "drivers/vfio/pci/pds/Kconfig"
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index e0a0757dd1d2b0bc69b7e4d79441d5cacf4e1cd8..6138f1bf241df04e7419f196b404abdf9b194050 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
 
 obj-$(CONFIG_MLX5_VFIO_PCI)           += mlx5/
 
+obj-$(CONFIG_ISM_VFIO_PCI)           += ism/
+
 obj-$(CONFIG_HISI_ACC_VFIO_PCI) += hisilicon/
 
 obj-$(CONFIG_PDS_VFIO_PCI) += pds/
diff --git a/drivers/vfio/pci/ism/Kconfig b/drivers/vfio/pci/ism/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..02f47d25fed2d34c732b67b3a3655b64a7625467
--- /dev/null
+++ b/drivers/vfio/pci/ism/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+config ISM_VFIO_PCI
+	tristate "VFIO support for ISM devices"
+	depends on S390
+	select VFIO_PCI_CORE
+	help
+	  This provides user space support for IBM Internal Shared Memory (ISM)
+	  Adapter devices using the VFIO framework.
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/vfio/pci/ism/Makefile b/drivers/vfio/pci/ism/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..32cc3c66dd11395da85a2b6f05b3d97036ed8a35
--- /dev/null
+++ b/drivers/vfio/pci/ism/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_ISM_VFIO_PCI) += ism-vfio-pci.o
+ism-vfio-pci-y := main.o
diff --git a/drivers/vfio/pci/ism/main.c b/drivers/vfio/pci/ism/main.c
new file mode 100644
index 0000000000000000000000000000000000000000..da8fedb2dcd7756814f97608312e1726a622bdf5
--- /dev/null
+++ b/drivers/vfio/pci/ism/main.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * vfio-ISM driver for s390
+ *
+ * Copyright IBM Corp.
+ */
+
+#include "../vfio_pci_priv.h"
+#include "linux/slab.h"
+
+#define ISM_VFIO_PCI_OFFSET_SHIFT   48
+#define ISM_VFIO_PCI_OFFSET_TO_INDEX(off) (off >> ISM_VFIO_PCI_OFFSET_SHIFT)
+#define ISM_VFIO_PCI_INDEX_TO_OFFSET(index) ((u64)(index) << ISM_VFIO_PCI_OFFSET_SHIFT)
+#define ISM_VFIO_PCI_OFFSET_MASK (((u64)(1) << ISM_VFIO_PCI_OFFSET_SHIFT) - 1)
+
+/*
+ * Use __zpci_load() to bypass automatic use of
+ * PCI MIO instructions which are not supported on ISM devices
+ */
+#define ISM_READ(size)                                                        \
+	static int ism_read##size(struct zpci_dev *zdev, int bar,             \
+				  ssize_t *filled, char __user *buf,          \
+				  loff_t off)                                 \
+	{                                                                     \
+		u64 req, tmp;                                                 \
+		u##size val;                                                  \
+		int ret;                                                      \
+									      \
+		req = ZPCI_CREATE_REQ(READ_ONCE(zdev->fh), bar, sizeof(val)); \
+		ret = __zpci_load(&tmp, req, off);                            \
+		val = (u##size)tmp;                                           \
+		if (copy_to_user(buf, &val, sizeof(val)))                     \
+			return -EFAULT;                                       \
+		*filled = sizeof(val);                                        \
+		return ret;                                                   \
+	}
+
+ISM_READ(64);
+ISM_READ(32);
+ISM_READ(16);
+ISM_READ(8);
+
+struct ism_vfio_pci_core_device {
+	struct vfio_pci_core_device core_device;
+	struct kmem_cache *store_block_cache;
+};
+
+static int ism_pci_open_device(struct vfio_device *core_vdev)
+{
+	struct ism_vfio_pci_core_device *ivdev;
+	struct vfio_pci_core_device *vdev;
+	int ret;
+
+	ivdev = container_of(core_vdev, struct ism_vfio_pci_core_device,
+			     core_device.vdev);
+	vdev = &ivdev->core_device;
+
+	ret = vfio_pci_core_enable(vdev);
+	if (ret)
+		return ret;
+
+	vfio_pci_core_finish_enable(vdev);
+	return 0;
+}
+
+/*
+ * ism_vfio_pci_do_io_r()
+ *
+ * On s390, kernel primitives such as ioread() and iowrite() are switched over
+ * from function handle based PCI load/stores instructions to PCI memory-I/O (MIO)
+ * loads/stores when these are available and not explicitly disabled. Since these
+ * instructions cannot be used with ISM devices, ensure that classic function
+ * handle-based PCI instructions are used instead.
+ */
+static ssize_t ism_vfio_pci_do_io_r(struct vfio_pci_core_device *vdev,
+				    char __user *buf, loff_t off, size_t count,
+				    int bar)
+{
+	struct zpci_dev *zdev = to_zpci(vdev->pdev);
+	ssize_t done = 0;
+	int ret;
+
+	while (count) {
+		size_t filled;
+
+		if (count >= 8 && IS_ALIGNED(off, 8)) {
+			ret = ism_read64(zdev, bar, &filled, buf, off);
+			if (ret)
+				return ret;
+		} else if (count >= 4 && IS_ALIGNED(off, 4)) {
+			ret = ism_read32(zdev, bar, &filled, buf, off);
+			if (ret)
+				return ret;
+		} else if (count >= 2 && IS_ALIGNED(off, 2)) {
+			ret = ism_read16(zdev, bar, &filled, buf, off);
+			if (ret)
+				return ret;
+		} else {
+			ret = ism_read8(zdev, bar, &filled, buf, off);
+			if (ret)
+				return ret;
+		}
+
+		count -= filled;
+		done += filled;
+		off += filled;
+		buf += filled;
+	}
+
+	return done;
+}
+
+/*
+ * ism_vfio_pci_do_io_w()
+ *
+ * Ensure that the PCI store block (PCISTB) instruction is used as required by the
+ * ISM device. The ISM device also uses a 256 TiB BAR 0 for write operations,
+ * which requires a 48bit region address space (ISM_VFIO_PCI_OFFSET_SHIFT).
+ */
+static ssize_t ism_vfio_pci_do_io_w(struct vfio_pci_core_device *vdev,
+				    char __user *buf, loff_t off, size_t count,
+				    int bar)
+{
+	struct zpci_dev *zdev = to_zpci(vdev->pdev);
+	struct ism_vfio_pci_core_device *ivpcd;
+	ssize_t ret;
+	void *data;
+	u64 req;
+
+	if (count > zdev->maxstbl)
+		return -EINVAL;
+	if (((off % PAGE_SIZE) + count) > PAGE_SIZE)
+		return -EINVAL;
+
+	ivpcd = container_of(vdev, struct ism_vfio_pci_core_device,
+			     core_device);
+	data = kmem_cache_zalloc(ivpcd->store_block_cache, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (copy_from_user(data, buf, count)) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+
+	req = ZPCI_CREATE_REQ(READ_ONCE(zdev->fh), bar, count);
+	ret = __zpci_store_block(data, req, off);
+	if (ret)
+		goto out_free;
+
+	ret = count;
+
+out_free:
+	kmem_cache_free(ivpcd->store_block_cache, data);
+	return ret;
+}
+
+static ssize_t ism_vfio_pci_bar_rw(struct vfio_pci_core_device *vdev,
+				   char __user *buf, size_t count, loff_t *ppos,
+				   bool iswrite)
+{
+	int bar = ISM_VFIO_PCI_OFFSET_TO_INDEX(*ppos);
+	loff_t pos = *ppos & ISM_VFIO_PCI_OFFSET_MASK;
+	resource_size_t end;
+	ssize_t done = 0;
+
+	if (pci_resource_start(vdev->pdev, bar))
+		end = pci_resource_len(vdev->pdev, bar);
+	else
+		return -EINVAL;
+
+	if (pos >= end)
+		return -EINVAL;
+
+	count = min(count, (size_t)(end - pos));
+
+	if (iswrite)
+		done = ism_vfio_pci_do_io_w(vdev, buf, pos, count, bar);
+	else
+		done = ism_vfio_pci_do_io_r(vdev, buf, pos, count, bar);
+
+	if (done >= 0)
+		*ppos += done;
+
+	return done;
+}
+
+static ssize_t ism_vfio_pci_config_rw(struct vfio_pci_core_device *vdev,
+				      char __user *buf, size_t count,
+				      loff_t *ppos, bool iswrite)
+{
+	loff_t pos = *ppos;
+	size_t done = 0;
+	int ret = 0;
+
+	pos &= ISM_VFIO_PCI_OFFSET_MASK;
+
+	while (count) {
+		/*
+		 * zPCI must not use MIO instructions for config space access,
+		 * so we can use common code path here.
+		 */
+		ret = vfio_pci_config_rw_single(vdev, buf, count, &pos, iswrite);
+		if (ret < 0)
+			return ret;
+
+		count -= ret;
+		done += ret;
+		buf += ret;
+		pos += ret;
+	}
+
+	*ppos += done;
+
+	return done;
+}
+
+static ssize_t ism_vfio_pci_rw(struct vfio_device *core_vdev, char __user *buf,
+			       size_t count, loff_t *ppos, bool iswrite)
+{
+	unsigned int index = ISM_VFIO_PCI_OFFSET_TO_INDEX(*ppos);
+	struct vfio_pci_core_device *vdev;
+	int ret;
+
+	vdev = container_of(core_vdev, struct vfio_pci_core_device, vdev);
+
+	if (!count)
+		return 0;
+
+	switch (index) {
+	case VFIO_PCI_CONFIG_REGION_INDEX:
+		ret = ism_vfio_pci_config_rw(vdev, buf, count, ppos, iswrite);
+		break;
+
+	case VFIO_PCI_BAR0_REGION_INDEX ... VFIO_PCI_BAR5_REGION_INDEX:
+		ret = ism_vfio_pci_bar_rw(vdev, buf, count, ppos, iswrite);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static ssize_t ism_vfio_pci_read(struct vfio_device *core_vdev,
+				 char __user *buf, size_t count, loff_t *ppos)
+{
+	return ism_vfio_pci_rw(core_vdev, buf, count, ppos, false);
+}
+
+static ssize_t ism_vfio_pci_write(struct vfio_device *core_vdev,
+				  const char __user *buf, size_t count,
+				  loff_t *ppos)
+{
+	return ism_vfio_pci_rw(core_vdev, (char __user *)buf, count, ppos,
+			       true);
+}
+
+static int ism_vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
+					      struct vfio_region_info *info,
+					      struct vfio_info_cap *caps)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+	struct pci_dev *pdev = vdev->pdev;
+
+	switch (info->index) {
+	case VFIO_PCI_CONFIG_REGION_INDEX:
+		info->offset = ISM_VFIO_PCI_INDEX_TO_OFFSET(info->index);
+		info->size = pdev->cfg_size;
+		info->flags = VFIO_REGION_INFO_FLAG_READ |
+			      VFIO_REGION_INFO_FLAG_WRITE;
+		break;
+	case VFIO_PCI_BAR0_REGION_INDEX ... VFIO_PCI_BAR5_REGION_INDEX:
+		info->offset = ISM_VFIO_PCI_INDEX_TO_OFFSET(info->index);
+		info->size = pci_resource_len(pdev, info->index);
+		if (!info->size) {
+			info->flags = 0;
+			break;
+		}
+		info->flags = VFIO_REGION_INFO_FLAG_READ |
+			      VFIO_REGION_INFO_FLAG_WRITE;
+		break;
+	default:
+		info->offset = 0;
+		info->size = 0;
+		info->flags = 0;
+	}
+	return 0;
+}
+
+static const struct vfio_device_ops ism_pci_ops = {
+	.name = "ism-vfio-pci",
+	.init = vfio_pci_core_init_dev,
+	.release = vfio_pci_core_release_dev,
+	.open_device = ism_pci_open_device,
+	.close_device = vfio_pci_core_close_device,
+	.ioctl = vfio_pci_core_ioctl,
+	.get_region_info_caps = ism_vfio_pci_ioctl_get_region_info,
+	.device_feature = vfio_pci_core_ioctl_feature,
+	.read = ism_vfio_pci_read,
+	.write = ism_vfio_pci_write,
+	.request = vfio_pci_core_request,
+	.match = vfio_pci_core_match,
+	.match_token_uuid = vfio_pci_core_match_token_uuid,
+	.bind_iommufd = vfio_iommufd_physical_bind,
+	.unbind_iommufd = vfio_iommufd_physical_unbind,
+	.attach_ioas = vfio_iommufd_physical_attach_ioas,
+	.detach_ioas = vfio_iommufd_physical_detach_ioas,
+};
+
+static int ism_vfio_pci_probe(struct pci_dev *pdev,
+			      const struct pci_device_id *id)
+{
+	struct ism_vfio_pci_core_device *ivpcd;
+	struct zpci_dev *zdev = to_zpci(pdev);
+	char cache_name[20];
+	int ret;
+
+	ivpcd = vfio_alloc_device(ism_vfio_pci_core_device, core_device.vdev,
+				  &pdev->dev, &ism_pci_ops);
+	if (IS_ERR(ivpcd))
+		return PTR_ERR(ivpcd);
+
+	snprintf(cache_name, sizeof(cache_name), "ism_sb_fid_%08x", zdev->fid);
+	ivpcd->store_block_cache =
+		kmem_cache_create(cache_name, zdev->maxstbl, 0, 0, NULL);
+	if (!ivpcd->store_block_cache) {
+		vfio_put_device(&ivpcd->core_device.vdev);
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(&pdev->dev, &ivpcd->core_device);
+	ret = vfio_pci_core_register_device(&ivpcd->core_device);
+	if (ret) {
+		kmem_cache_destroy(ivpcd->store_block_cache);
+		vfio_put_device(&ivpcd->core_device.vdev);
+	}
+
+	return ret;
+}
+
+static void ism_vfio_pci_remove(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *core_device;
+	struct ism_vfio_pci_core_device *ivpcd;
+
+	core_device = dev_get_drvdata(&pdev->dev);
+	ivpcd = container_of(core_device, struct ism_vfio_pci_core_device,
+			     core_device);
+
+	vfio_pci_core_unregister_device(&ivpcd->core_device);
+	vfio_put_device(&ivpcd->core_device.vdev);
+
+	kmem_cache_destroy(ivpcd->store_block_cache);
+}
+
+static const struct pci_device_id ism_device_table[] = {
+	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_IBM,
+					  PCI_DEVICE_ID_IBM_ISM) },
+	{}
+};
+MODULE_DEVICE_TABLE(pci, ism_device_table);
+
+static struct pci_driver ism_vfio_pci_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = ism_device_table,
+	.probe = ism_vfio_pci_probe,
+	.remove = ism_vfio_pci_remove,
+	.err_handler = &vfio_pci_core_err_handlers,
+	.driver_managed_dma = true,
+};
+
+module_pci_driver(ism_vfio_pci_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("vfio-pci variant driver for the IBM Internal Shared Memory (ISM) device");
+MODULE_AUTHOR("IBM Corporation");

-- 
2.51.0


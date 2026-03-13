Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697633A4521;
	Fri, 13 Mar 2026 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412850; cv=none; b=p1cpz62JvZEz+rP4L4XA3KPZPD1eLwP9nMZC75ODK465pCLAQESyGg7bMCJsKA7THtcXZ265nYVgc5Op3dywFRiFvkGGgl9Glpj0pvXUMtzqonyKX4A35j1LUiiyux/Bf5Rf1WVIM/kK1kfNXvvyJvP6eSNJahCrlnJpKoaL6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412850; c=relaxed/simple;
	bh=60fyhAkVvDHSA/HLbr0YvM1VfLz36v57Fn4Ru4bsZ6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PpVu5g7XeC/9o59/1lRTCxBLu+SAqt9WM6Wl3qG1wWBCZ3Xg4Uwk3FBqPfMlke11tgWG2Z3FQkIWB1Z3VqVwA5jeb6D0a1YJjNsK15DV6BIpprnHp6vicfKbBgLQEnXAy0iGk6EhmiKLPPo0oLaXIpJjslYrD5GWeTNuKkO4GZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FCmkq7FL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FCmkq7FL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D7BWhf2279397;
	Fri, 13 Mar 2026 14:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uDLbxu
	jlcHn6UVBAKlajNXypD5imEOcaBuBY1uEY024=; b=FCmkq7FLabPoX9xIlIAxZQ
	SsTRPnw0ISbJKJS8eV32TNaGqJ2wt6riHk7X0IYPHMqJoA+LakHYzQ9vfqfik0UE
	eNyCrjLWrAICbZaWkoJp00pmD55WaGchJhV/QEUkYcn3bPJ5aFA0NwggISi2Mvbq
	RtOnbGOVelrJ6OpLrJ0kQgy+HF/xA4R+oiXFzjEh5uUGiqHzTE8ybgdmEZJbUkTR
	qkIgwgs2U9zIL8hNqkUKNUedW8utMTLTLp5sZsbfZwwPC8yPmuHh2YF0Ck+uXuo9
	0gqpBGv5F1j2H0FnCKpfxSkYJ8oG2QlI02jcfT4K+CM79gnuD3KwjvBdNCqaQCJw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91r8pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 14:40:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAL9MA018371;
	Fri, 13 Mar 2026 14:40:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha871nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 14:40:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DEeedN39977364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 14:40:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02C7D2004D;
	Fri, 13 Mar 2026 14:40:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B675D2004F;
	Fri, 13 Mar 2026 14:40:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 14:40:39 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Fri, 13 Mar 2026 15:40:29 +0100
Subject: [PATCH v4 2/3] vfio/ism: Implement vfio_pci driver for ISM devices
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-vfio_pci_ism-v4-2-4765ae056f71@linux.ibm.com>
References: <20260313-vfio_pci_ism-v4-0-4765ae056f71@linux.ibm.com>
In-Reply-To: <20260313-vfio_pci_ism-v4-0-4765ae056f71@linux.ibm.com>
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
X-Proofpoint-GUID: Rp3ZDBXz-4ol3hVtgYD3pKhEl4LUgfkY
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b421ec cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Cakb2dha6NNJ7eZIcBAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExNiBTYWx0ZWRfX32gBT4Lp/1Uf
 2I+P5MmWsVZNWlVEwVhoBQ4GCDgfOFv1d0gylVfjKkpXIFqKcnKTJwoUWDX6JqKYMEnvdG7A6Vf
 KEkmtGlwAgF9d1+MkGPQaQywfGZEg0aguXuLHlsyHdoByVwGZ7nCnIwVYwk1RZmmtOUtu6XOvws
 XzT8TlVIeYBdoT/RhS2tMADCOD6QG/1E0+dUsnXBhm8bKlu/croehDRvcAExNhOoa0qyx5Qdygy
 ueQwQHDu5EESjp+rEkKm+3uq88Pg8129Ay9E8Uv//jwqBPvr+XOXBU1pc+Y6uLCsZ0L4iY4xPM4
 QJVPk/4lAEbnpkxsWvVS/KiGWip3OfclXc0PBoSwC7mQi0uS5Qe+oK7qoimbqgJQ96Mhe2v1K/K
 FMaggfIc6Zc0kwSlspDp/mIbZF5vW4KQccmMd3Dpk/hBbP77yjNfFslwM/mY9lncU3HZPLt2S2g
 ix6lhDxNPSHUEAx5j8A==
X-Proofpoint-ORIG-GUID: Rp3ZDBXz-4ol3hVtgYD3pKhEl4LUgfkY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130116

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
 drivers/vfio/pci/ism/main.c   | 345 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 362 insertions(+)

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
index 0000000000000000000000000000000000000000..34951ace4f041255d9b46cc9c5af66b181e72dfd
--- /dev/null
+++ b/drivers/vfio/pci/ism/main.c
@@ -0,0 +1,345 @@
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
+ * handle-based PCI instructions are used instead. The z/Architecture and ISM
+ * allow reads smaller than 8 bytes. Restrict it to 8 bytes for code simplicity.
+ */
+static ssize_t ism_vfio_pci_do_io_r(struct vfio_pci_core_device *vdev,
+				    char __user *buf, loff_t off, size_t count,
+				    int bar)
+{
+	struct zpci_dev *zdev = to_zpci(vdev->pdev);
+	ssize_t ret, done = 0;
+	u64 req, val;
+
+	if (!IS_ALIGNED(off, sizeof(val)) || !IS_ALIGNED(count, sizeof(val)))
+		return -EINVAL;
+
+	while (count) {
+		req = ZPCI_CREATE_REQ(READ_ONCE(zdev->fh), bar, sizeof(val));
+		/*
+		 * Use __zpci_load() to bypass automatic use of PCI MIO instructions
+		 * which are not supported on ISM devices
+		 */
+		ret = __zpci_load(&val, req, off);
+		if (ret)
+			return ret;
+		if (copy_to_user(buf, &val, sizeof(val)))
+			return -EFAULT;
+		count -= sizeof(val);
+		done += sizeof(val);
+		off += sizeof(val);
+		buf += sizeof(val);
+	}
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


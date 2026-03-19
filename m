Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C153E1D0C;
	Thu, 19 Mar 2026 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935002; cv=none; b=OrUy1Ao/7Dx9ev3lV3IbmRK5XCIbBPExzOThqmx/d071EJ9EfiZnZfIksKV8TRkMYyQkRCuyo814S991sW8OtuZSrwpmUQKWrtQvhCGMnF5lEx8HyjQm0jRAvIgcgBHoEOkLquB5G1Mkw0u5y0F4Fp9cZ21lToCLOZ8zDNrejwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935002; c=relaxed/simple;
	bh=B2ne86iTsY2UwLwVDxj7NgYgUG1OwK5piGjUP1HeKok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j3UfiS3Ytr35/N6xkr9yhDb4nc/vY0As/hlWUDHFD/EOzUabuaeUaASzfUQ8gT5FGF+XHZ4DEvvimo5GI5hka20XfZr21PBZiPE8chSwoTeM3TqZcZkHMiiLf5AVhnnm2iPPhL88mlNEnAG2r+lDCBE0Ao8Sp8d2yXDnKBqAQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PbPkR+yU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PbPkR+yU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JEWJp51189773;
	Thu, 19 Mar 2026 15:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f7wkow
	OWcYngBZbSHmeiTnZNyAcimw4qsTL3s+0qnEY=; b=PbPkR+yUiueJcreRL6cPg2
	SGGNLGAy1hvpGdUIR6/P4738SUpH+1Q+AG72H0T2FfDRlV5tOj03KPcXzy3qhIxn
	kJNBS4i8w5B7NZQ05Urd6io7KgjMUnk1ZTDwjZIjI2Sb+cWrpWtKxczLJcnet/KE
	iGMOQY1AdC5ZlZXBDFsH9zG9OLcFH9D4Hs2hBMCl5RabNfqjiDjvjIpYqnMlEowp
	EaqfgJGFd4XCR7iG2c5KuQ1z2F652w5WJpfwK1DbmbIf1E5UgdgE0qLC0FiPdHlU
	GSQAhP9BasIOE55mZArRvwsTKWoTIeBIzr1dlOJynxIGUATFZkQHvw6PdnpWHmng
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfsxrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 15:43:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62JEUZU8028510;
	Thu, 19 Mar 2026 15:43:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1jtty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 15:43:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JFhBTX51577136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 15:43:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A94C20040;
	Thu, 19 Mar 2026 15:43:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEB4120043;
	Thu, 19 Mar 2026 15:43:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 15:43:10 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Thu, 19 Mar 2026 16:42:55 +0100
Subject: [PATCH v6 2/3] vfio/ism: Implement vfio_pci driver for ISM devices
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-vfio_pci_ism-v6-2-c6bab675bc0a@linux.ibm.com>
References: <20260319-vfio_pci_ism-v6-0-c6bab675bc0a@linux.ibm.com>
In-Reply-To: <20260319-vfio_pci_ism-v6-0-c6bab675bc0a@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: r558pBO8_s3foee1NTWc0lfpjC4QglBD
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69bc1994 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=qDoQYVglVPIJUuxkhcQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyMCBTYWx0ZWRfXwIXKpihNI8vq
 wLlHP5QJ48lAmuozN8Lq/iTSoLEaxIkUAc3GVZzLkA5g8OL7yQyiy0hBVer1xG1X4JqekLym0Wn
 QSF+v1rA8NhPkWV7DlT1h64Fwg0UqVQEnTgIRGU5bX2eY6AUxwBjAs3OJ3oU30GlHJIIKJ6Lj81
 BXM6e5W8jkoHb1BUtKarpPg+FBkgrvj1xMykJz7YxtNMGMHc2N6Dy4WS2bZPx9QFCgDMmB7glCS
 tDHhWHp4WF1rdzYU9LYKG0n3cbmau0gTW6yqeLti+TO81RxsEO24pRPoLwikN3SA+Yh6A74TOf+
 xT+pmVZ9ynI9n7UcvwJRR2un3vZ5q8sPyaeNAL7LvGJWa+fHUoKx3ZcI8K2Gq0KmGhH+voWIVz6
 07Pya7wPeuefunfhEiE4NIbrYPaNsTFCqYQlRTmWtAvH1TyumEFLdYOTSozrrq0nT/YP6f1b7qx
 xBppCGm0SeIwgIYaNxA==
X-Proofpoint-GUID: r558pBO8_s3foee1NTWc0lfpjC4QglBD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190120

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
 drivers/vfio/pci/ism/main.c   | 400 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 417 insertions(+)

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
index 0000000000000000000000000000000000000000..45e611f54795780cf09e540c859db889afa67323
--- /dev/null
+++ b/drivers/vfio/pci/ism/main.c
@@ -0,0 +1,400 @@
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
+		if (ret)                                                      \
+			return ret;                                           \
+		val = (u##size)tmp;                                           \
+		if (copy_to_user(buf, &val, sizeof(val)))                     \
+			return -EFAULT;                                       \
+		*filled = sizeof(val);                                        \
+		return 0;						      \
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
+static int ism_vfio_pci_open_device(struct vfio_device *core_vdev)
+{
+	struct ism_vfio_pci_core_device *ivpcd;
+	struct vfio_pci_core_device *vdev;
+	int ret;
+
+	ivpcd = container_of(core_vdev, struct ism_vfio_pci_core_device,
+			     core_device.vdev);
+	vdev = &ivpcd->core_device;
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
+	data = kmem_cache_alloc(ivpcd->store_block_cache, GFP_KERNEL);
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
+static int ism_vfio_pci_init_dev(struct vfio_device *core_vdev)
+{
+	struct zpci_dev *zdev = to_zpci(to_pci_dev(core_vdev->dev));
+	struct ism_vfio_pci_core_device *ivpcd;
+	char cache_name[20];
+	int ret;
+
+	ivpcd = container_of(core_vdev, struct ism_vfio_pci_core_device,
+			     core_device.vdev);
+
+	snprintf(cache_name, sizeof(cache_name), "ism_sb_fid_%08x", zdev->fid);
+	ivpcd->store_block_cache =
+		kmem_cache_create(cache_name, zdev->maxstbl, 0, 0, NULL);
+	if (!ivpcd->store_block_cache)
+		return -ENOMEM;
+
+	ret = vfio_pci_core_init_dev(core_vdev);
+	if (ret)
+		kmem_cache_destroy(ivpcd->store_block_cache);
+
+	return ret;
+}
+
+static void ism_vfio_pci_release_dev(struct vfio_device *core_vdev)
+{
+	struct ism_vfio_pci_core_device *ivpcd = container_of(
+		core_vdev, struct ism_vfio_pci_core_device, core_device.vdev);
+
+	kmem_cache_destroy(ivpcd->store_block_cache);
+	vfio_pci_core_release_dev(core_vdev);
+}
+
+static const struct vfio_device_ops ism_pci_ops = {
+	.name = "ism-vfio-pci",
+	.init = ism_vfio_pci_init_dev,
+	.release = ism_vfio_pci_release_dev,
+	.open_device = ism_vfio_pci_open_device,
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
+	int ret;
+
+	ivpcd = vfio_alloc_device(ism_vfio_pci_core_device, core_device.vdev,
+				  &pdev->dev, &ism_pci_ops);
+	if (IS_ERR(ivpcd))
+		return PTR_ERR(ivpcd);
+
+	dev_set_drvdata(&pdev->dev, &ivpcd->core_device);
+
+	ret = vfio_pci_core_register_device(&ivpcd->core_device);
+	if (ret)
+		vfio_put_device(&ivpcd->core_device.vdev);
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


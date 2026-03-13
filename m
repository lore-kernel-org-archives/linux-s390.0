Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB93A5E7E;
	Fri, 13 Mar 2026 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412851; cv=none; b=lbyCEYpssusqkaJixqqZbZ47Wrf1i7wW938VEa9dUvzxPtsuIL4TgsAUZwv9lNFv9R8FTQISBHnD5P4epY95YIfLIck9Bm+LYaXp+4mHbcxk/PhdiUt1eVK9e5PO7xByMa3uzketHbsqytIMK99r/NMa2hTftwdJ/CaQMheVboA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412851; c=relaxed/simple;
	bh=fa+UCbtwReJTJptJMdx/NTEP96lWAeW85C7bH3Iv6iA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5ZoJSwgRV6r9D8zv3JDDek6jwmUZ7ZDY5GUH1TzdvLgoSwc+8hAMIJOep/gOylREmXQiqeDSPtHzTdeAnOTAN4KsUlSZpx3hJ1bM0sE2zshqLLQuue3CfBLP/9LhLOfdscHypaKD0REWrLu44ZR4wrurKslHJ2/cWKoviHqfL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lrOJd6BO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lrOJd6BO"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D7Tdgm2278044;
	Fri, 13 Mar 2026 14:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DLefWu
	Qx1WI+Y5vD2GhByCm3kkB0v+kz8E76A14iFbs=; b=lrOJd6BOMJbyfOSnF42MJX
	RlVLYiqiZuDCh3l6RfCyT4nNlBWl/zzt2YFfZt3y0MBI+pkoFdANWq+DtO0Hj/vB
	sEw2UMTgI9ZHr43TKymbvu3kzcleSO0/xojOSl6rn3Of9bAlU8gayWq50RI5kY8K
	Yx0sAFCh3vEjtGXbIvFGlNzIL3Tf153HZe7a8yTwwUV9QMguoL/7nE+YwVi1Vti/
	V8of1tc7+nkExhtEFd4U5OMGL/ZTz2auqZA1JxORC59pbHDHp072Phx4QxT89SQq
	hnMSRlihAHSsaBj5h/9njhye61T1SNy5lAYIRFbmkEkzWA5njWc0KiYvoSQspwyw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91r8pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 14:40:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAR5QS020811;
	Fri, 13 Mar 2026 14:40:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9q19h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 14:40:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DEedT259572528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 14:40:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0DDD2004D;
	Fri, 13 Mar 2026 14:40:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BAB62005A;
	Fri, 13 Mar 2026 14:40:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 14:40:39 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Fri, 13 Mar 2026 15:40:28 +0100
Subject: [PATCH v4 1/3] vfio/pci: Rename vfio_config_do_rw() to
 vfio_pci_config_rw_single() and export it
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260313-vfio_pci_ism-v4-1-4765ae056f71@linux.ibm.com>
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
X-Proofpoint-GUID: RIDdmxZgeZg5qOgXTthue9GQTdJh79N3
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b421ed cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=mooU_oynDD9EFzHbF-IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExNiBTYWx0ZWRfX2ocx1Q/ok9jy
 xUYlbtrQrtefcTKHPuKfBhm8jXQVzeKldE3miIYAO/6g4YPqGb6JRQXyoCfoD9nLsHqm7PtHlUD
 y59HlpWSB58F6j3FWicyKHKWXk1AB+sVndbDFVL++qRmw7sUH51hEk+EHJf9o1/H5E4Ea4c1Y2/
 +57pkIRigrgYA+FnIDWKfS5Mnu9HVf7Is65IAEZ20C6mul++oRhSKFKrwU7ITo7pY/XNOpH1chB
 /gMNWLxHH9eysh1RsVd9gPPjWz2Reejye89E8MhyhwM96GPpsI79thvN1pNMlYt61ec2j9Lxs3o
 83mOeJxIT59kfJpKtBEnUpcldS7j2KjxThZTGsOWhuQmc2361cEOPgajB8rJFrLith6m7HiwnGn
 g0T0PNMcVE1a1l4524oR18YgM2YZ0Q4jn99+4JwTzzG3ZF32tRBqOV+5ZdiqB5YyDMr3ZF+K5Q8
 NcQChgrLVnYpR6Pu7XA==
X-Proofpoint-ORIG-GUID: RIDdmxZgeZg5qOgXTthue9GQTdJh79N3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130116

A follow-up patch adds a new variant driver for s390 ISM devices. Since
this device uses a 256 TiB BAR 0 that is never mapped, the variant
driver needs its own ISM_VFIO_PCI_OFFSET_MASK. To minimally mirror the
functionality of vfio_pci_config_rw() with such a custom mask, export
vfio_config_do_rw(). To better distinguish the now exported function
from vfio_pci_config_rw(), rename it to vfio_pci_config_rw_single()
emphasizing that it does a single config space read or write.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 8 +++++---
 drivers/vfio/pci/vfio_pci_priv.h   | 4 ++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index b4e39253f98da61a5e2b6dd0089b2f6aef4b85a0..fbb47b4ddb43d42b758b16778e6e701379d7e7db 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1880,8 +1880,9 @@ static size_t vfio_pci_cap_remaining_dword(struct vfio_pci_core_device *vdev,
 	return i;
 }
 
-static ssize_t vfio_config_do_rw(struct vfio_pci_core_device *vdev, char __user *buf,
-				 size_t count, loff_t *ppos, bool iswrite)
+ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
+			      char __user *buf, size_t count, loff_t *ppos,
+			      bool iswrite)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	struct perm_bits *perm;
@@ -1970,6 +1971,7 @@ static ssize_t vfio_config_do_rw(struct vfio_pci_core_device *vdev, char __user
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(vfio_pci_config_rw_single);
 
 ssize_t vfio_pci_config_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			   size_t count, loff_t *ppos, bool iswrite)
@@ -1981,7 +1983,7 @@ ssize_t vfio_pci_config_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	pos &= VFIO_PCI_OFFSET_MASK;
 
 	while (count) {
-		ret = vfio_config_do_rw(vdev, buf, count, &pos, iswrite);
+		ret = vfio_pci_config_rw_single(vdev, buf, count, &pos, iswrite);
 		if (ret < 0)
 			return ret;
 
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 27ac280f00b975989f6cbc02c11aaca01f9badf3..28a3edf65aeecfa06cd1856637cd33eec1fa3006 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -37,6 +37,10 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
 ssize_t vfio_pci_config_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			   size_t count, loff_t *ppos, bool iswrite);
 
+ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
+			      char __user *buf, size_t count, loff_t *ppos,
+			      bool iswrite);
+
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
 

-- 
2.51.0


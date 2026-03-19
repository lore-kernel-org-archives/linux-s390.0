Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F713E714D;
	Thu, 19 Mar 2026 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935002; cv=none; b=cTm4jkLjSUKCN48sKNrJxaISjeiOvxlPSri3VhI99j20bgufOWIOnW72ckamkNRAikkMYJ1RtR06auMlL5yfSM89DnwSPvXSXkAQnZ648ozq6eV8NUrHpjXyo6YrnMh0iplacQReeur94F8loQeTO4/CqY+CYA4TZRSMe5K8urw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935002; c=relaxed/simple;
	bh=fa+UCbtwReJTJptJMdx/NTEP96lWAeW85C7bH3Iv6iA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MN8CQOqCKrkYGRnO9bDAnjgzIHLuDUr5uTFQacgvkkaPIz/xMDzpb1iB3O19Eq3tlTnlg4An45sn677qJ+ToLsl4sDqcy7Ji2mLCMjLY2Y2Ql6TwqX1cvZTyoTyg1neIVb5p9GUCVcm8zYBj1jJZW/pUmo/QTZgjGq+xmEu1hZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vv5nsZuk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vv5nsZuk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JDi0LO706946;
	Thu, 19 Mar 2026 15:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DLefWu
	Qx1WI+Y5vD2GhByCm3kkB0v+kz8E76A14iFbs=; b=Vv5nsZukw/uK0rDND0GRf4
	X89tuEZwstx2EOqqgMO2m0zsGZBOrIwuSJq/iy/UnCzj1eWjvyfF2sZYfOLTug0d
	go1U2pH5p0ypYX/vDVPwOif7sC1VGXKTURnJCU0cgzZ57G7bikKt3W+4CzUmSbH9
	ykv9w0YpD+rL9NJrriVJTiThDV6cjMa5DpZ+9exQuRQ9zBLo7PH9UJW+do/HLJPA
	ekpQzjqDvwYODsac6KdWoISPeMDVr5ThjRMBuN54CrilayCxBPTWZrNvZgExrx+F
	Nm6ySVjRwwSqnjtljo0zntQsRcYSKdow7LH95EGMeHY7p7KLTL+oNVuehsq5omTw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3j724k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 15:43:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62JDU4Qi029194;
	Thu, 19 Mar 2026 15:43:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkk1fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 15:43:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JFhAQM35782934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 15:43:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8ABE20040;
	Thu, 19 Mar 2026 15:43:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F7F72004D;
	Thu, 19 Mar 2026 15:43:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 15:43:10 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Thu, 19 Mar 2026 16:42:54 +0100
Subject: [PATCH v6 1/3] vfio/pci: Rename vfio_config_do_rw() to
 vfio_pci_config_rw_single() and export it
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260319-vfio_pci_ism-v6-1-c6bab675bc0a@linux.ibm.com>
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
X-Proofpoint-GUID: IvAXZLSk41RnF7kwj5_cWVnrJk00twxL
X-Proofpoint-ORIG-GUID: IvAXZLSk41RnF7kwj5_cWVnrJk00twxL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyMCBTYWx0ZWRfX2JP7XGvHxnt9
 +xITo+KPgj3jEgS4M6UEmzLiW9jLHO/ElhX6K4erkqt3HdX513IMcVZHSo/0ZyD6Sza/kcGAWNu
 6VEQ0uPjPUfNhYGStaR9cpghsJyTR/xrtA9P/wfT+0kdMY7Bj5JSZHgbyYq/FEY/Kc90IdTWmAL
 u/pv1B6A1hjIf2mwQjJH1vvBWclkNo4A5Mse1VjKwjJdSzL9noQ5cYaexkK/Ygs06YskjhVZo9k
 yLQoMWjJ7xWU0MoEDHPuaQFtlxCscq05INMv4odmvSvmhb0aTo4JV60RxAgEr6xh6O/NUPdSq4k
 H++H++Xx0DqbhQzqwFhd7D1XOrLJASBtH8WCvPLH1b61g2tQAXi6Qx1/BI57Py4j3NdwsYRTOsd
 kcljdaetbg3SAlP/q0NVSBJJCSHFWL3f9OOHOe4V364n1b9hGfnPaznQn6rXB/Ct9fyOJnM/mfd
 9rKu0flalbC5/R+o9VQ==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69bc1993 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=mooU_oynDD9EFzHbF-IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190120

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


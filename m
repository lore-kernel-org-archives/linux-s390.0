Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162F938552C;
	Mon, 23 Mar 2026 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258384; cv=none; b=rXUA/3/AubVGBlF/FT1u7DN0fcZv1HxqXrwMRclSY0F27tCZLdHRQ8zT1eUSjneiBd0nzRbU55xIdzQRwJ4Zn1JL1tXzhr5HMXoS2i+yYSnwKSpAVf5vQj8V9n/U3rBi7bqragbt5aoLI2dD9E+bgTKZdtlWJmeeFgoHitETE9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258384; c=relaxed/simple;
	bh=fa+UCbtwReJTJptJMdx/NTEP96lWAeW85C7bH3Iv6iA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8ZzDgFTB20vnpgXh9IBE3RaaCzzAQa+uuUlULlW911Ny5Vlq2jf3aBcQuSAzbFcQ3BfdiWAZeS7uk9loRumHPJovoFl3+cq7lX3MOMHobgJC9r+cgomBDQujA00E4O4ewAIJwbAxaNcJIhEA4FJntXVBidfIRwEIK1lN/CT9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mEehhd7J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mEehhd7J"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MFU1kq3961671;
	Mon, 23 Mar 2026 09:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DLefWu
	Qx1WI+Y5vD2GhByCm3kkB0v+kz8E76A14iFbs=; b=mEehhd7JtN+n5fpdSt+4Kq
	STliMzqaxCeX24jQ5o1EPP2eNgM8+SPz4A9kJiHro6AR6d5lwU03O46ft00KHL4f
	XjufLVZFWnrJEqWpmtUfJgMqFZAlyeVWu4mcDCIcDKO0giZBrkRoRzgq17FDxu4c
	68/p6tEHIB8BXCIs7Gxm9ffXorJ6o6O280MLYpOw9b9qCFjOpVPamyf8MNWWVjLN
	fMC90JeaKhEstUvcxRoDHWzNSOLFwUSOzAFEyTA7Z5a+OmozweYCskSqX4p25I/2
	SxVyKcxA7wf8E4ydZCZ/sEPNR49Wqha6T+zIPh2aY2aNckeFlPmyVGJk0xZi8AFA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxp6jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:32:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N83pE6011778;
	Mon, 23 Mar 2026 09:32:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vjvkvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:32:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62N9Wskl59703638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 09:32:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41A4E20043;
	Mon, 23 Mar 2026 09:32:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 071812004D;
	Mon, 23 Mar 2026 09:32:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 09:32:53 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Mon, 23 Mar 2026 10:32:45 +0100
Subject: [PATCH v7 1/3] vfio/pci: Rename vfio_config_do_rw() to
 vfio_pci_config_rw_single() and export it
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260323-vfio_pci_ism-v7-1-abf537150408@linux.ibm.com>
References: <20260323-vfio_pci_ism-v7-0-abf537150408@linux.ibm.com>
In-Reply-To: <20260323-vfio_pci_ism-v7-0-abf537150408@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c108cb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=mooU_oynDD9EFzHbF-IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA3MSBTYWx0ZWRfX1Tvd4cCR5t9L
 ZJiXtcoBEIYWvTf3SiX4Tm9EBOzNwyTCM7GcLPtO/ellFKkuie1jnCxeCzmo6kcd283IEYjZWUN
 lnWo8HYEwHHOR8KCZS2b8QbXLbaVXrFnvJ2Bw9O6I2IXUGXlw/Ffx6OD8ffb51qq0io4IjYlCaG
 35beOmDfjuAFcBqynvkHqLu0KeCFNahbQd374NLhdpmOpM2tXZ7Fv1N7SxXvxCi05t+D9IqwWqd
 XNEuhqoPLLnpkvguEHOWcpEKm12OcigstDtFYpcWXNBAzx90y+lm17hLjVpn7xJ0bKsBUn2zfn9
 zs0qoxiZg4As63sYxU5uDSKIT2p3/WBlnqIaFV1SLEERqR7FselRITt0l48ksfvkekH9kQD/VXV
 uCLNtlcrxVPlDQnxyXoA05ETOY/s05gOjnMv4fX/f8mXNVEDcSvhPi2DtwOysOXbAuVr4rGuxmK
 mGrMB6nidcRNnLnPgCA==
X-Proofpoint-GUID: h1L3di3Uv5Jy5_bLIE1mBmkD3nnKjUdu
X-Proofpoint-ORIG-GUID: h1L3di3Uv5Jy5_bLIE1mBmkD3nnKjUdu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230071

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


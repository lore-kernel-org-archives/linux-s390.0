Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C6E3C661B;
	Tue, 17 Mar 2026 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752354; cv=none; b=CgsGNrdpVGgJZPq8lDj3rDkJB5BeE5lGDqhvF7vp0TuTHnd/5FNiZdJTn5x2lF4s9Dy/p5rbMkNk7Ad79zeXxSTbjuV+TcQ23Zfh7YvD2oZRO5H3wNh93SU3ACL/qrLI3MSddzc2L20gQvRE3r9DIvZwjgGAdvME1n5072ufkGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752354; c=relaxed/simple;
	bh=fa+UCbtwReJTJptJMdx/NTEP96lWAeW85C7bH3Iv6iA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqiWrmOj79tudF9QKTAlo9C/hevJdmJ8PRbtrjrvBVPdGQlxbMQFakd4yXuQ2ITh+I+CecdeeIRHNS6cK0F9BdXvK/W8rnmVdJsLFTOdXIPLoGLYIYUxIK9DUpNazNimBdbx4bHBSxPLOhO3pB71PPvUGaSA+2NxEtpCU1ski5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cntabcQn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cntabcQn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7hmBl857314;
	Tue, 17 Mar 2026 12:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DLefWu
	Qx1WI+Y5vD2GhByCm3kkB0v+kz8E76A14iFbs=; b=cntabcQnWDTSI8gHacK8ln
	J+v5JCiN7rRG6oMjc4cy2Ia8FAvzpu0ek/U52PVwVeFF3JqQpl5M59LNJ3wn8N4H
	yqkBIhvkQFjiwQYjUjaWRKXbBcwAsH1L3qGPDI3GNIjCen7HrAofATOH7js7PdFJ
	vfw7tv2bVAzq2ibBV8/5oTXeIokqRT1RYLQBzTEMh33UFWn0VNu76clkM5UXZIl0
	XLF1dLprflTeOjgbsJLKP/iX5ESmBoWstIngqH+cwXf3G5gwbYSwOVUVQ25Q+EJp
	OFripxE5grs31g8GOpJzeCv1WwdIuMbM6ViDE76L5M4vlb2DI+onbF4d6dG6Q+Cw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cvb25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 12:59:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HBLoku014113;
	Tue, 17 Mar 2026 12:59:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy19fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 12:59:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HCx3L615073596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 12:59:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6338F20043;
	Tue, 17 Mar 2026 12:59:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 119FC2004F;
	Tue, 17 Mar 2026 12:59:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 12:59:03 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Tue, 17 Mar 2026 13:58:49 +0100
Subject: [PATCH v5 1/3] vfio/pci: Rename vfio_config_do_rw() to
 vfio_pci_config_rw_single() and export it
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-vfio_pci_ism-v5-1-b73248b4e576@linux.ibm.com>
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
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=mooU_oynDD9EFzHbF-IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExMiBTYWx0ZWRfX8i03ZuIQ9XxL
 +8foNVf0Rzs198zCShlFtyqjt7BxhBxfN+9iLgs7blEjSZPZdoD3ofiLrMU0urIMhU8SLtqdDVF
 vMN6QQ5Qp8eSwwpxySe0bxELRZNiuVQFeT6P4PG9BpB3YSkQ8aa68aZxRJiHP74z+DfHj8v12Z+
 mX9P6zUHlNrm/bELD8H9T2VyVHlnIVm/zUF2VoSffaYtq09cuHlUDcWo1Ax8yTlLxjSkJ4dPa6b
 tUR4q7HDt5fCu8s87YBrqQQzadTW7H3e4Pck8Jc1iH5eB+hn5iYgwv8QSnUfWsDj6iMDv9WkYZB
 f+9FGwsTFxty+Ejy1fT6Et+Ysh80NdNC3LOUnc11WTTP2XCHTzFIYatROks0nibVZIs9eG71Nvn
 LMJsSjoomJ4TkKk1Lt+ST2L3+LzCA5+1EH00fWY0KToy82W7zDoAzp+inX+E4AoVe4XJF5jfHzI
 vXrvjuXzpB4Ml9dXWsA==
X-Proofpoint-GUID: gCSg3scU304Zoo3kCWz-53A5wgvrqXxD
X-Proofpoint-ORIG-GUID: gCSg3scU304Zoo3kCWz-53A5wgvrqXxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170112

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


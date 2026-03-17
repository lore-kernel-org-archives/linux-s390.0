Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2743C73C0;
	Tue, 17 Mar 2026 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752356; cv=none; b=X6H30JMOcdtI9keP5DoYmpP31JrLKinKCxRZbDvyZYnoQgGpN9B+L/RjxbveDI93ABLokcwgCeE/zfPH/HNUpuZ0OY6i7nP5PmeKdUZbzS+nLmeeCbT0GAOjV06ThXpvxUZesEiSZW6k1Hf8oJgJs6EqSvcaeD12HmISvcTp6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752356; c=relaxed/simple;
	bh=jTHy7bZk/lBcDrCNabXe1lccncbLd7AFrROwYxPImAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pA0ty2iGmtJWp51SgBEKrbvwlmLgpAReNNdKT197SHf3ARuTOeYbi+mjqppNaObs7qjpojuWI5ssLcPB8d+Y0a48/RtdTpPSh8a3Q3Jew7Zm1I3p3bR2Or25F73GAMjEJ1ulEwiCsXDDx+X1kZ/lNBwkKZ5Sfd8TfmkN0AsW2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ec0otFMf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ec0otFMf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H6dO8W231841;
	Tue, 17 Mar 2026 12:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FkvWgc
	hnxowkB0BQQ4EmGr14eFi/swA/WlNLu1QTrYs=; b=ec0otFMfe2CTKoFX5h1CVW
	9C1x9HcKX1ao/YNpjjzxjQzVJ9eAaKOX7Zs26xWCoeclFP2Lw4x+UgzQRTqfPnxU
	zixbxqm1EqbSnh0syG06BDG0MDWQx4VpkzqETORsnaztHaXSDwLrp90/CABX50Dv
	JWPkX0UqdZpXQUTFO4cJJwi30hZc7wcddkUYNo2fKRMLp3OdXwJnm5A3nFbrYAFh
	TQLvXiUz7knEgbt+JXf/pXn2z3k2Q1kdxCU1RxaelJAkIYYoEhrTtSiB5q7Rp7kt
	vw3O4OBWOp0YNw+QJbZvnJ/HWaYA3clUZdcOx3u0qDGBrf2p5qcD3vB8/gdLikWg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs4sku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 12:59:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HAxjMG028708;
	Tue, 17 Mar 2026 12:59:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk963d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 12:59:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HCx4nH45678952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 12:59:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2416D20043;
	Tue, 17 Mar 2026 12:59:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9B512005A;
	Tue, 17 Mar 2026 12:59:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 12:59:03 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Tue, 17 Mar 2026 13:58:51 +0100
Subject: [PATCH v5 3/3] MAINTAINERS: add VFIO ISM PCI DRIVER section
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-vfio_pci_ism-v5-3-b73248b4e576@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b9501d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=jBZh5NATpTL4zB9YInYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TjRW62KM84P2KMPldasju9rnrjSIv3q6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExMiBTYWx0ZWRfX9LEBqxaboi1H
 5VzVpsxIERQAd8jQ3NPrF0nAQDiLiLb9QDC9RUJuBDlTyURMloby00JHWAV3ugOOCeU5BAhgt4/
 VVNS8zdCoPffAYlMiVXB2018kO93Ov6Cr0uZMSMeg9uvZ9S8aoJ1KzSHASmzBfCL+JLOCaodBCz
 bcDuSFtIMOFzPYIS9+IYL/cabPy1uoFbjDmrc9oF3VHwGUpB/a8K7IJCfjpApyMWG/kMjs4D2tD
 +6nkG1tF2GQjRV1Tlb020DAbjGmlgLLNzCWSLef3fCt7U/vS7PARhvFs48bZQb11HYqKkA3G6tI
 mKF/epFRNoDxfR+EjahINT0+vGb5kAeZxQR1qYXK5+4naKjMYY65pbnxvAgL4PXznKTaGMRQ7fv
 soQvVHdXbTqj3G4XDCw2YdnfgkTQqTAaGz13k7xEjOFcUarV/yc7TCiL2PUXJ8P/JRS8CRvGgrA
 DSmbQ+APFojKtW86MBw==
X-Proofpoint-GUID: TjRW62KM84P2KMPldasju9rnrjSIv3q6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170112

ism_vfio_pci is a new kernel component that allows
to use the ISM device from userspace. Add myself
as a maintainer.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96ea84948d76aff5e07579911d0f370ae13f481b..bae18582e71f7a17a949b1ed3d5e9689775e98ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27702,6 +27702,12 @@ L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/vfio/pci/hisilicon/
 
+VFIO ISM PCI DRIVER
+M:	Julian Ruess <julianr@linux.ibm.com>
+L:	kvm@vger.kernel.org
+S:	Maintained
+F:	drivers/vfio/pci/ism/
+
 VFIO MEDIATED DEVICE DRIVERS
 M:	Kirti Wankhede <kwankhede@nvidia.com>
 L:	kvm@vger.kernel.org

-- 
2.51.0


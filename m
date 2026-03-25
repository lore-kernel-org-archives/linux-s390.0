Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A323C512;
	Wed, 25 Mar 2026 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774445512; cv=none; b=DiztGS4tZgBUqtOhte5VlLASw3A8w7vxqejfblVa2lrWAZi2hjAn1yXRMYjNX07tHciGDQ5H0aYUyTzwWNXQqQ3X20pwAdYFyvcYB/940djcMl2puCSfGWk9AqtYtzDhR74GGmDCySRTupAfwnNE2niU39DjyAq6671A+lambbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774445512; c=relaxed/simple;
	bh=Xp06g/JyrGjiIf6S/4KzRoPbggPcb32EOw0bMnd70mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fodmscwkS7V9l6JUgu8y9DcQM77Pu+/snSzvDnFWRMrsv/V4AIxON208PPJWcUQrqPUBmG+44qQCZ7SJxihioNbJsEXZn2BH618h2F98pyre4SKPUKr7Wer8UHCfpUhuLMetX1nrPiewKmfntfzZ9eKH0sfhkWQQOcMZhMMJLVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P3KKqkrR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P3KKqkrR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P7Dgba3395859;
	Wed, 25 Mar 2026 13:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ws98jf
	qp8fT8UnB+vgUnR2tXV+A3dsfVNfiI/qBkFX0=; b=P3KKqkrRWmoXkplxF9yQR4
	Ol89mEE2aLLQDsOMOiPdyZueaEsH0fnG1FpHr1ZfqINAR7xv2mQYCIsMgYY6H0zr
	3Fe7jKQmCzfdmoJRWV65M6rtUsMH69Wh9yp0709Cq+5ugCjCFp9ozIayf/qIn9O4
	9KRpsZRZS3x+XqAXObW6lVRabK2PS9o6KHbM2O4p8F765BXPY0/BN5RqG0YNbzBe
	+YpwVA/4saE9LZlxWeN/vWcxxyFcTKbptxGlQuNsvcJuF4P7tmRcRWkKaKPNcfek
	ftI7bnXa8A/HXNK+Ki61u0TcbBFQOJgsn2G0hCMpUJ3o6BTNrDZY89dm7xYcxFdg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky07r73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 13:31:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PBSWZr011824;
	Wed, 25 Mar 2026 13:31:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk6g1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 13:31:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PDVfCO36045292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 13:31:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9628420043;
	Wed, 25 Mar 2026 13:31:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43B982004D;
	Wed, 25 Mar 2026 13:31:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 13:31:41 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Wed, 25 Mar 2026 14:31:23 +0100
Subject: [PATCH v8 1/3] vfio/pci: Rename vfio_config_do_rw() to
 vfio_pci_config_rw_single() and export it
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260325-vfio_pci_ism-v8-1-ddc504cde914@linux.ibm.com>
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
In-Reply-To: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA5NSBTYWx0ZWRfX3Ylqq9b3qI4o
 ipuWaza0ugWrvCG30qtA+I/5Mf7Q741czyy1Yi/1UJp0hLz3JISJQbQwhOlZTpSZfHE9H1EmOuG
 vO1Z6oAHIQu2Sa/ge+t1F+Wp53SNQ4LvIA3DfJaqeH0g6790VsKgseQFeSKza4jEhFEOFHGP8DJ
 x0wc3c95WO0tq5W8yLQBBDIjGnrCuIOZ5UyqXlIr+Gx9Fob7t5VZBl0+ZKdLL4wB2bIRkJwFAlK
 qQJonYDh/CM0Qjv4M9nqFp5fjdHZrNaQnbtHbW7gmJ0Is0J5WauqrOO+juQVpuHYPM7J09DklIH
 GOojMpDe9eS2jG8VGxaC5gOuXuvTvE0+be7BN05J+J4+TFJERVLSs4nA7apjnMsjHe+G2jj4aaW
 1MvjL5kUP0yhaoPJf9bFrDCW4E6g8DXYJPUL6uJdMofP37kZf6MgN3a7ME6gFt7ebLOxcAZdAn1
 cp2gS3OsT9X1hRSNsVA==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c3e3c2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=mooU_oynDD9EFzHbF-IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rjunKXmwxRwQiY9T4-exEQ1rJLhAMUOZ
X-Proofpoint-GUID: rjunKXmwxRwQiY9T4-exEQ1rJLhAMUOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250095

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
index b4e39253f98da61a5e2b6dd0089b2f6aef4b85a0..a10ed733f0e3af89c185f8b93192ba6b004f05ed 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1880,8 +1880,9 @@ static size_t vfio_pci_cap_remaining_dword(struct vfio_pci_core_device *vdev,
 	return i;
 }
 
-static ssize_t vfio_config_do_rw(struct vfio_pci_core_device *vdev, char __user *buf,
-				 size_t count, loff_t *ppos, bool iswrite)
+ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
+				  char __user *buf, size_t count, loff_t *ppos,
+				  bool iswrite)
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
index 27ac280f00b975989f6cbc02c11aaca01f9badf3..fca9d0dfac90f8eaaf2d281dd2213111c46d76a1 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -37,6 +37,10 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
 ssize_t vfio_pci_config_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			   size_t count, loff_t *ppos, bool iswrite);
 
+ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
+				  char __user *buf, size_t count, loff_t *ppos,
+				  bool iswrite);
+
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
 

-- 
2.51.0


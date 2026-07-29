Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6AB3EC828;
	Wed, 29 Jul 2026 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348688; cv=none; b=UzvaSQoKeL6c6KBUYl7Gd0wgwSjKDTApBeCEEjzaK+P5WOEMVAgzJaBcmq4tcYOW72EVycyAqE6Cht2G0L6CZ5XJsqtJ+9W6HxQ4y0DvI47zSuTK+9fnbeFA6C3WjdULOGBY6ObzzPX9At/yWfQ2Y8ey6rVijqZS3KFcHYhM1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348688; c=relaxed/simple;
	bh=FC3xdow7gvqfYTk3CFuk5P3bP84mOtzQDg9+fq4FJlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qiIDO+y4xqp5EK5OqhuoJF344bHPEjS4epIIcZ+6RU2/3oERhcujOaox9U5Aiy+/AmNpi8qlSBKcXbHuc893+tVaUT2F+fRRHm6VqkRAebNkEGzQr0h1ez4MRC2b5Qmr8t6gA0w9p8jVRlgwOpDtJEwXOvTjY9itBRTFeSejhdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CzUbfXl4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CzUbfXl4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFI15B2684724;
	Wed, 29 Jul 2026 18:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sgH2EJjcktcmM/j5u1s9LLcKOZo9NyikNK8G2yYlK
	SQ=; b=CzUbfXl4unznxhD/QfsILvnjA4m6sw4n7tPHWR/Dffv7M2AZ6II9w1gnd
	tFlcjBC1GhBxrI6ZY8wiqB0bfUaSug5iuvMm7WcLKp5EkocRYLEf4p6GLSTq5hpj
	IxBaPTa/w/69zJKhVURm3iQfVXpqEBmOvsN7YIJphYF66XjM8EhIEC2BbCkK/Xkl
	XjOTB8TpLWlwffMunxf2Y/Y1UBo1ACc7v43ZE7zxuVcZ6WRhM3m0kbIsQ+iNgGM5
	q60/V04ppAshl3E/DGQH8pzsQYqDfJG+kCA7oB5mpey/l8VH79F4Nldf6jE2L8m/
	fDeJw7VbzNzXBR0fBuKu6Pg/FW3cQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycm0a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 18:11:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TIBJcm001238;
	Wed, 29 Jul 2026 18:11:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhfs42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 18:11:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TIBIeM57606414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 18:11:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 118EE5805D;
	Wed, 29 Jul 2026 18:11:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A58658055;
	Wed, 29 Jul 2026 18:11:17 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.243.109])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 18:11:17 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        alex@shazbot.org, mattev@meta.com, schnelle@linux.ibm.com
Subject: [PATCH v1] vfio/pci: Avoid mapping BARs for devices with non-mappable BARs
Date: Wed, 29 Jul 2026 11:11:16 -0700
Message-ID: <20260729181116.1373-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LZLAPB0ZKSqsoSbB9I8Ba8iFaPMiCcMJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEzNyBTYWx0ZWRfXyM9tJftliIHh
 /hFosqzbvpybEeLVyCw+1+H1d+nZIxLFeaBML+yyyipFALDvjb+vwsintc5GY/IMDhvjzQJSHOx
 /81BHXOhTePpxSdVWKZAcpHAM1oFmy4UnZP9fX+zrRI/872Q+MEkdH7sucpIt/5/kluquB6WFVZ
 LcMBUk8Ji183zzNPCPXgSmh4CxrInMnD/3Hbk1BbeC3k1yP4p3mEy5LxTkCwRIi8ocfPUoWpMHB
 93nO38wssTNi6HuWg83akTwXN3SOfU+Wt0FxQ5gC3LYmT8VUmzZP4rtDcm853O2tKEtT7Zh2q3W
 g9LfhTFRZf2Jc36u4AfPnslKSmyM4ogoiwIQv6q0Rxjc4Pvgr/IUYP2suz0yI4Hyg4bydPnw+g0
 OK4gYD/0IGseM8gaePwYAel3MsbFc1L3hoN4LcY+S2xjwrilbx0DAQX9lNgfEGnRGF1+PLDSZMd
 TvZggJgS2zmxH+xFUgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEzNyBTYWx0ZWRfX0bRsLDC3p8Id
 K/RuVn5KGYsCE97CH/ICYJv1vcHVU+vFZyt2yysd/FpvsrwzEQrFEqYLhjbjwfq+tT/6/V0OS5a
 k03TkibpVlnHEn3Ci75F+MV4DHTwKsg=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6a4248 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=WVCk8p4kVaWWWIVyzUUA:9
X-Proofpoint-GUID: LZLAPB0ZKSqsoSbB9I8Ba8iFaPMiCcMJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290137

vfio_pci_core_map_bars() calls pci_iomap() to set up BAR resources, but not
all devices support having their BARs mapped by the CPU. The
non_mappable_bars flag indicates that a PCI device's BARs cannot be
accessed by the CPU. The ISM device on s390 is one such device. The BAR
size for an ISM device is 256 TiB, and attempting to map the BAR will lead
to warnings:

vmalloc_node_range for size 281474976714752 failed: Address range
restricted to 0x2110bab00000 - 0x21903ab00000

Use pdev->non_mappable_bars to skip pci_iomap() for such devices. This flag
is set by the PCI core at enumeration time and already serves the same
purpose in vfio_pci_probe_mmaps().

Fixes: 05f2a68b407a ("vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f11a9624b9c..6a184588ff23 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -554,6 +554,9 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
 
 		vdev->barmap[bar] = IOMEM_ERR_PTR(-ENODEV);
 
+		if (pdev->non_mappable_bars)
+			continue;
+
 		if (!pci_resource_len(pdev, i))
 			continue;
 
-- 
2.43.0


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A0E484226;
	Wed,  5 Aug 2026 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948932; cv=none; b=RmzpWs0D8+AbtLq1unb0nUQfRxGYwGbAMKELprNzJh2DrWy3IHXgzyLw3Okn7leg0mmpKAdpcIkrMhm0RSKAZNLKKrhYf84y6sitoepiGTxD7J4x9EHanJ/YVMOBvAU4A6WXtYfvbKMBeSUQLSDZBuPoiT//JYzqHa73DYDB5bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948932; c=relaxed/simple;
	bh=sg0VtxYCOYxT3znPEDqQSyRdxpGTmWhc8we1cTJ6GpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cmut8Du4XOOFja2c3+a18CrfUngTi3geGfbna1Sd0mKdwBi25He9cjVB7ny5GDgUk4Q/eYIsMhiYdeoAlNh5p1RSDnsggXYennEpkNwGW4WrpJC55u1D8awCBO2urQES+IPq3Akbcu1iuqCvpLJ9CKnlPb42IbL6GpPGFWMJmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rN9wD2Kh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rN9wD2Kh"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675FlveW088880;
	Wed, 5 Aug 2026 16:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gnlYYudiyN3pn80BpGaMHvSIQuUf16VtPIDhjyjKe
	3E=; b=rN9wD2KhmV5R81y4FriiBFt2FC9QOH3NJzv38Q32+S+KEGgKFJnkbgX/6
	ZOHQk7ChBJVD5wH7lmcU4hDbJGS1TxMXRdclt+vtVGN/0ayREak0DldOQcQ9KCcr
	4DINS8qk5o+xbXuJrd+1ybSeDcBnZ5ttO92N01+83JpCB3bb7RVnh1NlCLPwC7TF
	H0Fndh5Loe6uUozRlPZhWQdSs69WGCFpTZfC3ci+TIPSNVKPVfM2KU+gSmLtE+B/
	WyLoH1V/XnLYZ+kB70zhLv3Hzl/58Ann7KXFj2rgoFis7AbQBTH6f17A5K1K/hys
	t25/DrCGJnP+w27fXtIkWX28Olk2w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h544mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 16:55:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675GfLZp014967;
	Wed, 5 Aug 2026 16:55:22 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyq6p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 16:55:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675GtKLV7209714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 16:55:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF7AE58043;
	Wed,  5 Aug 2026 16:55:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B702458053;
	Wed,  5 Aug 2026 16:55:19 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.193])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 16:55:19 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v23 0/5] [PCI] Error recovery for vfio-pci devices on s390x 
Date: Wed,  5 Aug 2026 09:55:13 -0700
Message-ID: <20260805165518.794-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzNyBTYWx0ZWRfX7NHygiyRASag
 /CgnMmYR4fgYfy1l43oqWu6YNPD0mG5vSvon53QtZD/IKOkt9XXW375hXNvIVcCrQMsEEZhkWLF
 38ZxmdCZVy5C1CX63iYKwl5EmBsH17c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzNyBTYWx0ZWRfXxzQHt6HDBnfh
 UKwk5r4ttHEnik6nXEYVU0VRBK/zkGAYm+xIU1YimHqTwNbxQOMqHsyC30NlClV7ihoYGT30LmX
 sra9xjxBrFysI8Q+gOK3kpkKIpfxRIUQeloSoojQYS3jztCD8eshtT+GQZssmhb+PlWuEKIMTHA
 P1GD98bi189xqf0U8rPJBS7DaZ0gQJDrr8KOCgMStUhEbwrYmeDnyGJad5P13jh8GoWLmLgiLUN
 k5Wmtz3xDxAFU/rJciDNofWpUAxmDPZ5E7TH1nvPJA02MR+RwXZx/PmNKQLNRjMs1wi6P/uOx86
 h4y0kC/sDavswfi42X4+Bq/alx4sVOhiqdpgY2dgGOVQW7xRXbKs3oBz94ZM3EI+odjNSN3bioJ
 M1qRzsugEoSn+/JflPzLvnYNACq16A0+5HRPZRX6/1K3IeKCd1aGeZFCvSLXD4K0frNgRw5RJJQ
 tlLCReq/EXCWEj2uAvg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a736afa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=F5YOWpX_7pJtigPTpGQA:9 a=O8hF6Hzn-FEA:10 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-ORIG-GUID: O9wHjAvRvQitcDW_PlexZDJhIEkaB6T7
X-Proofpoint-GUID: O9wHjAvRvQitcDW_PlexZDJhIEkaB6T7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050137

Hi Bjorn,

This patch set includes only the PCI patches of the original series for
error recovery for vfio-pci devices on s390x [1]. Breaking up the patch
series into PCI and VFIO only patches to make merging easier based on
discussion with Alex [2].

Thanks
Farhan

[1] https://lore.kernel.org/all/20260520171113.1111-1-alifm@linux.ibm.com/
[2] https://lore.kernel.org/all/20260602163344.1eda12d2@shazbot.org/

ChangeLog
---------
v22: https://lore.kernel.org/all/20260720192505.2957-1-alifm@linux.ibm.com/
v22 -> v23:
  - Split placeholder constant into a separate patch (patch 1).
  - Rebase on 7.2-rc6

v21: https://lore.kernel.org/all/20260630164807.643-1-alifm@linux.ibm.com/
v21 -> v22
  - Ammend commit message for patch 1.
  - Rebase on 7.2-rc4

v20 https://lore.kernel.org/all/20260622171840.1618-1-alifm@linux.ibm.com/
v20 -> v21
  - Amend commit message to include Fixes tag and cc stable (patch 4).
  - Rebase on 7.2-rc1.

v19 https://lore.kernel.org/all/20260615183524.2880-1-alifm@linux.ibm.com/
v19 -> v20
  - Unconditionally enable Memory bit while restoring MSI-X (patch 4).
  Fixes an issue found with sashiko. 

v18 https://lore.kernel.org/all/20260603181647.2215-1-alifm@linux.ibm.com/
v18 -> v19
  - Move config space accessible check to pcie_flr() function (based on
  discussion of Sashiko review)

  - Fix a gap in MSI-X restoration (patch 4).

  - Rebase on 7.1-rc7

v17 -> v18
  - Rebase on 7.1-rc6.

Farhan Ali (5):
  PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder
    value
  PCI: Allow per function PCI slots to fix slot reset on s390
  PCI: Avoid saving config space state if inaccessible
  PCI: Fail FLR when config space is inaccessible
  PCI/MSI: Enable memory decoding before restoring MSI-X messages

 drivers/pci/hotplug/pnv_php.c     |  2 +-
 drivers/pci/hotplug/rpaphp_slot.c |  2 +-
 drivers/pci/msi/msi.c             | 10 +++++++
 drivers/pci/pci.c                 | 32 ++++++++++++++++++--
 drivers/pci/slot.c                | 50 +++++++++++++++++++++----------
 include/linux/pci.h               |  8 +++--
 6 files changed, 82 insertions(+), 22 deletions(-)

-- 
2.43.0


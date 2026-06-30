Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5853D6682;
	Tue, 30 Jun 2026 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838097; cv=none; b=sjEhjh0LS9bErO7PN4gaKFtDGlq2m88sOT0KG4z/axTdJ8mm4U3qzh5TEVy4z3ql5meL+FvdEOSN+i9/OXaWQEClYHr2OIwG12aYw+Xi0D4PzWImTzaKn7BW6nWDPUHeKcmUXurkZzu85q4JCD8obb8GnTMdUe6gijLvThUxb48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838097; c=relaxed/simple;
	bh=MkJ5Ad8Aa0cDRK6i/0BLEv03yrOAmr+ZDuM/89u7T3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFCUTK8hdg/hJ/z3pmNnutt/XF06vjIzAi6f+AwA+gLAIf2g46lb6ynDhHwtjW1NzI4hvB5lAOCTTkb5q3/V0Bxce77cAk7fOgK4/FEGgpiLvXyGze1DtWdysrq73xKC8xtkyOjG6IPk0D/R6JmoTiwu9snP6phWhCi/iNBkM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i5honSOk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i5honSOk"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIQRZ2170499;
	Tue, 30 Jun 2026 16:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CY84Ha24r9D+6D6AOFCIwYiP82uvSrg2wosBZFH4+
	Mo=; b=i5honSOkZZ341J5trDpU7ZAyMIMWfoZ8yQlaK8+KXtmX0lqzsK5aIMtz5
	jxAA661fQsBIIZWVl3EODlK2nzTcf6PJ5zCJ0/SJ+Nn83v1Uly6InAFcZ8ur8PHq
	0Ts8k7QbqminVVvKGKekoIG8fk5598VmDF7DAtm+QJvqPm16rANpKN7Gf3uOI6KE
	s4hwm3WBr8MGWxvWR47TFw21ruc33Un/jNc5L1ibmcVAXj+cQC3Cw0ruhDrIWogw
	kABBxl1XR03mSmy1I0g2hasXFhOyLp2WTV+lRygrSb9iLz+lGzhMQacEmY/MPHmU
	hWcBLusTo/K0LnKCrMV4p6CxvEfcA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26reynuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:48:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UGYhgf013136;
	Tue, 30 Jun 2026 16:48:10 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gb32j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:48:10 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UGm9oq4588308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 16:48:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B33758059;
	Tue, 30 Jun 2026 16:48:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B4B458058;
	Tue, 30 Jun 2026 16:48:08 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.250.12])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 16:48:08 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v21 0/4] [PCI] Error recovery for vfio-pci devices on s390x
Date: Tue, 30 Jun 2026 09:48:03 -0700
Message-ID: <20260630164807.643-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a43f34b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=ztKUdEHD2T5e-c5t2tQA:9 a=O8hF6Hzn-FEA:10 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-ORIG-GUID: xpBN0gbO7boSeYcVPE4j8qm4SsCB6Von
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX1SYxPrQGgNKT
 N9blT9q1wVK29/DEedKds5pbA70s7AHhAlmKLHNVG9yqxQqoWYr3kyiLkxUG40w//+LrJqB16sq
 oOpBYCUEhxEUBe4vmpWzGwcTs5nDDK+XMr9ThV4eUAVYrJ61yn3MH7YCrR4knd0Ipn96Q/41Y5w
 3SkSB+5QLdCzO09gGr8vIez9nzPHxRsIl47fIu6N51xPaRHqWHwJ1UiIaFGghe2Gj+9kaO7nwxZ
 8uvDCn1qLoWpSp2fvx1OWKLYCAUWgXla67+MbvQYwXvikeY56nxBlVAzFTTaXGuUS5NSQ1s7EOq
 uEcnjk7H9z1qdZ5WFkcHrKBMtmKBfRAusS93WuIsMZ+kfzK/sq0NumQ1XrXp87GBn//6mZGbTFh
 HwULq6LQqtsrv19EAnwJFh/GWYfXanLr9+Uxz9gwYAFbnla2sKB8QyiNRoSXBSQy0/YndcC76Nc
 YoSxe+GIoDsIbGz49jQ==
X-Proofpoint-GUID: xpBN0gbO7boSeYcVPE4j8qm4SsCB6Von
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX1tDRQ7fwEQjm
 u2lXPajeSjjiy0slTN6Ro1arw4lpvBvVn5xL32hzI6/0W8qIMzzSvPPpGW25d4k+9+5kChtbjs6
 1Aric0yi/FETO4f5LBlbXWy6ALLaez4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300160

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

Farhan Ali (4):
  PCI: Allow per function PCI slots to fix slot reset on s390
  PCI: Avoid saving config space state if inaccessible
  PCI: Fail FLR when config space is inaccessible
  PCI/MSI: Enable memory decoding before restoring MSI-X messages

 drivers/pci/hotplug/rpaphp_slot.c |  2 +-
 drivers/pci/msi/msi.c             | 10 ++++++++++
 drivers/pci/pci.c                 | 32 ++++++++++++++++++++++++++++--
 drivers/pci/slot.c                | 33 +++++++++++++++++++++++--------
 include/linux/pci.h               |  8 ++++++--
 5 files changed, 72 insertions(+), 13 deletions(-)

-- 
2.43.0


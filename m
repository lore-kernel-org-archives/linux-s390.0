Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7650730FC1E;
	Mon, 15 Jun 2026 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548533; cv=none; b=gil9inJcb3eliAFiEX5/LaE/nNhviHpHfYV+9tIiCzK3wq02rfnrA0B9Ueo1yRUIP4E+65WpZtRWvtObTVTFv8Z+g+aiFMx8EUvKILQfOhlwMl7ys759AJ16Mo2Lr/8xXaDEpWjLQl/+JTUBJmK+6479lxGGdLsK1i3WpP/8H00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548533; c=relaxed/simple;
	bh=3MyZ0HhFGZBCwg5M9tiHoUduXQRXz0Lhw4BSTtyl6bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aEnbFa/BdBGo9yFBaWX5OMnRL1+R/BFuwUD1ZTHeSeEvUzzibnTtBXzmpYjFPdAWX5x+7nhuA4So1clF9uMDoZ/e5I+cALPh54/fYn82rUo73kCR54jLVZPzZT8hOgiFDgc0IpJ5hLPnDdAGHRqUPP4PmD/1HLl5HGc9Mm/cZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qQxfCd1B; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qQxfCd1B"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFms7P2887716;
	Mon, 15 Jun 2026 18:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6h3dSfxggcldG1857VHpAHhTV7EoiGRft8T8Vkhr3
	FE=; b=qQxfCd1BEpWEe508RXPxclhblUn5Y3o6FvTRdn67c97stBSZCAhzptZPZ
	X451zS1SSSXjxY4kbYIOyb0grUEKdgTEU68+8OiVfuOSPdOLyl/RSK+LVm2JAPOS
	M58E/x1NpUTUhcY6n/SMZ4zsVnUn1moMSf4/KFVYy+xdh1vjhF6N3utgNJv2v/bo
	EqPFFFAcM5W1e4eKraqP2FqsxFllWcuBnoqTHE4juJvaktRlDtD3wPxopOggKx5Y
	krmQKTDE/vNcHgy3PIS2SzxmQsFax1yU/IF+ysXX4RV8pjIAmRLdLfAnwqKmyjfz
	vkJm5mF1FmG5DOKlLAqyszW+plBnA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0hknh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:35:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FIYgtH014751;
	Mon, 15 Jun 2026 18:35:27 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg7ntu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:35:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FIZQXR24969904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 18:35:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05EE558054;
	Mon, 15 Jun 2026 18:35:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE95F5803F;
	Mon, 15 Jun 2026 18:35:24 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.186])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 18:35:24 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v19 0/4] [PCI] Error recovery for vfio-pci devices on s390x
Date: Mon, 15 Jun 2026 11:35:20 -0700
Message-ID: <20260615183524.2880-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G2uAjod3CSEumnFD5Z5-Tehn9DL1c72O
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a3045ef cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=_2QMZfQrnrVBYBVu2iQA:9 a=O8hF6Hzn-FEA:10 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX5ntPIOGhqiqD
 IxG7wiBvXEv80yN10WGFFtbyIQOLNQrpPrwQY+rWEQ9Ga1V/FKLP4PiqxCP6/XiKSsAGA9sBB74
 ZWpFjzRMjSffEkRm9E0Nji05jBFBS7MmP0w/1wIb9VpT25IamZ0EqXCfuGXsdBbP4lJqaR3VFA4
 5tuiU4UV0JEUHsLDFP72aJ119SMe+zXXIkB4RIpmA78/BRhvpuQxN6BktMfGJD1/C7FsYvDjP3R
 fuV35ZWsSV0Mli0KFeZ7mFNQ8KSnERLBVMZsitRLYyKAcaP7WLpJBhT7KuaDIkRZSOKTATBgtK3
 A4rGnHYY6sVx5u6psgYVQd6ZpBIJm6R8JPhIY4rmND+KLbQbKGC0zw/2szjqxELq9MWrmERmIRV
 OWgRkufPyomyufyexH5k4GXBRKe+38AaskAZWtxZ+FE12fn3M0k4pTQG4jV0rKv5o5mXtqIN0GH
 VOJgXn9JUApYlNbZ/pA==
X-Proofpoint-ORIG-GUID: G2uAjod3CSEumnFD5Z5-Tehn9DL1c72O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX03gu4v0QbNZV
 tReRFGc6kI5BYdfkYXXxkCy/TguNyoETDrgql5icpPiKRD/kOnLJwNC52wh5yyJwC9dVpLt3+GI
 wTfdgSVd3h6mGadlnCa61PnzbuDZ5Kc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150194

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
 drivers/pci/msi/msi.c             |  9 +++++++++
 drivers/pci/pci.c                 | 32 ++++++++++++++++++++++++++++--
 drivers/pci/slot.c                | 33 +++++++++++++++++++++++--------
 include/linux/pci.h               |  8 ++++++--
 5 files changed, 71 insertions(+), 13 deletions(-)

-- 
2.43.0


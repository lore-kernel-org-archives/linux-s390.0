Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C2238E5FE;
	Mon, 20 Jul 2026 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575515; cv=none; b=VZThbib2+AW/aZkZejBYqgPXQxfTTkyt5+E/I5UgPm/bIuprnRdl+ilR82g5KpV8oLCFLNLApfRtcHcjE6Lb8no08vfd39oodRYjgkEh76lwKjolQVA6dGHaYI7MrudW1iNGKxsJNDfa7j1cvzpcSLht4uN6dBtKl66zycBu9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575515; c=relaxed/simple;
	bh=/KuxQCQymQoIRNq9iJ1JDsV4+O3aPA4c+7w8DtPch7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1FD9qZ5wmpP/rbai+OASDdjsCbCTiWbJtVTSacyqISZDS2bs2auFgbTemfDSc98opRFZCcHQp8yMmMaKipUO0LIfkXNx6DSliNkQNUHgooVTj9uFtbFbBo8LDLwaffO0r4ryf/INcJQ7Q44toxE76xwPlM5B5Bwg4xX41l9lcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=spVFV1JQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="spVFV1JQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBtZI2713694;
	Mon, 20 Jul 2026 19:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vxo1gr9j3rNVIPeG0Gh7PR3XHS/1P1MFJpWiBXCn9
	7s=; b=spVFV1JQJnS3BTEf6kWJwFgnn/kHJyKCanLlV0mICZ3k9ocVGqxbdN1aJ
	GYXFhYePPwEfy2CgGg7wMpzudRIBq9MI5i7tGt855EOtkeatpzxI07/bynS47jtK
	/oURgokFV63ULQmp+e2cNvqEM23xdo9xoigUqgvChn/ysMKUi1CvMS9Ijh3rn9xy
	5WKUszlEGmh60pTN/dFcEKRuBEzCZRmd37eMMVyNqFT8xMBzhVBYR3pvBjOP/aDZ
	zZOBiDP1+SDx3DYskTDOpYMCzV9BTVMqIwrcSzqGPeGTSIX2tAqmbec3iyMnamL5
	fmogK/0dCMlUMSq5dHuGSpryrIN0A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g0u12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 19:25:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KJJbqm030887;
	Mon, 20 Jul 2026 19:25:08 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpy6kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 19:25:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KJP6mX11731580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 19:25:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97B015805D;
	Mon, 20 Jul 2026 19:25:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4CD85805B;
	Mon, 20 Jul 2026 19:25:05 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.209])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 19:25:05 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v22 0/4] [PCI] Error recovery for vfio-pci devices on s390x
Date: Mon, 20 Jul 2026 12:25:01 -0700
Message-ID: <20260720192505.2957-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIwOSBTYWx0ZWRfXxRX/VYVo7pwY
 cQF2Vp+uOpUCILJUleutPFNEFyJbXSvuD+V4hL/liHnZjCRePNzBtfqv5x7nAUGL2Ukpmkm6EYu
 kAiZp10rwq4WEmuujd6sTREqbqw5+AWfIDLvnpkMfvvYygIXhomdObXJ3GbsvSGYcDROSyz9wD5
 uwY+wFpwuz63uVLrwpYuiAL+Qw5sD6X/G4EVIno0qAzYSohtI5DASHeNBkmFSk2azy3gKPk49Q0
 9hh0wYi9SIG4giPFrPi6yVnjzoOhfPlrg3+hIMI2sWwhb9T9Q034AuksMcSsbagT/TySwVKkvDC
 6T55sIqgXzjxDBR+v7mSo02mpinMDFlGMaeWQa0fQVJK693oyryyC0HHjG7pPkUkhkxPEXN7yte
 g4De45uCFjC+OIse3OQL730YaupJe6GGi+x50r3qLiGC4za6PWHVy6EyYP+6Bg/JNobSQQr0RQx
 TlDQDoWw1pM3/LJHHOQ==
X-Proofpoint-GUID: t7redkN4azQwop5noa20GTYTr82fJXIF
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5e7615 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=ztKUdEHD2T5e-c5t2tQA:9 a=O8hF6Hzn-FEA:10 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIwOSBTYWx0ZWRfX7DMCbl4UROXT
 cYKQYaKTVR1UhY/vreUWso2d/lrhGOIdHQJCz83ebz3mrqyZLExFA55X4E90etHEVAiCqSYqldV
 VNNS0L5w2vny9rI8l16BCr29d+PT7FE=
X-Proofpoint-ORIG-GUID: t7redkN4azQwop5noa20GTYTr82fJXIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200209

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


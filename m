Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CC126BF7;
	Mon, 22 Jun 2026 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148729; cv=none; b=uwzWXCZwxASjLinbCXTi3DJN+78FizM0mbi4HRzaQe/PQ8/UHb1WkZ0gLuMZTW0HTLRN974Pghbk9tVR9rTOF4UwTCOuMYT3tme73DmVHFmGdMG2eWi2GRah7Mmzh1WPV6FBqoIf3weP+KXGLzsOTbehOqgj9V91oFayDCs+iPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148729; c=relaxed/simple;
	bh=7CL7/L7BkB4fnGgV8RPaJFpjId/xrsNK8G25ok1J6QY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVEqrgJ5DqerrwrsGv+hLKU9yxnavNs4KUtuAny9+W2W0RO3L9OFjSCHADREDJkS7Sijxgr98+ZufpUrbQfWWqTOYsLT9qCG8BFFwnUHC6XyI56zEDumAkntd9wUmG3cs2FRbL6u3kCMn0gRNOVqOsDyC01mkdANGn9ItGdFDkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RkqTKI+D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RkqTKI+D"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmmv83333841;
	Mon, 22 Jun 2026 17:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=aHtdxecrAcQ9xOfbWqPN+HsX6aWPe44aUNkE/jUKl
	Nk=; b=RkqTKI+D+E9S5ot5evNdgvRIBdfdMMAPBOM1JUsQEGsW+R9xu74T/N568
	Hp0kb+/INCExmqU33Hfuk+8szwvSU1f+qFv3WUSGFR3TCFtxoYkU/9XB3o1efYZx
	HcU8MeCPQlPsHrjvSJ9t5rlivFkZz+u3273EnF8QIpbTpnYjQS5xBQQssOJ5F5g2
	NOXws4RFtqE99JORkJtXxjE3cKtut6HXJYgDt4lD90ltVu1idZY93Z7crSGg2eS5
	c0xJBTtdFDVFxCfmi4BNatKFa4OgURlIYMk0IXgeOjkePCij4pphvB8l/0mR4JTH
	kyOvht6CUN7MbgbXvOz00oQlZSNlA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsjcp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 17:18:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MH4gSq011572;
	Mon, 22 Jun 2026 17:18:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyeytn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 17:18:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MHIfEB17629836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 17:18:41 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74D2D58056;
	Mon, 22 Jun 2026 17:18:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFF9F58052;
	Mon, 22 Jun 2026 17:18:40 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.203])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 17:18:40 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v20 0/4] [PCI] Error recovery for vfio-pci devices on s390x
Date: Mon, 22 Jun 2026 10:18:36 -0700
Message-ID: <20260622171840.1618-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE2OSBTYWx0ZWRfX5utv5yCJmAJ4
 EjKLoQA5D7oNOaLDutTCd1+Mw2zBzdaTQoyoejLuqfunVU86zD4SiLt0vRJS2ciynvil7Z5ylav
 04jEKdM0SDIf5lUjQmj+F+gshBvw38hZU0RmtVehONiMThCHnWYkFXZMrnkjM5sJrKLBbF6+chK
 SoN1Wwk0SOJdpxJe4MKVDIo/2Hzepaed+Qfzhv4trHJOsll5lTBP47s3Cz7/4iBw1rsA7lmfyRi
 FojdQGQt3/sF7jzg/hr6mIMqt2IG8u2dfP4yaywFHFhQ5P5zoRMBC81APP6xnkzS9HzN1tDC27M
 zDrI+40PzcES01f82m6D+JGXONGdZRwE7sB3t+4GUDJiuyysX3WvMFd8CzneZyuIcoMk3hR5HGm
 owpZT9TPLHPgEtEMAI6Ni1KUFKUZg9l0ev8URvOkBPVvZavY5vHJtzv0V6C/kanjYD5/a119/wY
 v27lAQAYrH8Ln0nmOrQ==
X-Proofpoint-GUID: -1UWwTMbsFOPaWAhVKCP9dHnvv-rqOQs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE2OSBTYWx0ZWRfX2znxRdP9vkCx
 AP7jgdCaayVxEK+khvGlhOsag7AT9OdCTsz0IQicMKEQ4THLn2N+9mG7FYytTO9yKPdPQIN+Rr3
 pH0uTjpRBs+hRiVp4qygJkko9yaBWWM=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a396e73 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=GaOMMvUJxmiCxyyU8e0A:9 a=O8hF6Hzn-FEA:10 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-ORIG-GUID: -1UWwTMbsFOPaWAhVKCP9dHnvv-rqOQs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220169

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
 drivers/pci/msi/msi.c             |  4 ++++
 drivers/pci/pci.c                 | 32 ++++++++++++++++++++++++++++--
 drivers/pci/slot.c                | 33 +++++++++++++++++++++++--------
 include/linux/pci.h               |  8 ++++++--
 5 files changed, 66 insertions(+), 13 deletions(-)

-- 
2.43.0


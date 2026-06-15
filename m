Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809BD37F729;
	Mon, 15 Jun 2026 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548587; cv=none; b=s5WJNiknfaIFbspb9NB8FpNauWcNlgz5hIcUmusncHESApNJ8T/BE7mjlu6YIbYbSV1LQB/ceoONUX/tKdu8veKZt+eK7XowItOkMv8jYd9927HrnHHDRCATuZN0mmEJVwLW55AdvlqvE1BlEkYd2XZB8h7mWHbPvQKDc9shJZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548587; c=relaxed/simple;
	bh=BSW4qaXO1LZiVJ7hfdo/2N6CGKvHbCzKy6jXM/v6o4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lojffYGiHHSGOycdHfRMKDmTAhFKs4GZit5yDusXeFULxcF2kHQ3njcU1ZrFxj5m7eLSNpXsJBNNR/gJWJfMR4Ba/7YOIi/IzB62FJ7+IViChSqn2dfIK4tIopNUaxOSc7gZLBDy48/sgsROhUDaHiTHTBWIw3NiJ7snr03Eovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TN6FZ00i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TN6FZ00i"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFmNwj2841516;
	Mon, 15 Jun 2026 18:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Mh4Ul/sFGHdJ/zGgIvkt2zh/ooRPBofwUlOBRj0S1
	/M=; b=TN6FZ00i6b/os6WIIvoGaSVgiDo9T4blhCo++GHs/Gj1AdHrkDdZ2SH1b
	/e7H7fTBYGF2D6P9CP7SzKteNFrPhviIDo9/CI01PGu0YSiJKWcXZK04F63btIO9
	yWWAxYvtsVU0UCC3mYBMK3aeY6MpqRldUsiHC2Dqic9JO5RU3G3/kpC65asn/WmM
	fvi57oT6ceaZ4DIGv9iIm7T0m3yveGirkzKTY6e/lM5yNCBUcgkV0gg+UvNBYqZI
	1o+1lRsAexQ0kyf99fg8+8E3LgC56bleb5Lvf5X4gyVqAIbP263yaJZWEKmmchYA
	obGKj6BbWRhf1x2LU3QcZKtRwJ14w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nj1tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:36:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FIYZc3014732;
	Mon, 15 Jun 2026 18:36:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg7nya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:36:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FIaInN24707682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 18:36:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AE7D5805E;
	Mon, 15 Jun 2026 18:36:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52B7058043;
	Mon, 15 Jun 2026 18:36:17 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.186])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 18:36:17 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v19 0/3] [VFIO] Error recovery for vfio-pci devices on s390x
Date: Mon, 15 Jun 2026 11:36:13 -0700
Message-ID: <20260615183616.2902-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a304624 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=q0gwpn0l6oMsUSZbeGEA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX9sOIjbEQiFys
 /QQzHp/Xr4Uj0WN+ZKm8J0FxgeMMSLKWxwuz7/EZ+sjL405jzNSRrhdya7qFohr5SHA8zp9vZBV
 LbXmm/HMKBMoyqZfBw0+Y4oJoDuva9SI7w0F9hZNhD3+SUGU03+VrWztb9LCqfJW5Y7FjYUT/Po
 nN8gikVrOaB6ef+PzQFM6O0CNQ1OPZedJi7CfAm9nEXsF+BYFWJC4FX4qKkJkyqUzwxm3ma06su
 HwfDdhx2OJw4Z75rPJMnKePggF27Pvbj6EXnanBKR4Hs2bumc81Y8OD2DEAIgEkPbXWlgqvMva6
 p2UeDwGTtdwa21tikMPxeEmrN1ggOh9EoIdlPJq52Fj3At6sxyzKx+dmyPFHWbO25NFeFmB/DoL
 YyCf6B83KPULuwHATjsdlq7t/LAtoOfbLYHK7kz9CmToH3D5OdYkcX90xOs5Tcopa15kNlkhZ8z
 YkCmJfjcMnULtkk5X+g==
X-Proofpoint-GUID: ObKRDHSwYAoQ-ttL1EmA4oRFpfBIaE7F
X-Proofpoint-ORIG-GUID: ObKRDHSwYAoQ-ttL1EmA4oRFpfBIaE7F
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX+sDQvSDUbQVt
 CRNpUWxzlNMvlpZZCMzlfrT/1Bw2MTKatMxpUQONdZs8X7TYVpml7rxCcioh9lIFvmgJXQMRn9L
 jkExV1D+REOuxgLhWOtSSkNQPU1y/Kk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150194

Hi Alex,

This patch set includes only the VFIO patches of the original series for
error recovery for vfio-pci devices on s390x [1]. Breaking up the patch
series into PCI and VFIO only patches to make merging easier based on our
discussion [2].

Thanks
Farhan

[1] https://lore.kernel.org/all/20260520171113.1111-1-alifm@linux.ibm.com/
[2] https://lore.kernel.org/all/20260602163344.1eda12d2@shazbot.org/

ChangeLog
---------
v18 https://lore.kernel.org/all/20260603182415.2324-1-alifm@linux.ibm.com/
v18 -> v19
 - Fix hole in struct vfio_device_feature_zpci_err.
 - Remove reset_done() callback for vfio-pci driver.
 - Rebase on 7.1-rc7

v17 -> v18
 - Print a warn with dev_warn_ratelimited() for copy_to_user failure.
 - Rebase on 7.1-rc6.
 - Break patch series into VFIO patch set.

Farhan Ali (3):
  s390/pci: Store PCI error information for passthrough devices
  vfio-pci/zdev: Add a device feature for error information
  vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX

 arch/s390/include/asm/pci.h       |  32 +++++++
 arch/s390/pci/pci.c               |   1 +
 arch/s390/pci/pci_event.c         | 137 +++++++++++++++++++-----------
 drivers/vfio/pci/vfio_pci_core.c  |  10 +--
 drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
 drivers/vfio/pci/vfio_pci_priv.h  |   9 ++
 drivers/vfio/pci/vfio_pci_zdev.c  |  61 ++++++++++++-
 include/uapi/linux/vfio.h         |  30 +++++++
 8 files changed, 221 insertions(+), 62 deletions(-)

-- 
2.43.0


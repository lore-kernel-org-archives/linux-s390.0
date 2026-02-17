Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B232E12D;
	Tue, 17 Feb 2026 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352598; cv=none; b=bf8jNhadOLUszoKl2xjPlYufnuznPSmgQVZnzFy++nseq1Vfs3gsYGlO2vD0Vqg8rSGstbHQ/K9nSSgDfCkqEHL+OKLDdG14vKFPcHK9ZnYzVo98hKBiRsTu9VMtL7PKvGzvTOCg2EHB/ZT/3MmuG5eTuW3UCj0uf0xC5QpOeQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352598; c=relaxed/simple;
	bh=4wglaby+R8snrfD9UzVPP38foDdpaiJrB3YvtnEdI6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQDOkla7smz1VqmHajNbiq91QzgeLIX6qRZRHAl4qtCCEnTyBCM4Vb6jKhCnIPDCIiTI/8cKDtdW/+Ei0wxQleJ/A/zWSySBy5ERL++nnZH0NNYTKRacBGuyYub2JTvb8D72GDIMyWGcNDCOwTSdk7Pb6JKiCB+8CNwqxnDx5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WU5Fib4I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WU5Fib4I"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H8XSbs3466849;
	Tue, 17 Feb 2026 18:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9h1TT/s2NziYpsxx+
	DjjI2cbosM+B1a21s+AOqeVmp4=; b=WU5Fib4Iu6AjoHgy/3CqDRev5qagUf8OY
	Hhe0seMrW/Jp4JqbDBPizJufRAYwzfZJyz333DyVE8ECBHXCxZTTvhzhuBJMsY+3
	DavvpeK4S695olRnWpHeqNDaCyb0YunaoU7sQKNqcUj4k1qTjr7XS2NyMRPnhM1D
	nSvkp3GtiXtne4W9+xh42MZoEaZKiyHLcanrvHwpIH8mC+zIUPcEsfx09lS0OPT/
	g07zZl+TvUY8jFt7UBbJYEk8Qi2exjyBWH/rp4PDtn+9TlNr1EPCPsQkx6OUm6yi
	ANoDumPAmu5t2ye9alH63+94ixuQT4Zfues64A5szxRuMlCDw505A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rwjfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:23:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HG0QGJ030213;
	Tue, 17 Feb 2026 18:23:04 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb4543c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:23:04 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HIMgu618612962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 18:22:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9E915805D;
	Tue, 17 Feb 2026 18:23:02 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0FF658052;
	Tue, 17 Feb 2026 18:23:01 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.249])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 18:23:01 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v9 4/9] PCI: Add additional checks for flr reset
Date: Tue, 17 Feb 2026 10:22:52 -0800
Message-ID: <20260217182257.1582-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217182257.1582-1-alifm@linux.ibm.com>
References: <20260217182257.1582-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=6994b209 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_COy7Z8VS3VoYlkUqhYA:9
X-Proofpoint-GUID: kKPV7CYnKBboefQhCBwdR0tGXffE4dwJ
X-Proofpoint-ORIG-GUID: kKPV7CYnKBboefQhCBwdR0tGXffE4dwJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE0OCBTYWx0ZWRfX/uIpRuXbB/Cc
 j40p+vOknCXeBikRypy02x+wGOft/v869YCl9JD3X8NOJwp6U8YMV4ekYnE34WSWt3mdrxFseW/
 4o+fEJGSBxSunixp3fyK0i3onJg++/0lX0EgO8K1lEgJAsAWSgPPxphVN34R84ay+YZoCvcrwwg
 eSFcuktqGH68MjmXkKcGWnsaywNKE3PbThsxitfJLhwbB/+7r5tXErYtDuyu3L2ODnO7uc05Qwj
 eRP7E2UHPBniDwXlyyesjhlq0IbzUvjzHSeiYs3p9k2a9P6ejU95gX9Yzv5MH2VnecUx6vkntxr
 Er4xjJ1Qq7VHZUqICeT2r5Mc94pZUkxvx+iak7stUPHYiPO2FMTATyDthOfeZvcz4VusXxOTwG6
 ozf6FK1yqKYQwi6+fwHF697SlFt8cgBNu3BlEw17AtjhPnsLuFXfp2qq7GMAM86RkId8GrmHSNz
 /J+2UjmfVTf3UaOwVlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170148

If a device is in an error state, then any reads of device registers can
return error value. Add addtional checks to validate if a device is in an
error state before doing an flr reset.

Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2242b97e7d46..d867db7188d0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4373,12 +4373,19 @@ EXPORT_SYMBOL_GPL(pcie_flr);
  */
 int pcie_reset_flr(struct pci_dev *dev, bool probe)
 {
+	u32 reg;
+
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return -ENOTTY;
 
 	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
 		return -ENOTTY;
 
+	if (pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &reg)) {
+		pci_warn(dev, "Device unable to do an FLR\n");
+		return -ENOTTY;
+	}
+
 	if (probe)
 		return 0;
 
-- 
2.43.0


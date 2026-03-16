Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251EA3ED129;
	Mon, 16 Mar 2026 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688567; cv=none; b=ono3/aB6P2yIM5QmJ93pWBswjQJYh9O6N0fwS8MpQ5gUifIKd98iHeQf84Fh1tE8F2H7uQPzkHoirxUmkpgkAssFuXRRfIxsmrn5FV6HiY69fZTFML4yNrMKXe6sbdhV/5Jo0FJ+KNUA23685zZ595Iuqd/rh+ebVjlJ1hvJeLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688567; c=relaxed/simple;
	bh=sqH4CNseM+g5AdP+kWFJrBmAif5i7CB6o/CQIX21O3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaubySmett2xHnSOwSx1NOHWaxDk1ZR2xt2PjDWdcWu3hrQNj+30cBUS1npmfDGeNjxVOnfNFXayp1bQ/plGxK9+DmaYUDFksHP3zx9htKEI3sk2CXeJanlDn1VSxcLgb5zhiUstWYwoCCw1vOu2vbf1pntqr1MwljoGymGTt28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZWGUthVS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZWGUthVS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GFgPTJ752470;
	Mon, 16 Mar 2026 19:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bNx6CfAfsKbeiaX8T
	FWOGFnwQv2tLImSj8pacugZZKI=; b=ZWGUthVSFXFyp6eQc2GWF5YnR0L+xoW19
	xufDBqp29Tb4Y8boL1chlfSrKBfs0u77WQo1lmVCSSTNK3brxDvjOMudJ0xSX6/2
	NxbRSsyIKe2H/Gbpbs0EDmwqtbch37rpEfbnHeJzyshnVAJGu3d3Zw+Cl2br0iVt
	2MsgDAHM7betapO8w8rsQq2bUBM6yKl9HvTCMHAMPSYf2Gwwe26FN3y7E2kWkGcs
	tgcC954yeX+l0Cy6iD9GdPLO+r0IZk6+pFzP/iI+uHp/6N8+3zq1uYEpOcfnKDqS
	wSL3yAPQwqBF0yX2mCTgrPucALJIL+BpvaIE+869+RALWXiZNNqmg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cs2h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:15:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GEMPKQ004737;
	Mon, 16 Mar 2026 19:15:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s65h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:15:56 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GJFtFB20906606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 19:15:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D76558055;
	Mon, 16 Mar 2026 19:15:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E92C5804B;
	Mon, 16 Mar 2026 19:15:54 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.131])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 19:15:53 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, kbusch@kernel.org,
        clg@redhat.com, stable@vger.kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v11 4/9] PCI: Add additional checks for flr reset
Date: Mon, 16 Mar 2026 12:15:39 -0700
Message-ID: <20260316191544.2279-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316191544.2279-1-alifm@linux.ibm.com>
References: <20260316191544.2279-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b856ed cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_COy7Z8VS3VoYlkUqhYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE1MyBTYWx0ZWRfXxtCr1f3DilU7
 87whUQzLgJObH5iUz3G/f/fsFaz621tSnekHyOlCb7exNOh5t1a45LgjcWYJfZ8Z1dvM8O4npAJ
 ffakMqFBb/nX4Rj64FGvfRxMsn9AQ7/7B59k0MPgjEC3moLKFCqZb3txuSk6nC5JrfdavEyqZDI
 1PCwbT2RpcrTTxFA/pl+3+wR8qRXh2fggppOChzA+UY36Daa6a3y76THiDa8YiLEFk+L/RdtQmY
 hGBBt/zQTKRuELCE7J6s2GttN2cPrlHDQlFLWGHSFTljyoZEQU/eQNdbi234MSmLZijhx6sMa02
 3nl8ZgMgqbmrufjETTRpO6tnDR1qt7RrblRuWTMqRFcFEVKvLdkoLWaiAirEjJURpBQM4bnKURA
 w00PoJFZRAwTuWrGvtAdWl1elpoe9zBT/klZF2agpcnvX7zwwGV152WPinN1NZPrhxV9GSmM2pa
 15tbCSUD5DRBtmvWoHA==
X-Proofpoint-GUID: iPG7gyNGzXngN8ja6M1SSCp2XfWSudY5
X-Proofpoint-ORIG-GUID: iPG7gyNGzXngN8ja6M1SSCp2XfWSudY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160153

If a device is in an error state, then any reads of device registers can
return error value. Add additional checks to validate if a device is in an
error state before doing an flr reset.

Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 373421f4b9d8..8e4d924f4e88 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4371,12 +4371,19 @@ EXPORT_SYMBOL_GPL(pcie_flr);
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


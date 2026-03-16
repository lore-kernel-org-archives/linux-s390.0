Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F32D3ECBF2;
	Mon, 16 Mar 2026 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688563; cv=none; b=c+oci9zjMGxYnFiCINPFiBwtiTpP8Y81AkHk/NIcLtvuOkh+wA1/FF09HKsnV6ZDYAKNAQKMNvl1oMXn1+YmIIHA9pr7cHagpsc+J+XAz7vlQtJpJ/JvJDP11I8a60GE3GHAoyWXI8GXGIrMoiURdAh5tnGhxkh3hKl7p/ndESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688563; c=relaxed/simple;
	bh=/TAkttD/m8UcNbC+JGdCeHld2Xon1e0lpOiw6KxQiQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T43NyGnqHPfvgj3koqA86nRTbnrT0m0Ya9+wiiXdvDVzeZucUiMhJVWagidEqZbMlZ7I/8ORuP092SkFhE7PxSTqp3BEkHUpFFGq1gFskpPJL1IWHHIoZU/NV6L3CsGFqDjA4ifIQyysmGMxgiiyK5pYFsDgPCvx/kwTmHNjwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n3Hvou1/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n3Hvou1/"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GABFaR3402882;
	Mon, 16 Mar 2026 19:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uhUr2ihj00lp3TH0a
	EtGm1BA+ajK9Cbm95BModvo6JU=; b=n3Hvou1/mTY0TGUfDaVdCCv3E/a2iY4ab
	7RfxuK/gz5yf6OKsyDtepquYarP94mA7qsZgd5xj2dIVUmXjnhUFSG89db1LNvCP
	qwoI8r7vcNbYGMg5ZM6LG5345XX0BfGDlqvF9dOazs8Ts5r4JnFekw0x8/+wzghB
	0oT4ACuPpJ5/pHa93A8rbD1gF9lGaco2d1Wsy9hle/845KqpsmvIk4m1TSGRbpx4
	fPVguuZWcMocpurkIT7lMDkBE78t5SnjNnKnTuaya1Ck+uqak2CNEW5fieTuOggn
	wg1DsqLkd0hfQhoUlXR72uwDx1OjZBn9654rZFaE/16tS/AP7b1Kg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyau8yha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:15:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GEPTWi014032;
	Mon, 16 Mar 2026 19:15:55 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxx3yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:15:55 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GJFsB832637606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 19:15:54 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E794358055;
	Mon, 16 Mar 2026 19:15:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9F985804B;
	Mon, 16 Mar 2026 19:15:52 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.131])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 19:15:52 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, kbusch@kernel.org,
        clg@redhat.com, stable@vger.kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v11 3/9] PCI: Avoid saving config space state if inaccessible
Date: Mon, 16 Mar 2026 12:15:38 -0700
Message-ID: <20260316191544.2279-4-alifm@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE1MyBTYWx0ZWRfX9c79WJrVBsTB
 lo4pL7cVsZM7wzO2sLxM3hKT502d8AJ/JaOIuMyWsJXu4P8Ykz7a7R9SVOOXM2diG2xY8oNLsk2
 T3kNXM3zCyqKB1CNG9yCuV2pRxV9m1KLtq2/qHpRym68TB4MvFIwZ9pqPdonGs3RG1tlbnq4CcO
 BJ70ZX2jeLgK1hXcQ5U4t+PaSClksRUgFMGebTRpjPnVAHU48zj8UcIErxMeqe20EDYo4UI9h3j
 5yhwEyx2MOv6Xi3dvQuKYRayYbIQofnaMPqwfoCNLJbMWh/z9CHtnaIjuG3P3qCyjikftjQf9jR
 IukzmeWZf2Z4kkh17P+1UahCsQBnMIDNCe2AyfFRfNJBx9BNuk7Fszd1kMcZm3gNd5QPaI1df+A
 mVyDpYS2JxVw//Fal1RV6TkV6HxDyHUiD5D+PDxVeU7LgY7Te7UrHl0bFVocxwKjfsv+KOO9lF4
 sBoBYHXuS+LsZm+hXEw==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b856ec cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=zIJZGsahcqu1twqqOCkA:9
X-Proofpoint-ORIG-GUID: atdWXU3xHPgmlDB3jke0XVY08A_n6ylN
X-Proofpoint-GUID: atdWXU3xHPgmlDB3jke0XVY08A_n6ylN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160153

The current reset process saves the device's config space state before
reset and restores it afterward. However errors may occur unexpectedly and
it may then be impossible to save config space because the device may be
inaccessible (e.g. DPC) or config space may be corrupted. This results in
saving corrupted values that get written back to the device during state
restoration.

With a reset we want to recover/restore the device into a functional state.
So avoid saving the state of the config space when the device config space
is inaccessible.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/pci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a93084053537..373421f4b9d8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5014,6 +5014,7 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 {
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
+	u32 val;
 
 	/*
 	 * dev->driver->err_handler->reset_prepare() is protected against
@@ -5033,6 +5034,19 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 	 */
 	pci_set_power_state(dev, PCI_D0);
 
+	/*
+	 * If device's config space is inaccessible it can return ~0 for
+	 * any reads. Since VFs can also return ~0 for Device and Vendor ID
+	 * check Command and Status registers. At the very least we should
+	 * avoid restoring config space for device with error bits set in
+	 * Status register.
+	 */
+	pci_read_config_dword(dev, PCI_COMMAND, &val);
+	if (PCI_POSSIBLE_ERROR(val)) {
+		pci_warn(dev, "Device config space inaccessible\n");
+		return;
+	}
+
 	pci_save_state(dev);
 	/*
 	 * Disable the device by clearing the Command register, except for
-- 
2.43.0


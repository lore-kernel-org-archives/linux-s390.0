Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B4191F98;
	Tue,  5 May 2026 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011521; cv=none; b=UIaWYIl38HRcu3fRjclr1JYA9274+kHQ0pVhK/kTwcnpEoAfEohEZZR0OyToJQxW8AxSAcz2qM2gTUZyXcLskVdtETH3NptONvi4yCBbeQiVvZ53sN53ZLQY+VzKna1xVynJvnUTDscni65qY44bEvqEwc+Bu/uHGRgzYETn/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011521; c=relaxed/simple;
	bh=/A4i7jVvjy73WaQOU6JOmUh4l/ODHy9wJnwVOUgyG1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eufX14NvMk8EvTYEjPrXzAU05/a77dMvHeaj3gyySssPqYBgQhPmWXBM2YwMSqJAgdtITCmaoQX1j9tRTuBOkFUIL7ezlA8/RNHBfEZ4KHOiNksWzJo8R5GO6DXcm3v+xmfUQ6So6abfecW5g0vZ+YL0g306mwH20e+EGF5wWdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BPut1Hq7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BPut1Hq7"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645IPlTF3285137;
	Tue, 5 May 2026 20:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Xr+EsZK/+1s603aWr
	/wUgOxtfADRseSmWFfwoV44DZo=; b=BPut1Hq7jZfz2M0jvDpbpZ2AX1mu3CRgO
	oo/6TgoobGMxCrUpjVWIamDM5PsfkmL6blj/Xh0n9DVdbkJ/ZdkHWuf+XBbnvWUu
	gJCE/cOe2L8rm+rLupu08hS7dYKfgTD7Pm/0pu5ta10TcocMFiJk0F6s/chtkPEn
	Ly4Sxf43kOEhHyP7MDiavZcWyPo1dHZoNxU6L1875GpapUICjv+NVqQreZDJJast
	SkK/oLdUAgUmDsDQKwikutrbxHIvWAiD7efhn6VRRIW8KXyCfRLbVma9JVJq5t9Y
	4qE2VWTKObSAY0wu9KULZM2e8HhcHKyY+HvKZC/ssUREdAyXEzodg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxn3a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 20:05:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645JsVZ6013088;
	Tue, 5 May 2026 20:05:15 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw3bmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 20:05:15 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645K5DvL22020742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 20:05:14 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D75FA58060;
	Tue,  5 May 2026 20:05:13 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E8445805E;
	Tue,  5 May 2026 20:05:13 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.219])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 20:05:13 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v15 3/7] PCI: Fail FLR when config space is inaccessible
Date: Tue,  5 May 2026 13:05:06 -0700
Message-ID: <20260505200510.2954-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505200510.2954-1-alifm@linux.ibm.com>
References: <20260505200510.2954-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5MSBTYWx0ZWRfX3yzu4eLW6z1b
 26U+V5XHOZ79cp6hfGz+j+RhU6BaER9xUo+gevrSGV+B9Bg5uPraSjSfbPtt5G91u7NkYXTlSDm
 XeHgmY+Aw9sPtjwsKcWXQE60+YGByFOeTfGhehitzIz/3PzVGWLpSuNh/ENdrfXda8tNZQKiHpE
 9cb+TlFq/pph0UN9nrAVy82TALhp76coGYsX9I2rPwCWs5dLNsdQGHkRmAgRRRePSJSFdaNGiVG
 slaIICQE7ERKrk5Piw5nTNQ77nZh1LfVSdb8rwTD9dCENU54SbZuhPkOxzNOS56w9EM4/xaxvD3
 +5SkxQgOSoaYLnGt+cNlkEaLY1ftGhEef4WTe5wWxlZGVkUWTWZivsD9xlQs22gRuymDJ2/6EHd
 o87736BuACVkloo1BBhvXpbnqb62jSNm9iKMRv6yfBXw60IPLq9EYMcqET5ucxWayIZklDLrtL5
 7a7T+5f/1/kHfWQGddA==
X-Proofpoint-ORIG-GUID: NmbIbEEMgXt0UjmoIoeKxqXhpnQ-IRdz
X-Proofpoint-GUID: NmbIbEEMgXt0UjmoIoeKxqXhpnQ-IRdz
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fa4d7b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=1owyFLT6pZZ0tE0DW5YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050191

If a device is in an error state, then it's config space may not be
accssible. Add additional check to validate if a device's config space is
accessible before doing an FLR reset.

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e71b81415392..c50418f5e318 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4396,6 +4396,9 @@ int pcie_reset_flr(struct pci_dev *dev, bool probe)
 	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
 		return -ENOTTY;
 
+	if (!pci_dev_config_accessible(dev, "FLR"))
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
-- 
2.43.0


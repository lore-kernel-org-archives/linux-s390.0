Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404B36C0D3;
	Thu, 22 Jan 2026 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111124; cv=none; b=DltSrx4D/yyOhOIOTDkmjczpkO+TdTOQomcb1Pbmvyd/zDXAUB7mn1SyqbnoWAH88dXccSvn5ts6nQniTXSEJ8blyBGlHIjinFbIwThxN49pqFSnz1P5/Eg4X++tVtz+JNLILWcNNS3b4rau8OpqQvMJ+cm4wAegjCG4ra2RgJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111124; c=relaxed/simple;
	bh=GPFD3qc1VHTR0uhbsKNpqHY+0vJfMVltXW9tfMgERKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmNLWUZf3+wHzkQbwhjedQL20DE6iMKrqmB9NdrIxIGcRmnhGpPqWhOeHW8CXG/aitGN6OIEQF0hn2IVy+Mmnh8urUSnU9Ui5hMpUpEVsYLR9CldoSv6DAXmkIpe7HzWdMKZiH9IPNdlR66IfzEzpWSmSRKIc7pnBctgwMzMPsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rpnNNsPy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rpnNNsPy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MDtnjg019532;
	Thu, 22 Jan 2026 19:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=u/S734DCJ5Mg543I8
	3Qjcf7Q2ZoDQHYB42ma1HX+sbo=; b=rpnNNsPyy2R99SvyLoo0dPGCTa65IqyUD
	d9dKmEKVbFGJAJiI8/+nfRDk5VMHHxErISguAeAiEe6yeL9OcMJf/iNoMoQH3Kt6
	fSdVHc8AqS0jW3/IeqYpj6Yyx7uC+IYcXoBKtliknBZSoxR1Rf7SeQqd76re2ZNR
	vEt+FlLjUFTanYCroSLj57mMWSEZ+oWiPuLjY/WhQWOXKcr+vBdS8rRW9XvNrRHq
	KfF+vz6BZEhfUbLVXi5pMsCMgPmqXpzNrOPQxIzBVUjPxLqTAu4KbcabHsE02HnL
	iBoAUamxhCGWQmOzMpKITluB+7bwH2YYIt/D6XCM7M6PElrDMvqJw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256bt3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 19:44:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MIQjaj024610;
	Thu, 22 Jan 2026 19:44:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxas2t9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 19:44:45 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60MJihF33342952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 19:44:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C206358056;
	Thu, 22 Jan 2026 19:44:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC2EE58060;
	Thu, 22 Jan 2026 19:44:42 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.216])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jan 2026 19:44:42 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, julianr@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v8 4/9] PCI: Add additional checks for flr reset
Date: Thu, 22 Jan 2026 11:44:32 -0800
Message-ID: <20260122194437.1903-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122194437.1903-1-alifm@linux.ibm.com>
References: <20260122194437.1903-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE0OCBTYWx0ZWRfX4DREh+7gHQnn
 aglrDDecY/kSf5HpaF0dNYuzrnQwt3AnfpjjgOBxK+R+O6oisRgx/hG8bCgsq2+4DQpuKgWvifO
 OCejzjRcjcydIwGzn9jvsr3Ajq7acuPIbkrGfGtO6Z952VIMi3cuCjMkIiwPsAau53KWL/1glNc
 1qVPOUuOvzHdevtcrVcr2VH9nXkOkWuG4WeqLNVp8EbnlDDUSI0OYLUZ3wJc28cPoSS9tXTncIq
 d9sEuEBorQUmqNmVSfePSz1Kcehs1ZaA/DeP/louxRl8lIs1vknxGkd65SfExDSK3qFjvX4GOzf
 U4T2KS1jpG2M3GnTHbko1q2EuJSDU0lUtfCVO8VoEfxQNF4CkLLDOox4LHbmLQOUQUCA9vgwP98
 rOKQU47obu5V1Zgfbm+4WKwdKUbV+eD8jfGJlpXwzE1L/eSUtsBr/Uy/eQq/y9vJ+2k0l3iBXWf
 gVjvecqMckv4M60zZjA==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=69727e2e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_COy7Z8VS3VoYlkUqhYA:9
X-Proofpoint-GUID: nkCeWH2aLBt8wEgIKJLKEBUoBHeUIgLJ
X-Proofpoint-ORIG-GUID: nkCeWH2aLBt8wEgIKJLKEBUoBHeUIgLJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601220148

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
index e7beaf1f65a7..2d0a4c7714af 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4358,12 +4358,19 @@ EXPORT_SYMBOL_GPL(pcie_flr);
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


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F2B285CBA;
	Thu, 22 Jan 2026 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111126; cv=none; b=f8U9EpUzeaFqpwq03aAKkkNzld3Z8jrk0qrwknTBYa/h7uJf18Ui0svr0y34Nfiwp6e5K24SiG/R8w2/Vvqe5AntS46HRhn2k7zGVpNAqIiMU6HLjhK2oU0rpUNJ4uB23poA+/8v3PEVfydxsatf9uoz7nvBCZiy1qEYB+vtfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111126; c=relaxed/simple;
	bh=qdYOuZETphoSrYosgQirPiv2ckz7+9ATv7pHMUlE6qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiQ9D49mvqwTCSAphpkfF2HrzXIVaMHZK7HIGvBF+Ewd/1sS5O8mjKgIaDBvYyQFpisx2osoouAuB4Y3RRrd07kPJ6s+jloBeDB1nH03emR2IPA17ff8HlTJuiI7oYP+kSbjjdmJTOsEOdyKEKIaxj+XT5GeBILVSEug2iZFj/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QvqjRDpW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QvqjRDpW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MCmAhj019492;
	Thu, 22 Jan 2026 19:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3oNI0gV4CEhTXWZ2T
	szmdDtvkLJZcLUHUBHDHL/alnU=; b=QvqjRDpWOLaRoU8lbDtRW9zP8BlZqkqTU
	5Js/Kv8s/mTpsaBmzFNcu1tfxcswtR9Qqn+3FIAbW5tx1kfUg5m8lxyJDWBM/eZA
	Ge3FA2XVT3UL2DucATHJRaktHI2HoUNvaa3F+EYSy1USSIyp68Z/gckq+gSodmtM
	WMxlZ4c5iqwXYd8PSSuPpMw09NoB29y4ZOdJyLPV2ci6aW1LpvzH8umn6F5QBOeu
	Pod7SAzGaXeEbeevDIQQFEBNMX/RNgW/j6bo1Iox/vuZtjluTigoHDmxKsmr2e1p
	VqSgbcQJr4uwVaDexqp8wcUrYGg9Vu30mbr+9ZYwXIKneNd477hoQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256bt3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 19:44:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MIXcXs027233;
	Thu, 22 Jan 2026 19:44:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrncg29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 19:44:44 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60MJigOl59507194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 19:44:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD59858056;
	Thu, 22 Jan 2026 19:44:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBD445805A;
	Thu, 22 Jan 2026 19:44:41 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.216])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jan 2026 19:44:41 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, julianr@linux.ibm.com
Subject: [PATCH v8 3/9] PCI: Avoid saving config space state if inaccessible
Date: Thu, 22 Jan 2026 11:44:31 -0800
Message-ID: <20260122194437.1903-4-alifm@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE0OCBTYWx0ZWRfX0RzuDmWDJ8xm
 DED3A4HWPmIZoh7Igq0wa7LtYDZKJiSYyfIM1f9ZSw7L0rqPA6V4h7RyUvvNL8tt0AWe3ViphbX
 VH0T/8YyYNHyCXuhJr7HnY+pO8sgLkCJoIl1ESJkD8ka+OXvZNlY/5Jv1lhIvlRL5qVkOiArXB4
 HhIjFClQLXJ6oJPhdeqxkXfwegURaMtTmBMTMvB5Czi+6COZkZuG9Q4/liIRT78+bSBD/+HZVm7
 ASKW9tPt6B6NbnfCQuXRHJ3d9TdUArEDe/l/2gasqr/Rn4bX5Mn+tow6J9mq7ZVkh3qnLKzSxmy
 o/9DeIxcXHKiOLSrrCioKiNFZd4cOwCrwq3Dsyb4fFuzKTeYQc0oL9Vh6RseARgwSneZ7rJ+zw1
 +RjOI/QfKYPepKY+BSTvGVOUY3HBX1ncJKznOqhpGYeuH9f45IpZl+2u+S+He2/MJ0Y1xAxf+c9
 QJFpMkia7Tgf03SUIEA==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=69727e2d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=zIJZGsahcqu1twqqOCkA:9
X-Proofpoint-GUID: ZlIJyRKnOE2_CFtfkWIgBVZL-tgArplO
X-Proofpoint-ORIG-GUID: ZlIJyRKnOE2_CFtfkWIgBVZL-tgArplO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601220148

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
---
 drivers/pci/pci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c105e285cff8..e7beaf1f65a7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4960,6 +4960,7 @@ EXPORT_SYMBOL_GPL(pci_dev_unlock);
 
 static void pci_dev_save_and_disable(struct pci_dev *dev)
 {
+	u32 val;
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
 
@@ -4980,6 +4981,19 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
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


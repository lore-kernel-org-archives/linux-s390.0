Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439B534104E;
	Mon, 22 Jun 2026 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148731; cv=none; b=kZf/gUeW/pB9Ag1j5QsNrbjD3ORsLAMfNAHTKKLyo5I+DQfMzzSiSQyNy3M9p73VkMBfMgVMOtJWxjokxO74OoC4zOB3dx5r5km54+NT3xsx9T38TzWlflEDFdPo/v+EjRlDzyE6+dUns28HOuOJAUzD6yEGsIRTMCKDwMycn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148731; c=relaxed/simple;
	bh=aXtnh1XDkfyl9Qchb57izKfvAET1OL/16TRuqGUY3os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+/skqYT07qmKpc6tn++x6Dwc34uS0rhNSP27Gexyvrpif8GTBUtE1qFbhm2KZ6MSgGl/7C8yV454HWG6drB7K4I/G1kJBUX5NXA3EzzupbVhFzMKDCQroVrZelCnHinGg8L3NjtHhKoznnAt75FDvdONwybhBN34DMf2vPBOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oia3RcJP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oia3RcJP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmOhw3447281;
	Mon, 22 Jun 2026 17:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=X3l7SLvrNZOlg/Grb
	Nj/MWNHBcQ/IvPqQwU6/jfIaaA=; b=oia3RcJPdPqIiOiHgoAISAmIzrdjbOmLc
	A0QKpW8GmhxYl/ai8LAaF+LTPZS7H1sga9pCZmCaxkRjbnbXjNxrMLNB2X7F0gSK
	sh7UdMEk6qqAKv4VEu4fx63PVZX7Wt6WJhdFmIwpn+gDDDYhD5i1z5N5d4F8Aie9
	cZIBj5OdRfyK0StvCeKvgRJi3f8uk2wwpdAIBGqyv+WWegC45lPb5fnUXggRnbzL
	0G1eNlK9TmpgIJzA9uCZmFj47uhTlrbfQyHrfIg4ae+XeDFTaGinQxCi3ZBdsKkh
	CtttZSMpxYGwr+YAsNzpAXVc9ZSAcQr6mZFqJiK1N5rD+VNcdB40Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3agu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 17:18:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MH4dNM030132;
	Mon, 22 Jun 2026 17:18:46 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56q7ghg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 17:18:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MHIB9B29622868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 17:18:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E486058056;
	Mon, 22 Jun 2026 17:18:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C0AB58052;
	Mon, 22 Jun 2026 17:18:43 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.203])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 17:18:43 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v20 3/4] PCI: Fail FLR when config space is inaccessible
Date: Mon, 22 Jun 2026 10:18:39 -0700
Message-ID: <20260622171840.1618-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622171840.1618-1-alifm@linux.ibm.com>
References: <20260622171840.1618-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a396e76 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=1owyFLT6pZZ0tE0DW5YA:9
 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE2OSBTYWx0ZWRfX3tAL4UwEDUfM
 rcVi/7Eg/Z/OlFK5O+a46TNHTsw8bYlKhpSehdgfVcloFHSOGmR4WMeO3eMB6m9wfmKLQFAj6q6
 dm8p3fRzF0KNqemioxkxouBjArJeZTI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE2OSBTYWx0ZWRfX9Qjs8WX3QSMj
 pvD+4NwmFDCqmgVfB1W+5KXJK/p0OpjRaicFMSYXGhgRMMDdByqubRCCK8UC5cFMiZPj4tGeF99
 +zV3XLsrswJcP0kk7Cb3nye4mHSvM8W+jGuglCJd0a+YLiArC8QFFXelEq78JIzUURxmuZnWwCH
 V3/bBDKOQ9k8xTIstPdxqCA+Vle3wnpO65UuyDdnwFFmtEoOMI1PSRH1+KHHxc/ACwzVOsrnKLx
 NCTaQnrF5y09IBHV2v2/byWmtdstXjisdfxuqV6jHERL78XdvBElI7k5oiz2l81y/MShJkhY87N
 hUdW/0yNVGuKVDaYjG86FSkJhRb8TZogPz0XdWIiQo+XMLkJIjBTNlwbWX9XHM1cEltNqDb5EA3
 uzZzKLvHW64CHscPLOCilQGx2KDz4w2EXOs+IT/e5kdcyoH83y4kY7ov71TUEF2OMABmfIjXCH4
 yKiDxrw+5D+tEMuweSw==
X-Proofpoint-ORIG-GUID: 7tJvNMJ8oljm93-S2qoIDzOu_XJIlb-9
X-Proofpoint-GUID: 7tJvNMJ8oljm93-S2qoIDzOu_XJIlb-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220169

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
index 973d23e41c48..521a4bb189d7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4352,6 +4352,9 @@ int pcie_flr(struct pci_dev *dev)
 {
 	int ret;
 
+	if (!pci_dev_config_accessible(dev, "FLR"))
+		return -ENOTTY;
+
 	if (!pci_wait_for_pending_transaction(dev))
 		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
-- 
2.43.0


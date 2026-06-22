Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D4342CA7;
	Mon, 22 Jun 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148732; cv=none; b=Z79MnDo34jUX6QksS54Srj4uvZ3eljjeQi9MhpPP1njES1DCAmY1n9Dd11ePX45CeQUb4VPa1rwbTfaIEiHI4TqbeBob61JEOjpb9ZjbIN1Tcm703fZ+RBOj0Sn3g+rCDR34/XXZB37IEw80eN10EUl3SregAIybZjOf87BLgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148732; c=relaxed/simple;
	bh=HwilaB+MOwsNvLp3NNZBv6VKrQ6JxXEn3W7VRuDEss0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtJnWvVVC6Z6bz0OKwFvt1PlSs9t6aTOpu5dreuMCIA8y4Ly4+2z+ryPqcBCGjr9JtfDtYjZD5PnZqM5UB5LtbrWI8wYfOatM4EeGllQEOBalmoHfuZcH3TGpEQQDfEVImVywTHW8RW6zE3Y+r48EZsjBZhcgEBKZhwvpm+mHVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PkKHa0jJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PkKHa0jJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmktf3594318;
	Mon, 22 Jun 2026 17:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=z+uiSRVVSJ3AktqKQ
	PjjN84apzBlCrFNROyTAJCeo00=; b=PkKHa0jJvCGqhOWFUr+yXl8AzDz66d/HU
	2B5bmkRo71ajNJwIyPQhNtJ425/gbQ2VMbwOPv77mjuDyO2pxmllhOaIVC6ScodF
	byFoUXCmPX/Z+w2yYn1FwhrHWqFkEh6sHiqv8nPfEDZREDpMrAn1oIDdfmDzzGOo
	TOB91+UhLdiL9/7DqI8UGoF+XlXalD/6ncFDe/4Jof1SFusrsdTOpaJVsup/63z/
	R637GuUtAvXDLXsoFSinBOvHhN2bg0wvcTK57erVJenvaO7RRNcUw3Cyg82/37nI
	GpPTxT/GWyTgwmn7cLKuwQLTJ7pR7Q3qF4NCmPaAosGpOJSl/qcfA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqje3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 17:18:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MH4c6O011538;
	Mon, 22 Jun 2026 17:18:46 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyeytw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 17:18:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MHIio363701438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 17:18:45 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5C4058056;
	Mon, 22 Jun 2026 17:18:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1524E58052;
	Mon, 22 Jun 2026 17:18:44 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.203])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 17:18:43 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v20 4/4] PCI/MSI: Enable memory decoding before restoring MSI-X messages
Date: Mon, 22 Jun 2026 10:18:40 -0700
Message-ID: <20260622171840.1618-5-alifm@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a396e77 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=kR1LtElmgzqE7PBWmM4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE2OSBTYWx0ZWRfXwhAvYlTBv5U+
 CpyomKB031HF0ir/no8uO3PdTE3M6zrM5ChS9BPr4uHhqzrriPpWLnCVhICz8483W0p3xFFmnPy
 qX8229+kl6qxar/dc6M1z3YBp5Pk/qTSxnzZO9vQmLG6YVGY3hULK/48L7Y2r1ywjUaBg+Lcfse
 QbNWWtes0/1ArZTl+KQxeaQbPEQqJUb5eNo5JjRy5fXgS4yoVdG5ekAB6JXBcOFCAnwo9uAWypm
 W63c26z3jkbL0H6R8RnCaUOc7EgWMgsOlszG9WdVvGP94As+PP9kp5TuwwY3lSbdlhEn1jwx6fK
 wtmrvMSy9xOp4V3fNY1y8bcA7sGOjENVek2JKLvhpVnWWMyrYpugeLsXhKmQx6tB9yWC/q2XPq2
 i/Se20X1EHmUAHjJRefq7wIXoKGSEi6t5vFsPRdImWsIatF9zKqQEQexKIYzKSHDnH3a45bCfK+
 ZP6korv+Fa/d+Xuypyg==
X-Proofpoint-GUID: FJLXJNB220G98A0eJi4v7aQrneYDoRq7
X-Proofpoint-ORIG-GUID: FJLXJNB220G98A0eJi4v7aQrneYDoRq7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE2OSBTYWx0ZWRfXxGlwXWswPlvG
 woA7be5WlYNBROGctrvZF2HRIQr3/zbAYQYhsjGJoOHIHciWUecYiq+rhs8H7LWw9g7nIUqTiJO
 3PXgc8+qyZZCDNL7NT3eQ9WgMbTuTVU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220169

The current MSI-X restoration path assumes the Command register Memory bit
is enabled when writing MSI-X messages. But its possible the last saved and
restored state of device may not have the Memory bit enabled, even if a
device driver later enables Memory bit and MSI-X. Attempting to access
Memory space without Memory bit enabled can lead to Unsupported Request
(UR) from the device. Fix this by enabling Memory bit and restore
it afterwards.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/msi/msi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 81d24a270a79..46a0d9f68a57 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -874,6 +874,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
 	bool write_msg;
+	u16 cmd;
 
 	if (!dev->msix_enabled)
 		return;
@@ -882,6 +883,8 @@ void __pci_restore_msix_state(struct pci_dev *dev)
 	pci_intx_for_msi(dev, 0);
 	pci_msix_clear_and_set_ctrl(dev, 0,
 				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
 
 	write_msg = arch_restore_msi_irqs(dev);
 
@@ -893,6 +896,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
 		}
 	}
 
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
 
-- 
2.43.0


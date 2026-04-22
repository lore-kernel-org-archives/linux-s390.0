Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68433ED5C5;
	Wed, 22 Apr 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868672; cv=none; b=lfGFxDAv+qNSQON9VM2E+QZwTRGHmrYhPledMOB7NNrr79ZF2ObZOese3Ce+oJHQhDJLhZBBr2bxIESlXdhZUQPrFuM6k4JGHJotMMkDrwD9D+BYsRnU7joY6T7WdiezPV3HDWuYQTZctfgvocL1oTW5cgXicLPqJC2MuGCocYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868672; c=relaxed/simple;
	bh=6C0btdHehmcdBHpQXETgyuRBlAldDb54Mofy35XMiNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmjsBIlBK0ylUesrBYT3N9texF6N3ahtOq0DrJ4FVf7MkQasjP+0Go44dG1zeCW244feq4p5f2GAQ/B814rLYK6bm2knFhgXE1wBIfmjsSjSXRo2wv7LE3jUiml7F3pqm787DfczjPezswtnOavod+lJsV03u23Nu688O1AiigY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U4cKQjv7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U4cKQjv7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MB9LFB590754;
	Wed, 22 Apr 2026 14:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=pp1; bh=U7PquSzLk0
	46oRsJNtAhBNjD2BGpHFpbkUiQcZTx0Ng=; b=U4cKQjv7wvAWQ4DUJ1N25N5tY/
	s/EPwX5hopTycy+xf4WE+ei2TNcevjgS1Wol5iVIQWC9PWHpgB1v3dnmUB4e9gDP
	Oe9hwsocvtZGfgq8frmdhTGzoUrZwUhLQI0hdRGx1WFi1txPjqSWagYMROauQ92P
	d9HqNcShGl7DHK6LY5v0Z+Omq2LxTAox+B4PQ2ToYVT5MWFrVgReZaRIuxqZUQb/
	3GhwBEOVUDmIBk/llMeaB1JJGE/mau1t5iOEImQ/bG85dBdbSDfLBigDH+cqxSQe
	uLFWKc0YEmWMkCPQg7WhDLUtTyn7f8+e3NUTOgXm9xUH9wYeLLk2/qzp7B/Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu23yq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:37:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MEZQw1018163;
	Wed, 22 Apr 2026 14:37:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky2ktn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:37:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MEbjsO42402272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 14:37:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B4BB2004D;
	Wed, 22 Apr 2026 14:37:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0790120043;
	Wed, 22 Apr 2026 14:37:45 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Apr 2026 14:37:44 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wFYi0-0000000G4Rb-3438;
	Wed, 22 Apr 2026 16:37:44 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v4 2/3] PCI: Provide lock guard for pci_rescan_remove_lock
Date: Wed, 22 Apr 2026 16:37:43 +0200
Message-ID: <5abcac047ec9cb40cddca1d28c92ebb370ea3b9f.1776868550.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1776868550.git.bblock@linux.ibm.com>
References: <cover.1776868550.git.bblock@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: IBM Deutschland Research & Development GmbH, https://www.ibm.com/privacy, Vors. Aufs.-R.: Wolfgang Wendt, Geschäftsführung: David Faller. Sitz der Ges.: Ehningen, Registergericht: AmtsG Stuttgart, HRB 243294
Content-Transfer-Encoding: 8bit
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _HN-b5r82uKwrSGAPkG3mqRl4X4r-lMh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzOCBTYWx0ZWRfX88tvFuaP7FtK
 EQlEn03icKLLTLCFE10OmcUOUnZDa/15HG/EVwG8ontHRuEuU1Fa0QVrgLnDC0CRz3EtLglj9ER
 567rueEcRqtwCVgKR6rSS+mwsoytNC9nZSGGoczslLlSpx71YXN3iXNHZ7PoHFAyG7CqlCPN+XN
 ykrMltySHiwgAwLIxq9jjbkn2xozlYDMgVDuVuNMCkGFgZf+Q0NTnPphMsIBm8QBfZNq7T47wnZ
 C8372HZgdNhfolm2w7Yjort5M1y1KZssi5sq6xfKYaUrh/O2tX9/jWi06VrjHzP/U8TqLNU93Js
 ZiH5G8+XLm58k7KQHInFqUX/tJ3cGDHsIyqNM23mYazlaZEbX63bg/jTlDCekWBdCTOjAqg47IR
 UJtaPdiKES28j4KNRFoj78w18HijNuVntCSNIXz1Fb4jAvNn4ErpWk2AI3+AF7HxeaIXtLcCKr9
 lYlHq71Jc4uYkVAO5OQ==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69e8dd3e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=qAR2Z3AMSIpdRBh0OscA:9
X-Proofpoint-ORIG-GUID: AYr71c6qmVbzrFp9zzEX8XpAbWIIf4LU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220138

Make it possible to use guard() or scoped_guard() to lock, and
automatically unlock `pci_rescan_remove_lock`.

Since the actual mutex `pci_rescan_remove_lock` is always supposed to be
taken and released using the functions pci_lock_rescan_remove() and
pci_unlock_rescan_remove() it is not possible to simply use the already
existing guards for `struct mutex`. Instead define a new guard
`pci_rescan_remove` that will also call the functions in question, but
is usable via guard() or scoped_guard().

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 include/linux/pci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index fd7a962a64ef..4c41b5a2c90a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -41,6 +41,7 @@
 #include <linux/msi_api.h>
 #include <linux/mutex.h>
 #include <uapi/linux/pci.h>
+#include <linux/cleanup.h>
 
 #include <linux/pci_ids.h>
 
@@ -1537,6 +1538,8 @@ unsigned int pci_rescan_bus(struct pci_bus *bus);
 extern struct mutex pci_rescan_remove_lock;
 void pci_lock_rescan_remove(void);
 void pci_unlock_rescan_remove(void);
+DEFINE_LOCK_GUARD_0(pci_rescan_remove, pci_lock_rescan_remove(),
+		    pci_unlock_rescan_remove());
 
 /* Vital Product Data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
-- 
2.54.0


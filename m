Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C272425873;
	Wed,  5 Aug 2026 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948939; cv=none; b=O0OWlXX8DorEpSsBf4l1YJml3HiZH2ZvGg+qQ7PL8K3BNe7qlOoENv+5/u/nVmtXO7oB7SRaH2nvkI+jLppniKfDLhLP9y65BLlsTZytQyx0iVFHrSG7/3xTSdvT7L6Pq3R16+dAIwEiadYR6OSCFPDsgrbkcbcCUacfh/vG8HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948939; c=relaxed/simple;
	bh=cX5TZtvSZwarWBI5c6PMZ7i7miA4OLjgPxAssK4YgaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOkQJvgNfq+yFq40oKVc5PNkISbjzwwQTMYpS011fcsBdypvDtY0THomf17RsE8t56FbjHvz/J/TRGTgAFZ4KVd1oxlILZOWW+OMLuJ4BUWN609Cl2lLuc1qY5xULyrcBbOfbXsxKP8FjURsCzLeAdbVgtJHnMK0xS5LfyR6Aac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D08RBVaF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D08RBVaF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Flpeu4179505;
	Wed, 5 Aug 2026 16:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vXU3DidQiGyzHYE/9
	ch2T/ZRaHPRlcHfwPGBi3+olgE=; b=D08RBVaFzkGSV4wwE7YtGM9BnVO/SOBEi
	3shG5K8zZSkCs3M0Y7Agmke4Z+krO2Iq79zwNHde8oJIN6UVcWeFSl4WODF80aEK
	/N7+uyMyfF/lRRSzCZphf0sPH8n1O/qDffDk77gBJ5MDQGfvyNc+ehxOPN+U74EM
	OO5HCU5OPp3KwCF49TLMICYekBjlG2MkGs/T0oNIrio92n/DKv03jhGcMLsyUcPJ
	7Ea9zVbsysiGzaoVWDzMKfM64QOXO1Goq3ZM8wdg5iL39APoQeIysxolHaz7inmb
	78RcU7ZT4RT7uZZbTke0Sf+makwnHEI1oxSueFQbftHIY8WVQOG3A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gbq1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 16:55:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675GfG2c023471;
	Wed, 5 Aug 2026 16:55:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw7hnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 16:55:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675GtPis30802564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 16:55:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C61525805D;
	Wed,  5 Aug 2026 16:55:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF39058043;
	Wed,  5 Aug 2026 16:55:24 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.193])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 16:55:24 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v23 4/5] PCI: Fail FLR when config space is inaccessible
Date: Wed,  5 Aug 2026 09:55:17 -0700
Message-ID: <20260805165518.794-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805165518.794-1-alifm@linux.ibm.com>
References: <20260805165518.794-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzNyBTYWx0ZWRfXzCwtd+BoaI8+
 FaQsbahskR50DgawAcs36H6/aDs2d0IWHfsaRuAYfb7Ff0ns/VdrLLzb5biE+2jSJAUVnZUpY6r
 KNi9/dUPDJqUozGOrnlDQ6s75dQ8q5CtzofPH92ui6ZULskkGKGnlcypaqkSeNFNNkx/Zx/3542
 07+nHgbPvfeJMOYPdx+fmWCGwpGrAO1L3Hg9+Gl01nE2ozDcZLDC6bsRKabEuh4ZEIj+aUOuwiT
 RjXZcYjwqCEt+m2SOLpl8+GEFLFSrEtNL4uI8vuewJtqP6AaQO8Jk65IyKq9P9npf+DVRh8hdHR
 vkYw71PaUyOGDk1FMYyrf8zElF+l0SobU5C6jRH39/DUM7Z7U4hl3n/OpHgzxk94FmYBo0iF8Qs
 8+s4LHZys8oVn/PoepuLn4pIxcUGFD2vcr+iuWfqfC3HkSh6PDI5+EHkoFlZffhx8V98szeQq3f
 lGbDbA46oqDpU+GJpYg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a736aff cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=1owyFLT6pZZ0tE0DW5YA:9
 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: nYKQWf2c5tGdDO45B7lpghxWHQY_W83D
X-Proofpoint-ORIG-GUID: nYKQWf2c5tGdDO45B7lpghxWHQY_W83D
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzNyBTYWx0ZWRfX65e0g52Ak5D1
 RhB5EzZswZzTLxqdwpzQ3GOwQhLPw8f27qhprIm4ZxA2Y3lk9Su/3nyBUEECJ0RiXv0cXc9XsZW
 9YOPSYaqDpnRqQJh1xYfamG2PBL/paI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050137

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
index e8d7de77241a..9a9d021301c4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4384,6 +4384,9 @@ int pcie_flr(struct pci_dev *dev)
 {
 	int ret;
 
+	if (!pci_dev_config_accessible(dev, "FLR"))
+		return -ENOTTY;
+
 	if (!pci_wait_for_pending_transaction(dev))
 		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
-- 
2.43.0


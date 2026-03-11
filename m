Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89923D7F0;
	Wed, 11 Mar 2026 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235678; cv=none; b=oEiuHm+HdR19lXg4RXngLJ+Mv9BWt6cJZnLsJlbSMlaELgnazzfGr9ozkgDqDKAMqF59p1nI9Sq8sicLHNaB0VIkLjpv7TyoMogcdJKU0Z5Y3c6RjRzrshjS455G6lAWGFc9xYIi0Cj/Er7u5mFc8fhRkuAt3wR1y34HV6iSCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235678; c=relaxed/simple;
	bh=pgVfp++xnaWG3o5SBaf3zcDumRCcFiH3KiRg4ok919g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsXkDw9ii0iTpOSnPXGPlR4aWcWR83CDwfcCYSc3nNCOTICFdncfpTHGP/6+wQuwSFTJFBZHZ8PwO75alILZCRCyAWB7UjUBClCvs9DfdPOaDbAj0RGm78+wFLRTIw5RC3yNBJP0Y+ZmHARKuQlDgnKSTLmJGjjHHEo8fmLSW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ODLQod8E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ODLQod8E"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B8u4bn056775;
	Wed, 11 Mar 2026 13:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=pp1; bh=dMPhgHcSt3
	QLfSzVOvCxD77HfbBQXLqvXvAivL6lOh8=; b=ODLQod8Eya7x0x06kVHMM4aHBt
	MkEozzSv+Onpuw3X40a6OUUqL0gqAp6jif/ejsx2h052jKv/y+6wDr9Au3Y179F0
	ybPObnzDdeyXalzsN2Vu4Zb4FZTQptr+bVnTA3dSs6AFLdy9ytL3Q4abAareitQ5
	7fkVvKWPDmTP8d39H0v8nmVo8RI3GSsbRUtKqoXKIdugSXs+tTheoldYOYKq2CB6
	dA8Vmfs8oJDaEVdSdkgT7pMOwI4vAX9MPG5sB14GZKqBLtglfNC/aQPUtlg634qa
	9TVOw9cVwuX4eWZtHDsF2vML+KXkryKYMOUbXgyYKxLVnu0JZNkqZYxpN30A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvrfjvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:27:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BC1RQK023007;
	Wed, 11 Mar 2026 13:27:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ct8ng6hry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:27:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BDRpBi39322056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 13:27:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 087D82004D;
	Wed, 11 Mar 2026 13:27:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9B132004B;
	Wed, 11 Mar 2026 13:27:50 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Mar 2026 13:27:50 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1w0JbK-00000008V4T-2sp7;
	Wed, 11 Mar 2026 14:27:50 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Julian Ruess <julianr@linux.ibm.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v2 2/3] PCI: Provide lock guard for pci_rescan_remove_lock
Date: Wed, 11 Mar 2026 14:27:49 +0100
Message-ID: <c55e954604dcf728dfc93ed0adff102f2a2469e9.1773235561.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773235561.git.bblock@linux.ibm.com>
References: <cover.1773235561.git.bblock@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExMCBTYWx0ZWRfXwq/yzkw8sw02
 pODyLK6G2C8joPdj1Yoq+HwTay59zBdV2EZpG9P1ujeX47v666tCCtSWvz+s23PDkpaccS42wcu
 rFzPuIfO+cgxhdG+7mH/jwxgDdx2eruZJ4TYJGqOntNozAJumETfeK/bwmpyjTf1KlO/SWM+vvC
 dwxxdHyo7xV1ZICwh/0bejXIi1xLhtwksIX+9F8xLh0Gc6hBHF7XVebtltU+VY40OqvvGm0IzQx
 QZn9Wau532Au607Y8gyte9z/GBaH1D1HAWG/45qqo+Sgu5C/l4vsb0SYNYTjYjNboluOJ/rpokd
 OdNuw9MliDqMWi4YkOX/kvqMGUP3/sVIS6x+7JDRmVBeEuq5y61Bsla2TZYV340RyHtf6yyVMSL
 AJBiuBMghEC9rDJl3jb6ZmFA46HN8pe4F4kUCfATH4CMfdlaELHmgRRd2rE43xekK9NEPgT03XI
 oQsG5Z58oxKH1CnoQtg==
X-Proofpoint-GUID: mFzvpGUggbl7ooKcmekISc9utmEaT-Lq
X-Proofpoint-ORIG-GUID: gyGfgt7S7_DLNGek_P5w5M9Y4gfSA0yc
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69b16ddc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=qAR2Z3AMSIpdRBh0OscA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110110

Make it possible to use guard() or scoped_guard() to lock, and
automatically unlock `pci_rescan_remove_lock`.

Since the actual mutex `pci_rescan_remove_lock` is always supposed to be
taken and released using the functions pci_lock_rescan_remove() and
pci_unlock_rescan_remove() it is not possible to simply use the already
existing guards for `struct mutex`. Instead define a new guard
`pci_rescan_remove` that will also call the functions in question, but
is usable via guard() or scoped_guard().

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
2.53.0


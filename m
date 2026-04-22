Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4203B30BF4F;
	Wed, 22 Apr 2026 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867742; cv=none; b=nHOUU0T/16DJam4cBx9/E7k0Rsasik0nf25/HwZMKvA0vpq/MM2iwxgTC32l7ET7Tv3Llqs844gapmJirPTm6K7o52J3P7szjEjvwvB30kB5oXf2VrMXlssncc+YhQPzrkIACW26d/m5gs3DtRwjtfniN50f7c3YxZ6ULo2xQk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867742; c=relaxed/simple;
	bh=6C0btdHehmcdBHpQXETgyuRBlAldDb54Mofy35XMiNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9/GUlaRjsuahUzfZb/55kimhh5o34XKdwEuxSK0/rL2j5MMAMoMJEP9NVwWsV8fMwOZm9rLccghx9xDdAt8eJkPwvV025tqxxfnmMMdSqPPhyU/IFUTbDC/oDWihkivZw9eTiQ41eXY0HvWj2PGWn7eaKXk+DlqAFax7mNnSwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CETo7I6k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CETo7I6k"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MCrg7s177010;
	Wed, 22 Apr 2026 14:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=pp1; bh=U7PquSzLk0
	46oRsJNtAhBNjD2BGpHFpbkUiQcZTx0Ng=; b=CETo7I6knvkCXhV02KOYyPlPL5
	OISZ3x6WJErR8YmaK53E6R4tn0IPHeF7NKrgUlS0hWDzGkqIVPK2H3SUOLx6ZiRV
	5NAs8gfWi8eQ7H/6+BLMP7Z0JbbTOTLll7k17x/qOWT4ciK7NsA6E1cuN3zRsiGi
	lg7w3VLbCmTL/DIHrW8WoYYOkgQ17WhcrOXheQ5aANkZUWVDh8qsGH+k59oklAQ3
	aWzhBw11m0xJ0MZuDA48ilVPLfdyGNWq6IBcrsAq9VksTK3GpWiVlCg7SigEwcTf
	cotl8alUCqjG7jc1nmcgB68AsJJLklSMkHiVdzXBKgCzzD1leeocstK7PaNA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6bnat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:22:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MEKSwo021343;
	Wed, 22 Apr 2026 14:22:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxtj8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:22:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MEMEuL62062882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 14:22:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CF422004E;
	Wed, 22 Apr 2026 14:22:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF20D20043;
	Wed, 22 Apr 2026 14:22:13 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Apr 2026 14:22:13 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wFYSz-0000000FrWw-36Zr;
	Wed, 22 Apr 2026 16:22:13 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ionut Nechita <ionut.nechita@windriver.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Gerd Bayer <gbayer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Heiko Carstens <hca@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v3 2/3] PCI: Provide lock guard for pci_rescan_remove_lock
Date: Wed, 22 Apr 2026 16:22:12 +0200
Message-ID: <a20d6541e72625a3e244a737a7c94e59a7193859.1776866921.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1776866921.git.bblock@linux.ibm.com>
References: <cover.1776866921.git.bblock@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzOCBTYWx0ZWRfX1dho74nZVb5+
 0bKnBhzO2PiQKaCe9g02REXc6wLVEzpEL/g2tV00Owaq2uQMViOa9Gw38fm8rF95g6d7TDX7Fjy
 TziXqmQPu7MmqsYw+3BgLgv7DY59hLT9ngPXs5m2XZDRXy+5ksUyzgPttoPdnUVAaxE7Q3W2eKs
 hnzqARONizbPNFpQkPGXbpOLFFCWu3DqiH61WbhD7VV6LrW+cYCC2B8r9GEwd2dDYzRTIkQawoV
 A+JTBwtgCD3ou7GR9yyaJ8TUQ4pmBDX85l/jSG2e+P9J0HNki1bvGPvwa44uuF4GNNUKf/e6S8M
 Iz1Oja2ETgtEbbCeMEwVcuga9zqhIGLt1b2uFZ3YUAHnKvoI+LvwCdKP0YT+TzkJXtIzfm9GeJ0
 2ZKWxMbmAswAWH6jKZ5W6AI103scTi7X16CTCLzFde+hfI4Aqu3Fvd5xZ68pB+opnUv6Swy+zm+
 ZhN3p6w86HdFRYyeBPA==
X-Proofpoint-ORIG-GUID: kyxKZNpbTLuGkc8Vq0XRm2DUdcC-dJ1f
X-Proofpoint-GUID: ZshJOuVGDdKPQJBPIJu-98Le92IiQCEv
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69e8d99a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=qAR2Z3AMSIpdRBh0OscA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
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


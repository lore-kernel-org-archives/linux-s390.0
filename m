Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7C1248873;
	Fri,  6 Mar 2026 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815764; cv=none; b=q5np+Xi4Q040BdXphJmxKEl8+zMqIna6cDnsEDTcX+L8T2/6MN/mKpzhi9A95G1nYEH7u53t4UtiIe+RWh2a1z/OIsZP8W9ldl/9vrQaqrvXzLnL/5yX7WZblT+QKraHJaxTJSzuCxNFLXEN57jn+f0o43gjfWJxOqbgjYpWAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815764; c=relaxed/simple;
	bh=BTaeyQEoi2cJ/YpM1zJvdI+DayHoqgp97OQN05m8GtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVNCG8qY5B3J+PIChI41GmqjpC89Xlirz6rvlvOVJn5lB83DXtNqQd2Rt1EocwgHeeGdN9u0x7LRMiMuAvqJsapr1GwGkebaueox9KosPTit0luTzfXus6yp5reti3pM0E3HK9DAphH9e7FqJA40XApfQqephz6zo2+fH18Tyec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A7onrTBQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A7onrTBQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626FXUK01873366;
	Fri, 6 Mar 2026 16:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=pp1; bh=r1yWFVlCdj
	WSRuLAOmBPoKzTje6BW6UblbX2cI3tO5c=; b=A7onrTBQixfpeNt6d4m1MPndtG
	EYO+WZZ2qHgNbP2+E5Nq3nKk47fBX+h5hcppwbrqnWtK47FTaBrbuPOgQV8vlh0N
	dlEydSP0aWZZs8MK/kxRdHPGhj5RJPpTJiTujl+GQBYopq+jmegOiEWVMs7J2Csz
	+TZIVyF9Pd+kM47vnAW4wv0s9E7QnYnaZTmlhCrGo9/fcA7etLP6O9U8LwKCttho
	6wvXDtzEIKwcXkuwRfx7zWBaQWzYK5Tm15tI6Vtw2Cdf1Xh1U5sI1XWuSSzoQtMt
	0vtcll0G5C+ma/62qndG2qEd21bHe6hgua5TbcWdU4mWfa+SbLT+7XLN7aSQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjdsgyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 16:49:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626D1Yb0010317;
	Fri, 6 Mar 2026 16:49:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6kgkfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 16:49:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626GnHOJ43843990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 16:49:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FAB22004B;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C03720040;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vyYMX-00000005i3C-0Fky;
	Fri, 06 Mar 2026 17:49:17 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Tobias Schumacher <ts@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 3/4] PCI: Provide lock guard for pci_rescan_remove_lock
Date: Fri,  6 Mar 2026 17:49:15 +0100
Message-ID: <4f48fc3d4cd96e041733d2764a7aa5f1b37363cf.1772815642.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772815642.git.bblock@linux.ibm.com>
References: <cover.1772815642.git.bblock@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69ab0593 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=qAR2Z3AMSIpdRBh0OscA:9
X-Proofpoint-ORIG-GUID: 6D3697FmYPsVrqlstqokwbkUOyV3AAoy
X-Proofpoint-GUID: earvnWLhhE85YoPNaQ6BygRFS2RQyFKe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1OCBTYWx0ZWRfX+ggS/uwf5J+1
 tOBHIYaFQZdQc+cXXoncZfGlREKFRVf+iEsK7OPX5ASoaaSsVojh1OB2xmSugbe5fuTB1xKOAfd
 et8BIrPpldd7mQ8vrpM3/xMAiQWBwBZt/zZndiTrYopF7w1rJD8V1Y9bgHbYdkVU97VmyC4+vVe
 UJypOg3Z2UWJ9azbPV4JCD5nJIg7koPKGiwmJV2fZFH699fDqM1ctQhK2dmWbnO4BA4TtQdJiYK
 e6PKS+ihnEEc00TUn1HhogwZBlONpZSp2eewLgscfFuXFqJz5JGwkAYuQhuILcdTC8hQejajOpf
 cClF6yQ8h7F8gv5CBtnKO9Oi/ZAqo8Sbqnl/0ekP/IF0axxBr3436mv3RdododgW4rY6+w80bnu
 aqzggS0ewgIJ6BO14P9GxSz6vZfDeqAp4drfoP6x/xXMzsH5vc83OXT3e0f0i+ipWruVvePbUWh
 Xs+e8Il6UhIHMwMpdRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060158

Make it possible to use guard() or scoped_guard() to lock, and
automatically unlock `pci_rescan_remove_lock`.

Since the actual mutex `pci_rescan_remove_lock` is always supposed to be
taken and released using the functions pci_lock_rescan_remove() and
pci_unlock_rescan_remove() it is not possible to simply use the already
existing guards for `struct mutex`. Instead define a new guard
`pci_rescan_remove` that will also call the functions in question, but
is usable as via guard() or scoped_guard().

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


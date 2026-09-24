Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79967442B2E;
	Thu, 24 Sep 2026 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267415; cv=none; b=N6q1T9YNkpqNcqWYZjIpKBUqJ5INgpZMEop/33Wgm2By9ZWfHj+KkCK//MbUWDM8UFohEE+jIz7NdIpUX4sQ6sN6FjFnFk9bJYDKcF5yLtsltC03l5jB1IsN5ZzybED9GL4wYQ2j/9lIO5Cb+trSAG38sqN3tj3YvIoyBuirzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267415; c=relaxed/simple;
	bh=OdO6H26QAe+K/fOwhahRid/OSo1Dgm5tCAzUVTN3zPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/qO9OnCdFjMPkmrpNJSR40KWKmvuQLZAGGgUqIiHb5SWS5RhLQ1xybJJ/neH0xiTNk9V428Wbr71ilYw+2o0Jfd2979r/ln7dmnmROVmizwuIIWB7UkRjTdc7cNO1zVhAZhL+qpU7E/2eDbzytVTjysyRtVj+Hnkz7WNlZE/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kD6+6STE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kD6+6STE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OG653J2692741;
	Thu, 24 Sep 2026 16:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=pp1; bh=VhLyuulLGq
	Jw+Jf27W5MHk8fOlgiNH55JSYltoWiuYU=; b=kD6+6STEPPQ0/7+p7A970M+iqx
	vpNcxVp+yJ0HSrpbqAEPFgVFPtRtmzFuH0m2np9PZvMhzyn1ELN1DxzHVgrU/VFU
	bR7gQO339HCbxJPTi7rVz4rJQ7pdC5hdXhcKqnGvfsXF8/FPiurwZRnFAVaF/LsL
	vKZ5Dx79mW1/fNfwCzQWs7qTcY/OBAPr/82PEGoqwFfPIMf+EnvjWUAAuEufb864
	ZVVuAXbiMHKMs26rzi2jzZCGAshL+LMC8wuyAdfZWBM0F9QlSV5maEJcLNpU2Kku
	fdXL/yPY1kg5wRg4mkRVxG9DAdhLOrgWQp7xftd8Nm2NgPoLCKqPMlKPq5DQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsj8cc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:29:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFlT241019551;
	Thu, 24 Sep 2026 16:29:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7eavtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:29:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OGTW0d48759284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 16:29:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DFCE2004D;
	Thu, 24 Sep 2026 16:29:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7D8C2004B;
	Thu, 24 Sep 2026 16:29:31 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 16:29:31 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1x9mKB-000000094DK-3523;
	Thu, 24 Sep 2026 18:29:31 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Benjamin Block <bebl@ategam.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        linux-intel-xe <intel-xe@lists.freedesktop.org>,
        piotr.piorkowski@intel.com, Farhan Ali <alifm@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>, Guenter Roeck <linux@roeck-us.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Omar Elghoul <oelghoul@linux.ibm.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Ionut Nechita <sunlightlinux@gmail.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v15 3/5] PCI: Move declaration of pci_rescan_remove_lock into public pci.h
Date: Thu, 24 Sep 2026 18:29:29 +0200
Message-ID: <d15370f96120f007db5717839a313f1a7bbfe010.1790267348.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790267348.git.bblock@linux.ibm.com>
References: <cover.1790267348.git.bblock@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab54ff1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=vf2HUNMP9xvVswJDcwYA:9
X-Proofpoint-ORIG-GUID: zEdDsQBCImpeduCAAgowK4xMkWmCFeDe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX24KP3m34to9r
 NHgTLRzRTYh2aTwDghHXlgtn9ccj5QDEHB2yHzyfk+24/b3tanh0Yxx2VUbXP/l8lANdXvCkhfh
 eT4Ne0D6sm/+b0Axe6SDQjooIXs0vb7NEDiqXKL3BsdREay9b6ofxhLrJrFSigOFTfBrjT5wq+T
 3qid2XDE9NIYaFKu5qNmxcGvlSVXz45GHpzojMXIlvXSlQxbQkyyeSqmjUA8jVdIn/LHcb1Xvvj
 o5OBviwr3qoQTBMEEiI4kDwf2+3Q896WYMMQ6uTxJ4zAmDCbvbXnjhcJgUapZD2RGsnEjOCnm2l
 FRDgKuWqcLMGaottQTkZnl03smZas2JifwxD/O1MZKezPxOLAAKe+s7n4r/+I0jkB8ARL3xDUHY
 Awp6qxvPxW/H98525ciOZ8yPRYvhdbitg3n1WRTa2CksMDqGhcZV1+hQ12RnYnZZNcG2W7M3EhK
 Xd3wQRBEz+Hakuwo69A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX4Md9GKJ9NM5q
 wRh2H6SUHqyvfa+qhfRTQdwviH45eG3k4Nl//43At9nVVRnmXqG19ZnsbxEfJJ2jM3CUK8BQF3d
 eC9+3urdxkF/gPU8FnU35R2my8lffBg=
X-Proofpoint-GUID: a1c9gAbUA_5zQXrXiP8eooac--yqix6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240066

So far it is possible to use and call the functions
pci_lock_rescan_remove() and pci_unlock_rescan_remove() from any PCI
code, including modules and architecture code; but the lock variable
`pci_rescan_remove_lock` itself is private to objects residing in
`drivers/pci/` via the header `drivers/pci/pci.h`.

This makes it possible to use the lock - lock it, unlock it - from
anywhere, but it is not possible to use lockdep annotations such as
lockdep_assert_held(), or sparse annotations such as __must_hold() in
modules or architecture code for PCI to make the usage more safe.

Since it is useful for `pci_rescan_remove_lock` to have such
annotations, move the variable declaration into `include/linux/pci.h`.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/pci/pci.h   | 2 --
 drivers/pci/probe.c | 1 +
 include/linux/pci.h | 2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..811958807b63 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -114,8 +114,6 @@ unsigned char pcie_get_link_speed(unsigned int speed);
 
 extern bool pci_early_dump;
 
-extern struct mutex pci_rescan_remove_lock;
-
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cff9f0bf4c4b..85b96a8e40e7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3510,6 +3510,7 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+EXPORT_SYMBOL_GPL(pci_rescan_remove_lock);
 static const struct task_struct *pci_rescan_remove_owner;
 static size_t pci_rescan_remove_depth;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..d704a32ff988 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -40,6 +40,7 @@
 #include <linux/io.h>
 #include <linux/resource_ext.h>
 #include <linux/msi_api.h>
+#include <linux/mutex.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -1551,6 +1552,7 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev);
 
 /* Functions for PCI Hotplug drivers to use */
 unsigned int pci_rescan_bus(struct pci_bus *bus);
+extern struct mutex pci_rescan_remove_lock;
 void pci_lock_rescan_remove(void);
 void pci_unlock_rescan_remove(void);
 
-- 
2.55.0


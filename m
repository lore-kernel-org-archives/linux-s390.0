Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68DA3ED5CD;
	Wed, 22 Apr 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868672; cv=none; b=tYqyC7nUO65eLYEy3dfWG/ndYs9ZoteX1/v0+5heO8roAyGKx38W3kBUJFfYSIoE+DfDQRs/WZwmT1rsM2laXb/dW2tyZZAd4eLT9WDnDR6su/7YOCudXSHbkuL0IW2clcGBk721xUtAzHj+oZNjqdq7HkAfQaWDA9wQvZfbAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868672; c=relaxed/simple;
	bh=AOgrJvt8eAQd3uhRUBWWqieBYQQirzu5sfsd07wnJ0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXBHhwe/5rCvlKdDSrvRdu0LvROz8q059j65a5wMCDc35YPB/ZFKgZx/mESyZs+izbnIByUDa+T9m0RbEPzRvH1iEc+rBmqqL/QCXlOjD+rq0TeLbNS5Q+qpxf+JyGRjDUz1S/xwvZiTsy7e2a5dom0SL1VTvnhA91kOeYtBnTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gT8ajzhc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gT8ajzhc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MARLE5876696;
	Wed, 22 Apr 2026 14:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=pp1; bh=/B8iiDzQPv
	divl/buJcKUq4lAcbq+Yp2V/5n/G8nloU=; b=gT8ajzhcIXV63I6QId/GAUG7td
	hcN6veZQJ2w8v+dJGkL8t7REsYA/G20xMbikpX0KtmDNMIkRpiVz44D1nAyC+kcY
	fjhEhoc8yaJZWRWjtR3jlOLvVQ4c4ZzHwSg/iMVMNvKhUFc80FYPEZvAWXLW4dlf
	EvgbdC0DmbFtITGQ2+hc5oDljNT3vWXiCE8Sx4qWC8wbtFe/u0MJJ8brGsr1j2oN
	nCF+WJdegY2IMnZEvVcYlaXs0+KmhS9u23/D1mSxza4ApILsoVN+jbRDmO3t8F54
	YUgp0xEQs5PnbKwhHNTDPj2t+Z8/H3TBCbdKMI+w8kN+DLFh2tHY8W+vsaJA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2409v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:37:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MEZPBQ004822;
	Wed, 22 Apr 2026 14:37:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxtm0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:37:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MEbjmv36110838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 14:37:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B2DA20043;
	Wed, 22 Apr 2026 14:37:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB7A720040;
	Wed, 22 Apr 2026 14:37:44 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Apr 2026 14:37:44 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wFYi0-0000000G4RW-2ukc;
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
Subject: [PATCH v4 1/3] PCI: Move declaration of pci_rescan_remove_lock into public pci.h
Date: Wed, 22 Apr 2026 16:37:42 +0200
Message-ID: <c6bf51eafa3af2392f4f1462c7c2791ca19d13e6.1776868550.git.bblock@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzOCBTYWx0ZWRfX5qAqdt7TsJbt
 SnthpVsCTErylbLQ3cvko54l0CPQcYrmAj1zagJYQj7m7oChuQQ9WmPZPDaqXTSx7b/zEGYWBOG
 YAwU9vSqGJ7cPhG+Q+0miZOkMOvzXZUStixxjxIN95eXfvET2Nps+3R+rVoRjc+Zm+dWgAQv0/L
 sjrmqsPIkBJmU4nL/krc86vUEmm0kzFIuOjwSDufF1u8329DPpWyFlpQIOeJmrPyREwSdCBejar
 /rxv81sApB6/W2Rv7ByzpT3a1k1LjRzPjezTK3uyeMH473qoV1gxmgpljjQvdOH4coC5yO9jn2X
 9+NzfCKmGPgE2oD9q0xKfoQ1jl3sURjcghncFMxLonEefWaXrsQXhuUdlhjxCLKEnFtaZXmz/R8
 QPoqyAX2GHYfc1su/OquEZDACbe7mA5xO2yyb5w+XipjJ/EkHCxb4J+WGVsMZRH7EQ5fEd3JSTZ
 /0Ea+Rt1nPUjtVpYc4A==
X-Proofpoint-ORIG-GUID: i-apgRMqPvEPmC_aFkQ9NZi3pKgMWL2S
X-Proofpoint-GUID: n2fVAIjDJtn3MAwfgLwj3_nZYVdYXHv7
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69e8dd3e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=vf2HUNMP9xvVswJDcwYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220138

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
index 13d998fbacce..6d611523420f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -110,8 +110,6 @@ struct pcie_tlp_log;
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-extern struct mutex pci_rescan_remove_lock;
-
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 850a63c175f0..81a7db71ebc3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3509,6 +3509,7 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+EXPORT_SYMBOL_GPL(pci_rescan_remove_lock);
 static const struct task_struct *pci_rescan_remove_owner;
 static unsigned int pci_rescan_remove_depth;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..fd7a962a64ef 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -39,6 +39,7 @@
 #include <linux/io.h>
 #include <linux/resource_ext.h>
 #include <linux/msi_api.h>
+#include <linux/mutex.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -1533,6 +1534,7 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev);
 
 /* Functions for PCI Hotplug drivers to use */
 unsigned int pci_rescan_bus(struct pci_bus *bus);
+extern struct mutex pci_rescan_remove_lock;
 void pci_lock_rescan_remove(void);
 void pci_unlock_rescan_remove(void);
 
-- 
2.54.0


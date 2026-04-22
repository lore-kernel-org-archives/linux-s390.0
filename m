Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471030E0C0;
	Wed, 22 Apr 2026 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867742; cv=none; b=stU2YiWe4R9MqLvcB+3Jx6c5lcN7jzb2Uz5niwsMJ7uB0nMg0+eDLyH/ICAkY619uwfrYaMZwTt4GLtQL0BOpsErqU+FVNu59nAblLAyPkmCMsWUYTJJ9yOXBExy8aI+TvVI3BbsrHCUUXE5EfAVCssCs/Zp/dwwM8YF6ZgwfxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867742; c=relaxed/simple;
	bh=AOgrJvt8eAQd3uhRUBWWqieBYQQirzu5sfsd07wnJ0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rj3Nm5Rmdu0hMb/w27jrTUh2V7Tm2koXpi3m7nP0luoqKlaaeV0DNJir76CkvCEXWaxVufFjkpjkAVJd8wHxfK1f5YF6VHrQS2rNEMN6OaOZnVmpT0ivJBElRLuqxWAy4fz7wRfCnVMYdodzi36uLaFLYrH2q3kIjtGaZUz8exI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eECP0Bj4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eECP0Bj4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M5wtCr2295513;
	Wed, 22 Apr 2026 14:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=pp1; bh=/B8iiDzQPv
	divl/buJcKUq4lAcbq+Yp2V/5n/G8nloU=; b=eECP0Bj4e0Euk5POsppJ3fMUXA
	y8RFQSStie2S/3LD8b05lcugWAKFFpi0C67u8a5x5qwwa4vWH/hjXauyMyHz4hdI
	EHE+4kHy8wQQaV68gGE40475PjA2Xko5WFZ8OGLx44Dph+J6M3y5g3iNOdPABVA5
	Td/UC2lx3aSNlDQMVP42i/rFYs/FuaKpftXz6Hd+ZO1en9vdRQO3ONX95JA7/Off
	iDbENrJSxtVcHGZRuJvtfVlcQ/9PeYUpCywuwP2ij6oQkwT6O5wHN8V/boIRVOQ0
	/NydH+5R4e1MG7B/hNhcV8mxX0Qdb83Jda8/z9PsVsSK1/jxl4tR86ZCIL5w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3kmd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:22:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MEKIQI003174;
	Wed, 22 Apr 2026 14:22:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxtj7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:22:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MEME2f62325132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 14:22:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09B292004D;
	Wed, 22 Apr 2026 14:22:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB38E20040;
	Wed, 22 Apr 2026 14:22:13 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Apr 2026 14:22:13 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wFYSz-0000000FrWp-2w75;
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
Subject: [PATCH v3 1/3] PCI: Move declaration of pci_rescan_remove_lock into public pci.h
Date: Wed, 22 Apr 2026 16:22:11 +0200
Message-ID: <3686615aaecef10c38f6a91f39742412d05bb0f6.1776866921.git.bblock@linux.ibm.com>
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
X-Proofpoint-GUID: g8VGT8nT7JX1-CuTkSOq4kTXeOGBwLF3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzOCBTYWx0ZWRfX6AGCsAzBkvnn
 bXOglQ7IwtbVBSe/v6Wcq1JPb+vyY6fgQdWnPq5nMccutO9C8QE8sQC8Qc9LanyepwgGhugSa+o
 YybfxEamerwDBJ0S4veCaEIac79fu/F5XQVqhKOkwzeSMMLBhOzytNjZTqbEuF+zqBt6zQOSLh+
 TQtwtGSc6P/fp/aHuX/fKHLvSzzGvTUAuqohrRYhaDh6RHX+oU52oBtqGiskI02Li2E7iZ93Suz
 T6f9+4VzDFxVZylUKozPQ4IUmVsxyfw2LXwe/yVLpQf53RiN8cMq5/LCx4+3htdjw8vA9KnvnBF
 TkCiPS68dc2lPDVdkgz/auyBId7LlaFm95PtW315tKYGH87o40e6n8fMNdKB6tcAdS3jWuFkLo3
 D5VuOlbWMw1XPEd9gpsLQByI5IF68mB1ZUTph6xlLI+fJ46bBKi3EqyUidGp49Ac0GVHeiVmpwh
 fI7yeMlAMWp315OjCoA==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69e8d99a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=vf2HUNMP9xvVswJDcwYA:9
X-Proofpoint-ORIG-GUID: 2ueOtlWB3NuzUbPeaYjju9Pay1TykOVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220138

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


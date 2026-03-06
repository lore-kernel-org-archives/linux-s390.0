Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9572B41160F;
	Fri,  6 Mar 2026 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815764; cv=none; b=DDqBoIOL9Tv28W58Tr1NYSxrsoi+Fsy7rzqgJhs9wuw8SWk6Fnmr0p2xHTgPdkBPU6nDnqjhuAQjF3iDUvwo8liYBsJpFotJwkI0wuPu7YLTmbMiFGuqlXXJEXGJmSxjgtv4FXhDREtgEFYOaRtqj/ANKRBLrrQNIzhhJwIvWNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815764; c=relaxed/simple;
	bh=zuvw6mRGe7krq7I+UAVTpV4J/VpduGA4dfhxnOz3sn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oy5uWXgNk7dIH4NR5eWxeA+7u3emI3PYUREEmLIpF8moxOH+q8YSfQZM1GVCMCBV5X/xoyFHayQemK9aCM6wapUQwG75YiPFXkXAnEnK94FJ4wNrxvlxNTzqPg7joP9TI0qIb5tKIt3zdKF+XzW8Yx1il4FnnvJquzNCik7hqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n2KONrtW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n2KONrtW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6267QKmo2397074;
	Fri, 6 Mar 2026 16:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=pp1; bh=hxg/zKnG74
	bP8hf1Ays7K4HHwTT+TiZojKef0W3ZuFk=; b=n2KONrtWJIgkCqtTu9MpTpX3PU
	uUBGzM6D2coyr4RffBqHKAl6ZvEt8nMuppiEv+0rDn9zcF+lbAS06xciMbiiosbj
	3Igq3fsCzGCHAMKGI5JPwo09uZhCzjk7NnpQnGwB3q+r9+lI3gLeL9eFStv1PbOF
	8U6B32KP/4Mvv6hG6R1A6uKOrIeEL7cONNjQf8/Dr8Pn3hGz81COR0oYJQ7kUe9l
	r5y01qtXEioFTVRl8LQ2bUjm52PC27Itt1/06mhBiYEQeT9VIeLg9CU2/LhnH1LP
	h01qkUXHv/Rv+PO/QOOTmqZ69wYeC8DADBBc2sKMKidiD530RNPRSToZ5I1w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrjhmgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 16:49:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626Ctr7Q029112;
	Fri, 6 Mar 2026 16:49:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmapsguew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 16:49:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626GnHn550987308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 16:49:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F2E52004B;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49CDB20040;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vyYMX-00000005i36-02WT;
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
Subject: [PATCH 1/4] PCI: Move declaration of pci_rescan_remove_lock into public pci.h
Date: Fri,  6 Mar 2026 17:49:13 +0100
Message-ID: <9afaf022cb8e37241c4d2e5356cb262266b0bf3d.1772815642.git.bblock@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69ab0592 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=acfJzRXfimrUt77ygewA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1OCBTYWx0ZWRfX6fykfw3A7Fcv
 CqwR7zhrd0znJlMFEuP4P0vPpeUe0Bx9LhiaR6Ds8yTLFqQR1i1dCbNTX14F6/hadNvEzPboTWR
 0R4E/vGcJ818O8B3nM+a2EpqNr/qJZEKm0O4/F8+5bRA6oUGRSnoMo/95R1mXi0d0R6HAyDmrSi
 x+RqlW78CouhaDuW/RF2tXxKPwuzlas/SodaSl9syCAb7HAREY/AH5C9rbl+P1OYQZfagF8Ue3y
 ESJhzjkCyQcuOquOvzdSNFn/Ps8MM8uL/HjAKyDNu+gGUfaQj+63JK6uhrDMSEIbAlZwvEXvgG7
 qLfeqlysQngiETaJhBlwytJHNhfJlyyY6a2pBZKqHLVtmDXnIcHug7ISzZDDSRPa4BqKJOpP8Zp
 nAKB0YaHdQfFPhIyrbReBnvZ7vRdI7riZgazo+p8thQTnIA/YDKzEmirCt+GPEmTqYKN9oYqLLu
 hQntCUp3rsw5lnHr96Q==
X-Proofpoint-GUID: mhiJwRwOZFQH8oBXHzq35xZ8nc06BUGQ
X-Proofpoint-ORIG-GUID: OwQaR1Wtsl0oJtlwrIj-Zw2Wdj04hYac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060158

So far it is possible to use and call the functions
pci_lock_rescan_remove() and pci_unlock_rescan_remove() from any PCI
code, including modules and architecture code; but the lock
`pci_rescan_remove_lock` itself is private to objects residing in
`drivers/pci/` via the header `drivers/pci/pci.h`.

With that setup it is not possible to use lockdep annotations such as
lockdep_assert_held(), or sparse annotations such as __must_hold() in
modules or architecture code for PCI.

Since it is useful for `pci_rescan_remove_lock` to have such
annotations, move the variable declaration into `include/linux/pci.h`.

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
index bccc7a4bdd79..e5b12878e972 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3509,6 +3509,7 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+EXPORT_SYMBOL_GPL(pci_rescan_remove_lock);
 
 void pci_lock_rescan_remove(void)
 {
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
2.53.0


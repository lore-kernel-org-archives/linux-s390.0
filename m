Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A631AF1B;
	Wed, 11 Mar 2026 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235679; cv=none; b=l1YbUfU009Auw3AwOjxNrojG2st4aF+3ACGQHhiMRsRFoKTs/5igl61qKyGNda3Rs8debS5kNIhXY+wOBO6P60QRINKU/MDcCTGXt50Go4cDfUIfi+Owa52eVDDWVX6BPX5zqG/qKQjGJECAdgvG2A82QPF5QHQ2zAR8BhlLdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235679; c=relaxed/simple;
	bh=ojkmc1O/iVrw5QvN5vOI5XGosJie2J9egrshtD19wRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMqH+e9ySduSoxbxnBK1zbLtbtmvuRVAQfay07l5v/HIBjPY9D6hZ4Rpfi6oANfOdDPpXSZ0fNo3FJ7bSrFOSjckIyaY6DsIem3qIQcnRzQJzRrXJk60La4CXi/B05ObJ/5P3/BMoZLHGSf7XLjwRrTUPPqzN/FXJpvkh2/nv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LWi9Gm63; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LWi9Gm63"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ALJhm51237000;
	Wed, 11 Mar 2026 13:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=pp1; bh=v12UnWacSu
	kRAwpPiLST1JBJ6l9mHvVtQYE5aNqJOKo=; b=LWi9Gm63XS10kscWJgQGn6ny7O
	+mj/Lel44sLQeBUwIqwP6AOv9JBMTqvqn1TY/UJEdl93/2w+IrIvspNcgFFRKdfK
	L65pYtBFKQFo1ibpHf7PCVxEGk+Lgj1X1edT4mIDQDYK51W9iswom0gFLR0GKUbO
	SrL5ZU9NGmu62UuG7xQJOo+ozAo0Afuf0Pc+a+d71q5r4k8f3KKYEXXTcgIEGkj4
	uHcFwLuIpPV4EINVj4hkP0U9nbbFVjugTtnHXvEYIiOXdcNzD0Vy27tO7YtYWYUM
	QGah12QgNFiDWeG11wQrH6jHX0OesXGAueMo91CbgXY6mHKyDDeRm4sVc0Sg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mqgpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:27:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BDCOQW025052;
	Wed, 11 Mar 2026 13:27:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk5duc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:27:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BDRpFu17039764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 13:27:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 014552004E;
	Wed, 11 Mar 2026 13:27:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E10CB2004B;
	Wed, 11 Mar 2026 13:27:50 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Mar 2026 13:27:50 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1w0JbK-00000008V4R-2mAv;
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
Subject: [PATCH v2 1/3] PCI: Move declaration of pci_rescan_remove_lock into public pci.h
Date: Wed, 11 Mar 2026 14:27:48 +0100
Message-ID: <e9f46b25e5b47ec1d8fdca33b10346bc6de23445.1773235561.git.bblock@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69b16ddc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=vf2HUNMP9xvVswJDcwYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExMCBTYWx0ZWRfXyy9F7LfA7Pnj
 aj6AeYxkyNugVf+FoSjkZnxSwk3EfEuXZg6IksNlwiP2huW87W37C2+N/gTK+3pqlaaK9goChBP
 MnStgtfPZLEbdCln9t29FIbsxxm+cP/Kg8gTkxiukin2PQIZ7ITH39/1S7QNoYmQni4C1VAos01
 Z2W8ucs9Za3EQbHjESCb5a8RD2ARqwGO9UuosT4q3tXNx4qsC3QnZegP9qxVA0bVz7pHi7MLITH
 XttxFeO4hM09V7vt/PPuAskw8RdjvEvwSc4uI5gX+awj6AJgoqytltQki3wjgkyACHPTtMgOZju
 QDs55JpG9+mCKC/2P2QCCW06gxD1CNX9nRE1VBEHmunVP7F5C1KESBFXpR5QEMAXnwFipPgsOm0
 Gcqb3rna4uv0vtQM0xAeGfzkqB5dnqiCi0w08eW5nxYoz9Cui9JXG7DyD/sSPZsyc4GoBEj2oSf
 LcYu8vsLL1rft+soLyw==
X-Proofpoint-GUID: Or0kII9nvfl59S-E7NSU-dbSBoug22TV
X-Proofpoint-ORIG-GUID: GkzOiCd3X2MmloVmJ8jdpA6GODkboARw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110110

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


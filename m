Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49FD46AA8B;
	Thu, 24 Sep 2026 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267405; cv=none; b=oyPW2TVRbnyWcrRq3tMv7WT7eaPWmBhrOAohO+1JSHdu11V9c+CIXpD5NeQwvb9cjGPJbBL1jRs136n5MvBQBhyR5coaE4WWoYnMIgnnAUYs27/4frPLknB8jJK2GOdVgH+Y2qrwNZdZL/fB9/VTufLjKDA6xbYRN8sQHHFMR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267405; c=relaxed/simple;
	bh=7oxpPFINSUhxaRT3cM9OvJ+mzb/FVL/zKF4ZGZYnzk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJI/PU8RtwHJcBa939tk4WWH/zEgdekHDVCMkfBgNWuVrqrr9E6uPbN/I+nnfNHmEEmcsTrlhfyWFI2XkrR8ldX1+23s8D3le4IjEQCI94Od2xzPAVk39R7Enk/CdT+klqe4LSYuW0qNIOfSahZSTLC+aIlZAKGqwahFRPlzZgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ecXpusaU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ecXpusaU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OG5cbL2730496;
	Thu, 24 Sep 2026 16:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=pp1; bh=pfV/N3ITI2
	SzwnoDUzkRUm6JbEdTEiLhJaxZHRVcrhM=; b=ecXpusaUboRVML2uvng+OgPoou
	djBgduNohS0KFsL7LYCl0eMZHlVez6fRAFGUqIrupSK8s1aBuOSfOKE8gCcpkMZZ
	5Zb07WoIueJ9pBt1LQNf34mDhsOoR2F/WS6Kw906cBzQ84eb/DCvQpzSLzQdJSUv
	cZoLFd1X5rcarOGsj3OPniqD3mqShNz3Dh3SRW4liLqF3OGOBWg/1+OHLMUJvh4a
	pFTY6K48WjbuNBCynY4eqjZIw7cWf95P8bH2Vd0X9bwB/vAYx9VufWRiOuTEBAX1
	mANiYd0V0Leu6+mdUZBf1ZtPjMNgnkvZS8NvyD2GvvTidHr/CUgYIlFLdIJQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvhhdj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:29:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFlUjQ1019556;
	Thu, 24 Sep 2026 16:29:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7eavtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:29:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OGTW1H51315168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 16:29:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 158322004E;
	Thu, 24 Sep 2026 16:29:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE2E120043;
	Thu, 24 Sep 2026 16:29:31 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 16:29:31 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1x9mKB-000000094DN-3954;
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
Subject: [PATCH v15 4/5] PCI: Provide lock guard for pci_rescan_remove_lock
Date: Thu, 24 Sep 2026 18:29:30 +0200
Message-ID: <33e55a5db13f7ed16234774803e8f0ec03ae8c5b.1790267348.git.bblock@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Ujtc9mNrH-vujbJI1sjBFKcYZx6fXRx9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfXxn/v5knK7VR9
 PZYkxr8VvlgVxcRbN5seDURvuRdZhSLkb1YuOgzDNbNOGPpu89YyK+Wovji7t+sBBWrbSRj8vmR
 knMyhIdTIuGjzzThy305SoP95sHCIio=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab54ff1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=qAR2Z3AMSIpdRBh0OscA:9
X-Proofpoint-GUID: 1A7fTvtIHwhImyeJ_ZZ7UXdWhq8FmQND
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX48Gh5Qkbh+Qw
 L3VoRfLaQszpnh8OBeG5sU8OdY83dZs9C9zrjExCK8p71Ttl6sTEt4h5LjIg8ptsNCrYsJ4WQtv
 PZvdgq5eW+6hTfYZLv1tRqjhJtYwMEro/QEZWm2LJTQRy0UDmPSq5RR6GG8HVQ3D9ihvs7sSU57
 dKt9NoVptIlxinza4ZGbyJ5ucyPeSVMKK2IJrZqi99vL1zpcKuQcGY+R7uFaQdWLIyf/f8T22aQ
 dahTkXLRbes1Xpj4iE1EZrr9rjBRP3ukOZDEYeAOgrIKt32TAehATm2E+rZNY1O1ojV542bL2r2
 pDXOMt03riG0cVz2NKQg2+RsWT/Bxel7qRq8Atz8JQxo3XNQlYAegKqFEvjWxtDNTC7v0cPYfmv
 9nmCjZlCfOj+WmL0RC43bHsNqkRb95BQegXZo9gede7U26t39T+ED1CFsgZaXd7qNHe3pQrkJut
 U+DeJG5gFxdC17ckmzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240066

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
index d704a32ff988..a0e36b7acac0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -42,6 +42,7 @@
 #include <linux/msi_api.h>
 #include <linux/mutex.h>
 #include <uapi/linux/pci.h>
+#include <linux/cleanup.h>
 
 #include <linux/pci_ids.h>
 
@@ -1555,6 +1556,8 @@ unsigned int pci_rescan_bus(struct pci_bus *bus);
 extern struct mutex pci_rescan_remove_lock;
 void pci_lock_rescan_remove(void);
 void pci_unlock_rescan_remove(void);
+DEFINE_LOCK_GUARD_0(pci_rescan_remove, pci_lock_rescan_remove(),
+		    pci_unlock_rescan_remove());
 
 /* Vital Product Data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
-- 
2.55.0


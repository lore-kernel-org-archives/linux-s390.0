Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412843BDDD;
	Thu, 24 Sep 2026 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267402; cv=none; b=NHdpTI0PRncZ9TnjSfG5PbApRfA3FadVJZ/W7bVN1QSFOCCEJ1PficXnVpnBadvb0VFsqhiwxVBQlniLdCc7x5+k8260o9Gr9prrvLqF5MUKqP5YPGWsJVh177ZQXZsOI9h6ka6+uB+cWyGZSiFTwXrlBh+H8qROre8mC56hKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267402; c=relaxed/simple;
	bh=jX3owEl/wow6VhNrSLFoibeDtB8Hsc8XajGD9c+bKSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lICt3MGoVvMkPB5nXJc3oDInDlSspC//r2nYDr3jntpbK7Rbh20qeBzWVj22idxvYBn0WQCoKOteHKcEboxVz2EA2E90PBNzuRqookzZH+2QSjxJeU2JBHhaSq9Kd02ZUQg4yoRIUDnPNT2aw9EaxbtxYE8988+I395Y2BrBTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gJSe9WOp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gJSe9WOp"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OG5LZJ825034;
	Thu, 24 Sep 2026 16:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=pp1; bh=pRuQLBERAR
	3MTkySYBCt0e35VR1SOiA2wVOX4AmhXSg=; b=gJSe9WOpWhp2k442w7CzaTyGij
	yjIacxizpsEBFxHCj5/qqAV65P7UUmFzHI+xgNNKcmOgqS6uVMNlpyPofVnQ3vra
	jmi/Rqg7FjWX1CW/oq6Hny1ZudjtkbsTlWdTuHVfXRiSkYw0mDYzVHMVthSUMa2v
	qCm9+iRjUgPmukAg5OlLxJwcT3SllkR110K9k5lyOar62p83+n2vLLw1MPkXD6mY
	rl9FQolAg+YFEjGgwd8IvWElWNrQ94EN8XjIAArXkc9oVkJMHEm0lsfFSgr0P5sO
	r/Hcaw/XHRGwh2HwNI2uwTr9tnIGi2YM7CLbUMszLRFBtqc/BJEYE/Akb9BA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske229rq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:29:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFlV6D2307342;
	Thu, 24 Sep 2026 16:29:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2xjg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:29:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OGTWWV53346752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 16:29:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C5C720043;
	Thu, 24 Sep 2026 16:29:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E239D20040;
	Thu, 24 Sep 2026 16:29:31 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 16:29:31 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1x9mKB-000000094DE-2w3C;
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
        Benjamin Block <bblock@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v15 1/5] PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect sriov_add_vfs/sriov_del_vfs
Date: Thu, 24 Sep 2026 18:29:27 +0200
Message-ID: <3e3bfc04a89459de57c4783734ff56e4ec979db0.1790267348.git.bblock@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 5pPW0UFM_sub4Hpuklk4lmhZCyQM2Sl7
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab54ff1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hh5_vNSPTWDFZ6TSUYYA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfXxrQV/cKXmOjq
 S0Clu+GWvfs5QwIXDbrydoGmMaYE+Sem0vIz89qaDCfN+Xf3oW83aPhj70bRuLKfVNtzQFJVthS
 XeV1uYN+vBXBB+CIvEWX/eRhyu3XqAk=
X-Proofpoint-GUID: -rQYvwVn-ZIcMN_fYiIaMMz2yDcMpTmu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfXwN8XN0vE+j8Z
 KwdWZK1flYyrdAKW9882x89UMRTrZpji5KIrBSVVV0Y+6EoRvANv0InM4fF/mmjq1/ZC6KDM8tL
 H05yZJyjJaZkKWVtW1+b8dwKACMbHA84k68aMdUvmfrT3RaEvKQEhDpqDV9uq2T7dlLqN9v7TGD
 lCbszE7hCpr5tKLkDDHWhIg/6djLTP5oBYPb489suQamY9Kt+8oMcUipjjTET/7NBsm+xcmDx+6
 oNi/7XhmK5iTkqQShgW2K9psjB+rFCKltaKuEYNow7Vswx8F0P7M65XSUMSFKstgOpFMalS+HOx
 JA00fjV5VXkJECRorRr3ojZBSWDRY/JmXxdlo+0fUwKMwsbOkDJ3t98JFFFIPFXzHJrXKPBQ6PW
 vsn2/4GqHp/r6/r7anSji3OowwHOGEOzm+hdFnVMkjAZoHDJQ8vSaTKRO/grQzqa6yJZbEC0CrD
 DHTYj+kA0iaKbSnCmEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240066

From: Ionut Nechita <ionut.nechita@windriver.com>

After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
locking when enabling/disabling SR-IOV") and moving the lock to
sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
or manual unbind) that calls pci_disable_sriov() directly remains
unprotected against concurrent hotplug events. This affects any SR-IOV
capable driver that calls pci_disable_sriov() from its .remove()
callback (i40e, ice, mlx5, bnxt, etc.).

On s390, platform-generated hot-unplug events for VFs can race with
sriov_del_vfs() when a PF driver is being unloaded. The platform event
handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
leading to double removal and list corruption.

We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
be called from paths that already hold pci_rescan_remove_lock (e.g.
remove_store -> pci_stop_and_remove_bus_device_locked, or
sriov_numvfs_store with the lock taken by the previous patch). Using
mutex_lock() in those cases would deadlock.

Make pci_lock_rescan_remove() itself reentrant by tracking the current
owner task and a recursion depth counter, as suggested by Lukas Wunner
and Benjamin Block, since these recursive locking scenarios exist
elsewhere in the PCI subsystem:
 - If the lock is already held by the current task (owner == current):
   increments the depth counter and returns without re-acquiring,
   avoiding deadlock.
 - If the lock is held by another task: blocks until the lock is
   released, then records the owner and sets depth to 1.
 - If the lock is not held: acquires the mutex normally.

pci_unlock_rescan_remove() decrements the depth counter and releases
the mutex (clearing the owner) only when the depth reaches zero.
A WARN_ON catches mismatched unlock calls from tasks that do not own
the lock.

This avoids relying on mutex_get_owner(), which is not exported to
modules and caused link failures for builds that inline this code
outside of the core kernel image.

This approach keeps the API unchanged: callers simply pair lock/unlock
calls without needing to track any return value or use separate
reentrant variants.

Add pci_lock_rescan_remove()/pci_unlock_rescan_remove() calls to
sriov_add_vfs() and sriov_del_vfs() to protect VF addition and
removal against concurrent hotplug events.

Remove the rescan/remove locking from sriov_numvfs_store() that was
introduced by commit a5338e365c45 ("PCI/IOV: Fix race between SR-IOV
enable/disable and hotplug"), since the locking is now handled directly
in sriov_add_vfs() and sriov_del_vfs() where it is actually needed,
reducing the lock scope.

Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")
Cc: stable@vger.kernel.org
Suggested-by: Lukas Wunner <lukas@wunner.de>
Suggested-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
[bblock@linux.ibm.com: rebase on v7.3, READ_/WRITE_ONCE changes, comments]
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/pci/iov.c   |  9 +++++----
 drivers/pci/probe.c | 27 +++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9d408fb8ac25..885855650dbf 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -495,9 +495,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 
 	if (num_vfs == 0) {
 		/* disable VFs */
-		pci_lock_rescan_remove();
 		ret = pdev->driver->sriov_configure(pdev, 0);
-		pci_unlock_rescan_remove();
 		goto exit;
 	}
 
@@ -509,9 +507,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 		goto exit;
 	}
 
-	pci_lock_rescan_remove();
 	ret = pdev->driver->sriov_configure(pdev, num_vfs);
-	pci_unlock_rescan_remove();
 	if (ret < 0)
 		goto exit;
 
@@ -633,15 +629,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	if (dev->no_vf_scan)
 		return 0;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
+	pci_unlock_rescan_remove();
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 
 	return rc;
 }
@@ -766,8 +765,10 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..cff9f0bf4c4b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3510,16 +3510,39 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+static const struct task_struct *pci_rescan_remove_owner;
+static size_t pci_rescan_remove_depth;
 
 void pci_lock_rescan_remove(void)
 {
-	mutex_lock(&pci_rescan_remove_lock);
+	if (READ_ONCE(pci_rescan_remove_owner) == current) {
+		/*
+		 * read and modify while &pci_rescan_remove_lock is held by
+		 * current thread
+		 */
+		pci_rescan_remove_depth++;
+	} else {
+		mutex_lock(&pci_rescan_remove_lock);
+		WRITE_ONCE(pci_rescan_remove_owner, current);
+		pci_rescan_remove_depth = 1;
+	}
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
 
 void pci_unlock_rescan_remove(void)
 {
-	mutex_unlock(&pci_rescan_remove_lock);
+	if (WARN_ON(READ_ONCE(pci_rescan_remove_owner) != current))
+		return;
+
+	/*
+	 * read and modify while &pci_rescan_remove_lock is held by current
+	 * thread
+	 */
+	pci_rescan_remove_depth--;
+	if (pci_rescan_remove_depth == 0) {
+		WRITE_ONCE(pci_rescan_remove_owner, NULL);
+		mutex_unlock(&pci_rescan_remove_lock);
+	}
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
-- 
2.55.0


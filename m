Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A5413791;
	Thu, 24 Sep 2026 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267401; cv=none; b=A9fgDLxWggQQBYAvnyxJUThAGsqo++xyfu8OBeGIvu0ul9qdtq9GThE8KznWeVCKs704v0qqcnPiAnxt2K79/wqEU6FeOkiAufX6Dl0a63bGzMIHcsMjEWmGUUw5aEWSVU539hL5ZoT2Q4CbTQ1JrfwAqkgnu17fPOyvW8wXheM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267401; c=relaxed/simple;
	bh=9jfMsNk9akWPwe0IiXXBzbYQl1P4W3soEary6GoUjWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sS9rS4LDKgcYsXtFAN5R3r092KBbCG8j2rb/FZvqbHW9EGiAzzN9utTMXNdqjmldpaKsB0GtbReW3lr9tJEABUf8ZKOso/EBD2Qlj6fdzSVqun64O4TxRAd8ak7Nn+5rYtF1IzCZf707P3jWYmf/QiSUdOGqPD/vZQ5hFzaS+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ll7pA9TG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ll7pA9TG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OG5MXk825063;
	Thu, 24 Sep 2026 16:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=VUq2GbGsrpRuCcrI7n2aLJ3DGjDy/tlAFPx7q8eG2og=; b=Ll7pA9TGCORD
	WYqSfZksX/4C+N/kaQv9CBwUxVDwMOTenWMTlxB9LY8FOCbcvGBFjJ7DE+LFjE06
	DrL8BcA4AKW5IOWR9FI6gXrrvrOYakJfApFB1I8b5+aECasQWdU6esYIubapPFpy
	YLxW1uXzLai80ya8jlVZMZWbKJgaizLKF+k+aDKRtKygAaFd7FTLz9tdKdtsRiBX
	7JwiWy0K92cWluPGPr4LA64LfRU2+cPU166PIW8FnCvVm9yLpoqtwiTxKbV4QCF0
	zFs1M2EXrShMVLurGjfgDCQszPpaHCJnhjQryGsgaatNlVB2O3WilyVmQKBkyccE
	Rpv6R4vpzQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske229rp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:29:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFlUfK2301584;
	Thu, 24 Sep 2026 16:29:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8xjac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:29:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OGTWuW16122290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 16:29:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23D222004E;
	Thu, 24 Sep 2026 16:29:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F03B420043;
	Thu, 24 Sep 2026 16:29:31 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 16:29:31 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1x9mKB-000000094DQ-3DQA;
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
Subject: [PATCH v15 5/5] s390/pci: Fix circular/recursive deadlocks in PCI-bus and -device release
Date: Thu, 24 Sep 2026 18:29:31 +0200
Message-ID: <845f3fd0e94294765ea10454823c21e464d2f4bd.1790267348.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790267348.git.bblock@linux.ibm.com>
References: <cover.1790267348.git.bblock@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: IBM Deutschland Research & Development GmbH, https://www.ibm.com/privacy, Vors. Aufs.-R.: Wolfgang Wendt, Geschäftsführung: David Faller. Sitz der Ges.: Ehningen, Registergericht: AmtsG Stuttgart, HRB 243294
Content-Transfer-Encoding: 8bit
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: jzlC5ypWuzCc2YyByrQjl0Q7YJQWDKL0
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab54ff1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8WQ6pR0vsFU20fZEhjUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX889Ja00XyGLj
 tjbM6kurjxR6PS4otBXvm32mLltsCT3MITtDhhTNKJ14ygnUGBY54AWWusCnStomW6UfAewcKq4
 zI2RHKefrMmVg5SzDTV0KRaER2R103Q=
X-Proofpoint-GUID: zN7NXSVQ1NQ-ZXbWa5v_DCxTOgIZ9ZbI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX0a5wJ1B9QUJD
 M5eZKhT/q+egqPvyfLGBJR09WqgnJ4KEa1kSZ2thbVu4AZwwYlpHCv8f/CCOuUV58iaXzW+GCsb
 +rslAL6Edfcbl95dGF6ezTTWRJTJxiUJsRUpWfoBz/XLtQFoUQbLr30qHaQRM54pIW4S2a/tjNJ
 VUAbrG5W0a+u/0mKV2+xKQOHZsf07DX6gfK69GoTYveB5bqg764rxdw1bloyC41X5QsGRBhACC2
 5Ve8W07jy3DgE1nB4s4kxhoNdlMyEVwVcK0LpW3YNNSAjryvLpSaRevLR3Pm34tYrB0wUKIv2G7
 /6Q/er+QKUwPt7iU6Wx8YRb7zawLhJkngcZtfDA8dgGa0gEo7GLp0towXb8JdAOjGRv9CXlUmwF
 ImAlkzBRdNn+UUsojJsptf4v6qIh34bT+dq4v5+IzXLeTfQicyc6JzhA8ukluBJvcyxTEYUKDTv
 epqijK1GArCJTZkA94Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240066

When removing PCI device or PCI bus objects there are a couple of
call-chains where it is possible that the kernel runs into a circular
deadlock involving the central `pci_rescan_remove_lock`.

Two examples:

(A) Thread α receives a PCI event notifying the kernel that a PCI
virtual function has been moved into Reserved state, and so the PCI
subsystem will try to remove that PCI function. The call-chain for that
looks like this:
  __zpci_event_availability()
    -> zpci_zdev_put()              # will   lock(zpci_add_remove_lock),
                                    # and    lock(zpci_list_lock)
    -> zpci_release_device()        # will unlock(zpci_list_lock)
    -> zpci_cleanup_bus_resources() # will   lock(pci_rescan_remove_lock)

Thread β is triggered by userspace writing 0 into the SysFS attribute
`sriov_numvfs` of the parent PCI physical function of the same function
we just try to remove. This will also try to release the PCI virtual
function; but this time the call-chain looks like this:
  sriov_numvfs_store()
    -> ... (device driver dependent)
    -> sriov_disable()
    -> sriov_del_vfs()              # will   lock(pci_rescan_remove_lock)
    -> ... (deep chain)
    -> pci_release_dev()
    -> pcibios_release_device()
    -> zpci_zdev_put()              # will   lock(zpci_add_remove_lock)

If thread α and β coincide, this will result in a cyclic deadlock.

(B) Thread γ receives a PCI event notifying the kernel that one or more
PCI functions got hot plugged, and need to be configured. A possible
call-chain that might happen while the PCI subsystem is trying to add
those new function looks like this:
  __zpci_event_availability()
    -> ... (multiple ways in which a device gets added)
    -> zpci_add_device()            # will   lock(zpci_add_remove_lock)
    -> zpci_bus_device_register()
    -> zpci_bus_put()               # will   lock(zbus_list_lock)
    -> zpci_bus_release()           # will unlock(zbus_list_lock)
                                    # will   lock(pci_rescan_remove_lock)

Now the same thread β as above in (A) might coincide, and again could
result in a cyclic deadlock.

`pci_rescan_remove_lock` has to be and is taken at a "high level" in
most call-chains since it is intended to protect/mutual exclude all
rescan and/or removal actions taken in the PCI subsystem. So to prevent
the outlined deadlock scenarios above remove it instead from the "low
level" release functions for both the PCI device and PCI bus objects.

Instead, lock `pci_rescan_remove_lock` in all call-chains leading to
those release functions:
  * initialization of the PCI subsystem;
  * processing of availability events (CRWs) for PCI functions;
  * processing of error events (CRWs) for PCI functions;
  * architecture specific release PCI device implementation.

Additionally, remove `pci_rescan_remove_lock` from zpci_bus_scan_bus()
since its only caller zpci_scan_devices() is now always called with
`pci_rescan_remove_lock` already held.

Lastly, document the new locking expectations after these changes. Add
sparse and lockdep annotations to functions that previously locked
`pci_rescan_remove_lock` explicitly, making sure the lock is now
already held when called. Additionally also add the annotations to
zpci_zdev_put() and zpci_bus_put() to make sure that every function that
potentially drops the last reference already holds the lock to prevent
surprises.

Fixes: 05bc1be6db4b2 ("s390/pci: create zPCI bus")
Fixes: ab909509850b2 ("PCI: s390: Fix use-after-free of PCI resources with per-function hotplug")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 arch/s390/pci/pci.c       | 11 ++++++++---
 arch/s390/pci/pci_bus.c   | 15 ++++++++-------
 arch/s390/pci/pci_event.c | 28 ++++++++++++++++++----------
 arch/s390/pci/pci_iov.c   |  3 +--
 arch/s390/pci/pci_sysfs.c | 25 ++++++++++++-------------
 5 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index d64c544b32b0..4fc3e3dc87ad 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -71,9 +71,11 @@ struct airq_iv *zpci_aif_sbv;
 EXPORT_SYMBOL_GPL(zpci_aif_sbv);
 
 void zpci_zdev_put(struct zpci_dev *zdev)
+	__must_hold(&pci_rescan_remove_lock)
 {
 	if (!zdev)
 		return;
+	lockdep_assert_held(&pci_rescan_remove_lock);
 	mutex_lock(&zpci_add_remove_lock);
 	kref_put_lock(&zdev->kref, zpci_release_device, &zpci_list_lock);
 	mutex_unlock(&zpci_add_remove_lock);
@@ -583,11 +585,13 @@ int zpci_setup_bus_resources(struct zpci_dev *zdev)
 }
 
 static void zpci_cleanup_bus_resources(struct zpci_dev *zdev)
+	__must_hold(&pci_rescan_remove_lock)
 {
 	struct resource *res;
 	int i;
 
-	pci_lock_rescan_remove();
+	lockdep_assert_held(&pci_rescan_remove_lock);
+
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		res = zdev->bars[i].res;
 		if (!res)
@@ -600,7 +604,6 @@ static void zpci_cleanup_bus_resources(struct zpci_dev *zdev)
 		kfree(res);
 	}
 	zdev->has_resources = 0;
-	pci_unlock_rescan_remove();
 }
 
 int pcibios_device_add(struct pci_dev *pdev)
@@ -630,6 +633,7 @@ void pcibios_release_device(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
+	guard(pci_rescan_remove)();
 	zpci_unmap_resources(pdev);
 	zpci_zdev_put(zdev);
 }
@@ -1208,7 +1212,8 @@ static int __init pci_base_init(void)
 	if (rc)
 		goto out_irq;
 
-	rc = zpci_scan_devices();
+	scoped_guard(pci_rescan_remove)
+		rc = zpci_scan_devices();
 	if (rc)
 		goto out_find;
 
diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 36a4807285fa..c1b48b572e86 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -82,9 +82,8 @@ int zpci_bus_scan_device(struct zpci_dev *zdev)
 	if (!pdev)
 		return -ENODEV;
 
-	pci_lock_rescan_remove();
+	guard(pci_rescan_remove)();
 	pci_bus_add_device(pdev);
-	pci_unlock_rescan_remove();
 
 	return 0;
 }
@@ -132,10 +131,13 @@ void zpci_bus_remove_device(struct zpci_dev *zdev, bool set_error)
  * Return: 0 on success, an error value otherwise
  */
 int zpci_bus_scan_bus(struct zpci_bus *zbus)
+	__must_hold(&pci_rescan_remove_lock)
 {
 	struct zpci_dev *zdev;
 	int devfn, rc, ret = 0;
 
+	lockdep_assert_held(&pci_rescan_remove_lock);
+
 	for (devfn = 0; devfn < ZPCI_FUNCTIONS_PER_BUS; devfn++) {
 		zdev = zbus->function[devfn];
 		if (zdev && zdev->state == ZPCI_FN_STATE_CONFIGURED) {
@@ -145,10 +147,8 @@ int zpci_bus_scan_bus(struct zpci_bus *zbus)
 		}
 	}
 
-	pci_lock_rescan_remove();
 	pci_scan_child_bus(zbus->bus);
 	pci_bus_add_devices(zbus->bus);
-	pci_unlock_rescan_remove();
 
 	return ret;
 }
@@ -214,11 +214,12 @@ static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *fr, s
  * run of the function.
  */
 static inline void zpci_bus_release(struct kref *kref)
-	__releases(&zbus_list_lock)
+	__releases(&zbus_list_lock) __must_hold(&pci_rescan_remove_lock)
 {
 	struct zpci_bus *zbus = container_of(kref, struct zpci_bus, kref);
 
 	lockdep_assert_held(&zbus_list_lock);
+	lockdep_assert_held(&pci_rescan_remove_lock);
 
 	list_del(&zbus->bus_next);
 	mutex_unlock(&zbus_list_lock);
@@ -229,14 +230,12 @@ static inline void zpci_bus_release(struct kref *kref)
 	 */
 
 	if (zbus->bus) {
-		pci_lock_rescan_remove();
 		pci_stop_root_bus(zbus->bus);
 
 		zpci_free_domain(zbus->domain_nr);
 		pci_free_resource_list(&zbus->resources);
 
 		pci_remove_root_bus(zbus->bus);
-		pci_unlock_rescan_remove();
 	}
 
 	zpci_remove_parent_msi_domain(zbus);
@@ -250,7 +249,9 @@ static inline void __zpci_bus_get(struct zpci_bus *zbus)
 }
 
 static inline void zpci_bus_put(struct zpci_bus *zbus)
+	__must_hold(&pci_rescan_remove_lock)
 {
+	lockdep_assert_held(&pci_rescan_remove_lock);
 	kref_put_mutex(&zbus->kref, zpci_bus_release, &zbus_list_lock);
 }
 
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index f317a1465dad..268f435677ae 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -382,6 +382,7 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 	pci_dev_put(pdev);
 no_pdev:
 	mutex_unlock(&zdev->state_lock);
+	guard(pci_rescan_remove)();
 	zpci_zdev_put(zdev);
 }
 
@@ -428,6 +429,7 @@ static bool zpci_event_avail_any_device(struct zpci_ccdf_avail *ccdf)
 	if (ccdf->pec != 0x0306)
 		return false;
 	/* 0x308 or 0x302 for multiple devices */
+	guard(pci_rescan_remove)();
 	zpci_remove_reserved_devices();
 	zpci_scan_devices();
 	return true;
@@ -436,26 +438,29 @@ static bool zpci_event_avail_any_device(struct zpci_ccdf_avail *ccdf)
 static void zpci_event_avail_new_device(struct zpci_ccdf_avail *ccdf)
 {
 	struct zpci_dev *zdev;
+	bool freed = false;
 
 	switch (ccdf->pec) {
 	case 0x0301: /* Reserved|Standby -> Configured */
 		zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_CONFIGURED);
 		if (IS_ERR(zdev))
 			break;
-		if (zpci_add_device(zdev)) {
-			kfree(zdev);
-			break;
-		}
-		zpci_scan_configured_device(zdev, ccdf->fh);
+		scoped_guard(pci_rescan_remove)
+			if (zpci_add_device(zdev)) {
+				kfree(zdev);
+				/* break; is incompatible w/ scoped_guard() */
+				freed = true;
+			}
+		if (!freed)
+			zpci_scan_configured_device(zdev, ccdf->fh);
 		break;
 	case 0x0302: /* Reserved -> Standby */
 		zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_STANDBY);
 		if (IS_ERR(zdev))
 			break;
-		if (zpci_add_device(zdev)) {
-			kfree(zdev);
-			break;
-		}
+		scoped_guard(pci_rescan_remove)
+			if (zpci_add_device(zdev))
+				kfree(zdev);
 		break;
 	}
 }
@@ -497,11 +502,13 @@ static void zpci_event_avail_existing_device(struct zpci_dev *zdev, struct zpci_
 		/* The 0x0304 event may immediately reserve the device */
 		if (!clp_get_state(zdev->fid, &state) &&
 		    state == ZPCI_FN_STATE_RESERVED) {
+			guard(pci_rescan_remove)();
 			zpci_device_reserved(zdev);
 		}
 		break;
 	case 0x0308: /* Standby -> Reserved */
-		zpci_device_reserved(zdev);
+		scoped_guard(pci_rescan_remove)
+			zpci_device_reserved(zdev);
 		break;
 	}
 }
@@ -523,5 +530,6 @@ void zpci_event_availability(void *data)
 	mutex_lock(&zdev->state_lock);
 	zpci_event_avail_existing_device(zdev, ccdf);
 	mutex_unlock(&zdev->state_lock);
+	guard(pci_rescan_remove)();
 	zpci_zdev_put(zdev);
 }
diff --git a/arch/s390/pci/pci_iov.c b/arch/s390/pci/pci_iov.c
index 13050ce5c3e9..1f7e4dd018e7 100644
--- a/arch/s390/pci/pci_iov.c
+++ b/arch/s390/pci/pci_iov.c
@@ -38,10 +38,9 @@ void zpci_iov_map_resources(struct pci_dev *pdev)
 
 void zpci_iov_remove_virtfn(struct pci_dev *pdev, int vfn)
 {
-	pci_lock_rescan_remove();
+	guard(pci_rescan_remove)();
 	/* Linux' vfid's start at 0 vfn at 1 */
 	pci_iov_remove_virtfn(pdev->physfn, vfn - 1);
-	pci_unlock_rescan_remove();
 }
 
 static int zpci_iov_link_virtfn(struct pci_dev *pdev, struct pci_dev *virtfn, int vfid)
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index bbb76113a4d0..1e211bcb284e 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -76,10 +76,15 @@ static int _do_recover(struct pci_dev *pdev, struct zpci_dev *zdev)
 	return ret;
 }
 
+/* So we don't have to mix cleanup.h helpers and gotos in recover_store() */
+DEFINE_CLASS(sysfs_break_active_protection, struct kernfs_node *,
+	     if (_T) sysfs_unbreak_active_protection(_T),
+	     sysfs_break_active_protection(kobj, attr),
+	     struct kobject *kobj, const struct attribute *attr);
+
 static ssize_t recover_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
-	struct kernfs_node *kn;
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct zpci_dev *zdev = to_zpci(pdev);
 	int ret = 0;
@@ -94,13 +99,13 @@ static ssize_t recover_store(struct device *dev, struct device_attribute *attr,
 	 * This is analogous to sdev_store_delete() in
 	 * drivers/scsi/scsi_sysfs.c
 	 */
-	kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+	CLASS(sysfs_break_active_protection, kn)(&dev->kobj, &attr->attr);
 	WARN_ON_ONCE(!kn);
 
 	/* Device needs to be configured and state must not change */
-	mutex_lock(&zdev->state_lock);
+	guard(mutex)(&zdev->state_lock);
 	if (zdev->state != ZPCI_FN_STATE_CONFIGURED)
-		goto out;
+		return count;
 
 	/* device_remove_file() serializes concurrent calls ignoring all but
 	 * the first
@@ -109,20 +114,14 @@ static ssize_t recover_store(struct device *dev, struct device_attribute *attr,
 
 	/* A concurrent call to recover_store() may slip between
 	 * sysfs_break_active_protection() and the sysfs file removal.
-	 * Once it unblocks from pci_lock_rescan_remove() the original pdev
+	 * Once it unblocks from guard(pci_rescan_remove)() the original pdev
 	 * will already be removed.
 	 */
-	pci_lock_rescan_remove();
-	if (pci_dev_is_added(pdev)) {
+	guard(pci_rescan_remove)();
+	if (pci_dev_is_added(pdev))
 		ret = _do_recover(pdev, zdev);
-	}
 	pci_rescan_bus(zdev->zbus->bus);
-	pci_unlock_rescan_remove();
 
-out:
-	mutex_unlock(&zdev->state_lock);
-	if (kn)
-		sysfs_unbreak_active_protection(kn);
 	return ret ? ret : count;
 }
 static DEVICE_ATTR_WO(recover);
-- 
2.55.0


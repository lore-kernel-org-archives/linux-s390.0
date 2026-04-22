Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C73ED5B2;
	Wed, 22 Apr 2026 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867745; cv=none; b=GhSvLdgR7RUEu8iEL1XHKR7E1fIYWMy1O3rHoCDyx7iiO7AL4g7YuNCZ5j1N8PgHKLNFSpIlr2432m4ZSG7JEteSt8PAkXnmwvhFmfmVDjyuJT3eL25thIuHRrBpNRRPVzKv3vTfJh7xgph8E1HxqJ/iz0wcsN8a9uPDLcy1Xbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867745; c=relaxed/simple;
	bh=RU8E5xKj/5EEdekR/laTh16XMwHXMvKeC+Mk4oMoc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdPRGaoN6bHtbALLi+pSbN7t/fXzAS6kwc6cZfv1s+gOLp7S5dHGCjlZA37oxJ4NAPkiiwBGdtvcdreVbROFH8o2mHz3pkeSF40FXgqvQOEJYFKtbPzjnibVtmFqQaVdYkHYhxHHenm8Z4OA2Eg3/3HDXKr1ODRUW4QuG6K7cDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mi1X/xQ0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mi1X/xQ0"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MBtAvk971245;
	Wed, 22 Apr 2026 14:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=r7ztKlUSzOtu70ku9vw+PvftWW973woYQuHmu/2yvcI=; b=Mi1X/xQ0/tZO
	XKnASD05HxDoYuLn3FkmRrrcBH/mIqDvZiQZ/wZo+rxLudlN+aAv6oC/jNHT2e1e
	U8V67wc7qNJoGxz5gQ9nV6t3JM7WnlSLwsuigLCoil3RCRIpqRS6W4aEfZuEXtDk
	qOhIa6xdFv528iSMj+X/UJlTNCrA6dSh48dc3P20iIaQdw+bytIEC0/0l5EYIF8O
	6x2hlC/SPnjdHO0POvTm4XssCIlC0huZXuQTwRf1LD9Xycg3s56qiqyKtLLro2G6
	m0sAgs1QmeL6t2bNInsCit5DeyYfVr7ierErL1d808ul/Hel7Fbp0hwdj0tGAq90
	QLoIhvsE+g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3kmd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:22:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MEKKFP029967;
	Wed, 22 Apr 2026 14:22:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyjjd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:22:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MEME1i46596490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 14:22:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 285BF20040;
	Wed, 22 Apr 2026 14:22:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 094F32004B;
	Wed, 22 Apr 2026 14:22:14 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Apr 2026 14:22:13 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wFYSz-0000000FrX2-3HYW;
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
Subject: [PATCH v3 3/3] s390/pci: Fix circular/recursive deadlocks in PCI-bus and -device release
Date: Wed, 22 Apr 2026 16:22:13 +0200
Message-ID: <da7d517cf35528dd54b4323600302c3c9d3dc2c4.1776866921.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1776866921.git.bblock@linux.ibm.com>
References: <cover.1776866921.git.bblock@linux.ibm.com>
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
X-Proofpoint-GUID: 4qzqklZKk1iWWnCsm2FWdOZ0T_nhUMvq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzOCBTYWx0ZWRfX50kA4QCVE+N1
 yDxuPT9Xsf0VLApaAc/gOl6kklcnuPcLTCJZlssrRtdBDpYj/iP8syFDNJsm/qfElwSgfaOtGTM
 oa7UqLy/jaNqm7EN9wd+smJ+pv+aXb+UTFRb+V1Eolu60oSDDIQFlyf+CC5H1Cj2q9/cLuJnVXc
 dWJcWJ5fVJk3e16AjIPS+KAooufpxnGAWLMhVrF0tOd7WNNl8HJZGoch9o9IWKsAQrwcaI/Cdix
 l/WnLFQDIGhbnVEh3Gxbo98GUPYX1fFIP6UUyGhlsqNKDi9J+zNBkuG67YS9qYUSCieOU6x1tIa
 mQrsxZ7YPsoVRq4kasyJG7jL25UQqUS8KVxqZaOHT8BocZmaxeSZ7Tnti3yOGImp9gHtymbrx9X
 g2uu34rgND2k7CF+khHBeeN7AAONP+TOKdPuI6DuZxmxicBbYF1q9Y9UgRSOUX3f7Nt53yVYkmU
 qw+VUT0AJXHHTy7Ro4g==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69e8d99b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=qptzKXhuCiR4edXAYWEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rA8OIpfmEW8xYS2yt14cKnHdgxBj2qLp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220138

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
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
Reference-ID: JUP1193979
---
 arch/s390/pci/pci.c       | 11 ++++++++---
 arch/s390/pci/pci_bus.c   | 15 ++++++++-------
 arch/s390/pci/pci_event.c | 28 +++++++++++++++++++---------
 arch/s390/pci/pci_iov.c   |  3 +--
 arch/s390/pci/pci_sysfs.c |  9 +++------
 5 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 2a430722cbe4..86ef1e516857 100644
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
@@ -582,11 +584,13 @@ int zpci_setup_bus_resources(struct zpci_dev *zdev)
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
@@ -599,7 +603,6 @@ static void zpci_cleanup_bus_resources(struct zpci_dev *zdev)
 		kfree(res);
 	}
 	zdev->has_resources = 0;
-	pci_unlock_rescan_remove();
 }
 
 int pcibios_device_add(struct pci_dev *pdev)
@@ -629,6 +632,7 @@ void pcibios_release_device(struct pci_dev *pdev)
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
index 839bd91c056e..98253706b591 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -342,6 +342,7 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 no_pdev:
 	if (zdev)
 		mutex_unlock(&zdev->state_lock);
+	guard(pci_rescan_remove)();
 	zpci_zdev_put(zdev);
 }
 
@@ -400,9 +401,11 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_CONFIGURED);
 			if (IS_ERR(zdev))
 				break;
-			if (zpci_add_device(zdev)) {
-				kfree(zdev);
-				break;
+			scoped_guard(pci_rescan_remove) {
+				if (zpci_add_device(zdev)) {
+					kfree(zdev);
+					break;
+				}
 			}
 		} else {
 			if (zdev->state == ZPCI_FN_STATE_RESERVED)
@@ -419,9 +422,11 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_STANDBY);
 			if (IS_ERR(zdev))
 				break;
-			if (zpci_add_device(zdev)) {
-				kfree(zdev);
-				break;
+			scoped_guard(pci_rescan_remove) {
+				if (zpci_add_device(zdev)) {
+					kfree(zdev);
+					break;
+				}
 			}
 		} else {
 			if (zdev->state == ZPCI_FN_STATE_RESERVED)
@@ -450,24 +455,29 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 			/* The 0x0304 event may immediately reserve the device */
 			if (!clp_get_state(zdev->fid, &state) &&
 			    state == ZPCI_FN_STATE_RESERVED) {
+				guard(pci_rescan_remove)();
 				zpci_device_reserved(zdev);
 			}
 		}
 		break;
 	case 0x0306: /* 0x308 or 0x302 for multiple devices */
-		zpci_remove_reserved_devices();
-		zpci_scan_devices();
+		scoped_guard(pci_rescan_remove) {
+			zpci_remove_reserved_devices();
+			zpci_scan_devices();
+		}
 		break;
 	case 0x0308: /* Standby -> Reserved */
 		if (!zdev)
 			break;
-		zpci_device_reserved(zdev);
+		scoped_guard(pci_rescan_remove)
+			zpci_device_reserved(zdev);
 		break;
 	default:
 		break;
 	}
 	if (existing_zdev) {
 		mutex_unlock(&zdev->state_lock);
+		guard(pci_rescan_remove)();
 		zpci_zdev_put(zdev);
 	}
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
index c2444a23e26c..f5027aa95928 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -98,9 +98,9 @@ static ssize_t recover_store(struct device *dev, struct device_attribute *attr,
 	WARN_ON_ONCE(!kn);
 
 	/* Device needs to be configured and state must not change */
-	mutex_lock(&zdev->state_lock);
+	guard(mutex)(&zdev->state_lock);
 	if (zdev->state != ZPCI_FN_STATE_CONFIGURED)
-		goto out;
+		return count;
 
 	/* device_remove_file() serializes concurrent calls ignoring all but
 	 * the first
@@ -112,15 +112,12 @@ static ssize_t recover_store(struct device *dev, struct device_attribute *attr,
 	 * Once it unblocks from pci_lock_rescan_remove() the original pdev
 	 * will already be removed.
 	 */
-	pci_lock_rescan_remove();
+	guard(pci_rescan_remove)();
 	if (pci_dev_is_added(pdev)) {
 		ret = _do_recover(pdev, zdev);
 	}
 	pci_rescan_bus(zdev->zbus->bus);
-	pci_unlock_rescan_remove();
 
-out:
-	mutex_unlock(&zdev->state_lock);
 	if (kn)
 		sysfs_unbreak_active_protection(kn);
 	return ret ? ret : count;
-- 
2.54.0


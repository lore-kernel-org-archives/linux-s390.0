Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0EE1A6829;
	Wed, 11 Mar 2026 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235678; cv=none; b=C5oHrpAyGi+J0P8qQDS4xBE36g5E8kdQIu1i2+0kapWR8b3G2lO2PJIBMW3fFcOuUsq1EAvgSTzf9Kg8z6GjOj2ZaZsT91V64u2ryEVQq3D3hwpNSdQOJUHhEdPSHyaYDiky2XuONWBZfiTklknEzc2r8DJeURa1cXpaiddaNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235678; c=relaxed/simple;
	bh=Cn9LF1t0cttQqvmIDVD4dlYiJbsuWRlI1wC1Cjn1LnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iyhnl/ywuVFEyCNBX8yPCHTUZ0FKEOyX7axNFJpFTG2pXg5GTu88+aOFD+MOdS2+R2LMS5Y/MdXnJlq/noAqYabUL0T2HnYuiHtVIpKkBx66mF1o7TbO1C4rv9+yM7WW1Aok8grTMIYBj5MgAdLiUmgjr9dZFn4MmeIpjBh+5Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kkdQTPRi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kkdQTPRi"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B8b55H576632;
	Wed, 11 Mar 2026 13:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=3gbzl7jb1qOKG04PVKkoawfwEKnH5zepUUCqawqu7Hs=; b=kkdQTPRiziH3
	qJDkJTZrQytWD+unM0Lt1NeO8whR/daSVEYBg3NWPS0VN0P++KQvE4Bh0DWP9tBY
	9XxCMVf6sFaHUhgMFWUbD1kAZzplRDPfkVKS3v3kzmHwd/9ivLV1CIJIz23p8idU
	ZNA+YYAaRGnK7JSFYe/ja/xXPlIwEs/F2pNBm7U8TdG5IIz6JD6WayKEmRtEDJni
	+kYnshe0s+aTLey68u+nPZQahmVIuTLVv5MlXEM4ENEOJbe+xQWWM8OfScB1i3wk
	41xiuBVt9rycemsuH7VlI8Cok1hhGoqkeY+DuuCKOan32i4gYXhCGbU0YqhS+NT8
	SLQ98NKbOw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuyg24t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:27:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BCMf6C021521;
	Wed, 11 Mar 2026 13:27:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbswq3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:27:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BDRpI031392510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 13:27:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 162252004B;
	Wed, 11 Mar 2026 13:27:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAF872004D;
	Wed, 11 Mar 2026 13:27:50 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Mar 2026 13:27:50 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1w0JbK-00000008V4X-3021;
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
Subject: [PATCH v2 3/3] s390/pci: Fix circular/recursive deadlocks in PCI-bus and -device release
Date: Wed, 11 Mar 2026 14:27:50 +0100
Message-ID: <354b9e4a54ced67f3c89df198041df19434fe4c8.1773235561.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773235561.git.bblock@linux.ibm.com>
References: <cover.1773235561.git.bblock@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b16ddc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=4Ogr7rOChN4w0RTaVvUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExMCBTYWx0ZWRfX+rW/MwJxXu2W
 hgDOTGHJBmHWXVfMAI1ZLiQh5YbCkXavq+IQQ/N5SbyBcILvVB9BETSu1ZzU5owcPzbdoBrxIqb
 5+sanVsB/90hqDS2ADgLmn/5QNedOtUzqDOE7XZ1JqReqVfTq2tYAnPDOH2qUEcc98ngrfMZLq7
 jlsw7/T0iw52X44lJ0UBaKLDDYC0vUmWj/fzG73wc8B84V+aG7RGxV/0gHCizcM3z/iSwpTOQyS
 cc4fK+AEr+wTppdPxD5VqK2ESN+SHSg0cNLHw85brzcnRK+Tvf5gkAgVIaVaVQ3jPupAi6gTnVo
 dQ+aarM/0OFO46WByaeExfebKAscKhYtoLza4wlooGSDkMOqU5I5qctXukdxEPtcRA11h0emGvX
 knc/hMXIgIKwclc/gorg4voSKK28gnO4D7uAx9AIAwITSEdGgcZpKHGn+zNCGvo6eBuS614wGe0
 43kgofLHjWCWPlrDSwg==
X-Proofpoint-GUID: 1m2yKTsirBGTeEPkegVgLjKt_T358LCh
X-Proofpoint-ORIG-GUID: x6k1tDpIHA423-9-I9IppV1XB8pf_pAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110110

When removing PCI device or PCI bus objects there are a couple of
call-chains where it is possible that the kernel runs into a circular or
recursive deadlock involving taking the central `pci_rescan_remove_lock`.

For example:

(A) Thread α receives a CRW event notifying the kernel that a PCI
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
  sriov_numvfs_store()              # will   lock(pci_rescan_remove_lock)
    -> ... (deep chain)
    -> pci_release_dev()
    -> pcibios_release_device()
    -> zpci_zdev_put()              # will   lock(zpci_add_remove_lock)

If thread α and β coincide, this will result in a cyclic deadlock.

(B) Consider thread β from above; if the thread was to follow the same
outlined call-chain for thread α, and not fall into the cyclic deadlock,
it would recursive deadlock:
  sriov_numvfs_store()              # will   lock(pci_rescan_remove_lock)
    -> ... (deep chain)
    -> pci_release_dev()
    -> pcibios_release_device()
    -> zpci_zdev_put()              # will   lock(zpci_add_remove_lock),
                                    # and    lock(zpci_list_lock)
    -> zpci_release_device()        # will unlock(zpci_list_lock)
    -> zpci_cleanup_bus_resources() # will   lock(pci_rescan_remove_lock)

(C) And even in case `pci_rescan_remove_lock` was removed from
zpci_cleanup_bus_resources(), the resulting call-chain would recursive
deadlock when it tries to release the associated PCI bus:
  sriov_numvfs_store()              # will   lock(pci_rescan_remove_lock)
    -> ... (deep chain)
    -> pci_release_dev()
    -> pcibios_release_device()
    -> zpci_zdev_put()              # will   lock(zpci_add_remove_lock),
                                    # and    lock(zpci_list_lock)
    -> zpci_release_device()        # will unlock(zpci_list_lock)
    -> zpci_bus_device_unregister()
    -> zpci_bus_put()               # will   lock(zbus_list_lock)
    -> zpci_bus_release()           # will unlock(zbus_list_lock),
                                    # will   lock(pci_rescan_remove_lock)

It can also easily be seen that scenario (C) offers the same risk as (A)
for a cyclic deadlock in cases where `pci_rescan_remove_lock` is first
locked, and the PCI bus released under its protection.

`pci_rescan_remove_lock` has to be and is taken at a "high level" in
most call-chains since it is intended to protect/mutual exclude all
rescan and/or removal actions taken in the PCI subsystem. So to prevent
the outlined deadlock scenarios above remove it instead from the "low
level" release function for both the PCI device and PCI bus objects.

Instead, lock `pci_rescan_remove_lock` in all call-chains leading to
those release functions:
  * initialization of the PCI subsystem;
  * processing of availability events (CRWs) for PCI functions;
  * processing of error events (CRWs) for PCI functions;
  * architecture specific release PCI device implementation.

Additionally, remove `pci_rescan_remove_lock` from zpci_bus_scan_bus()
since it is now always already taken when called.

Lastly, document the new locking expectations after these changes. Add
sparse and lockdep annotations to functions that previously locked
`pci_rescan_remove_lock` explicitly, making sure the lock is now
already held when called. Additionally also add the annotations to
zpci_zdev_put() and zpci_bus_put() to make sure that every function that
potentially drops the last reference already holds the lock to prevent
surprises.

Fixes: 05bc1be6db4b2 ("s390/pci: create zPCI bus")
Fixes: ab909509850b2 ("PCI: s390: Fix use-after-free of PCI resources with per-function hotplug")
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
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
2.53.0


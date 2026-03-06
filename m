Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039AF393DC0;
	Fri,  6 Mar 2026 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815767; cv=none; b=UVQQxT/D473WZF/ogggj1MfgR0yMxYpCneA2PKAaG4I29Ejy+YNutuoobEMVtF2T029OVGFV/Au5AHdV4bKrlEcKglifAQWyRZ1QMw+8Gs2gikGCXlorvb7bPIZhIVEFGW+5Lh6X/Yb+V2D9FHX0HCn1nMZSgmVSftFNs1NJvi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815767; c=relaxed/simple;
	bh=w7SLMaatAEk9YpzuVMJZPVrAEzQEViQeGyKMdSb/T2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVZ5Z3UT88Xv9YN43W98tKInvZi3UtjUMaDwgrswX9KaHNBVgqYInzSO9ye4EuGdxMWR9xORuJbyQhCv/NdVxjx32LMsa0cJe9F/CckWJyajj+nH2ClrWNGishdb+3w1nMtGmBLFDe9aQ8DDsZzExKZufQ45UH30Hxq0wizJO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R+O3QE6/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R+O3QE6/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264bK0Q1183853;
	Fri, 6 Mar 2026 16:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=d8KN0yuscVe1KZMQZLFdiNGnRrFWyZU0bZQuWYxrDls=; b=R+O3QE6/jJmf
	ZbzsTd+iw50Fr0hlFkJmHxhHNVndc4hol6FiEywlL7/ps1rdZVSB8kFOOsjvafPN
	6J9zTJnuc5dSSW6vaj5xLtI1G7D9HD06/oOgiOkp3zitLTITxX9PmAmx9uluLRHQ
	snlKfnpVNLA2RbDp6/THjSt1EJPlP5YUluaAhJhazIjUGP6vV7zqeLaK8YorvMW1
	8VzyI0ViMBPnJOb4eqSDhfU6l+BiBJi+cDAASqNfC5erTnw4yRjd8ncvSvAIAu42
	n2f7tmtSjl1FrpqPNpWGim0eSosSlv0wR8k4fJZbGsx7TSy+srQNFdoF7iG8185u
	MGziKQMxxQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskc8wk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 16:49:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626Cg7Ui003200;
	Fri, 6 Mar 2026 16:49:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2ygsm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 16:49:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626GnHXV52298036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 16:49:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68C0D2004E;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49EBD20043;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vyYMX-00000005i38-09Bx;
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
Subject: [PATCH 2/4] s390/pci: Fix circular/recursive deadlocks in PCI-bus and -device release
Date: Fri,  6 Mar 2026 17:49:14 +0100
Message-ID: <a2740ba8e0a0c4d0035a2d320170d2f3a245ed46.1772815642.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772815642.git.bblock@linux.ibm.com>
References: <cover.1772815642.git.bblock@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: qQZ3BJ1tc9CowTmf4VKUC3SoCPWWa6qQ
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69ab0592 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=MfPiQNo1A4lVxNDC-NsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1OCBTYWx0ZWRfX/KfIegx7q+Py
 gRBOBCy6DZdXjPX324ZZiUMXC9X5Mb5IaL6LuNzjOR2TWjpmYc7wts1+H7TRPIIamSSGvIGYysQ
 l+odJ/0ZCWKZMhgMuK2HvKhJNZnZMhn7BuOgUGYixVFf0uvBSeG9uV6j/Cs9/8AtaboJZztNPUQ
 t7Ju4+LlD0KRaTvPMUTfWXFVClQahS8/AXc3BjNfLS2+Y8KUnYCsJ3Y/sS23drLXTNh8CHsUVNV
 krRVBpbJaO2WHH9D2W8a7SbJiREBRdmeyc2CSFjIrpDnYZhbWZI0KiU6VC4MwWTGj+d9pu3lO0S
 9c05/5v93gPb5rBTi0/vBLDd0xIbRalIAUymsQuBkhqO/J/lr60l0LLgISbeAQ4PvxhS2tgum6l
 5WV2julTEasxZ0A91tdvhlrxit7oFjXRt34IYl+La6xFN32Y8faj/HNSsXjhBXwg0q9ScxrURLr
 kvKCeyeWur0rTCLYqog==
X-Proofpoint-GUID: ZefXUe_WsheFHvVgpxWyXZfn1FVtrHt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060158

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

Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 arch/s390/pci/pci.c       | 11 +++++++++--
 arch/s390/pci/pci_bus.c   | 12 +++++++-----
 arch/s390/pci/pci_event.c | 21 +++++++++++++++++++--
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 2a430722cbe4..fd16e6ad21c1 100644
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
@@ -629,8 +632,10 @@ void pcibios_release_device(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
+	pci_lock_rescan_remove();
 	zpci_unmap_resources(pdev);
 	zpci_zdev_put(zdev);
+	pci_unlock_rescan_remove();
 }
 
 int pcibios_enable_device(struct pci_dev *pdev, int mask)
@@ -1208,7 +1213,9 @@ static int __init pci_base_init(void)
 	if (rc)
 		goto out_irq;
 
+	pci_lock_rescan_remove();
 	rc = zpci_scan_devices();
+	pci_unlock_rescan_remove();
 	if (rc)
 		goto out_find;
 
diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 36a4807285fa..2b598222c621 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -132,10 +132,13 @@ void zpci_bus_remove_device(struct zpci_dev *zdev, bool set_error)
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
@@ -145,10 +148,8 @@ int zpci_bus_scan_bus(struct zpci_bus *zbus)
 		}
 	}
 
-	pci_lock_rescan_remove();
 	pci_scan_child_bus(zbus->bus);
 	pci_bus_add_devices(zbus->bus);
-	pci_unlock_rescan_remove();
 
 	return ret;
 }
@@ -214,11 +215,12 @@ static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *fr, s
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
@@ -229,14 +231,12 @@ static inline void zpci_bus_release(struct kref *kref)
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
@@ -250,7 +250,9 @@ static inline void __zpci_bus_get(struct zpci_bus *zbus)
 }
 
 static inline void zpci_bus_put(struct zpci_bus *zbus)
+	__must_hold(&pci_rescan_remove_lock)
 {
+	lockdep_assert_held(&pci_rescan_remove_lock);
 	kref_put_mutex(&zbus->kref, zpci_bus_release, &zbus_list_lock);
 }
 
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 839bd91c056e..edfaeed737ac 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -342,7 +342,9 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 no_pdev:
 	if (zdev)
 		mutex_unlock(&zdev->state_lock);
+	pci_lock_rescan_remove();
 	zpci_zdev_put(zdev);
+	pci_unlock_rescan_remove();
 }
 
 void zpci_event_error(void *data)
@@ -387,6 +389,7 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
 	bool existing_zdev = !!zdev;
 	enum zpci_state state;
+	int rc;
 
 	zpci_dbg(3, "avl fid:%x, fh:%x, pec:%x\n",
 		 ccdf->fid, ccdf->fh, ccdf->pec);
@@ -400,7 +403,10 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_CONFIGURED);
 			if (IS_ERR(zdev))
 				break;
-			if (zpci_add_device(zdev)) {
+			pci_lock_rescan_remove();
+			rc = zpci_add_device(zdev);
+			pci_unlock_rescan_remove();
+			if (rc) {
 				kfree(zdev);
 				break;
 			}
@@ -419,7 +425,10 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_STANDBY);
 			if (IS_ERR(zdev))
 				break;
-			if (zpci_add_device(zdev)) {
+			pci_lock_rescan_remove();
+			rc = zpci_add_device(zdev);
+			pci_unlock_rescan_remove();
+			if (rc) {
 				kfree(zdev);
 				break;
 			}
@@ -450,25 +459,33 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 			/* The 0x0304 event may immediately reserve the device */
 			if (!clp_get_state(zdev->fid, &state) &&
 			    state == ZPCI_FN_STATE_RESERVED) {
+				pci_lock_rescan_remove();
 				zpci_device_reserved(zdev);
+				pci_unlock_rescan_remove();
 			}
 		}
 		break;
 	case 0x0306: /* 0x308 or 0x302 for multiple devices */
+		pci_lock_rescan_remove();
 		zpci_remove_reserved_devices();
 		zpci_scan_devices();
+		pci_unlock_rescan_remove();
 		break;
 	case 0x0308: /* Standby -> Reserved */
 		if (!zdev)
 			break;
+		pci_lock_rescan_remove();
 		zpci_device_reserved(zdev);
+		pci_unlock_rescan_remove();
 		break;
 	default:
 		break;
 	}
 	if (existing_zdev) {
 		mutex_unlock(&zdev->state_lock);
+		pci_lock_rescan_remove();
 		zpci_zdev_put(zdev);
+		pci_unlock_rescan_remove();
 	}
 }
 
-- 
2.53.0


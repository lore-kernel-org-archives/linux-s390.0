Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027B407598;
	Fri,  6 Mar 2026 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815765; cv=none; b=RznZAoLzlqg02p/gvpKdOpXTe+WR5RjLyqYEdw/0GqDtqteGoQVwHDyQqVjdoA2PPW11DcwxpmIl7n9r3nFoWzkkOlWTB1bQs/Z//Liek6S9+/OuVumgyOndwgl0Pxs/h4wmtgbpsLF/pj6bdLfCj+Ee8WTK3BX7SjrwdRQB8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815765; c=relaxed/simple;
	bh=4UuH2kzp6vSguETGtW033xrkAsv4m3iPrngElE1bJkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9QwrqHd5Fkcj4wKbFPSaRSRAYzODyXRJJOo18YtzlApM24tK3uH/74+azN4pmUj8edDYbS+el3SNb4NKGa5Y4jEQLq0SS62fZgh52XWE1Xdtg5nVqoLwPnQ4xUr9SzJCE98rRt84ufX5wbDHJbSOsCM0/nyGRjNV/D/F8ATxO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=slav72l2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="slav72l2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6268b3qH2188183;
	Fri, 6 Mar 2026 16:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=pp1; bh=hj7wILe7Dw
	ofximExeMg+O/rcrkBumQx8RM4MuMnuCI=; b=slav72l2689+XJ7uyZ3mpdebyv
	BpzpS9ftTh4AJ5PF/6d1MHheJQmu2FHF78fir70ecHrz4BFzUPzaZqTUKFBtns2P
	/U4m1qkPw6uCEYJ0tafe9CIPErVXapNhmcSh7f0782nquDL5spqnAcCy7i+HKZIS
	nPSRtDt3D88w9rxtp0Ajn2GoGFBSef4qj3Q+Lw+X6RxEWy5TV2ZDRSsNv2yB1NNR
	Ii9cX7yKe9KCxcibl2n+qeo1Pbx2iYOyBeTQfGCn4bbNsffNshIMZW0IO2yyKZ2f
	CJe7okMPE7Yyxs0bAqpkerfSm+HZE1zOcOamjCoy2YViXBcWe9vodPeg8oTg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk48yks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 16:49:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626Cg7Uj003200;
	Fri, 6 Mar 2026 16:49:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2ygsm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 16:49:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626GnHgu41812370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 16:49:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73D132004E;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 560352004B;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Mar 2026 16:49:17 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vyYMX-00000005i3F-0MIz;
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
Subject: [PATCH 4/4] s390/pci: Use lock guard for pci_rescan_remove_lock
Date: Fri,  6 Mar 2026 17:49:16 +0100
Message-ID: <7be9c8ad56f5ef9366316c3621dece9a10f3eb8b.1772815642.git.bblock@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: sP9hLgzdB-yi6la35WTiKVzBRMCioX1E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1OCBTYWx0ZWRfX+dCfDc1IN8hp
 Qsp8LrCsVTjdWFmNJIkMReNihtMVO/7j39QVfL06yfoXFRQn6qiSBqwIQX6krJSWGpnZGGSwCHe
 8odTxMU+v4hyDwH+aOShmLJ+LPvsbMEfS+u+WrqnLWf2QZX2kVpkPvJ9b7W80/MfalGUFBDLffw
 Kowfr/28AqOm3t9bfpp+fEH11cDImtgc1/zmgMptUONrAaOsKHzyDIFYg7nRnGTcD321GN2k8qa
 jICJK7qO3Iu1XhjybFPjUhVsRjKoq5zjVrRle1U50gl3jqHa+vdY9aUIXXzvJmqCT9HvluZpgaX
 0tOZ+1OHbKNGOAsoqKt/g3YEmcJUM++KKHqqjkncP0dcRckNP+iz1KMlDvlOGbZBm/oCltJHheN
 guC8PN8jH6MInunO4+5NqzR5wmnty2rLN2/iT0H/5piMjM4jxYe6BlllsytjKEXKhTjwUdeeYXj
 fghDI2a5DiTeAmCwvTA==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69ab0592 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=YfMtKnRlwAlJkKqiXaoA:9
X-Proofpoint-GUID: AHGmpoC8Vr8N8uht1Cg1rpRlSPKX-aQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060158

There are quite a few places in the s390 architecture code for the PCI
subsystem where the kernel needs to lock `pci_rescan_remove_lock` now;
which is done by calling pci_lock_rescan_remove() to lock, and
pci_unlock_rescan_remove() to unlock the mutex.

Instead of always manually calling both functions, which induces a
certain amount of visual clutter, and in some cases of errors, cleanup,
and jumplabels more complexity, use either guard() or scoped_guard()
depending on the context.

Convert all users in the s390 architecture code for PCI.

Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 arch/s390/pci/pci.c       |  8 +++----
 arch/s390/pci/pci_bus.c   |  3 +--
 arch/s390/pci/pci_event.c | 45 +++++++++++++++++----------------------
 arch/s390/pci/pci_iov.c   |  3 +--
 arch/s390/pci/pci_sysfs.c |  9 +++-----
 5 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index fd16e6ad21c1..86ef1e516857 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -632,10 +632,9 @@ void pcibios_release_device(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
-	pci_lock_rescan_remove();
+	guard(pci_rescan_remove)();
 	zpci_unmap_resources(pdev);
 	zpci_zdev_put(zdev);
-	pci_unlock_rescan_remove();
 }
 
 int pcibios_enable_device(struct pci_dev *pdev, int mask)
@@ -1213,9 +1212,8 @@ static int __init pci_base_init(void)
 	if (rc)
 		goto out_irq;
 
-	pci_lock_rescan_remove();
-	rc = zpci_scan_devices();
-	pci_unlock_rescan_remove();
+	scoped_guard(pci_rescan_remove)
+		rc = zpci_scan_devices();
 	if (rc)
 		goto out_find;
 
diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 2b598222c621..c1b48b572e86 100644
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
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index edfaeed737ac..98253706b591 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -342,9 +342,8 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 no_pdev:
 	if (zdev)
 		mutex_unlock(&zdev->state_lock);
-	pci_lock_rescan_remove();
+	guard(pci_rescan_remove)();
 	zpci_zdev_put(zdev);
-	pci_unlock_rescan_remove();
 }
 
 void zpci_event_error(void *data)
@@ -389,7 +388,6 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
 	bool existing_zdev = !!zdev;
 	enum zpci_state state;
-	int rc;
 
 	zpci_dbg(3, "avl fid:%x, fh:%x, pec:%x\n",
 		 ccdf->fid, ccdf->fh, ccdf->pec);
@@ -403,12 +401,11 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_CONFIGURED);
 			if (IS_ERR(zdev))
 				break;
-			pci_lock_rescan_remove();
-			rc = zpci_add_device(zdev);
-			pci_unlock_rescan_remove();
-			if (rc) {
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
@@ -425,12 +422,11 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_STANDBY);
 			if (IS_ERR(zdev))
 				break;
-			pci_lock_rescan_remove();
-			rc = zpci_add_device(zdev);
-			pci_unlock_rescan_remove();
-			if (rc) {
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
@@ -459,33 +455,30 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 			/* The 0x0304 event may immediately reserve the device */
 			if (!clp_get_state(zdev->fid, &state) &&
 			    state == ZPCI_FN_STATE_RESERVED) {
-				pci_lock_rescan_remove();
+				guard(pci_rescan_remove)();
 				zpci_device_reserved(zdev);
-				pci_unlock_rescan_remove();
 			}
 		}
 		break;
 	case 0x0306: /* 0x308 or 0x302 for multiple devices */
-		pci_lock_rescan_remove();
-		zpci_remove_reserved_devices();
-		zpci_scan_devices();
-		pci_unlock_rescan_remove();
+		scoped_guard(pci_rescan_remove) {
+			zpci_remove_reserved_devices();
+			zpci_scan_devices();
+		}
 		break;
 	case 0x0308: /* Standby -> Reserved */
 		if (!zdev)
 			break;
-		pci_lock_rescan_remove();
-		zpci_device_reserved(zdev);
-		pci_unlock_rescan_remove();
+		scoped_guard(pci_rescan_remove)
+			zpci_device_reserved(zdev);
 		break;
 	default:
 		break;
 	}
 	if (existing_zdev) {
 		mutex_unlock(&zdev->state_lock);
-		pci_lock_rescan_remove();
+		guard(pci_rescan_remove)();
 		zpci_zdev_put(zdev);
-		pci_unlock_rescan_remove();
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


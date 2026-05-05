Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060843DC4C0;
	Tue,  5 May 2026 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011524; cv=none; b=MZiEsIGwm4FJR9Lu0sxocpfWxhrRXAbD6/PHWNNLG6Mm2NxNlGOih66DmAwYvLz7xIrA19I0V5fwaWgrA3tjiFBONtE5M612PqsjhbRO6IpQ16a6FRvwQvcrCKtdb87sSbGS+18TcGlJOl/ZJEp8u9oLas4Wfk59bUce2TTrUXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011524; c=relaxed/simple;
	bh=IvQxud+RooMcKnqQtBgOaXEbS2IgbPoA6y5YIyibfJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDIq3UVeuJzndJUrOReS57zAl7HWprux2YjpZMtQadenZFJoG1D3SZDoz+1iovP/rcK4iijKnQtT/WFJhVU30as6B6mh9px63c+ZyC5GNeDXJXcR4WNwVo/mpntk8isZAp70vHc1d2I2iAZDVV1MZAah7057t70+kePqxYTdTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T5jSc55k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T5jSc55k"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645CSNSA1362084;
	Tue, 5 May 2026 20:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IuhPl+zjWAsAyvPUD
	ZyzHYIWBFnJxKpWyqsj8FrEgyY=; b=T5jSc55kdIaSmfBKqLvwVS7Zau4PSenAd
	0R8f9MDNJbF+86vKdUNiMgQLiBMhmyR5QzKPJZF+xcqyZlBNHYf+cYAkk89YQ+6N
	T2mFh06ur3JB7/EM/X/2rclo34Rqi834Oxj2kr/UYGGJiGKoLhmb+D7XICFnOTOG
	v8gLmrCEvN2VxZ9Kj7g3Vmcwgtdc7jEuwavEmtg59Y/DJuN/mPLzU4EUFknW5I1+
	dXgFzyS37borPM/ikm9kL9yw2KTPGS/hKS4wZ+OFmKm6ii5rokGoE5tYHHEboa2Y
	T0kEr0gUwDlIOuXEuF6d8xV2qd9+Q9atn34T8T9eSgYNT3gz6zyaQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7dkv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 20:05:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645JsSJ4019163;
	Tue, 5 May 2026 20:05:16 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkju83t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 20:05:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645K5EBG20316908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 20:05:15 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A76A85805E;
	Tue,  5 May 2026 20:05:14 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 024FD58059;
	Tue,  5 May 2026 20:05:14 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.219])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 20:05:13 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v15 4/7] s390/pci: Store PCI error information for passthrough devices
Date: Tue,  5 May 2026 13:05:07 -0700
Message-ID: <20260505200510.2954-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505200510.2954-1-alifm@linux.ibm.com>
References: <20260505200510.2954-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5MSBTYWx0ZWRfX1082iAw4Ikpv
 UupuKE+OrTs4wG+YFuqY1357/pdAoNGU/+BTcR3T22pEu906EcoyKUE+jYbX6HWsyVnETHpcGHf
 +RiFV9WPHpJjGYxNzgvkgUCDl9dGRlET/1w3OwUuwYy1v/VXHEcIsMIChQtfXnd7JC3/78hYu8a
 Eij9sIf2ZT969r4y8YCKklidbj9yk449CTMKOiWSqTM5IwNQ9zRz+XlsrtslEZgquOFDelvD5g3
 EmJGCKEQKlSO/rkLE0C/QQPY7DE60Hz3bW0RgVqjkyQoM6pk6XxxdpD1WHpIaOXkSsd9wUcG/nc
 yUotpC387KCMl5HacEwDP0jtubNfJ4yA0Dsx7ICc+KB8/vARh+INlOuliv82Ci25fU0p6E5G4de
 ZrZfTDcvKNlBjq2W9unnSRc0wyUo8U7FNryRrvq5Wv3OKXvXn1UKO+04Z8gwKQWUjyAKu7o4R8M
 1/h4P1EJ+WaQigOLpSg==
X-Proofpoint-GUID: r-AG62rpBkOdQX_7aKmN_0zbcGJCJP3C
X-Proofpoint-ORIG-GUID: r-AG62rpBkOdQX_7aKmN_0zbcGJCJP3C
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fa4d7d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=PQMJTAmWB74Go-Ie6_gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050191

For a passthrough device we need co-operation from user space to recover
the device. This would require to bubble up any error information to user
space.  Let's store this error information for passthrough devices, so it
can be retrieved later.

We can now have userspace drivers (vfio-pci based) on s390x. The userspace
drivers will not have any KVM fd and so no kzdev associated with them. So
we need to update the logic for detecting passthrough devices to not depend
on struct kvm_zdev.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/include/asm/pci.h      |  30 ++++++++
 arch/s390/pci/pci.c              |   1 +
 arch/s390/pci/pci_event.c        | 114 +++++++++++++++++--------------
 drivers/vfio/pci/vfio_pci_zdev.c |  18 ++++-
 4 files changed, 109 insertions(+), 54 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 5dcf35f0f325..016386f7ef4a 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -118,6 +118,32 @@ struct zpci_bus {
 	enum pci_bus_speed	max_bus_speed;
 };
 
+/* Content Code Description for PCI Function Error */
+struct zpci_ccdf_err {
+	u32 reserved1;
+	u32 fh;                         /* function handle */
+	u32 fid;                        /* function id */
+	u32 ett         :  4;           /* expected table type */
+	u32 mvn         : 12;           /* MSI vector number */
+	u32 dmaas       :  8;           /* DMA address space */
+	u32 reserved2   :  6;
+	u32 q           :  1;           /* event qualifier */
+	u32 rw          :  1;           /* read/write */
+	u64 faddr;                      /* failing address */
+	u32 reserved3;
+	u16 reserved4;
+	u16 pec;                        /* PCI event code */
+} __packed;
+
+#define ZPCI_ERR_PENDING_MAX 4
+struct zpci_ccdf_pending {
+	bool mediated_recovery;
+	u8 count;
+	u8 head;
+	u8 tail;
+	struct zpci_ccdf_err err[ZPCI_ERR_PENDING_MAX];
+};
+
 /* Private data per function */
 struct zpci_dev {
 	struct zpci_bus *zbus;
@@ -192,6 +218,8 @@ struct zpci_dev {
 	struct iommu_domain *s390_domain; /* attached IOMMU domain */
 	struct kvm_zdev *kzdev;
 	struct mutex kzdev_lock;
+	struct zpci_ccdf_pending pending_errs;
+	struct mutex pending_errs_lock;
 	spinlock_t dom_lock;		/* protect s390_domain change */
 };
 
@@ -334,6 +362,8 @@ void zpci_debug_exit_device(struct zpci_dev *);
 int zpci_report_error(struct pci_dev *, struct zpci_report_error_header *);
 int zpci_clear_error_state(struct zpci_dev *zdev);
 int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
+void zpci_start_mediated_recovery(struct zpci_dev *zdev);
+void zpci_stop_mediated_recovery(struct zpci_dev *zdev);
 
 #ifdef CONFIG_NUMA
 
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 39bd2adfc240..2d377c2e194d 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -842,6 +842,7 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
 	mutex_init(&zdev->state_lock);
 	mutex_init(&zdev->fmb_lock);
 	mutex_init(&zdev->kzdev_lock);
+	mutex_init(&zdev->pending_errs_lock);
 
 	return zdev;
 
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 839bd91c056e..41547c54076f 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -17,23 +17,6 @@
 #include "pci_bus.h"
 #include "pci_report.h"
 
-/* Content Code Description for PCI Function Error */
-struct zpci_ccdf_err {
-	u32 reserved1;
-	u32 fh;				/* function handle */
-	u32 fid;			/* function id */
-	u32 ett		:  4;		/* expected table type */
-	u32 mvn		: 12;		/* MSI vector number */
-	u32 dmaas	:  8;		/* DMA address space */
-	u32		:  6;
-	u32 q		:  1;		/* event qualifier */
-	u32 rw		:  1;		/* read/write */
-	u64 faddr;			/* failing address */
-	u32 reserved3;
-	u16 reserved4;
-	u16 pec;			/* PCI event code */
-} __packed;
-
 /* Content Code Description for PCI Function Availability */
 struct zpci_ccdf_avail {
 	u32 reserved1;
@@ -60,18 +43,6 @@ static inline bool ers_result_indicates_abort(pci_ers_result_t ers_res)
 	}
 }
 
-static bool is_passed_through(struct pci_dev *pdev)
-{
-	struct zpci_dev *zdev = to_zpci(pdev);
-	bool ret;
-
-	mutex_lock(&zdev->kzdev_lock);
-	ret = !!zdev->kzdev;
-	mutex_unlock(&zdev->kzdev_lock);
-
-	return ret;
-}
-
 static bool is_driver_supported(struct pci_driver *driver)
 {
 	if (!driver || !driver->err_handler)
@@ -81,6 +52,46 @@ static bool is_driver_supported(struct pci_driver *driver)
 	return true;
 }
 
+static void zpci_store_pci_error(struct pci_dev *pdev,
+				 struct zpci_ccdf_err *ccdf)
+{
+	struct zpci_dev *zdev = to_zpci(pdev);
+	int i;
+
+	guard(mutex)(&zdev->pending_errs_lock);
+	if (!zdev->pending_errs.mediated_recovery)
+		return;
+
+	if (zdev->pending_errs.count >= ZPCI_ERR_PENDING_MAX) {
+		pr_err("%s: Maximum number (%d) of pending error events queued",
+		       pci_name(pdev), ZPCI_ERR_PENDING_MAX);
+		return;
+	}
+
+	i = zdev->pending_errs.tail % ZPCI_ERR_PENDING_MAX;
+	memcpy(&zdev->pending_errs.err[i], ccdf, sizeof(struct zpci_ccdf_err));
+	zdev->pending_errs.tail++;
+	zdev->pending_errs.count++;
+}
+
+void zpci_start_mediated_recovery(struct zpci_dev *zdev)
+{
+	guard(mutex)(&zdev->pending_errs_lock);
+	zdev->pending_errs.mediated_recovery = true;
+}
+EXPORT_SYMBOL_GPL(zpci_start_mediated_recovery);
+
+void zpci_stop_mediated_recovery(struct zpci_dev *zdev)
+{
+	guard(mutex)(&zdev->pending_errs_lock);
+	zdev->pending_errs.mediated_recovery = false;
+	if (zdev->pending_errs.count)
+		pr_info("Unhandled PCI error events count=%d for PCI function 0x%x",
+			zdev->pending_errs.count, zdev->fid);
+	memset(&zdev->pending_errs, 0, sizeof(struct zpci_ccdf_pending));
+}
+EXPORT_SYMBOL_GPL(zpci_stop_mediated_recovery);
+
 static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev,
 							 struct pci_driver *driver)
 {
@@ -175,7 +186,8 @@ static pci_ers_result_t zpci_event_do_reset(struct pci_dev *pdev,
  * and the platform determines which functions are affected for
  * multi-function devices.
  */
-static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
+static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
+							  struct zpci_ccdf_err *ccdf)
 {
 	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
 	struct zpci_dev *zdev = to_zpci(pdev);
@@ -194,13 +206,6 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	}
 	pdev->error_state = pci_channel_io_frozen;
 
-	if (is_passed_through(pdev)) {
-		pr_info("%s: Cannot be recovered in the host because it is a pass-through device\n",
-			pci_name(pdev));
-		status_str = "failed (pass-through)";
-		goto out_unlock;
-	}
-
 	driver = to_pci_driver(pdev->dev.driver);
 	if (!is_driver_supported(driver)) {
 		if (!driver) {
@@ -216,12 +221,25 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 		goto out_unlock;
 	}
 
+	zpci_store_pci_error(pdev, ccdf);
+
 	ers_res = zpci_event_notify_error_detected(pdev, driver);
 	if (ers_result_indicates_abort(ers_res)) {
 		status_str = "failed (abort on detection)";
 		goto out_unlock;
 	}
 
+	mutex_lock(&zdev->pending_errs_lock);
+	if (zdev->pending_errs.mediated_recovery) {
+		pr_info("%s: Leaving recovery of pass-through device to user-space\n",
+			pci_name(pdev));
+		ers_res = PCI_ERS_RESULT_RECOVERED;
+		status_str = "in progress";
+		mutex_unlock(&zdev->pending_errs_lock);
+		goto out_unlock;
+	}
+	mutex_unlock(&zdev->pending_errs_lock);
+
 	if (ers_res != PCI_ERS_RESULT_NEED_RESET) {
 		ers_res = zpci_event_do_error_state_clear(pdev, driver);
 		if (ers_result_indicates_abort(ers_res)) {
@@ -266,25 +284,19 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
  * @pdev: PCI function for which to report
  * @es: PCI channel failure state to report
  */
-static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es)
+static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es,
+				  struct zpci_ccdf_err *ccdf)
 {
 	struct pci_driver *driver;
 
 	pci_dev_lock(pdev);
 	pdev->error_state = es;
-	/**
-	 * While vfio-pci's error_detected callback notifies user-space QEMU
-	 * reacts to this by freezing the guest. In an s390 environment PCI
-	 * errors are rarely fatal so this is overkill. Instead in the future
-	 * we will inject the error event and let the guest recover the device
-	 * itself.
-	 */
-	if (is_passed_through(pdev))
-		goto out;
+
+	zpci_store_pci_error(pdev, ccdf);
 	driver = to_pci_driver(pdev->dev.driver);
 	if (driver && driver->err_handler && driver->err_handler->error_detected)
 		driver->err_handler->error_detected(pdev, pdev->error_state);
-out:
+
 	pci_dev_unlock(pdev);
 }
 
@@ -330,12 +342,12 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 		break;
 	case 0x0040: /* Service Action or Error Recovery Failed */
 	case 0x003b:
-		zpci_event_io_failure(pdev, pci_channel_io_perm_failure);
+		zpci_event_io_failure(pdev, pci_channel_io_perm_failure, ccdf);
 		break;
 	default: /* PCI function left in the error state attempt to recover */
-		ers_res = zpci_event_attempt_error_recovery(pdev);
+		ers_res = zpci_event_attempt_error_recovery(pdev, ccdf);
 		if (ers_res != PCI_ERS_RESULT_RECOVERED)
-			zpci_event_io_failure(pdev, pci_channel_io_perm_failure);
+			zpci_event_io_failure(pdev, pci_channel_io_perm_failure, ccdf);
 		break;
 	}
 	pci_dev_put(pdev);
diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
index 0990fdb146b7..78a28db00c6d 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -144,24 +144,36 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 {
 	struct zpci_dev *zdev = to_zpci(vdev->pdev);
+	int ret;
 
 	if (!zdev)
 		return -ENODEV;
 
+	zpci_start_mediated_recovery(zdev);
+
 	if (!vdev->vdev.kvm)
 		return 0;
 
+	ret = -ENOENT;
 	if (zpci_kvm_hook.kvm_register)
-		return zpci_kvm_hook.kvm_register(zdev, vdev->vdev.kvm);
+		ret = zpci_kvm_hook.kvm_register(zdev, vdev->vdev.kvm);
 
-	return -ENOENT;
+	if (ret)
+		zpci_stop_mediated_recovery(zdev);
+
+	return ret;
 }
 
 void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
 {
 	struct zpci_dev *zdev = to_zpci(vdev->pdev);
 
-	if (!zdev || !vdev->vdev.kvm)
+	if (!zdev)
+		return;
+
+	zpci_stop_mediated_recovery(zdev);
+
+	if (!vdev->vdev.kvm)
 		return;
 
 	if (zpci_kvm_hook.kvm_unregister)
-- 
2.43.0


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0773803EC;
	Thu, 22 Jan 2026 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111113; cv=none; b=JIHGFDD5FGxXUJsAm1U8X1XJTKZf9S2Kvs3EKjuCZS2BtRyQN8uhF/w84/A+yutxNg/nrNkctJ68yUYyhNcZvRH53egvEzTEL59RsFpwkdgLOPCATBAfzi7/Y1gEx7fcMCbdhPDnwOnxfO9eJu1FeZSUOvzajet78PQPhle4/Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111113; c=relaxed/simple;
	bh=9UIw2iuyvjpO58D3t7uC6pT+I44iThrsuMkzhLS3Lw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g03uJE4LgOc9R3Th8z87+9NBhwxgoim7O13bUF9sO1qEExPHZvnwfB26G7vLZlOtwOpo61mVYgi8oKpSwcFdzUMWW/Ncj76N9BrY0pylrUsfeGDSWhWzvbLyBWi86HRzuNLu3HHvivsPrOC4vRkaGNr7WLYtKL6U86OWy5C4TXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K+XOjVFr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K+XOjVFr"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MDb45u028624;
	Thu, 22 Jan 2026 19:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B3h7xuHWKqpI0/AkD
	OMPMgjp0iE72TMUKWwuCLGJaMQ=; b=K+XOjVFrZI+7IOupc5vlY3T3bADE3EOUg
	rFFRhErYM0uq43zmT17mIAYoGZc4sOEtwvRXQbRhbEA04VhTUVRHuV/ykj9U6V3r
	rjf6JK7i7HVmR+8yh+Jtd8csLWV+WtTPQl4nSWD1riTL8PORHrxRUlV0eW7O3h/+
	jwgdHdbonHTK63xH+WiC6h4hpZzKg4s6D7zVvJ4HAQAWZmWLBod4nJ4NvHuN+rJo
	96CFwDtvYeYmaUdP3DdWFIa85mPlaKzQTnBufedEG0S7CF6Byc3B0BIAow3RH0QF
	PPmB8kpNf/p/XTlDLLhU0rFDjltr/TX70MMfHGSOyWFOOTdyEn5Ug==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60eycxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 19:44:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MHT54U006399;
	Thu, 22 Jan 2026 19:44:47 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf1v64p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 19:44:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60MJijUd57540994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 19:44:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFC4858064;
	Thu, 22 Jan 2026 19:44:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF73558060;
	Thu, 22 Jan 2026 19:44:44 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.216])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jan 2026 19:44:44 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, julianr@linux.ibm.com
Subject: [PATCH v8 6/9] s390/pci: Store PCI error information for passthrough devices
Date: Thu, 22 Jan 2026 11:44:34 -0800
Message-ID: <20260122194437.1903-7-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122194437.1903-1-alifm@linux.ibm.com>
References: <20260122194437.1903-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WMdyn3sR c=1 sm=1 tr=0 ts=69727e31 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=JwDFWkoFWNOLAMzFnh4A:9
X-Proofpoint-GUID: aKStqxVbf7Gv6lLFkBxaSzCJVAuy-0U2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE0OCBTYWx0ZWRfX2P6DWaQ+MfXU
 e1vJOwgHmkYIRnYwj/GfdTtwPkko6SmFhraQ+gSb0C7D5KtjbWuJss7grC7RiekkMfamrUl5zLT
 9rAKQoWXnIbjAPhkhBzqqatucSRxpSynBj2uSajG1BkSXva4c5Nkstq06iJ99sC9yLYLdX6rmi7
 yditBxhw1S++4LGtZzYKRCI6M+j9qMsNFkDmf65oxPrwW4dstTHEJySjvvGtHSH89SRoopAznq3
 rwLiQHAzkXzAcNjwYkbXzeAVz6bQEQZ++gvLPk+7a95ztqJuODtFr21P8DFM5O7vMbJX7lkg87x
 nJaTMcOnT+GgaDfjfJHRriS7J6unrzLJuHawF0uW/WpJ8xaHdmhpYx14TBMmW5RX6sRnvk/S0iM
 ZJGnPnDxbA3s9eOw/1YtSjlExnsVSBMLa8P7UOv9U53TfvFvQwqHCsgiDxLHbrv928wk/TomGWK
 3cbQ7lbs2brGBEVfHCQ==
X-Proofpoint-ORIG-GUID: aKStqxVbf7Gv6lLFkBxaSzCJVAuy-0U2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601220148

For a passthrough device we need co-operation from user space to recover
the device. This would require to bubble up any error information to user
space.  Let's store this error information for passthrough devices, so it
can be retrieved later.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/include/asm/pci.h      | 28 ++++++++++
 arch/s390/pci/pci.c              |  1 +
 arch/s390/pci/pci_event.c        | 95 +++++++++++++++++++-------------
 drivers/vfio/pci/vfio_pci_zdev.c |  2 +
 4 files changed, 88 insertions(+), 38 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index ec8a772bf526..383f6483b656 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -118,6 +118,31 @@ struct zpci_bus {
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
+	u8 count;
+	u8 head;
+	u8 tail;
+	struct zpci_ccdf_err err[ZPCI_ERR_PENDING_MAX];
+};
+
 /* Private data per function */
 struct zpci_dev {
 	struct zpci_bus *zbus;
@@ -193,6 +218,8 @@ struct zpci_dev {
 	struct iommu_domain *s390_domain; /* attached IOMMU domain */
 	struct kvm_zdev *kzdev;
 	struct mutex kzdev_lock;
+	struct zpci_ccdf_pending pending_errs;
+	struct mutex pending_errs_lock;
 	spinlock_t dom_lock;		/* protect s390_domain change */
 };
 
@@ -331,6 +358,7 @@ void zpci_debug_exit_device(struct zpci_dev *);
 int zpci_report_error(struct pci_dev *, struct zpci_report_error_header *);
 int zpci_clear_error_state(struct zpci_dev *zdev);
 int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
+void zpci_cleanup_pending_errors(struct zpci_dev *zdev);
 
 #ifdef CONFIG_NUMA
 
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 81e7e6b689d1..5f7412b6bb57 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -902,6 +902,7 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
 	mutex_init(&zdev->state_lock);
 	mutex_init(&zdev->fmb_lock);
 	mutex_init(&zdev->kzdev_lock);
+	mutex_init(&zdev->pending_errs_lock);
 
 	return zdev;
 
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index de504925f709..9f4ccd79771a 100644
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
@@ -75,6 +58,42 @@ static bool is_driver_supported(struct pci_driver *driver)
 	return true;
 }
 
+static void zpci_store_pci_error(struct pci_dev *pdev,
+				 struct zpci_ccdf_err *ccdf)
+{
+	struct zpci_dev *zdev = to_zpci(pdev);
+	int i;
+
+	mutex_lock(&zdev->pending_errs_lock);
+	if (zdev->pending_errs.count >= ZPCI_ERR_PENDING_MAX) {
+		pr_err("%s: Maximum number (%d) of pending error events queued",
+		       pci_name(pdev), ZPCI_ERR_PENDING_MAX);
+		mutex_unlock(&zdev->pending_errs_lock);
+		return;
+	}
+
+	i = zdev->pending_errs.tail % ZPCI_ERR_PENDING_MAX;
+	memcpy(&zdev->pending_errs.err[i], ccdf, sizeof(struct zpci_ccdf_err));
+	zdev->pending_errs.tail++;
+	zdev->pending_errs.count++;
+	mutex_unlock(&zdev->pending_errs_lock);
+}
+
+void zpci_cleanup_pending_errors(struct zpci_dev *zdev)
+{
+	struct pci_dev *pdev = NULL;
+
+	mutex_lock(&zdev->pending_errs_lock);
+	pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
+	if (zdev->pending_errs.count)
+		pr_info("%s: Unhandled PCI error events count=%d",
+			pci_name(pdev), zdev->pending_errs.count);
+	memset(&zdev->pending_errs, 0, sizeof(struct zpci_ccdf_pending));
+	pci_dev_put(pdev);
+	mutex_unlock(&zdev->pending_errs_lock);
+}
+EXPORT_SYMBOL_GPL(zpci_cleanup_pending_errors);
+
 static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev,
 							 struct pci_driver *driver)
 {
@@ -169,7 +188,8 @@ static pci_ers_result_t zpci_event_do_reset(struct pci_dev *pdev,
  * and the platform determines which functions are affected for
  * multi-function devices.
  */
-static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
+static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
+							  struct zpci_ccdf_err *ccdf)
 {
 	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
 	struct zpci_dev *zdev = to_zpci(pdev);
@@ -188,13 +208,6 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	}
 	pdev->error_state = pci_channel_io_frozen;
 
-	if (needs_mediated_recovery(pdev)) {
-		pr_info("%s: Cannot be recovered in the host because it is a pass-through device\n",
-			pci_name(pdev));
-		status_str = "failed (pass-through)";
-		goto out_unlock;
-	}
-
 	driver = to_pci_driver(pdev->dev.driver);
 	if (!is_driver_supported(driver)) {
 		if (!driver) {
@@ -210,12 +223,23 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 		goto out_unlock;
 	}
 
+	if (needs_mediated_recovery(pdev))
+		zpci_store_pci_error(pdev, ccdf);
+
 	ers_res = zpci_event_notify_error_detected(pdev, driver);
 	if (ers_result_indicates_abort(ers_res)) {
 		status_str = "failed (abort on detection)";
 		goto out_unlock;
 	}
 
+	if (needs_mediated_recovery(pdev)) {
+		pr_info("%s: Leaving recovery of pass-through device to user-space\n",
+			pci_name(pdev));
+		ers_res = PCI_ERS_RESULT_RECOVERED;
+		status_str = "in progress";
+		goto out_unlock;
+	}
+
 	if (ers_res != PCI_ERS_RESULT_NEED_RESET) {
 		ers_res = zpci_event_do_error_state_clear(pdev, driver);
 		if (ers_result_indicates_abort(ers_res)) {
@@ -260,25 +284,20 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
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
+
 	if (needs_mediated_recovery(pdev))
-		goto out;
+		zpci_store_pci_error(pdev, ccdf);
 	driver = to_pci_driver(pdev->dev.driver);
 	if (driver && driver->err_handler && driver->err_handler->error_detected)
 		driver->err_handler->error_detected(pdev, pdev->error_state);
-out:
+
 	pci_dev_unlock(pdev);
 }
 
@@ -324,12 +343,12 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
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
index a7bc23ce8483..2be37eab9279 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -168,6 +168,8 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
 
 	zdev->mediated_recovery = false;
 
+	zpci_cleanup_pending_errors(zdev);
+
 	if (!vdev->vdev.kvm)
 		return;
 
-- 
2.43.0


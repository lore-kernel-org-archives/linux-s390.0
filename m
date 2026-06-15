Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47EE37F731;
	Mon, 15 Jun 2026 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548589; cv=none; b=OTJrsYTxD+DnvR8ZGKpH1SeMcmcFBWR2mpQuxc+Z8NqGF2FmCYpWCuHrfcx1RS1LlDiD+DAmaigjAT8IEaabiQXzmiAfHpL7hlPCH6+M0oAmmuOQd81z1IPCBlNEHplpDIZm5p+B0W8VVzyI+tSCxFNwC4qw0lbuR3u0vLGaOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548589; c=relaxed/simple;
	bh=Fu78Q2KQbpig71vWhoCyCMsqVC0DLWcYAM3xkIPM4PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOrygoQENCQMmRKiGtLWMJtLWBk1hYAT/SogD2rq0iv2H9Eia84B5kvhqpkeNOKyR488l6HVG5LdjFBgpG67ZnKU61wmRy0EdDV6eDiWlm1xbS2+kB/+au9u51DEbBvl85tvLMt7E80eHCOp+7PGSakw1gXzhGZQbl6NSBDnZuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L3pyKW59; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L3pyKW59"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFm7Yl2850793;
	Mon, 15 Jun 2026 18:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6Rb2uqd7Lj+HJr1AM
	fAEDaZ8uE6Ks/P/5V7LkIsnFh8=; b=L3pyKW59dNLDucuNmFA/henPSWjNedqr/
	RwiP2uIkmKBjYXJU/YLK8x2vAHZy07HUbGh+sx+zzMCUuND1QOmlJOAN1p2Rw48m
	0Yx5gXHY1opc3slTTlSTRo7vwTQePu2YJRIair1t0tL//ruVR5BrMAv2nkC6JfXV
	P4lRbDR4PQc1JaXimCZl6f1+21/frjGvSbRM1AxoxvVYAJ4GshfYiXxs20XEgmy9
	vHonA2ckqdhjuZgw/DOhZlU6t7y9VUG3zLHJEL3SnkAe1hRVb1Y/9fbc7tAhT0vV
	uWalrEPIjAH5PPqrteSxRERxXI+GgKyv/T3sUamPU0G/nauhMF5fA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm22n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:36:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FIYliD026788;
	Mon, 15 Jun 2026 18:36:20 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhq01fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:36:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FIaJCw17367748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 18:36:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6F5F58055;
	Mon, 15 Jun 2026 18:36:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C36C58043;
	Mon, 15 Jun 2026 18:36:18 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.186])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 18:36:18 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v19 1/3] s390/pci: Store PCI error information for passthrough devices
Date: Mon, 15 Jun 2026 11:36:14 -0700
Message-ID: <20260615183616.2902-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615183616.2902-1-alifm@linux.ibm.com>
References: <20260615183616.2902-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfXw6ygXX8kNrha
 qvHT3d1nEcg7k5qrFF8zAkSh03We1bakwQIV6KyGBKy3NlSnhZHHesWXqpA2cainzsQZEwmekxm
 Hfp4kM9j5s49tBTnfyrToVZOcxGSnJI=
X-Proofpoint-GUID: spnXhKtUnHgurCFYOlT-BE4Cg42Bxqgg
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a304625 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=PQMJTAmWB74Go-Ie6_gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX7OsnX2CkhKqy
 0V+p6DSH5LgvfLJ7xLhvALBnqd+Z7cHZPpetE48HugbmCAx6KttuGQDXlif8YKJJYOIEl7trO76
 68iDYNtNjkjybbF8Di3lOlZtJDL5Fi7ZUgrqxyiRkxz8Vj/gQii+sqQ+1cZsrw+jDFhoImB7L+Y
 +LqoR74qiXaa0mHk0uDCFF86dDQGaXhXu/b0r5GN9T3Qm8L2dwiVqfOzQfFxsN3bRzlJXGJjpNd
 G7tkRd8xAo2Q5HRn7z2oJNQ1n9R7rg9RZ8zvs9+kdjRO1UnlPhNekE5lCPITTsr1Y5fzV+4sNkk
 /LTJYf5bxmTvHwyXBzDuIH0p0yCCXCtZKYXLo9kuuVKT7zNlAhfR6WqF24Cedrq0esGyyg1RmbF
 85NFRifQx2MOZ9DRcooPoAhcQh2xaxUC/xw9IebcPFH4H0uMBmMeLsOvYeF4SZqXZObEv+Y88rg
 CNG4iABqpB9wVHcz5Cg==
X-Proofpoint-ORIG-GUID: spnXhKtUnHgurCFYOlT-BE4Cg42Bxqgg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150194

For a passthrough device we need co-operation from user space to recover
the device. This would require to bubble up any error information to user
space.  Let's store this error information for passthrough devices, so it
can be retrieved later.

We can now have userspace drivers (vfio-pci based) on s390x. The userspace
drivers will not have any KVM fd and so no kzdev associated with them. So
we need to update the logic for detecting passthrough devices to not depend
on struct kvm_zdev.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/include/asm/pci.h      |  30 ++++++++
 arch/s390/pci/pci.c              |   1 +
 arch/s390/pci/pci_event.c        | 118 ++++++++++++++++++-------------
 drivers/vfio/pci/vfio_pci_zdev.c |  18 ++++-
 4 files changed, 113 insertions(+), 54 deletions(-)

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
index 839bd91c056e..8934b640a095 100644
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
@@ -81,6 +52,49 @@ static bool is_driver_supported(struct pci_driver *driver)
 	return true;
 }
 
+static int zpci_store_pci_error(struct pci_dev *pdev,
+				 struct zpci_ccdf_err *ccdf)
+{
+	struct zpci_dev *zdev = to_zpci(pdev);
+	int i;
+
+	guard(mutex)(&zdev->pending_errs_lock);
+	if (!zdev->pending_errs.mediated_recovery)
+		return -EINVAL;
+
+	if (zdev->pending_errs.count >= ZPCI_ERR_PENDING_MAX) {
+		dev_warn_ratelimited(&pdev->dev,
+				     "%s: Maximum number (%d) of pending error events queued\n",
+				     pci_name(pdev),
+				     ZPCI_ERR_PENDING_MAX);
+		return -ENOMEM;
+	}
+
+	i = zdev->pending_errs.tail % ZPCI_ERR_PENDING_MAX;
+	memcpy(&zdev->pending_errs.err[i], ccdf, sizeof(struct zpci_ccdf_err));
+	zdev->pending_errs.tail++;
+	zdev->pending_errs.count++;
+	return 0;
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
+		pr_info("Unhandled PCI error events count=%d for PCI function 0x%x\n",
+			zdev->pending_errs.count, zdev->fid);
+	memset(&zdev->pending_errs, 0, sizeof(struct zpci_ccdf_pending));
+}
+EXPORT_SYMBOL_GPL(zpci_stop_mediated_recovery);
+
 static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev,
 							 struct pci_driver *driver)
 {
@@ -175,12 +189,15 @@ static pci_ers_result_t zpci_event_do_reset(struct pci_dev *pdev,
  * and the platform determines which functions are affected for
  * multi-function devices.
  */
-static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
+static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
+							  struct zpci_ccdf_err *ccdf)
 {
 	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
 	struct zpci_dev *zdev = to_zpci(pdev);
+	bool mediated_recovery = false;
 	char *status_str = "success";
 	struct pci_driver *driver;
+	int rc;
 
 	/*
 	 * Ensure that the PCI function is not removed concurrently, no driver
@@ -194,13 +211,6 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
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
@@ -216,12 +226,24 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 		goto out_unlock;
 	}
 
+	rc = zpci_store_pci_error(pdev, ccdf);
+	if (!rc || rc == -ENOMEM)
+		mediated_recovery = true;
+
 	ers_res = zpci_event_notify_error_detected(pdev, driver);
 	if (ers_result_indicates_abort(ers_res)) {
 		status_str = "failed (abort on detection)";
 		goto out_unlock;
 	}
 
+	if (mediated_recovery) {
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
@@ -266,25 +288,19 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
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
 
@@ -330,12 +346,12 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
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


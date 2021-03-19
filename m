Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08F3C433C1
	for <linux-s390@archiver.kernel.org>; Fri, 19 Mar 2021 18:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 817D161979
	for <linux-s390@archiver.kernel.org>; Fri, 19 Mar 2021 18:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhCSSj0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 Mar 2021 14:39:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231234AbhCSSjC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Mar 2021 14:39:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12JIYkJT161697;
        Fri, 19 Mar 2021 14:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=BOH7TQv1wsE3dEoU3qqN+5EXplktNRzzQe64eQZnSAI=;
 b=IE2eoWRnSER3c8+QDiVzMG3AkcCLhJ0JDAX4AWDS4l00a/1BdiFmXtKM/U9lGBpKP1Kd
 W/Ikne0mEKSJnngrkxWiiyB0aG/4VlQtI+BrCMahfckzgd9Hlzs5MyleFy1Jnyy8l9it
 NQptlVFLCLYbaIknm6LaCNYJv9lY+xTLO/MUoPfoPPiEKcmGH8oBO6IWjwGoq7sBEDMi
 Bc+UT+S5nKSOQhl3AfW25Fd4dBoeC51p/Q4nW5Zw2T437FSMa5JO8NFNFoRkeqXv9YZP
 rGWcr1RkhXDMNl7Ai1zwpdQ+nEZIO8YRG4nyBrP6UZ/mDV6XllrMZxuWFUuewL7D26JP 7Q== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37c6tgaadk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 14:39:00 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12JIa16O030010;
        Fri, 19 Mar 2021 18:38:59 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 37brpfrygt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 18:38:58 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12JIccPI34734536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 18:38:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D42FE4204C;
        Fri, 19 Mar 2021 18:38:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 982F442052;
        Fri, 19 Mar 2021 18:38:55 +0000 (GMT)
Received: from osiris (unknown [9.171.9.107])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 19 Mar 2021 18:38:55 +0000 (GMT)
Date:   Fri, 19 Mar 2021 19:38:54 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.12-rc4
Message-ID: <YFTvvrxm7BxAPIP5@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_10:2021-03-19,2021-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103190125
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Linus,

please pull three s390 specific bug fixes for 5.12-rc4.

Thanks,
Heiko

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-4

for you to fetch changes up to 0b13525c20febcfecccf6fc1db5969727401317d:

  s390/pci: fix leak of PCI device structure (2021-03-15 19:10:56 +0100)

----------------------------------------------------------------
s390 updates for 5.12-rc4

- disable preemption when accessing local per-cpu variables in the new
  counter set driver

- fix by a factor of four increased steal time due to missing
  cputime_to_nsecs() conversion

- fix PCI device structure leak

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/vtime: fix increased steal time accounting

Niklas Schnelle (1):
      s390/pci: fix leak of PCI device structure

Thomas Richter (1):
      s390/cpumf: disable preemption when accessing per-cpu variable

 arch/s390/include/asm/pci.h          |  2 +-
 arch/s390/kernel/perf_cpum_cf_diag.c |  3 ++-
 arch/s390/kernel/vtime.c             |  2 +-
 arch/s390/pci/pci.c                  | 28 ++++++++++++++++++++++++----
 arch/s390/pci/pci_event.c            | 18 ++++++------------
 drivers/pci/hotplug/s390_pci_hpc.c   |  3 ++-
 6 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 053fe8b8dec7..a75d94a9bcb2 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -202,7 +202,7 @@ extern unsigned int s390_pci_no_rid;
 ----------------------------------------------------------------------------- */
 /* Base stuff */
 int zpci_create_device(u32 fid, u32 fh, enum zpci_state state);
-void zpci_remove_device(struct zpci_dev *zdev);
+void zpci_remove_device(struct zpci_dev *zdev, bool set_error);
 int zpci_enable_device(struct zpci_dev *);
 int zpci_disable_device(struct zpci_dev *);
 int zpci_register_ioat(struct zpci_dev *, u8, u64, u64, u64);
diff --git a/arch/s390/kernel/perf_cpum_cf_diag.c b/arch/s390/kernel/perf_cpum_cf_diag.c
index bc302b86ce28..2e3e7edbe3a0 100644
--- a/arch/s390/kernel/perf_cpum_cf_diag.c
+++ b/arch/s390/kernel/perf_cpum_cf_diag.c
@@ -968,7 +968,7 @@ static int cf_diag_all_start(void)
  */
 static size_t cf_diag_needspace(unsigned int sets)
 {
-	struct cpu_cf_events *cpuhw = this_cpu_ptr(&cpu_cf_events);
+	struct cpu_cf_events *cpuhw = get_cpu_ptr(&cpu_cf_events);
 	size_t bytes = 0;
 	int i;
 
@@ -984,6 +984,7 @@ static size_t cf_diag_needspace(unsigned int sets)
 		     sizeof(((struct s390_ctrset_cpudata *)0)->no_sets));
 	debug_sprintf_event(cf_diag_dbg, 5, "%s bytes %ld\n", __func__,
 			    bytes);
+	put_cpu_ptr(&cpu_cf_events);
 	return bytes;
 }
 
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 73c7afcc0527..f216a1b2f825 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -214,7 +214,7 @@ void vtime_flush(struct task_struct *tsk)
 	avg_steal = S390_lowcore.avg_steal_timer / 2;
 	if ((s64) steal > 0) {
 		S390_lowcore.steal_timer = 0;
-		account_steal_time(steal);
+		account_steal_time(cputime_to_nsecs(steal));
 		avg_steal += steal;
 	}
 	S390_lowcore.avg_steal_timer = avg_steal;
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 600881d894dd..91064077526d 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -682,16 +682,36 @@ int zpci_disable_device(struct zpci_dev *zdev)
 }
 EXPORT_SYMBOL_GPL(zpci_disable_device);
 
-void zpci_remove_device(struct zpci_dev *zdev)
+/* zpci_remove_device - Removes the given zdev from the PCI core
+ * @zdev: the zdev to be removed from the PCI core
+ * @set_error: if true the device's error state is set to permanent failure
+ *
+ * Sets a zPCI device to a configured but offline state; the zPCI
+ * device is still accessible through its hotplug slot and the zPCI
+ * API but is removed from the common code PCI bus, making it
+ * no longer available to drivers.
+ */
+void zpci_remove_device(struct zpci_dev *zdev, bool set_error)
 {
 	struct zpci_bus *zbus = zdev->zbus;
 	struct pci_dev *pdev;
 
+	if (!zdev->zbus->bus)
+		return;
+
 	pdev = pci_get_slot(zbus->bus, zdev->devfn);
 	if (pdev) {
-		if (pdev->is_virtfn)
-			return zpci_iov_remove_virtfn(pdev, zdev->vfn);
+		if (set_error)
+			pdev->error_state = pci_channel_io_perm_failure;
+		if (pdev->is_virtfn) {
+			zpci_iov_remove_virtfn(pdev, zdev->vfn);
+			/* balance pci_get_slot */
+			pci_dev_put(pdev);
+			return;
+		}
 		pci_stop_and_remove_bus_device_locked(pdev);
+		/* balance pci_get_slot */
+		pci_dev_put(pdev);
 	}
 }
 
@@ -765,7 +785,7 @@ void zpci_release_device(struct kref *kref)
 	struct zpci_dev *zdev = container_of(kref, struct zpci_dev, kref);
 
 	if (zdev->zbus->bus)
-		zpci_remove_device(zdev);
+		zpci_remove_device(zdev, false);
 
 	switch (zdev->state) {
 	case ZPCI_FN_STATE_ONLINE:
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index b4162da4e8a2..ac0c65cdd69d 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -76,13 +76,10 @@ void zpci_event_error(void *data)
 static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 {
 	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
-	struct pci_dev *pdev = NULL;
 	enum zpci_state state;
+	struct pci_dev *pdev;
 	int ret;
 
-	if (zdev && zdev->zbus->bus)
-		pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
-
 	zpci_err("avail CCDF:\n");
 	zpci_err_hex(ccdf, sizeof(*ccdf));
 
@@ -124,8 +121,7 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 	case 0x0303: /* Deconfiguration requested */
 		if (!zdev)
 			break;
-		if (pdev)
-			zpci_remove_device(zdev);
+		zpci_remove_device(zdev, false);
 
 		ret = zpci_disable_device(zdev);
 		if (ret)
@@ -140,12 +136,10 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 	case 0x0304: /* Configured -> Standby|Reserved */
 		if (!zdev)
 			break;
-		if (pdev) {
-			/* Give the driver a hint that the function is
-			 * already unusable. */
-			pdev->error_state = pci_channel_io_perm_failure;
-			zpci_remove_device(zdev);
-		}
+		/* Give the driver a hint that the function is
+		 * already unusable.
+		 */
+		zpci_remove_device(zdev, true);
 
 		zdev->fh = ccdf->fh;
 		zpci_disable_device(zdev);
diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
index c9e790c74051..a047c421debe 100644
--- a/drivers/pci/hotplug/s390_pci_hpc.c
+++ b/drivers/pci/hotplug/s390_pci_hpc.c
@@ -93,8 +93,9 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
 		pci_dev_put(pdev);
 		return -EBUSY;
 	}
+	pci_dev_put(pdev);
 
-	zpci_remove_device(zdev);
+	zpci_remove_device(zdev, false);
 
 	rc = zpci_disable_device(zdev);
 	if (rc)

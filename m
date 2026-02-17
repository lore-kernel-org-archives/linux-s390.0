Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87C7374167;
	Tue, 17 Feb 2026 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352597; cv=none; b=uBZOrWSZRk9cyeDIdVjLx0sEM90SYRL6P05Ulz+IPKRvnPyxNddudZCo5gjNBjfBvzY7mfd7B75kD8U+3SxvFrXxugMRliesqlA3MsUpfj9Jk+qtRvJCTXdqlGrcnV/QOGq7mJW5HjTjRzUju7JgYT4FU06fJdxq3w05GyaUiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352597; c=relaxed/simple;
	bh=Dl44cojdkrbOgz7OGnWK4SZITJpO4H3rbatvSyA7VZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jrqtc/o4C7HeNenazwMt9d4TZx/ftnY1mnYWrtqVyrvyII5UxsCTrSQInIYOtqILo8lfQFZeFFVlWuD065NUmZ3bSwDV+Y3aZFj6OoBRVza88rOJZR5T+AfxB6r3JJKio0o7FCoQiMsBbsfeM37LEokK8VH7qxPfMEHW10f/TNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ekwOwdag; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ekwOwdag"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HG5F6L2616022;
	Tue, 17 Feb 2026 18:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ijoU0uqIQ0OGxfqCL
	84PUTuv0JTag63LZuisjraDBW4=; b=ekwOwdagL6umvfLZNjH4m0oSQBqs6/ad9
	SztPcqBaLwvnW6Aqi+3kPe7zULTrnkFDZA6rS4IXQTFupLV2xTcVfYQiHqcH3WZK
	YDNj7tXRYZ2sMCZxQoPpFUIxKeEP6XJiREIt87dOBMFFwHD1XrqatSoUS2UbhnJU
	Ejx7bwndwZ1ucyrz2EAi0EeDZP3GSuLK0MIu1FieKQVjU5pFSdT5Kq3QUpXW9bZQ
	VJNAoM89PvoSrqIWy2QqEIP4hPz1mfXgAummMI8021mNzuSfKUq8vyJhv+DyMFn+
	028mkEIYma563RP6kXHOi910LEfg8PL6xfDflXjA8njTDQqoo2VLg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6unjwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:23:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HFpo7W017792;
	Tue, 17 Feb 2026 18:23:03 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28c3x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:23:03 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HIN1rS31261314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 18:23:02 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C28AF58065;
	Tue, 17 Feb 2026 18:23:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0F4058052;
	Tue, 17 Feb 2026 18:23:00 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.249])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 18:23:00 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v9 3/9] PCI: Avoid saving config space state in reset path
Date: Tue, 17 Feb 2026 10:22:51 -0800
Message-ID: <20260217182257.1582-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217182257.1582-1-alifm@linux.ibm.com>
References: <20260217182257.1582-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=6994b209 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=hbZPLYCdMM6bdNz2SwkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE0OCBTYWx0ZWRfXzu7tBop/26/O
 dyqM8W/yAqq7n5M+YJiqVG3G7AjzQ0FW7HQRL6hg06UIpNGdJiMTRaFR6EhScAcIB6cyBdcI3cw
 91tHjYemFlZ1XOkGXiW07Vf8F8jOhklEjISmJsZUEYxRpzhr5RGMt0+smCPrrCC9XrXON4CbAq3
 jEw6pVOhp04ZHaCN7mbi2WxQzh0K76OvRY2qn4erPOa+denS0chfATSPsADXVqyRbMqI6Msqg+8
 A23qyhHk1uRQLrXY0njkEVtyuZnjOQ9+Z3ApzLIZNonXG8nbn567PlOUrUSXEoygYqffUL0hXE8
 HI8OLD4bUdbv/gk7UVBcFcLKH374CTZiaC8BZmR3mzykdbk5d9d9MM42GI7gUObphozpiFv+Kg8
 hSgPD1bZMDGX2C5/Enomhvxx3Hw7tSXJKUaKeP8sIxnGvNrKZQGjm/DT98hHCXmWnJcX34hYFim
 WI2WSPYIzaw1JhN1wuQ==
X-Proofpoint-ORIG-GUID: xERkUY4qU36jSMR8DLK3le5_fVuTp6nC
X-Proofpoint-GUID: g75EdxLNhCONvZs-rE4XixChsgVPXg9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170148

The current reset process saves the device's config space state before
reset and restores it afterward. However errors may occur unexpectedly and
it may then be impossible to save config space because the device may be
inaccessible (e.g. DPC) or config space may be corrupted. This results in
saving corrupted values that get written back to the device during state
restoration.

Since commit a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all times"),
we now save the state of device at enumeration. On every restore we should
either use the enumeration saved state or driver's intentional saved state,
never a state saved at the unpredictable time of an error recovery reset.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3090c727b76f..2242b97e7d46 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5012,7 +5012,7 @@ void pci_dev_unlock(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_dev_unlock);
 
-static void pci_dev_save_and_disable(struct pci_dev *dev)
+static void pci_dev_disable(struct pci_dev *dev)
 {
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
@@ -5029,13 +5029,11 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 		pci_warn(dev, "resetting");
 
 	/*
-	 * Wake-up device prior to save.  PM registers default to D0 after
-	 * reset and a simple register restore doesn't reliably return
-	 * to a non-D0 state anyway.
+	 * PM registers default to D0 after reset and a simple register
+	 * restore doesn't reliably return to a non-D0 state.
 	 */
 	pci_set_power_state(dev, PCI_D0);
 
-	pci_save_state(dev);
 	/*
 	 * Disable the device by clearing the Command register, except for
 	 * INTx-disable which is set.  This not only disables MMIO and I/O port
@@ -5199,7 +5197,7 @@ int pci_reset_function(struct pci_dev *dev)
 		pci_dev_lock(bridge);
 
 	pci_dev_lock(dev);
-	pci_dev_save_and_disable(dev);
+	pci_dev_disable(dev);
 
 	rc = __pci_reset_function_locked(dev);
 
@@ -5241,7 +5239,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
 	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
-	pci_dev_save_and_disable(dev);
+	pci_dev_disable(dev);
 
 	rc = __pci_reset_function_locked(dev);
 
@@ -5267,7 +5265,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 	if (!pci_dev_trylock(dev))
 		return -EAGAIN;
 
-	pci_dev_save_and_disable(dev);
+	pci_dev_disable(dev);
 	rc = __pci_reset_function_locked(dev);
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
@@ -5441,17 +5439,17 @@ static int pci_slot_trylock(struct pci_slot *slot)
 }
 
 /*
- * Save and disable devices from the top of the tree down while holding
+ * Disable devices from the top of the tree down while holding
  * the @dev mutex lock for the entire tree.
  */
-static void pci_bus_save_and_disable_locked(struct pci_bus *bus)
+static void pci_bus_disable_locked(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_save_and_disable(dev);
+		pci_dev_disable(dev);
 		if (dev->subordinate)
-			pci_bus_save_and_disable_locked(dev->subordinate);
+			pci_bus_disable_locked(dev->subordinate);
 	}
 }
 
@@ -5477,16 +5475,16 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
  * Save and disable devices from the top of the tree down while holding
  * the @dev mutex lock for the entire tree.
  */
-static void pci_slot_save_and_disable_locked(struct pci_slot *slot)
+static void pci_slot_disable_locked(struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-		pci_dev_save_and_disable(dev);
+		pci_dev_disable(dev);
 		if (dev->subordinate)
-			pci_bus_save_and_disable_locked(dev->subordinate);
+			pci_bus_disable_locked(dev->subordinate);
 	}
 }
 
@@ -5566,7 +5564,7 @@ static int __pci_reset_slot(struct pci_slot *slot)
 		return rc;
 
 	if (pci_slot_trylock(slot)) {
-		pci_slot_save_and_disable_locked(slot);
+		pci_slot_disable_locked(slot);
 		might_sleep();
 		rc = pci_reset_hotplug_slot(slot->hotplug, PCI_RESET_DO_RESET);
 		pci_slot_restore_locked(slot);
@@ -5660,7 +5658,7 @@ int __pci_reset_bus(struct pci_bus *bus)
 		return rc;
 
 	if (pci_bus_trylock(bus)) {
-		pci_bus_save_and_disable_locked(bus);
+		pci_bus_disable_locked(bus);
 		might_sleep();
 		rc = pci_bridge_secondary_bus_reset(bus->self);
 		pci_bus_restore_locked(bus);
-- 
2.43.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C411D3D9049;
	Mon,  8 Jun 2026 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939222; cv=none; b=Yx/jPINAVud0cygyqwi8NBZU/znnW7pWOW4JQeCjKLx+S/8hIAWhZH3GoV+HOqi6nT+L18tcV5HDdJku8A4onerjOcZsjvyHPnaXgmVooD+w5i+xY4EtrqvU+V/Vu0O7iyC6hqyoXWhfiqMfKetnTctpMV2S7q+ADzCMsvEwpag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939222; c=relaxed/simple;
	bh=lGYWXHOh1KO3b7KM58MKy3iF6WpXrtwyauv0s/bMl+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsFiE+xK8wrxzgoFrnI0TYE1HEFHdKl/vJAMLMYsvrQSi5Gtn36p+SrdyrlPgZcDAKRBi1SxQZ6BcJHvom0ub4v6wL6e8h5xfIF0dinyPtVl1nuAxlfBMsow7fMOyzW3r12P7xY8spNjpxC+Et9agkALE1/YDIbXcYuesh9WvQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TCq/8MqB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TCq/8MqB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DlC48458596;
	Mon, 8 Jun 2026 17:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iWVLpdzEPDvmlH+4K
	Qy4naQGATN6IZkCBJo61YTYJrM=; b=TCq/8MqBL3nu+icBmjEHYOKTZfcHGp8EA
	n6c0hUUa/UJ5qJWyhtIFG1EHSROZK6OsQHjdPMlrGXBmbpg/dfyCGqcnVSdKrsyR
	YRAlVZcyfZjJYpFqP68MvfJKPXBnsjn3IaQi3U2oxD61XjHihQEL+sm/AsbKOFfr
	JPSfrctIjKZCLfv+ZfPk1skcsrmxzgHfQ3QLeWEBlOsEmfM9E8uZmnYhYbBO4E8F
	Scedogj8eTHaRkW66bY7syINI6mS7wR40h4N4Ng5m+j422/MrYr1NuTQlGmdhcOo
	YklYquZiNgGYB8m/FENTf8FrKGvSEkw6Vp5onJLO5fdU6rU764dmQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye0en5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 17:20:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658HJfOh019267;
	Mon, 8 Jun 2026 17:20:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgx92y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 17:20:17 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658HKEFC19923496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 17:20:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 280B35804E;
	Mon,  8 Jun 2026 17:20:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C844958055;
	Mon,  8 Jun 2026 17:20:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.12.78.81])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 17:20:12 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v3 2/4] s390/pci: Preserve FMB state in device re-enablement
Date: Mon,  8 Jun 2026 13:18:48 -0400
Message-ID: <20260608171850.62829-3-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608171850.62829-1-oelghoul@linux.ibm.com>
References: <20260608171850.62829-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2MiBTYWx0ZWRfX41G65X6z8E5+
 V7LCWxW1WYxpJbl/dQ6U5+6zL2UbxjaO2mFUB/Y9MY3QscPCVDGEa7LAJ3K0RcQSLPI9KNCoYO/
 rB9RmN63bVwidZnXa0ouGGRqnVSNFE9dXSlgqMa9w0/KdFBhC5J6WbCGQr5b6rnj4MLomGEbBPs
 FO1vxE966e3WxgMD+nHgHFGdf0qO15WkeoXLPisL4NtuYA0lBsgK8fl4SfedFUgnivviVS6k0BJ
 LFWa7O+sSUU3fqsyXeMEaBHkdWiO4Cn6UIatDPPLlLEYTJMu2b4KLeQlHSM1cod0/4jn+wmGyGl
 JIKcKAHqPKBLj77cKP3G9do2qexIHJTamInTKK8GcEfl4miElMipP1ekagzwSIf+KxDuCA9XPcH
 4vxtd4wWKvkxkrKYECViPurSVCH+Grnkihz5P+vA48ElqtRvwZYCUcjrWYtipE3DYOvKZdFKXww
 p6Vmp1S812IEv+IEWjQ==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a26f9d2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=6Vtv6p8LYkiH6MEZsLwA:9
X-Proofpoint-GUID: 6QlsgfZDLCv5MbuQL9ogMY3qUyZspVMj
X-Proofpoint-ORIG-GUID: 6QlsgfZDLCv5MbuQL9ogMY3qUyZspVMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080162

Introduce a function zpci_fmb_reenable_device() that checks for the state
of the FMB and reuses the same buffer where appropriate. If the FMB was not
previously enabled, enable it for the device. Call this function during a
zPCI device re-enablement, which in turn implicitly ensures that the FMB is
is enabled for host devices during their KVM registration.

Besides re-enabling the FMB itself in zpci_fmb_reenable_device() also clear
out the software counters, such that a program resetting an FMB sees all
counters start from zero as expected. Separate this clearing of software
counters out into zpci_fmb_clear_iommu_ctrs() and reuse it in
zpci_fmb_enable_device() and zpci_fmb_reenable_device(). Likewise separate
the FMB enable logic into zpci_fmb_do_enable() to be reused in the same two
functions.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         | 96 +++++++++++++++++++++++++++++--------
 2 files changed, 78 insertions(+), 19 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 5dcf35f0f325..65014e52d559 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -323,6 +323,7 @@ void zpci_remove_parent_msi_domain(struct zpci_bus *zbus);
 /* FMB */
 int zpci_fmb_enable_device(struct zpci_dev *);
 int zpci_fmb_disable_device(struct zpci_dev *);
+int zpci_fmb_reenable_device(struct zpci_dev *zdev);
 
 /* Debug */
 int zpci_debug_init(void);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 2910d4038d39..652f0b7e8893 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -164,24 +164,10 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
 	return cc;
 }
 
-/* Modify PCI: Set PCI function measurement parameters */
-int zpci_fmb_enable_device(struct zpci_dev *zdev)
+static void zpci_fmb_clear_iommu_ctrs(struct zpci_dev *zdev)
 {
-	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
 	struct zpci_iommu_ctrs *ctrs;
-	struct zpci_fib fib = {0};
-	unsigned long flags;
-	u8 cc, status;
-
-	lockdep_assert_held(&zdev->fmb_lock);
-
-	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
-		return -EINVAL;
-
-	zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
-	if (!zdev->fmb)
-		return -ENOMEM;
-	WARN_ON((u64) zdev->fmb & 0xf);
+	unsigned long flags = 0;
 
 	/* reset software counters */
 	spin_lock_irqsave(&zdev->dom_lock, flags);
@@ -194,17 +180,49 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 		atomic64_set(&ctrs->sync_rpcits, 0);
 	}
 	spin_unlock_irqrestore(&zdev->dom_lock, flags);
+}
 
+static int zpci_fmb_do_enable(struct zpci_dev *zdev)
+{
+	/* This helper assumes that zdev->fmb is already allocated and thus only
+	 * takes care of the actual enablement.
+	 */
+	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
+	struct zpci_fib fib = {0};
+	u8 cc, status;
 
 	fib.fmb_addr = virt_to_phys(zdev->fmb);
 	fib.gd = zdev->gisa;
 	cc = zpci_mod_fc(req, &fib, &status);
-	if (cc) {
+
+	return cc ? -EIO : 0;
+}
+
+/* Modify PCI: Set PCI function measurement parameters */
+int zpci_fmb_enable_device(struct zpci_dev *zdev)
+{
+	int rc;
+
+	lockdep_assert_held(&zdev->fmb_lock);
+
+	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
+		return -EINVAL;
+
+	zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
+	if (!zdev->fmb)
+		return -ENOMEM;
+	WARN_ON((u64) zdev->fmb & 0xf);
+
+	zpci_fmb_clear_iommu_ctrs(zdev);
+
+	rc = zpci_fmb_do_enable(zdev);
+	if (rc) {
 		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
 		zdev->fmb = NULL;
 	}
-	return cc ? -EIO : 0;
+	return rc;
 }
+EXPORT_SYMBOL_GPL(zpci_fmb_enable_device);
 
 /* Modify PCI: Disable PCI function measurement */
 int zpci_fmb_disable_device(struct zpci_dev *zdev)
@@ -231,6 +249,41 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 	}
 	return cc ? -EIO : 0;
 }
+EXPORT_SYMBOL_GPL(zpci_fmb_disable_device);
+
+int zpci_fmb_reenable_device(struct zpci_dev *zdev)
+{
+	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
+	struct zpci_fib fib = {0};
+	u8 cc, status;
+	int rc;
+
+	lockdep_assert_held(&zdev->fmb_lock);
+
+	if (!zdev->fmb)
+		return zpci_fmb_enable_device(zdev);
+
+	fib.gd = zdev->gisa;
+	cc = zpci_mod_fc(req, &fib, &status); /* Disable function measurement */
+
+	/* Unlike in zpci_fmb_disable_device(), cc == 3 is not a valid state here
+	 * because we are re-enabling function measurement for the same function
+	 * handle.
+	 */
+	if (cc)
+		return -EIO;
+
+	zpci_fmb_clear_iommu_ctrs(zdev);
+
+	rc = zpci_fmb_do_enable(zdev);
+	if (rc) {
+		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
+		zdev->fmb = NULL;
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
 
 static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8 len)
 {
@@ -737,9 +790,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
 	}
 
 	rc = zpci_iommu_register_ioat(zdev, &status);
-	if (rc)
+	if (rc) {
 		zpci_disable_device(zdev);
+		return rc;
+	}
 
+	mutex_lock(&zdev->fmb_lock);
+	zpci_fmb_reenable_device(zdev);
+	mutex_unlock(&zdev->fmb_lock);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(zpci_reenable_device);
-- 
2.54.0


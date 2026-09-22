Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4974A6CCB;
	Tue, 22 Sep 2026 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106729; cv=none; b=F12BX3H2Pd/lJjZTEdUWENeU5CueJBTMVO4kegx3jxaOVT54/RWMJyZVuDEzKekBzpa1pgkd6Ze+ZJfbY1A8VSIcTeBg9W8yh5TQrZzelO05tipphHDYKyAhATHNVkmxeqldWwhVIYclrjTYzZsSXwg80tMCpo5LWiqg+jKc92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106729; c=relaxed/simple;
	bh=QBhmkDMAa8cr35n+rT6ne8SpvZBcC9tHhlL5QyLRz/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABk57uFJru1aVKNPLGvyKDV/XLSmGcDaJqGXwgJT/3IwRvubVmFW/IfwD6UPm5cbRWeaoS2Dxk/CG9LNF3EYLvu1wdNnHqJQlQrMuu/50O2e7PWuhDn/R+qkc1E6XlLMRqXOTquGCHjLjQ9dc6Q0+nOqsQr7sRlmSXFsTP5P7mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VSD1IvwY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VSD1IvwY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI7R7w964628;
	Tue, 22 Sep 2026 19:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q6hiabvjECSV60h3P
	cN8TqF1ioYqUF6qtCyzILAiGgs=; b=VSD1IvwYpAx7RUcim0HZeqGw1il68rElN
	m8r+EQ6sxlIbDTHNNRUeObGszd1Bf0vR7JHv0QEdMtd9Q2lVD9fCKgPtDwdjnKg1
	lAZBH7OyoTC2XgLERL9HIewa3xHrXJUyaa4yq5do9rU5HTmd+V159/n7xdq0XlWv
	I9uPwO62el5g3hEbnAUeydcllbwuZsZc/eAWfV6WufJguZiSmUzvfmQ7y3ixh3v+
	Yrkf2hTzUjxiHONdjCuO4xaehNAcwU3Gw3+0sLd4u4Y98FzYTAzo9Of+RozdMUU7
	pNsTMJ4XaNSBKc7gnYYO71Zld5C237OOUFPEis8vviEsfTdn8+PAw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1fdua-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 19:52:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MIHVDd3239732;
	Tue, 22 Sep 2026 19:52:04 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gu676-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 19:52:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MJq2LG23528096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 19:52:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E76158054;
	Tue, 22 Sep 2026 19:52:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE55558045;
	Tue, 22 Sep 2026 19:52:00 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.246.118])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 19:52:00 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org
Subject: [PATCH v7 2/4] s390/pci: Reuse FMB buffer and preserve state in device re-enablement
Date: Tue, 22 Sep 2026 15:51:39 -0400
Message-ID: <20260922195141.94548-3-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922195141.94548-1-oelghoul@linux.ibm.com>
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pVYBPRtYWfNx_-k3_FePfEJd4cRR-xwe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfX8R4x8FZkTWvQ
 8x4JiUIK9vHibVW80HAHIl7rOZe/B7v2lMI6RlbPLZlh0Xl/8BdVG4epGoCzShydU1Ht/XjbN1e
 3c3Bunal4fZTob+69QFSoDqR0Wq0HctaJ0nnnZK7Rx1SYB7+1bOtHVYyH1BFWd7xJldS+CZE91y
 Y+sOaVQPLhBmewvhWXkemidfmM0Kjha2rH/nTeU+/+3GEWoW751byIxc1tW09TlP63cgyr42yPa
 HQWMc+Gx609XkQENnIZAtUW+/TiJU1J/CStKCX7GV415e0R4gjPiFz+pegQBaH6F5aeSJ5pY+5+
 JmysBTGLRzJd/M2dH6ipGBqZ1sTvn2FCY5ib5wXqMhZzatrbEKRDVa+Lxt0Rkm7ugQFZ8zuiqVR
 oI+Jg3CFrf6NkJ2VWw5Wp81uSm3mo03I8ICSYTlk6cxbzOeFvlbZNMZRP3uhxQxdJH80zcnviJd
 jBjZ2nroIbhBa0xCfgw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab2dc65 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=LP0gC_cnHC4A9rhkzj4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfX9W2Cr9ZNdaxH
 jSlNSJUE/eWgSE1h4wyKtg9fdnvxM42UnUU2c8fvpRMY2Dt3JoGensFjSj72dRzKmqylSRlEREB
 h+EtNHfW5aqKt+i7zdzcgnmWLxk8RDo=
X-Proofpoint-GUID: pVYBPRtYWfNx_-k3_FePfEJd4cRR-xwe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220287

Introduce the function zpci_fmb_reenable_device() that checks the state
of function measurement and ensures it is enabled. Reset the counters to
zero, disable, and re-enable the FMB if it was already enabled. Call
this function from zpci_reenable_device().

Don't free the FMB buffer during disabling and reuse it when re-enabling
measurement. Instead, free the buffer upon device teardown, allowing the
same buffer to be reused in the enable path and add the bit fmb_enabled
to struct zpci_dev. Audit the only consumer of zdev->fmb and update it
to reflect the change in semantics.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  2 +
 arch/s390/pci/pci.c         | 77 +++++++++++++++++++++++++++++--------
 arch/s390/pci/pci_debug.c   |  2 +-
 3 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 88a125b92bdd..b8162f7a8968 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -175,6 +175,7 @@ struct zpci_dev {
 	u8		util_str_avail	: 1;
 	u8		tid_avail	: 1;
 	u8		rtr_avail	: 1; /* Relaxed translation allowed */
+	u8		fmb_enabled	: 1;
 	unsigned int	devfn;		/* DEVFN part of the RID*/
 
 	u8 pfip[CLP_PFIP_NR_SEGMENTS];	/* pci function internal path */
@@ -351,6 +352,7 @@ void zpci_remove_parent_msi_domain(struct zpci_bus *zbus);
 /* FMB */
 int zpci_fmb_enable_device(struct zpci_dev *);
 int zpci_fmb_disable_device(struct zpci_dev *);
+int zpci_fmb_reenable_device(struct zpci_dev *zdev);
 
 /* Debug */
 int zpci_debug_init(void);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index c055a9ad0972..815257ddb6c8 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -175,13 +175,18 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 
 	lockdep_assert_held(&zdev->fmb_lock);
 
-	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
+	if (zdev->fmb_enabled || sizeof(*zdev->fmb) < zdev->fmb_length)
 		return -EINVAL;
 
-	zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
-	if (!zdev->fmb)
-		return -ENOMEM;
-	WARN_ON((u64) zdev->fmb & 0xf);
+	if (!zdev->fmb) {
+		zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
+		if (!zdev->fmb)
+			return -ENOMEM;
+		WARN_ON((u64) zdev->fmb & 0xf);
+	} else {
+		/* FMB buffers are intentionally persistent for later reuse */
+		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
+	}
 
 	/* reset software counters */
 	spin_lock_irqsave(&zdev->dom_lock, flags);
@@ -199,11 +204,11 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 	fib.fmb_addr = virt_to_phys(zdev->fmb);
 	fib.gd = zdev->gisa;
 	cc = zpci_mod_fc(req, &fib, &status);
-	if (cc) {
-		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
-		zdev->fmb = NULL;
-	}
-	return cc ? -EIO : 0;
+	if (cc)
+		return -EIO;
+
+	zdev->fmb_enabled = 1;
+	return 0;
 }
 
 /* Modify PCI: Disable PCI function measurement */
@@ -215,7 +220,7 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 
 	lockdep_assert_held(&zdev->fmb_lock);
 
-	if (!zdev->fmb)
+	if (!zdev->fmb_enabled)
 		return -EINVAL;
 
 	fib.gd = zdev->gisa;
@@ -224,13 +229,39 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 	cc = zpci_mod_fc(req, &fib, &status);
 	if (cc == 3) /* Function already gone. */
 		cc = 0;
+	if (cc)
+		return -EIO;
 
-	if (!cc) {
-		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
-		zdev->fmb = NULL;
-	}
-	return cc ? -EIO : 0;
+	zdev->fmb_enabled = 0;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(zpci_fmb_disable_device);
+
+int zpci_fmb_reenable_device(struct zpci_dev *zdev)
+{
+	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
+	struct zpci_fib fib = {0};
+	u8 cc, status;
+
+	lockdep_assert_held(&zdev->fmb_lock);
+
+	if (!zdev->fmb_enabled)
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
+	zdev->fmb_enabled = 0;
+	return zpci_fmb_enable_device(zdev);
 }
+EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
 
 static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8 len)
 {
@@ -737,8 +768,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
 	}
 
 	rc = zpci_iommu_register_ioat(zdev, &status);
-	if (rc)
+	if (rc) {
 		zpci_disable_device(zdev);
+		return rc;
+	}
+
+	guard(mutex)(&zdev->fmb_lock);
+	if (zdev->fmb_enabled)
+		zpci_fmb_reenable_device(zdev);
 
 	return rc;
 }
@@ -1003,6 +1040,12 @@ void zpci_release_device(struct kref *kref)
 	if (zdev->has_resources)
 		zpci_cleanup_bus_resources(zdev);
 
+	if (zdev->fmb) {
+		zdev->fmb_enabled = 0;
+		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
+		zdev->fmb = NULL;
+	}
+
 	zpci_bus_device_unregister(zdev);
 	zpci_destroy_iommu(zdev);
 	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index c7ed7bf254b5..44f026ead414 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -97,7 +97,7 @@ static int pci_perf_show(struct seq_file *m, void *v)
 		return 0;
 
 	mutex_lock(&zdev->fmb_lock);
-	if (!zdev->fmb) {
+	if (!zdev->fmb_enabled) {
 		mutex_unlock(&zdev->fmb_lock);
 		seq_puts(m, "FMB statistics disabled\n");
 		return 0;
-- 
2.55.0


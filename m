Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C873D75BE;
	Wed, 16 Sep 2026 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594447; cv=none; b=PNy/oNJGm2Z/4PwPw4XCbftUPQBMdeL6NiOgAadeFhSEkRgbkDghPmSxfs3i5b/QNPQd5imv6XYKo3AmW6kyHA/AGZP21/oMgKw7m4ll10LmbRMv7BgJ6dz+H5cuqFqmrjC7CNjhexOjLcG/pZhRBiCsyYhsppu2h6/ZIyMoKnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594447; c=relaxed/simple;
	bh=lqdnQoVdUb9vpkLHEhbIN41yc69nCTgbNLTV8hSRQoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lL1zRQO3dslmfg9teQPAxw90RXH7DxyAHgjHq3A5CdvU0CYRlI3Sqh8eDNTooxdXQDNN3Dzf//oMzqQJ0J5S6TEzFQpyBKy9UOMewvRVohowBlowKIFU8JFFEWem7/UCFQJSQay4U1RPhp0gwzSFNhLHGLbA4lNj1mbPV9O/4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LEKhNDDn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LEKhNDDn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1gwd046003;
	Wed, 16 Sep 2026 21:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hNwRbeFuimRH4ahph
	ijpRmVrkbZV5h4cB845uWeAQck=; b=LEKhNDDnq6TAK+0Eei4KZRyNXPec8vyhF
	/PMuXtIzLnFqih1Re6+1tO0zK0q40pLkvkbX7vUKSzzv2qPOeBGzwhDGwCbvJatd
	4I76y0qVI4ETz85qnCg2B5wfl4EIyEz2dsYfrq6NUmvDwzgSfzTwBwzjEEcToIuE
	tFzDy9DKMa7R0Jo2yw8HBSC6SGvOO1G3zfVRsAa18QNGBui4PZwv5eYgUZ4xx2Ep
	fiLVlQZD9s67Xj2YjME+AENfZv4LYIpgRcE+KvfMQccnMuY4AlGbF5KbcaLp5G8c
	LX/6C1wECrG/kYCkFzee9SSnDL6DIFGJDrbt0xZJc3w4AvEx7CIqQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv6php-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 21:34:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GJ0FZf1699869;
	Wed, 16 Sep 2026 21:34:00 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gq03vgjg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 21:34:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GLXvB210617462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 21:33:57 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 371295805A;
	Wed, 16 Sep 2026 21:33:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6821558066;
	Wed, 16 Sep 2026 21:33:55 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.251.90])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 21:33:55 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org
Subject: [PATCH v6 2/4] s390/pci: Reuse FMB buffer and preserve state in device re-enablement
Date: Wed, 16 Sep 2026 17:32:20 -0400
Message-ID: <20260916213222.233-3-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916213222.233-1-oelghoul@linux.ibm.com>
References: <20260916213222.233-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMwMCBTYWx0ZWRfXwSEwzExdMs3C
 1G/jwHc7VkhbsTaqhFII/qoHotcKLCVrdx7+ClKGMiLrULl0gN9XLZd3J2lfCnykjWlBBDXy8Ix
 oy/BOkh9a3A+03T1VySQEIb73Y1dFJw=
X-Proofpoint-ORIG-GUID: Ylz-L7i369HCXUw4QJSBxcASIZp38e-R
X-Proofpoint-GUID: Ylz-L7i369HCXUw4QJSBxcASIZp38e-R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMwMCBTYWx0ZWRfXxy3+bLVKxHVd
 faULSPLZE3P8YVZP/Qd/6So/5FRhlOTb0kkFLTjd8MsO9Uq1T9kE3XiMMd2K+fJ68CEJYq29xTP
 Nt7g2ApKlOmU5KEpPKAPaW9bo/hBQAgZZrJJJs53/z9VChfzUR5QEgeU98LNjUy+kYr0nVbo2cI
 wt6yqs0SpfDIPbjPuu08gty3SaNFdM0e6h410QIvUOKrbqFQ2gzbODZnqeLXS7+aiwl1tkg748/
 0jtysHBtU+ksSY9n0Rsby4otzmVIPrrJOaj1cV3tVhZCnk5YTkcnOjx02iBV5N3p6/TP4k1ZCrJ
 d1b9Knb9knI2rRIS6dyZsfdGOvN3HXmF4LdNQ0j8WiuT1E9RlpwahX/7gdOCGlbbenFBZppcw6l
 5BRcMNav7/5blUEX8uiONnI4Uo7ZGGSUGvS3/oy2/9qm1c8dmluZF6YNoJhbhrPuv0ARF3xi00o
 U85cS9VUE7aVzqmkJdA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aab0b49 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=LP0gC_cnHC4A9rhkzj4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160300

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
 arch/s390/pci/pci.c         | 75 ++++++++++++++++++++++++++++---------
 arch/s390/pci/pci_debug.c   |  2 +-
 3 files changed, 61 insertions(+), 18 deletions(-)

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
index c055a9ad0972..5d1f5b75bff5 100644
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
 }
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
+}
+EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
 
 static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8 len)
 {
@@ -737,9 +768,13 @@ int zpci_reenable_device(struct zpci_dev *zdev)
 	}
 
 	rc = zpci_iommu_register_ioat(zdev, &status);
-	if (rc)
+	if (rc) {
 		zpci_disable_device(zdev);
+		return rc;
+	}
 
+	guard(mutex)(&zdev->fmb_lock);
+	zpci_fmb_reenable_device(zdev);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(zpci_reenable_device);
@@ -1003,6 +1038,12 @@ void zpci_release_device(struct kref *kref)
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


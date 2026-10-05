Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8E4CC625;
	Mon,  5 Oct 2026 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215252; cv=none; b=ZUqnaDLKbREaSLJiw+SgF5y4M7hVmYVPVWAmcrgY5GD3zKWgiWKFSZGdEvJgufFPF0fWIZfDw+d9Hecf22YMV9FbPh3pUYxojlRFVuwQlZI92R3colVP6d3WDzujq/wyonpNxDlV8YjCis/dunACxlH2SFJJ4piMzzSzo5HlPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215252; c=relaxed/simple;
	bh=2uZQEhkvS0kpHKxAijPic6hVV2SMzqmEn4wN2Ex+0MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWLSi4oWNvWn2w0knrjQQxDkLMdjRX45x2y1r/jt6NznmAB/RAMBfO67rsgJzjYWkHF5g48NkC3bwMdJPhcwzKovteBnuDqDzJwmt14dlapGcFXhGasVA1LPOBkEbQaStfGYpWklRtuq5hzIYg8TECUNuDpsowty1cHU/1vt9sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C1KJfvW2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C1KJfvW2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EZhsH884389;
	Mon, 5 Oct 2026 15:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3JcWXd5HSyT9rnwba
	8zghpXiF9CfnUbk4lpHgrSeQr8=; b=C1KJfvW2hq0eeWg5vNKO9AVOR+pFn1cgQ
	Bugg41rq3xRqWtG6APrPRZRp3xM0q/VhLJpkIvjqrwGh0p9LL7OfWnJUYG8aUpd4
	l99g9KyUXzlDh8///AgT59KHudBoByiyWDkgqnD1RP+k7IA7+gSyfZdxY0h9m4vu
	nGm5Xh5Vl21LiHZyn2jLsFJunSPDtOPbSv6p9+vyml2CnvzB7zJJMaTmQGWwq9OV
	7k1+5AVArp8znNLxk+0DpWbsLvk1spAeY80FayoCSCLINpidlkcb3bE1DF3MdIY9
	3pIAK5/ITIvvVY+xgo3eBY003OIyJ5RVMrgmBE4AIZ1M4Mya5165g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5b48w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:47:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695EWUvd3050620;
	Mon, 5 Oct 2026 15:47:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pp97u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:47:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695FlOKK32572030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 15:47:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9763058055;
	Mon,  5 Oct 2026 15:47:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1E165804B;
	Mon,  5 Oct 2026 15:47:22 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.252.89])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 15:47:22 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v8 2/4] s390/pci: Reuse FMB buffer and preserve state in device re-enablement
Date: Mon,  5 Oct 2026 11:45:55 -0400
Message-ID: <20261005154557.57801-3-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005154557.57801-1-oelghoul@linux.ibm.com>
References: <20261005154557.57801-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MSBTYWx0ZWRfXxOE20PIEhRef
 DsMFxyK2/7zZaAoFUy79b9Uz1cQiqMgxkvfASn+4VgGzPVausFAdNjgBcoRz3ADA5HtjBSkYxHX
 h2CZssMNLJDgiuhDT1rOd1jsOVbV3oQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MSBTYWx0ZWRfXxv182okZR8ZQ
 diXlZcpHUr0N7xya1VMnPccwH6rpZmPuOggo5UWDagMAnkpQrxIvYfKqrhLi2sHpZFlPc2ltNT9
 i1/z5jhsYKzIdjNfDG+E+ameWTrjwqtCkT/EQfKY0PrOjeQSrSkuGhCT5xtCupL8fieoQrZyTwq
 ZO3Tp6alzuCuNQMU7HSpWez/npFFCBPovDS4KZFy72EmvdG2yeLjtnu2xJJ5iJI1isl+688ZKpQ
 r4Rb0hCPRJz9ZUHmQolSoV41m7XQDe1YrB9HR8boxyzXRuGtIwGCX+/AN+gafbHdI0tuVwRx4Qn
 Hskqy9frWb9xpi4KHWcRlOVK2mX6IvhA1bhNnHzNInKzPtogUjpz2bfjSdhPUDMcceM1943EB0d
 jwUq8YUmNBZIisLNrkH7JTcuYYwFMnOoFmm/3fG+cIktWzKmRDrX9MH3rVu47XXxLLtvZc5HLKP
 CwuUrQPfzDcbBwQgLVw==
X-Proofpoint-GUID: JJl-5Bpjlugd-o1BQsp2adfwH6riNWSK
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac3c68f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=n-mqwLDmIPUJ2U0ygWkA:9
X-Proofpoint-ORIG-GUID: JJl-5Bpjlugd-o1BQsp2adfwH6riNWSK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050061

Don't free the FMB buffer when disabling measurement in
zpci_fmb_disable_device(). Instead, make the buffer persistent for the
lifetime of the device and reuse it across enable/disable cycles. Defer
freeing the buffer until teardown in zpci_release_device().

To support the persistent buffers, add the fmb_enabled bool to struct
zpci_dev to decouple whether FMB is enabled from whether the buffer has
been allocated. Audit the only consumer of zdev->fmb as a liveness check
and update it to reflect this change.

Introduce the function zpci_fmb_reenable_device() to ensure that the FMB
is enabled. If it was already enabled, disable it, zero the counters,
and re-enable it. This allows the function to be used in both first-time
enabling and re-enabling measurement. Call it in zpci_reenable_device()
to preserve the FMB enablement if it had been implicitly disabled by
firmware in zpci_disable_device().

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  2 +
 arch/s390/pci/pci.c         | 76 ++++++++++++++++++++++++++++---------
 arch/s390/pci/pci_debug.c   |  2 +-
 3 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 88a125b92bdd..2920de1f9484 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -205,6 +205,7 @@ struct zpci_dev {
 
 	/* Function measurement block */
 	struct mutex fmb_lock;
+	bool fmb_enabled;
 	struct zpci_fmb *fmb;
 	u16		fmb_update;	/* update interval */
 	u16		fmb_length;
@@ -351,6 +352,7 @@ void zpci_remove_parent_msi_domain(struct zpci_bus *zbus);
 /* FMB */
 int zpci_fmb_enable_device(struct zpci_dev *);
 int zpci_fmb_disable_device(struct zpci_dev *);
+int zpci_fmb_reenable_device(struct zpci_dev *zdev);
 
 /* Debug */
 int zpci_debug_init(void);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index c055a9ad0972..ec729be91f97 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -175,13 +175,17 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 
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
+	} else {
+		/* reuse the same FMB buffer for as long the zdev lives */
+		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
+	}
 
 	/* reset software counters */
 	spin_lock_irqsave(&zdev->dom_lock, flags);
@@ -199,11 +203,11 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
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
+	zdev->fmb_enabled = true;
+	return 0;
 }
 
 /* Modify PCI: Disable PCI function measurement */
@@ -215,7 +219,7 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 
 	lockdep_assert_held(&zdev->fmb_lock);
 
-	if (!zdev->fmb)
+	if (!zdev->fmb_enabled)
 		return -EINVAL;
 
 	fib.gd = zdev->gisa;
@@ -224,13 +228,39 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
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
+	zdev->fmb_enabled = false;
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
+	zdev->fmb_enabled = false;
+	return zpci_fmb_enable_device(zdev);
 }
+EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
 
 static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8 len)
 {
@@ -737,8 +767,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
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
@@ -1003,6 +1039,12 @@ void zpci_release_device(struct kref *kref)
 	if (zdev->has_resources)
 		zpci_cleanup_bus_resources(zdev);
 
+	if (zdev->fmb) {
+		zdev->fmb_enabled = false;
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


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428B472F97;
	Wed,  7 Oct 2026 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381597; cv=none; b=fBLFSYU1vr71q5ybHuSvA/Dm/9J0OTQVijUoCZ/42morozOxmwIDJ/OqWcRgl3ls0X56wDz6LaYKOoMTpB9ZMKsBB4QpeG1bN0sq3QoCO4GAFse2TUe4Twyr4kXPAGw6v02ZvIdGUMkG2Eo1FTatXX4LaiPd6E0aqcED558Cw6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381597; c=relaxed/simple;
	bh=f3wrbcO69IbCQpex+2DvjMB1X6I2563pF4ggElJZEBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXLAu0lhm3vcloR35Jk3xrsAD7raILZUstrnYvidtktO24ibEfqyAsEjvm2ZU2iXRKKc7vH4rSaHc+MxZMNkP6gPfO2oXB1myyMc1rM41QEpikgzQVM+9ZRQodCMGB7lYVd5aNjuHR8zhhKsoL00jQSSJh0LjkfsW6sQW/Khpmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PeP+6YjT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PeP+6YjT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZjND2463294;
	Wed, 7 Oct 2026 13:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6idt8nz/Zm4TXX5py
	6B06ZjG48H5vVuoaWfz1rseCZo=; b=PeP+6YjTLjjF9eHDkQ0O1q3S3Rfi+FRt6
	8qVvn0eOQaD7cDNJZekAiegGW1SSG1omw9ztTJFextfd6ZEKJL/K4Wje1tSVUwwv
	PEHGASSxmzoMWG981yNb9YV6DkPmnLh9DxhJpmSsmUZAuIDsyD+z5Jv24+oeH7vr
	lKlkF4u+ZXS7/KQDekCVx3C1dabI65RYSU5nqZh70jwnh2YH4Cx8oSSi2z+UbBOD
	FKrZZ4DM4kPo1O1bX2PwqHRZVsHYaQhT55DrS8BjQ59N10DO9APUvlzxCZ2u2q8N
	QVjLZv4wTbhUsmlwYiZPJrHgHaEYewa11dyxwe0BqmwZm9weKEl5g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74wuqv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:59:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BX7LP1852610;
	Wed, 7 Oct 2026 13:59:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgxsr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:59:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697Dxe3W15598302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 13:59:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ED625803F;
	Wed,  7 Oct 2026 13:59:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C261358054;
	Wed,  7 Oct 2026 13:59:38 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.253.231])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 13:59:38 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v9 2/4] s390/pci: Reuse FMB buffer and preserve state in device re-enablement
Date: Wed,  7 Oct 2026 09:59:24 -0400
Message-ID: <20261007135926.82935-3-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261007135926.82935-1-oelghoul@linux.ibm.com>
References: <20261007135926.82935-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Blx0JW_9p0WnReiurV89W_cUpYdWy7Gv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NCBTYWx0ZWRfX0KHxmzsUTmQN
 rsunq0END5KmC5Q7jSZ6h0EOsQaBDgYdUJlRKp3Q5GQIhHwcVRqdig12QVCo0DjQ7xDQq2oqksh
 ZCLmM7u6afR5xXTc/AtL6k4dMTiPUMI=
X-Proofpoint-GUID: Blx0JW_9p0WnReiurV89W_cUpYdWy7Gv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NCBTYWx0ZWRfXwmdwHss/DtEn
 d3XD0ZqV/H1h/PcyEF211ymZJXOVMoc5Pd21xjlEQCIXRizgZOfsyR8vOxZgUOWKedoyDwY/48R
 g2sopOzH10qyk2fJjd0KX5p/9EFkFzq5jTUqNPLvufZANcwZfi2y8nj5nbg7xoPvQc0+3sSlSnI
 cEHuQeH+L0zhR8ENmtpomqd2SDXGenyDg8tAdLPtTk7z1iiUS4U5gqAy3c+yRLoB5MBTS1sq4uO
 GQQdMhTxA7caimCndV6CEPhajXzdPNAkwWG5d/fiEKowkP0s6qqNQy2kdb0cIxHkhmipcTS3mIb
 yy8w3nQUOmQvO+YfbZDoL666VrutCL4Hu/iqiZpKEt5E4QdlXlWSPqiA/E99y+65IHRWZT4cpcc
 oYEgZ/rHpoFfdvM1EeBD+SuDMd6nIqQiEZUY8378ncUMc+isJ/1CIgj/UqX0+er2b5+5rxC7THD
 IV6OWNZqXswFpHRvBtg==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac65050 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=dRjUNzlWurLrRo6W1lgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070054

Don't free the FMB buffer when disabling measurement in
zpci_fmb_disable_device(). Instead, make the buffer persistent for the
lifetime of the device and reuse it across enable/disable cycles. Defer
freeing the buffer until teardown in zpci_release_device().

Introduce the bool fmb_requested to struct zpci_dev to track whether FMB
enablement has been requested. This decouples tracking the enablement
from whether the buffer had been previously allocated, allowing us to
account for implicit disablement by firmware in zpci_disable_device().
Audit the only consumer of zdev->fmb and update its liveness check to
reflect this change.

Separate the buffer allocation and measurement enablement step into the
new function zpci_fmb_reenable_device(), which allocates the FMB buffer
on first use, zeroes it on reuse, resets the software IOMMU counters,
and enables measurement. Make zpci_fmb_enable_device() delegate to this
function, and call the latter from zpci_reenable_device() when
fmb_requested is true.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |   2 +
 arch/s390/pci/pci.c         | 106 +++++++++++++++++++++++-------------
 arch/s390/pci/pci_debug.c   |   2 +-
 3 files changed, 70 insertions(+), 40 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 88a125b92bdd..77c8c49ba6c8 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -208,6 +208,7 @@ struct zpci_dev {
 	struct zpci_fmb *fmb;
 	u16		fmb_update;	/* update interval */
 	u16		fmb_length;
+	bool		fmb_requested;	/* desired FMB enablement state */
 
 	u8		version;
 	enum pci_bus_speed max_bus_speed;
@@ -351,6 +352,7 @@ void zpci_remove_parent_msi_domain(struct zpci_bus *zbus);
 /* FMB */
 int zpci_fmb_enable_device(struct zpci_dev *);
 int zpci_fmb_disable_device(struct zpci_dev *);
+int zpci_fmb_reenable_device(struct zpci_dev *zdev);
 
 /* Debug */
 int zpci_debug_init(void);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index c055a9ad0972..bda91d79bafd 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -167,43 +167,13 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
 /* Modify PCI: Set PCI function measurement parameters */
 int zpci_fmb_enable_device(struct zpci_dev *zdev)
 {
-	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
-	struct zpci_iommu_ctrs *ctrs;
-	struct zpci_fib fib = {0};
-	unsigned long flags;
-	u8 cc, status;
-
 	lockdep_assert_held(&zdev->fmb_lock);
 
-	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
+	if (zdev->fmb_requested || sizeof(*zdev->fmb) < zdev->fmb_length)
 		return -EINVAL;
 
-	zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
-	if (!zdev->fmb)
-		return -ENOMEM;
-	WARN_ON((u64) zdev->fmb & 0xf);
-
-	/* reset software counters */
-	spin_lock_irqsave(&zdev->dom_lock, flags);
-	ctrs = zpci_get_iommu_ctrs(zdev);
-	if (ctrs) {
-		atomic64_set(&ctrs->mapped_pages, 0);
-		atomic64_set(&ctrs->unmapped_pages, 0);
-		atomic64_set(&ctrs->global_rpcits, 0);
-		atomic64_set(&ctrs->sync_map_rpcits, 0);
-		atomic64_set(&ctrs->sync_rpcits, 0);
-	}
-	spin_unlock_irqrestore(&zdev->dom_lock, flags);
-
-
-	fib.fmb_addr = virt_to_phys(zdev->fmb);
-	fib.gd = zdev->gisa;
-	cc = zpci_mod_fc(req, &fib, &status);
-	if (cc) {
-		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
-		zdev->fmb = NULL;
-	}
-	return cc ? -EIO : 0;
+	zdev->fmb_requested = true;
+	return zpci_fmb_reenable_device(zdev);
 }
 
 /* Modify PCI: Disable PCI function measurement */
@@ -215,22 +185,68 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 
 	lockdep_assert_held(&zdev->fmb_lock);
 
-	if (!zdev->fmb)
+	if (!zdev->fmb_requested)
 		return -EINVAL;
 
+	zdev->fmb_requested = false;
 	fib.gd = zdev->gisa;
 
 	/* Function measurement is disabled if fmb address is zero */
 	cc = zpci_mod_fc(req, &fib, &status);
 	if (cc == 3) /* Function already gone. */
 		cc = 0;
+	if (cc)
+		return -EIO;
 
-	if (!cc) {
-		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
-		zdev->fmb = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(zpci_fmb_disable_device);
+
+/* Re-enable PCI function measurement: clear the software IOMMU counters
+ * and (re-)enable the FMB. This function is used to restore the desired
+ * FMB enablement state when measurement may be implicitly disabled by
+ * firmware (i.e., via CLP in zpci_disable_device())
+ */
+int zpci_fmb_reenable_device(struct zpci_dev *zdev)
+{
+	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
+	struct zpci_iommu_ctrs *ctrs;
+	struct zpci_fib fib = {0};
+	unsigned long flags;
+	u8 cc, status;
+
+	lockdep_assert_held(&zdev->fmb_lock);
+
+	if (!zdev->fmb) {
+		zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
+		if (!zdev->fmb)
+			return -ENOMEM;
+	} else {
+		/* reuse the same FMB buffer for as long the zdev lives */
+		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
 	}
-	return cc ? -EIO : 0;
+
+	/* reset software counters */
+	spin_lock_irqsave(&zdev->dom_lock, flags);
+	ctrs = zpci_get_iommu_ctrs(zdev);
+	if (ctrs) {
+		atomic64_set(&ctrs->mapped_pages, 0);
+		atomic64_set(&ctrs->unmapped_pages, 0);
+		atomic64_set(&ctrs->global_rpcits, 0);
+		atomic64_set(&ctrs->sync_map_rpcits, 0);
+		atomic64_set(&ctrs->sync_rpcits, 0);
+	}
+	spin_unlock_irqrestore(&zdev->dom_lock, flags);
+
+	fib.fmb_addr = virt_to_phys(zdev->fmb);
+	fib.gd = zdev->gisa;
+	cc = zpci_mod_fc(req, &fib, &status);
+	if (cc)
+		return -EIO;
+
+	return 0;
 }
+EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
 
 static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8 len)
 {
@@ -737,8 +753,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
 	}
 
 	rc = zpci_iommu_register_ioat(zdev, &status);
-	if (rc)
+	if (rc) {
 		zpci_disable_device(zdev);
+		return rc;
+	}
+
+	guard(mutex)(&zdev->fmb_lock);
+	if (zdev->fmb_requested)
+		zpci_fmb_reenable_device(zdev);
 
 	return rc;
 }
@@ -1003,6 +1025,12 @@ void zpci_release_device(struct kref *kref)
 	if (zdev->has_resources)
 		zpci_cleanup_bus_resources(zdev);
 
+	if (zdev->fmb) {
+		zdev->fmb_requested = false;
+		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
+		zdev->fmb = NULL;
+	}
+
 	zpci_bus_device_unregister(zdev);
 	zpci_destroy_iommu(zdev);
 	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index c7ed7bf254b5..9a960310d4dd 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -97,7 +97,7 @@ static int pci_perf_show(struct seq_file *m, void *v)
 		return 0;
 
 	mutex_lock(&zdev->fmb_lock);
-	if (!zdev->fmb) {
+	if (!zdev->fmb_requested) {
 		mutex_unlock(&zdev->fmb_lock);
 		seq_puts(m, "FMB statistics disabled\n");
 		return 0;
-- 
2.56.0


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B67E18FDDE;
	Tue, 19 May 2026 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230614; cv=none; b=AWPTS0/s2WOCump7RxKE8eufubVPSGG2B0DbK0frifT6VSTUKrS4hlp0mRji1yl8iHeTn/uXpHPZF5Qwr3v8cba84pCUzbJ8LyWQJ4Bq7Gaz0XPeqr+pXil6wHeO8YFprGv0a/Xycn2nqWS9yJUxmNKGCV71+kN7Lv7jrRRKStE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230614; c=relaxed/simple;
	bh=4k+l6wcQdft/kmjIwmrM7v8gHVMIFPxq+8dlBg5+zhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sk1CjlfY2ZT2G/HEHPG8jwQm+1tb41IWuziJUfAbkfh3LSIsXmiapisyCTg2BmMa7UA+6ONs4A925vs2BjlhxwZsZReYf5FHkhRb3ftwBWASA7TM/ml6JVMpbar/XzApAE95KwKHkMJYa1eH6pnDyW0cKW5ZLKsgHtY3G3nYLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VU8bxkb4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VU8bxkb4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JF13Ev795743;
	Tue, 19 May 2026 22:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F9i8DssIb9Mj1M/nY
	CLIOk2AEZCuF7njsq9xNmy7Snw=; b=VU8bxkb4cwPOo1Ozi3oD8qKlN0GapdKNk
	+eWDrYpbjhcLknzpBZGbbBlFaAqwet0LLh5wQt/r5H9Igyl6sI2QeW2W4u1/ErM3
	b5vYoREKFmHwK4QtdAyQwOd4jdK+HoJk4fygc0AF0NsSp6e8RmiLMcz/mcW+2tB1
	XL9oIkYHHcT4h1432Vyf1l01I9nJo36LuH4bl+NT5Un7sb+Sk9rGAjqW2qqAoCW/
	35RV2zXVNkElWCsrGTlsV2RQD48xfhWOmQNKcCOlnsulhM2+rt7g+gGmAYuOreg9
	ko+pwMO8CcFv4VIfWbwJhr237yWGp+3MbICZlET3Sy3DI1B8batMg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mqd4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 22:43:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JMd8vL004605;
	Tue, 19 May 2026 22:43:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gckjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 22:43:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JMguie10945164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 22:42:56 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBE7B58052;
	Tue, 19 May 2026 22:43:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38FD158050;
	Tue, 19 May 2026 22:43:23 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.253.120])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 22:43:23 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v2 1/3] s390/pci: Preserve FMB state in device re-enablement
Date: Tue, 19 May 2026 18:42:02 -0400
Message-ID: <20260519224204.19154-2-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519224204.19154-1-oelghoul@linux.ibm.com>
References: <20260519224204.19154-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gIQAz5Qtc2YG8-4XWRs2AVuhcZn0csfV
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0ce791 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=sdm-MloC9ubkM-Nm6RcA:9
X-Proofpoint-ORIG-GUID: gIQAz5Qtc2YG8-4XWRs2AVuhcZn0csfV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIyNyBTYWx0ZWRfX0uNyiwkQmMNo
 mQRKOMk57GpMiVULJ8u1ctRPcZGjLTpYzpg+3qJtya9iqbdtlEB7fE7cyJVS+25iknPvhv2Uovb
 bMV87MsnKRyBhtftt16AjADnZK0U5cHOi3Mz0U8ChGzlG4YlHlTHTGxMTU7EmgHACxKyoZPH009
 4cJnpuPTQGjrE87I1cujDqUUTKgrNYt0EKOvtHVJkLYIZA8OfJ2FG3nQRsrdUrHBk2BSVXdRPze
 2DXJ+8PsLrR/OnWMw9jooWPYtZlirmr95O8TnWx5FH0W7kfCjQManluWOPBenBLpi6DqM8DevVL
 YsANpJrrbzTwarhaYF94gNFsaZCb7PWVRMhgOQMUk1QW6VIL8x1VhT8FwTYAgTz8n4Gw3BI0uMa
 3gx6IQqgtOKoYlhZDwi+ddaIw952E6ycIkQkFu4FvTWnneyNYrvLPk+LJlyPBVLr1TqMP7p2guO
 E56wTPVitJuXb0ZDMBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190227

Introduce a function zpci_fmb_reenable_device() that checks for the state
of the FMB and reuses the same buffer where appropriate. If FMB was not
previously enabled, it enables it for the device. Call this function during
a zPCI device re-enablement, which in turn implicitly ensures that the FMB
is enabled for host devices during their KVM registration.

This function also clears out the software counters, so that a program
resetting an FMB would see all its counters restart from zero as expected.
The function to clear the software counters is also separated into a static
function as it is now reused in both zpci_fmb_enable_device() and
zpci_fmb_reenable_device().

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         | 75 +++++++++++++++++++++++++++++--------
 2 files changed, 61 insertions(+), 15 deletions(-)

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
index 39bd2adfc240..56cabb2dc291 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -164,22 +164,10 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
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
@@ -192,7 +180,24 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 		atomic64_set(&ctrs->sync_rpcits, 0);
 	}
 	spin_unlock_irqrestore(&zdev->dom_lock, flags);
+}
+
+/* Modify PCI: Set PCI function measurement parameters */
+int zpci_fmb_enable_device(struct zpci_dev *zdev)
+{
+	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
+	struct zpci_fib fib = {0};
+	u8 cc, status;
+
+	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
+		return -EINVAL;
+
+	zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
+	if (!zdev->fmb)
+		return -ENOMEM;
+	WARN_ON((u64) zdev->fmb & 0xf);
 
+	zpci_fmb_clear_iommu_ctrs(zdev);
 
 	fib.fmb_addr = virt_to_phys(zdev->fmb);
 	fib.gd = zdev->gisa;
@@ -227,6 +232,41 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
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
+	fib.fmb_addr = virt_to_phys(zdev->fmb);
+	cc = zpci_mod_fc(req, &fib, &status); /* Re-enable function measurement */
+	if (cc) {
+		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
+		zdev->fmb = NULL;
+		return -EIO;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
 
 static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8 len)
 {
@@ -729,9 +769,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
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
2.52.0


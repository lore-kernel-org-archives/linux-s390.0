Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202251;
	b=Sn9kbOyFS04QLIOJ8kyVE7h7fBnv4a5emXlh7rgxkUYZC5JTFibF9/DgFzIzRvkeDCtz
	 BdMCfzEb/9pAqc2ho+8ItgP3LeBUpecQYteJH/QaCTBI6cppwvX7PjqPoiaRrmG0y9LmI
	 DCysYtiPTK9E+ny1oMVEv8Xymg9ARrp7GHWvc7VesT2QkgBhvu1+lLcSmYh1ISu3ALAS6
	 Wjqb8JJAxVBeRJazxLTWOgK63D6n+wo70icFQ8t5pWO1e8tVLocmWeaKYtWcDLDyz9Sgq
	 HzF4D2AdfPzW8/ypC/hTZXTXIBh8OJlSHHnSfDsxjnznhefFDdBhkrylPpZK/Tidc0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202251;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SFL+oINgrKpt7yJuv2k7gdwyOzpkOg1qfLRc60v2g2A=;
	b=W/BKKfvEetFdEijo+okIuZDXU53bbC/Ft7v/LgqfGgv5XB49lGNqXlWr6i5BLKA+mPeq
	 ZOhKbuLwEDDQ2DE99Mz5RMC+qRGq87JqMEUCdc74+VJtxuUyafQt00ZTwDDeUSjqhO+DV
	 XHj00CHo6vlaOkITumRAljnbl8mEXJLHFhby+iwqxvg10Og/9qWkrzVMUeR5i2QWYr1/u
	 sGSPNBpZvJJDFpPbYoVnNEktmPhLtkkm8nogGZS/6paGgtKDwiuu8VGQTKvjdCyIrNzQ9
	 TxjPLDcw5ZMtGTgWiMQQDMvZwuqolB1qmINvDxWKmt29SSDJdSFM/E6bhkig63e73Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZPAZlXuG;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4827C606A32A;
	Wed, 28 Oct 2026 15:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4827C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZPAZlXuG
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFE5eH4147946;
	Wed, 28 Oct 2026 15:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SFL+oINgrKpt7yJuv
	2k7gdwyOzpkOg1qfLRc60v2g2A=; b=ZPAZlXuGlnBmcpmB7AT8g22VNwIhyrkzL
	UzQlKf301oIanMjRKKb0g124i5HPRTF9tMQoKZe8NAPJ9DkWxh9Wkx8jm6NxmAHR
	uq/VC1sK/EjJ8VCVqw94MWcAR2wLmNwsqzgGrzvlC8doDtU6jLiRZo2AXCrlc5MJ
	IpRGFl+kt8sYR+hxa63ChPwD1txfb4VSo7UbK5JYWTotkH5OTPMkbJHfzNsLlrxf
	ErC2tC/qeo41bncE1aGiH5D9xJ/meFyq3zRZ++Qws07vdH+WLUOxnZlnAlspA1AY
	gE3AZ5lhFiq+X258fYAzUifp5dcvQj3/sYl7DGtI+XAUa9tnI7dSw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbt5kmk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:44:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFJuwo1784644;
	Wed, 28 Oct 2026 15:44:07 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh7xnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:44:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SFi2to19202674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 15:44:03 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94CB858061;
	Wed, 28 Oct 2026 15:44:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70BCF58052;
	Wed, 28 Oct 2026 15:44:00 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.240.205])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 15:44:00 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v11 2/5] s390/pci: Improve function measurement state management
Date: Wed, 28 Oct 2026 11:43:49 -0400
Message-ID: <20261028154352.15108-3-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028154352.15108-1-oelghoul@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfX6MZzm6P0VUKt
 9wg/bbjL4/8fsOiM6d1PVX+CdgcHzkerg/K6qaHWZkMXrzSOXLsG18ll3epPaVVdpN6JJ119y1P
 APiQO/F/IVjKnbxJbGcLiosftYdGhntIV88DOrkFD13p9DAgvpfB1HlZq0n9/wnJ3LPfssHTr8t
 Ss6j9CcmsYzZZ/yflEo1ZW7AeYqVKxxsM/9toHCEsdQs9JfnsGTMRmo/il18nJaEc9qFtCTzQX6
 WPaEAQhei4jW1rbIvq26GAoAmPmLmYl8une6Dnd1kV4mg4nG+d83bnPL9jZC1jiUhUV4T5j2Bq3
 lAJo63jcFR9yk1hZMgaot8wOO2E1gaI7BPot2kKQnTc3bHgVDyKsfFH+jiZxtGxYNe0EhQQSNO1
 p8kQfVmHnlg5k28GyN1gRju0muYY9IVa11KW0CVuUzBHPp2eRiN+LnRRdjEWKCWZscIgxW6A7aE
 6X6Aq8CNdLa/rdAe/Hg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfXxstWNkGZX2A0
 CTIDc7PBp+xmlX6AxrZFm7qnseogotWBLObGDTFVjfuVqbUdwzDFaUL2WAkueCzTmMo6GAuqFL1
 ghnK2LBdHz33zHxmZMAZPHLzWfYeG4Q=
X-Proofpoint-ORIG-GUID: E-em-Ome7uFfRDNW1JAu51jt_qIVmxP-
X-Proofpoint-GUID: E-em-Ome7uFfRDNW1JAu51jt_qIVmxP-
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae21847 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=cItLoxOyQSrHz8uLRusA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280062

When a zPCI function is disabled and re-enabled, the firmware implicitly
disables function measurement while the kernel still believes it is
enabled, leading to a disconnect between the user-visible state and the
actual device state.

Add the statistics_on field to struct zpci_dev to track the desired FMB
state. Introduce the functions zpci_fmb_request_on() and off(), which
defer to zpci_fmb_enable() or disable() to perform the actual firmware
change. This decouples the enablement or disablement step from managing
the user's requested state.

Preserve the state in pcibios_enable_device(), pcibios_disable_device(),
and zpci_reenable_device(), so measurement is restored automatically
after a re-enable. New devices start with measurement on by default,
unchanged from before.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  7 +++--
 arch/s390/pci/pci.c         | 60 +++++++++++++++++++++++++++++++++----
 arch/s390/pci/pci_debug.c   |  6 ++--
 3 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 88a125b92bdd..dd7a17955362 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -208,6 +208,7 @@ struct zpci_dev {
 	struct zpci_fmb *fmb;
 	u16		fmb_update;	/* update interval */
 	u16		fmb_length;
+	bool		statistics_on;	/* desired FMB enablement */
 
 	u8		version;
 	enum pci_bus_speed max_bus_speed;
@@ -349,8 +350,10 @@ int zpci_create_parent_msi_domain(struct zpci_bus *zbus);
 void zpci_remove_parent_msi_domain(struct zpci_bus *zbus);
 
 /* FMB */
-int zpci_fmb_enable_device(struct zpci_dev *);
-int zpci_fmb_disable_device(struct zpci_dev *);
+int zpci_fmb_request_on(struct zpci_dev *zdev);
+int zpci_fmb_request_off(struct zpci_dev *zdev);
+int zpci_fmb_enable(struct zpci_dev *zdev);
+int zpci_fmb_disable(struct zpci_dev *zdev);
 
 /* Debug */
 int zpci_debug_init(void);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index c055a9ad0972..5889dd227009 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -164,8 +164,44 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
 	return cc;
 }
 
+int zpci_fmb_request_on(struct zpci_dev *zdev)
+{
+	int rc;
+
+	lockdep_assert_held(&zdev->fmb_lock);
+
+	if (zdev->statistics_on)
+		return -EINVAL;
+
+	rc = zpci_fmb_enable(zdev);
+	if (rc)
+		return rc;
+
+	zdev->statistics_on = true;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(zpci_fmb_request_on);
+
+int zpci_fmb_request_off(struct zpci_dev *zdev)
+{
+	int rc;
+
+	lockdep_assert_held(&zdev->fmb_lock);
+
+	if (!zdev->statistics_on)
+		return -EINVAL;
+
+	rc = zpci_fmb_disable(zdev);
+	if (rc)
+		return rc;
+
+	zdev->statistics_on = false;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(zpci_fmb_request_off);
+
 /* Modify PCI: Set PCI function measurement parameters */
-int zpci_fmb_enable_device(struct zpci_dev *zdev)
+int zpci_fmb_enable(struct zpci_dev *zdev)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
 	struct zpci_iommu_ctrs *ctrs;
@@ -207,7 +243,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 }
 
 /* Modify PCI: Disable PCI function measurement */
-int zpci_fmb_disable_device(struct zpci_dev *zdev)
+int zpci_fmb_disable(struct zpci_dev *zdev)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
 	struct zpci_fib fib = {0};
@@ -644,7 +680,8 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
 
 	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
 	mutex_lock(&zdev->fmb_lock);
-	zpci_fmb_enable_device(zdev);
+	if (zdev->statistics_on)
+		zpci_fmb_enable(zdev);
 	mutex_unlock(&zdev->fmb_lock);
 
 	return pci_enable_resources(pdev, mask);
@@ -655,7 +692,8 @@ void pcibios_disable_device(struct pci_dev *pdev)
 	struct zpci_dev *zdev = to_zpci(pdev);
 
 	mutex_lock(&zdev->fmb_lock);
-	zpci_fmb_disable_device(zdev);
+	if (zdev->statistics_on)
+		zpci_fmb_disable(zdev);
 	mutex_unlock(&zdev->fmb_lock);
 	zpci_debug_exit_device(zdev);
 }
@@ -737,8 +775,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
 	}
 
 	rc = zpci_iommu_register_ioat(zdev, &status);
-	if (rc)
+	if (rc) {
 		zpci_disable_device(zdev);
+		return rc;
+	}
+
+	guard(mutex)(&zdev->fmb_lock);
+	if (zdev->statistics_on)
+		zpci_fmb_enable(zdev);
 
 	return rc;
 }
@@ -847,6 +891,12 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
 		goto error;
 	zdev->state =  state;
 
+	/*
+	 * Measurement is on by default for new functions, this will be honored
+	 * by pcibios_enable_device().
+	 */
+	zdev->statistics_on = true;
+
 	mutex_init(&zdev->state_lock);
 	mutex_init(&zdev->fmb_lock);
 	mutex_init(&zdev->kzdev_lock);
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index c7ed7bf254b5..e479763858cd 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -97,7 +97,7 @@ static int pci_perf_show(struct seq_file *m, void *v)
 		return 0;
 
 	mutex_lock(&zdev->fmb_lock);
-	if (!zdev->fmb) {
+	if (!zdev->statistics_on || !zdev->fmb) {
 		mutex_unlock(&zdev->fmb_lock);
 		seq_puts(m, "FMB statistics disabled\n");
 		return 0;
@@ -156,10 +156,10 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
 	mutex_lock(&zdev->fmb_lock);
 	switch (val) {
 	case 0:
-		rc = zpci_fmb_disable_device(zdev);
+		rc = zpci_fmb_request_off(zdev);
 		break;
 	case 1:
-		rc = zpci_fmb_enable_device(zdev);
+		rc = zpci_fmb_request_on(zdev);
 		break;
 	}
 	mutex_unlock(&zdev->fmb_lock);
-- 
2.56.0


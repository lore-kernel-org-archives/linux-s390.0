Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531491;
	b=XIUFe47UpIU2RiB0jsOtjVh34sK4EqTOwU782xDd3baumdq6ejG0JzVqsxPG6IN3Kp18
	 nnYO3j7WoLUYDnHXdIZwREs/VNvxeJX4yvMjzVa/omOqHh0tPy11cG2YHak6n9QH9z1nX
	 MD8szHMbAP5f8RMrcmyhNWcRRBrBwqvPZFqMCDHoGOCb7X0EJ0EeOvp/Jn9cpCl2ZLD/B
	 EkdqjTna2CxuBX/O3QZ1fUbEB9lfNrTIpDWo6pO+Npn5Q9H5i0EtysD2F4ey4AOiVAopm
	 fmN1/pI8O4Z2udACGOvOfeUlRXSEHd5O0VJ1DDgDOyPfGbKI68ySvCM6Dj8a02O2TTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531491;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=E54xKdORn13BGGmuZS6OIqNLEs0d6p1zOngaT9Q/Lms=;
	b=zfiKo+PCwCpnTf87AcnKXHmWzqmSNkRBOfFBV+BAvuC7lJ7PL1sPJ8HAmz97dXHGrv64
	 Tc6YAPHT+pQo6T+hOHuzEy/eGiXZw50bLbc/G5mQaCcj7Y/aZkYEiXUiwDasbYdY8oYA5
	 Y8bZLsy7CUNLdzEo9H1DTn25A16R06TQ/vwJzb/I2yAKvRURsnkKje6YZHDMWdoV9fqWA
	 x75nXDssgYatxnOdOqqiJNzPhXT6YL5/rLF5L66BwIJntwga0NME0JFeJIaxAi4gM6YPf
	 0Mii9wrhx7qzVl5nK3gDoGfOZqkBuvhom5K2HosfWZgCO0EWhkah/FEfFCweLX6QkfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IThYoLuD;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E89606A31F;
	Tue, 20 Oct 2026 21:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86E89606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IThYoLuD
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KLE3BO1864440;
	Tue, 20 Oct 2026 21:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E54xKdORn13BGGmuZ
	S6OIqNLEs0d6p1zOngaT9Q/Lms=; b=IThYoLuDFPjdS8PUwZOyHzBDe3hX5jir4
	3RAtiXQ1HSh2+/p/DmV06CN5bjPn5bQuPg3xUPk1lsupgSPmhGQP9TIBlQf6F/bG
	Et+fMBdAvyVmUA01IXmuzV/zbun1j7ow5mzB4uCyP9ZZg6PouNobazxv+GmSFXJD
	CnEaqJCAjzGiY149nsuwa2rnEXGqiSqi+Hsz0jMRh3giJmgry0UZnZo7p9oXXb6+
	YED25W3POkc6UNhSRuXm7gNkEr58d2lNaG0cNxeE9GHhY2Cj3IM/9yh80mnxKw1J
	dcqSWAoHTFrbLVsJG9FIpen5sW2CUoEv+hgvWUoSQiD3HHmaBD62A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bdgbf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:24:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KL4x8m2114031;
	Tue, 20 Oct 2026 21:24:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmuh41wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:24:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KLOhYQ48169448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 21:24:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B77BC5803F;
	Tue, 20 Oct 2026 21:24:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30C7758060;
	Tue, 20 Oct 2026 21:24:42 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.240.182])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 21:24:42 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v10 3/5] s390/pci: Improve function measurement state management
Date: Tue, 20 Oct 2026 17:24:25 -0400
Message-ID: <20261020212427.2561-4-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020212427.2561-1-oelghoul@linux.ibm.com>
References: <20261020212427.2561-1-oelghoul@linux.ibm.com>
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
X-Proofpoint-GUID: Z0-mzEKtKvD8i0asOvvOeI2_gpyUKgHA
X-Proofpoint-ORIG-GUID: Z0-mzEKtKvD8i0asOvvOeI2_gpyUKgHA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4NCBTYWx0ZWRfX/qGU60voUclE
 8deOdtXNEMWb7UsqR6l4vR/ZNNkf1TDpVvbcA9gQ1KmT5+QtDqSBQvPSf0IlqWON18w+/0PQjOv
 18AH5GgG7yxHA00lwNd8SbQwQyigkxk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4NCBTYWx0ZWRfX4FpQciuD/19/
 WjECzdZjl/hion1zPszgKmUQ6kS+cenCKgfJ1tcZEjF7bhsnVKtCGOSVl8Ik6RTRpwC2TR+rz29
 WsJRhHyfCnpVAK8BQQKQQaYMiXqXfQPv5hrbsWlC0n2WMq7mxP80hYwUmlJxjxgX220D3OpLWw7
 QBAlwjc+aBZFXPmzkDSmJnoHVD+GBjj1QuAGRNM2f5bQtJwqgIeOGIWFpMRnIUMVsp2HSqi+yar
 g0lWCnXV5cjbiV2NNemVgqfrXpa81ZKSqaZWRmRnZwRCiLXMkoBwx5adQxfi9Rlvw+LklWTuNhG
 BuPZs7gvc7cXOdF+GcVZYZkiXYMSm6wJMUV2Qrwd1N9lroo/HBYNL4I2Bdc8E49kp2wY2tsH5HT
 jV9x9qz6XceJjy8a+KnwAstb6b3bifmfV8jGYUgJE0XkLoxl5bNErRMgyLl2x9zGEEa/No2HoXe
 Szs4Fspf3KkYLF4UCaA==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6ad7dc1f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VaO1hkoxRiRHp-0gMLIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200084

When a zPCI function is disabled and re-enabled, the firmware implicitly
disables function measurement while the kernel still believes it is
enabled, leading to a disconnect between the user-visible state and the
actual device state.

Make statistics_on represent the requested state instead. Introduce the
functions zpci_fmb_request_on() and off(), which call zpci_fmb_enable()
or disable() to perform the actual firmware change. This decouples the
enablement or disablement from managing the user's desired state.

Preserve the state in pcibios_enable_device(), pcibios_disable_device(),
and zpci_reenable_device(), so measurement is restored automatically
after a re-enable. New devices start with measurement on by default,
unchanged from before.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  8 +++--
 arch/s390/pci/pci.c         | 63 ++++++++++++++++++++++++++++++-------
 arch/s390/pci/pci_debug.c   |  4 +--
 3 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index f4fea1c34746..dd7a17955362 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -208,7 +208,7 @@ struct zpci_dev {
 	struct zpci_fmb *fmb;
 	u16		fmb_update;	/* update interval */
 	u16		fmb_length;
-	bool		statistics_on;
+	bool		statistics_on;	/* desired FMB enablement */
 
 	u8		version;
 	enum pci_bus_speed max_bus_speed;
@@ -350,8 +350,10 @@ int zpci_create_parent_msi_domain(struct zpci_bus *zbus);
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
index 2a7e1ca0fa12..98a4e938865a 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -165,7 +165,37 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
 }
 
 /* Modify PCI: Set PCI function measurement parameters */
-int zpci_fmb_enable_device(struct zpci_dev *zdev)
+int zpci_fmb_request_on(struct zpci_dev *zdev)
+{
+	lockdep_assert_held(&zdev->fmb_lock);
+
+	if (zdev->statistics_on && zdev->fmb)
+		return -EINVAL;
+
+	/*
+	 * Record the user's intent first. If the enable fails, the flag stays set
+	 * so we can retry enabling the FMB upon the next device (re-)enable. The
+	 * consumer can detect that a measurement sample was never written if the
+	 * timestamp is still zero, or if the FMB pointer is null.
+	 */
+	zdev->statistics_on = true;
+	return zpci_fmb_enable(zdev);
+}
+
+/* Modify PCI: Disable PCI function measurement */
+int zpci_fmb_request_off(struct zpci_dev *zdev)
+{
+	lockdep_assert_held(&zdev->fmb_lock);
+
+	if (!zdev->statistics_on)
+		return -EINVAL;
+
+	zdev->statistics_on = false;
+	return zpci_fmb_disable(zdev);
+}
+EXPORT_SYMBOL_GPL(zpci_fmb_request_off);
+
+int zpci_fmb_enable(struct zpci_dev *zdev)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
 	struct zpci_iommu_ctrs *ctrs;
@@ -175,7 +205,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 
 	lockdep_assert_held(&zdev->fmb_lock);
 
-	if (zdev->statistics_on || sizeof(*zdev->fmb) < zdev->fmb_length)
+	if (sizeof(*zdev->fmb) < zdev->fmb_length)
 		return -EINVAL;
 
 	if (!zdev->fmb) {
@@ -206,12 +236,11 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 	if (cc)
 		return -EIO;
 
-	zdev->statistics_on = true;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(zpci_fmb_enable);
 
-/* Modify PCI: Disable PCI function measurement */
-int zpci_fmb_disable_device(struct zpci_dev *zdev)
+int zpci_fmb_disable(struct zpci_dev *zdev)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
 	struct zpci_fib fib = {0};
@@ -219,9 +248,6 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 
 	lockdep_assert_held(&zdev->fmb_lock);
 
-	if (!zdev->statistics_on)
-		return -EINVAL;
-
 	fib.gd = zdev->gisa;
 
 	/* Function measurement is disabled if fmb address is zero */
@@ -231,7 +257,6 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 	if (cc)
 		return -EIO;
 
-	zdev->statistics_on = false;
 	return 0;
 }
 
@@ -647,7 +672,8 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
 
 	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
 	mutex_lock(&zdev->fmb_lock);
-	zpci_fmb_enable_device(zdev);
+	if (zdev->statistics_on)
+		zpci_fmb_enable(zdev);
 	mutex_unlock(&zdev->fmb_lock);
 
 	return pci_enable_resources(pdev, mask);
@@ -658,7 +684,8 @@ void pcibios_disable_device(struct pci_dev *pdev)
 	struct zpci_dev *zdev = to_zpci(pdev);
 
 	mutex_lock(&zdev->fmb_lock);
-	zpci_fmb_disable_device(zdev);
+	if (zdev->statistics_on)
+		zpci_fmb_disable(zdev);
 	mutex_unlock(&zdev->fmb_lock);
 	zpci_debug_exit_device(zdev);
 }
@@ -740,8 +767,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
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
@@ -850,6 +883,12 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
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
index 419c6a9200a2..e479763858cd 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
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


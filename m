Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718120;
	b=XJzG0uWLUZZeAHPgWMXoR85l2joYLNEYcY239u5wBsUyKQkalCqHY4F3EMOiUpHnRYv/
	 UahTKmryRHKYW3Psh0q8SybpBKP+Y5kJsWjfJBu5vzl44B98xmpaFEfzD1rFphF4ar+zA
	 E6rc/la/OLSAbGeEtQpbkcpoEiSvc5gzJq8Zfb7rddTV1s1GOtUlTrzn7zKbzYll+szM/
	 h5q3vmUyZc2g/K0IGT2AQ3wx2dcIWxdBnasL7gmsS96mjphsEyrHPaHoPth/9W/qp9on5
	 dEV+yRZm89wTclfcuHLMSQC15EKANaSK8gn0QMFXlmPTZL9DVb6cq6dY0LDz8WAwbZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718120;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9NFf+pssF7Iw/T3QXdW4oNg9Dns1GqN3Nr4tuyoRZDc=;
	b=FHIdyGaf/DHMYhO4Jaz5Mj7YX03Om/73hPpCUpnt4ZQUKrf0+BxVywOAGWc/jVhQsfEv
	 UhmE6137i/n5XmKJaoUahDC5gPZYiwmdtMqvDMS2eo5iHeEVmQ1gX3GPnlUR0j3DHXc2z
	 OBTgMgNxNvRAy//jmmVLuP1bVetSs012fIgjzWb6vyHl1WnGtSRU0tzNEE0LJzf/9ZuKm
	 /da6Mmy6NUoO2LOfwwLokgvng3O9dfR5mmmjWuzb2Z0mCxS+lXQam5S2rOFN9Fcd3rYcJ
	 0kvkVe2mZxw5Lyrz51C6jMLVmf/G9jx6aBxelndpVvsQA+r6hBKyAiyQ9vFhwHNUWHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="lgklS/Fo";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E6606B26A;
	Tue,  3 Nov 2026 15:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4E6606B26A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lgklS/Fo
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EEDwc860830;
	Tue, 3 Nov 2026 15:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9NFf+pssF7Iw/T3QX
	dW4oNg9Dns1GqN3Nr4tuyoRZDc=; b=lgklS/Fo/HouppF3TLW/MQqRCRdkWqztJ
	Ssko8bCLj+EYWZ/KgPIvnSkwwIvqxdR8Jh9ko7HhxQmASp9Q1tUzRZYzdQwqVrhP
	dQSw5XKBBbjSVnanCL/wZ7/gQbH9HiugFoXotQ9WBHdW7Siko0wYYuVVo+54nKnE
	l7dhKSLeYQNO+b88Eff3KAA3KKX6U5hVQ07cwX+v2BXjwk/bOsAssv+5Sm8zTM08
	IdM0FO705tGhh1Gs4Xvimquc9V8rHnUTNAhiesqZRJx0s0x/JUQ2MxtJub679OPG
	mrnmyY1NtJNWXVl/h+9sNFGhOl1FFU1tRlJBshEaprTOvkppgxXow==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rd68sj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 15:01:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EK0LI1451556;
	Tue, 3 Nov 2026 15:01:25 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnvvfttjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 15:01:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3F1M8b11272788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 15:01:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B35D958056;
	Tue,  3 Nov 2026 15:01:22 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EC6A5803F;
	Tue,  3 Nov 2026 15:01:21 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.243.67])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 15:01:21 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v12 2/5] s390/pci: Improve function measurement state management
Date: Tue,  3 Nov 2026 10:01:11 -0500
Message-ID: <20261103150114.68873-3-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103150114.68873-1-oelghoul@linux.ibm.com>
References: <20261103150114.68873-1-oelghoul@linux.ibm.com>
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
X-Proofpoint-GUID: agAxxBj15yQjI4GiAZlVPuoY8RtYOs9N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1OCBTYWx0ZWRfX3WvObv1do75p
 BwMoZcqV3haAk03KdbQr3VS/gmUi2v9ZPyX0PR7W9nCu2G/svx/1hsmdPFsB2maY5zbnbXd+GQy
 kqYD6b2Sy5Iam3PIzUVMVYyLZ71PTO0hoO9mNxZJ8iCrR+MdN5IQ8hNBZxJcGRXpeCJ1eUDBASJ
 gx7lTEIkFpbS3MrmWHTkBks3oMy5P1gxrGbpT2Ik8H7Bb2o5Om/1hziQUNrGqKCZtkKobQDSnyX
 w1faQFicNIXX7M1ohroGAqgO0Vg2ojB6XJitwsHMQfOic9GVy6F+vqB/SaeJySH5G2BD6wSl8KV
 rhk0FVVwmzEvwIWqs2LBVUnlJGTf7XezRnK6nLcyWIKvIvtqMeDsARKrlLMpF4O4FaJo+OJhHoD
 CkyKp+u8ASs0hLEeXvINHQrgiINDfZdCeSO2wXAHhon+Bsd5TSzXFQSoYY2l6j9jst1qZLEkvdq
 GV3YhaRe/cdKbCdsCMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1OCBTYWx0ZWRfX9ADkrkHoPOSG
 ADnVx+eGRt0UnoEaNUbcYY21SKvcPmmZbDHmvw6zHcq1TfEKilEjwf1reCvgLMBQ9MAl7sggX8+
 hbjMGsWyAXr9aoKCbPbFzHhDxXGBcaM=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae9f746 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=cItLoxOyQSrHz8uLRusA:9
X-Proofpoint-ORIG-GUID: agAxxBj15yQjI4GiAZlVPuoY8RtYOs9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030058

When a zPCI function is disabled and re-enabled, the firmware implicitly
disables function measurement while the kernel still believes it is
enabled, leading to a disconnect between the user-visible state and the
actual device state.

Add the statistics_on field to struct zpci_dev to track the desired FMB
state. Introduce the functions zpci_fmb_request_on()/_off(), which defer
to zpci_fmb_enable()/_disable() to perform the actual firmware change.
This decouples the enablement or disablement step from managing the
user's requested state.

Restore the state in pcibios_enable_device(), pcibios_disable_device(),
and zpci_reenable_device(). New devices start with measurement on by
default, unchanged from before.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  7 +++--
 arch/s390/pci/pci.c         | 54 +++++++++++++++++++++++++++++++++----
 arch/s390/pci/pci_debug.c   |  4 +--
 3 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 88a125b92bdd..dd58c48ac2ed 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -208,6 +208,7 @@ struct zpci_dev {
 	struct zpci_fmb *fmb;
 	u16		fmb_update;	/* update interval */
 	u16		fmb_length;
+	u8		statistics_on	: 1; /* desired FMB enablement */
 
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
index c055a9ad0972..f49736386eb7 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -164,8 +164,38 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
 	return cc;
 }
 
+int zpci_fmb_request_on(struct zpci_dev *zdev)
+{
+	int rc;
+
+	lockdep_assert_held(&zdev->fmb_lock);
+
+	rc = zpci_fmb_enable(zdev);
+	if (rc)
+		return rc;
+
+	zdev->statistics_on = 1;
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
+	rc = zpci_fmb_disable(zdev);
+	if (rc)
+		return rc;
+
+	zdev->statistics_on = 0;
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
@@ -207,7 +237,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 }
 
 /* Modify PCI: Disable PCI function measurement */
-int zpci_fmb_disable_device(struct zpci_dev *zdev)
+int zpci_fmb_disable(struct zpci_dev *zdev)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
 	struct zpci_fib fib = {0};
@@ -644,7 +674,8 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
 
 	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
 	mutex_lock(&zdev->fmb_lock);
-	zpci_fmb_enable_device(zdev);
+	if (zdev->statistics_on)
+		zpci_fmb_enable(zdev);
 	mutex_unlock(&zdev->fmb_lock);
 
 	return pci_enable_resources(pdev, mask);
@@ -655,7 +686,8 @@ void pcibios_disable_device(struct pci_dev *pdev)
 	struct zpci_dev *zdev = to_zpci(pdev);
 
 	mutex_lock(&zdev->fmb_lock);
-	zpci_fmb_disable_device(zdev);
+	if (zdev->statistics_on)
+		zpci_fmb_disable(zdev);
 	mutex_unlock(&zdev->fmb_lock);
 	zpci_debug_exit_device(zdev);
 }
@@ -737,8 +769,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
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
@@ -847,6 +885,12 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
 		goto error;
 	zdev->state =  state;
 
+	/*
+	 * Measurement is on by default for new functions, this will be honored
+	 * by pcibios_enable_device().
+	 */
+	zdev->statistics_on = 1;
+
 	mutex_init(&zdev->state_lock);
 	mutex_init(&zdev->fmb_lock);
 	mutex_init(&zdev->kzdev_lock);
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index c7ed7bf254b5..06e2e8bb2f82 100644
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414516;
	b=dyc+V8VG1LlAt8SA4+UNMpM8jF9AkPXqdHhEq0RSF7otOkn5jysZNmiM3q1NGUM2Hqld
	 dOLLEO+vMH2W2aJSlqT6XP25W8OzLUlVVSfKhdBd1Ty0clUEYVQu7yNq4XgdAlFJBpD/M
	 gz8yRrM0WUuSNuBbyMDi2XaxLOtF4kxcr/lfAnUcH4pVEuA2OuzVQ7v0SvoNh5IIpXG6/
	 OmQs5b6ViAc5O5BZn4crnXtPLCU22Hj4mZCAgjZI218uc9FI1Gs8oQKiYDBmWjOSX/4/P
	 cA0btvx3VVWYYlvRy7hZJ3Yn9UR3AP9su47mkHuav5YrCwfzZPVsQKVfps2KYKB5xfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414516;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BaBB6wALlTm7Cd26ZBadZj7pR/ee8fNdP9/e/WzIdzk=;
	b=xWQ44HUKzRSOTVLLEsFm3nbb/ZhJ38aAyD9linPy4w/GtuM/8VzdrFZYzyf1I6hnBdoT
	 ZQNFM9S9KBcEGwwyxQGETb28ccMIdLWkUNpVQC9EDsa06h0se9Pdi4v/8WOL/fV9R8kc7
	 Cz0BlBqqxTH7AQlIyCq/3EbSLiC9ALVUj6BYNns+rzvxX0UNhCW0HU69wPt3KEsKUvTpV
	 DE35IEX/RcRDTkimtRQjOmC7z2AFZ9jf1hkokO2PVQzpIdPqt7Ye+qdBVoM3JXtlm8ESv
	 ZXXEANx0VbVJClEJOdLyeJHnq4QuADuHBK1OnahrAX/P73YP3m6bPFZdNB85BNyHimA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K1hdr0hF;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696FB60A260B;
	Wed, 11 Nov 2026 16:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 696FB60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K1hdr0hF
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABFEEN3236840;
	Wed, 11 Nov 2026 16:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BaBB6wALlTm7Cd26Z
	BadZj7pR/ee8fNdP9/e/WzIdzk=; b=K1hdr0hFtEdAfcOznN3q6XMbYh1yGVr1Y
	V0FgQ0u5ICzTldbeZoRptAr7Brfa+yyL/BpDQdsvIJXYKaiQHR8tTm59LDymduK1
	NOth53t0tIlx1sCH0i8eA6YqwU4FBX4vV2JY81QyURyNfZi8zFacokY+6jy/B4aw
	/nt4C241DtvX5BSBIOp23YYrO+VH0J4roRbSWdYAbgalYJiKbBuI8q0mYQAiUdXN
	3e9nsa8npX9M+ScL3icdRqFOZfR5fAR7s1olxQxmPLk2jN94IxtEtkByRsDjNcs2
	CxtMmBk06R/evQW2xxVhwaRWCCmT9l+hx9U0zbKBfOVzj4s4T77EQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgagu5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 16:28:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABF4xn53490875;
	Wed, 11 Nov 2026 16:28:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309n6dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 16:28:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABGSUxH18088514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 16:28:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08E4258059;
	Wed, 11 Nov 2026 16:28:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA09958028;
	Wed, 11 Nov 2026 16:28:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.243.186])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 16:28:26 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v13 2/5] s390/pci: Improve function measurement state management
Date: Wed, 11 Nov 2026 11:27:55 -0500
Message-ID: <20261111162758.9792-3-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111162758.9792-1-oelghoul@linux.ibm.com>
References: <20261111162758.9792-1-oelghoul@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af497b1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=cItLoxOyQSrHz8uLRusA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NCBTYWx0ZWRfXwZTsxHTuLcl5
 RBZdTxUOzhb4InL3+1roiFA13pZGb5P53j7CtcwdE/91s/L8QLDn1X93hLLyXHNISuBR8KnDRB3
 USEWxQGv+Bfswt2uf+6x9QYf7biL0bXsE6jS0q1HQFLAlP3F2UDNsgSJHfkweFgemznTIVygWKu
 QN69lEss6mhne/cpFZ0+EaTMDp5CYVENTMpg2fysAf5UI/QIfmK26IX9tocnWX8QYXlAA86+4qv
 lXXanAR4vZu7tecBkjx/Rp0zPWpcZzCGD1wJ2l0qj7X3yjfby+hiDvsQ4sGGzJ4AJ6TlfdrZ+I6
 jXWMfU0TxvKORebd0w58HH3nNYj1HJQ6Mb5CVBPatnR+i5H3QfrTbNx/YdoH/mj19q/moQZLpkv
 sjUGxoQu+HBDlSW3bqovk34HZSsUNkjsucKO4XQE83IHJ7xuoYAywsF/G6umQasu4D67to5bzy3
 69muJOYAjca0MZ5UWyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NCBTYWx0ZWRfX0lmwAJSjt2f4
 uNI/9ypMeRLly438gYkZAdB/wkOrMynn1Tv1aQSuL8kAKXCeMiajzGG/fktnG8witYi95ZZQBL1
 GjVCLbI0FBt66/6ItHQh1qNcp20DNcE=
X-Proofpoint-GUID: gLHU0-BEE1d0S2PvvBYBmIujFXPJmbvl
X-Proofpoint-ORIG-GUID: gLHU0-BEE1d0S2PvvBYBmIujFXPJmbvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110064

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
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
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
index ee1b1759655a..576e824c3107 100644
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


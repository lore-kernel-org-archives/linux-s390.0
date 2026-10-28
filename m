Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202251;
	b=YrknLMWhv7zuu+c0nTUAKsbdgoIO7YqIJ77jW1vn77RFQBUWNjpnJWdIIkVbSTLYNqf7
	 mPsxD/BsNSy2pGbluaH+xgCGKLo76m7EOTQEm8xOdX59g9SSQTVLB2mu+Fsr+S4FJ0Iy1
	 FHVRBbuNq3U1vAeBvBpBRwj5rPbiKkexdxnfG/TygYsRrNsnzfOMzWamSuT/lKopKYzrR
	 i/yHIw5rzQmFOixSdVUZk4xw6bKwq8nn+3liiIHln18WdopwCkAaY9/YTkCOGo9tzJLZy
	 P6jNLAGcMo14Fm2b+7xNXMirz/ZQf8fdiIcAeKWblMfy7jxibIJhVgKBcglaNXtSS+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202251;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=EtbCnKJyEA3gnzjmgYhdHmn4HskVzv8aV9KXBZSNEks=;
	b=coA1CFBVadLpj83+wjzIDWDQHb6snkzNqqXG4seITrEJdST4pIZmbOdsGQovUhyllCnp
	 CXKXAjFidrjOydefBc2fXaIwXTLDvG3ikQH5afhcY6HXTgPXDkZPsZ1h2F3yajxg0Grdy
	 xLnBj/YwSQbqK9Krp79OBkgXkKKrpu9G3qeL2NLKLUxKG6ZuEQpZ3Azt9TOKdDtXdsCy1
	 e9fqxmvqpfem0aLnL/HBnoWCW5fme4OzN83BbktXm/qJyLq0hN381HhK44bVmrt4FUvOt
	 vwq+Z5FrstT/tnazm+s9a1UEZukVHTZn2KuHXZOPLSfExZhc+FCY3x+UqOG9etvrnXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YFvd9dPO;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89AF606A325;
	Wed, 28 Oct 2026 15:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E89AF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YFvd9dPO
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFEHoL1520313;
	Wed, 28 Oct 2026 15:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EtbCnKJyEA3gnzjmg
	YhdHmn4HskVzv8aV9KXBZSNEks=; b=YFvd9dPO21FiU8XyrvjXQNMcNxG3xzFM8
	xh19G/Q4+pnADEXYyAC97DD+xgA3+JBsmLMgFtSmJ9ckGgnzFT70jsWYaXS/cs/u
	tdVXWGBQIXg7EoJAB7egk82rB4OLtdqiTW5Ajz+3H2Mgxi8gtay+2A7iys8v4ngr
	K6ks9obpViDMQ4yQh0FdgqR1HMIBRlrvpRUSYGTaFnnR9RrFV+gDQTwVWMWJwisf
	0B9G4TgzIbOvNBIOcCfHwLVtVpLpBNeeJk30UHKidd/X/ZnD3HBwPkag9qrZorrr
	2aUj0eqbNj6dt5ShdAT9j0KR4G1FRr40QpOElhs8b2KXhzz1rrJ4w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mdpuq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:44:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFJs1e1676512;
	Wed, 28 Oct 2026 15:44:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnndngh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:44:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SFi5Ka32244368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 15:44:05 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E170F58050;
	Wed, 28 Oct 2026 15:44:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C805558054;
	Wed, 28 Oct 2026 15:44:02 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.240.205])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 15:44:02 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v11 3/5] s390/pci: Reuse FMB buffer across enable and disable cycles
Date: Wed, 28 Oct 2026 11:43:50 -0400
Message-ID: <20261028154352.15108-4-oelghoul@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfX53IXN+2Lsxep
 SU2vIahxsXIw8FOEG9qjFvpIXMOKy/G1kspp1tQf1kkZ/BoyRtlDI+d4GFGVNc/t2xPCvMJzI/8
 Fd6LqXqSAf4I4JMGD+e/0ARoqQJaKMY=
X-Proofpoint-ORIG-GUID: hGvurylBdevgcKTSYM3cPrsc6gKkq6RN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfX3hxIndObiPAJ
 YhXicmoALf2KD/aoYX1l46NlWYUrV8VnNRtYSWWJ9iRTJlCdYOPUWjDQgzW83Vlu+qBAzK3frg3
 TNStjtuWbemPPaU68v3qHmixqpVkVGv9EPEfbYB5IikJ2uqbkFfxWmlJ+ZNXFvC52c9K4zuMAry
 gWsCns4XXU1GYrllzVR6Tka9mTDc2eoIomrmosY9oHgPoOPaglUJWaqjh0Ak4OGQu/TKgU0cVZd
 +ewSRUS8sAS5VAtbKgcdP/mHwPbjpiEXUu++IO8fR/ycXIGh4CpRBt1ZZJqmdgYTp49pW3FGLX7
 7OE6XNtQycGtdFYFPlJQVibc5JL7FFzT/xz8Vc2/qcXU258MGhLcw2bumMvsJAnqIE6YazTdYZD
 +wSBjqu/zg59BWsYKm0PDjcjyfb+Z71lyC4Fj/U/NXsw9bNH3uL7DNmjM2N/rQHH64bjRJTQraG
 qKWfFMDDrTmgb6ijemA==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae21848 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=47iA2AqdoKUvbfnVlasA:9
X-Proofpoint-GUID: hGvurylBdevgcKTSYM3cPrsc6gKkq6RN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280062

Allocate the FMB once upon first enable and keep it for the lifetime of
the zdev instead of freeing it on every disable. Defer freeing the
buffer until device teardown in zpci_release_device().

Drop the alignment warning after allocating the FMB buffer due to it
already being guaranteed by the kmem_cache.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/pci/pci.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 5889dd227009..a7e548a83bc1 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -211,13 +211,17 @@ int zpci_fmb_enable(struct zpci_dev *zdev)
 
 	lockdep_assert_held(&zdev->fmb_lock);
 
-	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
+	if (sizeof(*zdev->fmb) < zdev->fmb_length)
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
+		/* reuse the same FMB buffer for as long as the zdev lives */
+		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
+	}
 
 	/* reset software counters */
 	spin_lock_irqsave(&zdev->dom_lock, flags);
@@ -235,10 +239,6 @@ int zpci_fmb_enable(struct zpci_dev *zdev)
 	fib.fmb_addr = virt_to_phys(zdev->fmb);
 	fib.gd = zdev->gisa;
 	cc = zpci_mod_fc(req, &fib, &status);
-	if (cc) {
-		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
-		zdev->fmb = NULL;
-	}
 	return cc ? -EIO : 0;
 }
 
@@ -251,9 +251,6 @@ int zpci_fmb_disable(struct zpci_dev *zdev)
 
 	lockdep_assert_held(&zdev->fmb_lock);
 
-	if (!zdev->fmb)
-		return -EINVAL;
-
 	fib.gd = zdev->gisa;
 
 	/* Function measurement is disabled if fmb address is zero */
@@ -261,10 +258,6 @@ int zpci_fmb_disable(struct zpci_dev *zdev)
 	if (cc == 3) /* Function already gone. */
 		cc = 0;
 
-	if (!cc) {
-		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
-		zdev->fmb = NULL;
-	}
 	return cc ? -EIO : 0;
 }
 
@@ -1053,6 +1046,12 @@ void zpci_release_device(struct kref *kref)
 	if (zdev->has_resources)
 		zpci_cleanup_bus_resources(zdev);
 
+	if (zdev->fmb) {
+		zdev->statistics_on = false;
+		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
+		zdev->fmb = NULL;
+	}
+
 	zpci_bus_device_unregister(zdev);
 	zpci_destroy_iommu(zdev);
 	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
-- 
2.56.0


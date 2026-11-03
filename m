Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718117;
	b=jecMC5Kpl/GjLQUHxnBM7pBJ+cBGg1EwkjxEcdrW8cD0HoqbwyHusrTlBPRffjdLjNYZ
	 zoN/wZIkT669BKkNekrnaiJBQdKc5HerCKeYCr5vw5M0aTofikRuBriMDGhOj1t/EMCOi
	 13CQU6R6ixE9FaC2H1O5wKFTDiDFtj7KaYJMUj/U14S9W0cl2gYH1KE+WsdETeT62xtQ6
	 +5qvBMSx1m3Y2cUL1MrjcxXbTabglxx2/jo1gh6JRafY/z/+poST1TmI7txhGkRgC49V9
	 lQvXZnqeZUick+pZ9bwQYUu4LNxXOmmDCb8N+SbvgpWZTdty1nVdOdVCPVGaRmWY1gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718117;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2pkUrBoyH40amtVGREy64CNaOtDz9u8h22hfKScE3TU=;
	b=Cgn7F9iFd8RfiT/a7SDCxM2bkQ8CJyHPli/HJWUW65SB46kW9nT+PMmxnpM/IyvNZbNP
	 /EwjCU3zL7CYItvb1nZSXtzQrj265AzzgdSIuS4Q95fCxIjg+IIlWQ3gBXEcpCjwBOsZ+
	 M9iZGG0cBF/VU6n50UVuRF5xBJA666pz4fhayxhicutWUZQ0XPFkcn0gemt6+5ftZpBlm
	 P648fDCMo5AGiQGoftwhWhP8W8oKzrrr/Bj7WFvU60ApBVutXsScFp1tL6XmRkTeJIS/O
	 cHqXRRvpxAZEUvIPKkwEplpaLNeoNHPlRN9H80o5dZAkr9ZGnE4c6Lgwhesb8gRHEHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MmSzGv2d;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D937C606A338;
	Tue,  3 Nov 2026 15:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D937C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MmSzGv2d
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EEBog2025819;
	Tue, 3 Nov 2026 15:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2pkUrBoyH40amtVGR
	Ey64CNaOtDz9u8h22hfKScE3TU=; b=MmSzGv2dPMpknoVlInR7LOnVPusXaqdWP
	KqMUOBQWati7pkmeXdumLKygtMznzOuJ1EotTLs1CJdZO3wcR8/NZXe9GRZZw9NA
	2UprfRDFGITXfdATsFvmtlBTsewnCg43o/blH3H0sTSdaqCDY2mHSuJ6U0/t2P2z
	7IZl7DfrVAYZohJGQP+gO+zCv2e/J3qsXgOHq9l5w7YAr3pM8B4jJgByJO/ScKAX
	2Q9WAn6UINOaj6516kDgInmhzk8jO/jv75B0JDV1BUTfLUKfHTsw5m3eqL0n3pnc
	KCLZ+sRGu+loPa5tP6JxNnwhvC2LBo06CwlweG5u8s78iIMGAn6Bg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7yrx5av-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 15:01:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EZ3wr2652734;
	Tue, 3 Nov 2026 15:01:27 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnu1vk1tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 15:01:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3F0Zel18940640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 15:00:36 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DAC45806F;
	Tue,  3 Nov 2026 15:01:24 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFD885803F;
	Tue,  3 Nov 2026 15:01:22 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.243.67])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 15:01:22 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v12 3/5] s390/pci: Improve FMB memory management
Date: Tue,  3 Nov 2026 10:01:12 -0500
Message-ID: <20261103150114.68873-4-oelghoul@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6ae9f747 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ANRpRwoEbYyGjrzp4ocA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1OCBTYWx0ZWRfX1+P18M3kiD4C
 GwL+Y54ptIxE5C5izVtKN03O1g2zPmyPF8VFIUk2fnF2tWmc37HcDkFYRxF3v/s/b7JJZiwukqw
 8Fe2D+LC0IvdaPATqfElInxy7ci6aw0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1OCBTYWx0ZWRfX6qUnnAK0iQTQ
 kuEQFuNqWQUZCi5oncGfdbHYkQhDsRN+yQo58QtulTqwWcVE4hh4ha6jHyDMMCGwrMw73CHjPCw
 QgZ+pgErFh8SlAUlc0eB6ji8gkTSwFqfEFWlWUUMp8WkN5+s5iLVHun1hNOCS4QtmYDqXxrWvV4
 rC8knufI2SljkbjFdi+hFJzaqHcMiuu5V8e5dEv/Jwp5Z79G1GkslpOA/H66C76vwjY7+4MyQ1J
 nsM7xbixHqPvFVyVU5gQChYx7yzyOcmEt4hI2v0ONCtJlEmceFwCTjq76+gsNRIREnMeczrMuz2
 kp9PnJD0IaFF0kdchR0171Kxd1PSoRMRVBdx/RhUIzw8C3I7qq70ZGHdWGg4ZlMOJubKmDr/8nH
 P4f5XfVufoPf1zb9db1PSG+W6emSye52lti8tFgssm1v9uw9nKWQ+AOibkmmDXOAKCsqx5rKxdB
 JdrTtuC6HfhRVTndo3g==
X-Proofpoint-GUID: 9-4GzO5Js40RjmU0dEb7XXSGMRLGuqbM
X-Proofpoint-ORIG-GUID: 9-4GzO5Js40RjmU0dEb7XXSGMRLGuqbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030058

Refactor the FMB memory management code to use kzalloc() instead of a
dedicated kmem_cache. kzalloc() already guarantees adequate alignment
for power-of-two sizes, rendering the kmem_cache approach unnecessary.
This simplifies both the initialization and cleanup procedures.

Allocate the FMB once upon first enable and keep it for the lifetime of
the zdev instead of freeing it on every disable. Defer freeing the
buffer until device teardown in zpci_release_device(). Add the field
fmb_enabled to struct zpci_dev as the new FMB liveness bool, since a
non-null FMB pointer no longer implies FMB enablement.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         | 59 +++++++++++++++++++++----------------
 arch/s390/pci/pci_debug.c   |  2 +-
 3 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index dd58c48ac2ed..6d3c1b8ac75b 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -209,6 +209,7 @@ struct zpci_dev {
 	u16		fmb_update;	/* update interval */
 	u16		fmb_length;
 	u8		statistics_on	: 1; /* desired FMB enablement */
+	u8		fmb_enabled	: 1; /* actual FMB enablement */
 
 	u8		version;
 	enum pci_bus_speed max_bus_speed;
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index f49736386eb7..f066a7ffc35c 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -62,8 +62,6 @@ EXPORT_SYMBOL_GPL(zpci_iomap_start);
 
 DEFINE_STATIC_KEY_FALSE(have_mio);
 
-static struct kmem_cache *zdev_fmb_cache;
-
 /* AEN structures that must be preserved over KVM module re-insertion */
 union zpci_sic_iib *zpci_aipb;
 EXPORT_SYMBOL_GPL(zpci_aipb);
@@ -205,13 +203,17 @@ int zpci_fmb_enable(struct zpci_dev *zdev)
 
 	lockdep_assert_held(&zdev->fmb_lock);
 
-	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
+	if (zdev->fmb_enabled || sizeof(*zdev->fmb) < zdev->fmb_length)
 		return -EINVAL;
 
-	zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
-	if (!zdev->fmb)
-		return -ENOMEM;
-	WARN_ON((u64) zdev->fmb & 0xf);
+	if (!zdev->fmb) {
+		zdev->fmb = kzalloc_obj(*zdev->fmb, GFP_KERNEL);
+		if (!zdev->fmb)
+			return -ENOMEM;
+	} else {
+		/* reuse the same FMB buffer for as long as the zdev lives */
+		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
+	}
 
 	/* reset software counters */
 	spin_lock_irqsave(&zdev->dom_lock, flags);
@@ -229,11 +231,12 @@ int zpci_fmb_enable(struct zpci_dev *zdev)
 	fib.fmb_addr = virt_to_phys(zdev->fmb);
 	fib.gd = zdev->gisa;
 	cc = zpci_mod_fc(req, &fib, &status);
-	if (cc) {
-		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
-		zdev->fmb = NULL;
-	}
-	return cc ? -EIO : 0;
+
+	if (cc)
+		return -EIO;
+
+	zdev->fmb_enabled = 1;
+	return 0;
 }
 
 /* Modify PCI: Disable PCI function measurement */
@@ -245,7 +248,7 @@ int zpci_fmb_disable(struct zpci_dev *zdev)
 
 	lockdep_assert_held(&zdev->fmb_lock);
 
-	if (!zdev->fmb)
+	if (!zdev->fmb_enabled)
 		return -EINVAL;
 
 	fib.gd = zdev->gisa;
@@ -255,11 +258,11 @@ int zpci_fmb_disable(struct zpci_dev *zdev)
 	if (cc == 3) /* Function already gone. */
 		cc = 0;
 
-	if (!cc) {
-		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
-		zdev->fmb = NULL;
-	}
-	return cc ? -EIO : 0;
+	if (cc)
+		return -EIO;
+
+	zdev->fmb_enabled = 0;
+	return 0;
 }
 
 static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8 len)
@@ -802,6 +805,12 @@ int zpci_disable_device(struct zpci_dev *zdev)
 	} else {
 		rc = -EIO;
 	}
+
+	if (!rc) {
+		guard(mutex)(&zdev->fmb_lock);
+		zdev->fmb_enabled = 0;
+	}
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(zpci_disable_device);
@@ -1047,6 +1056,12 @@ void zpci_release_device(struct kref *kref)
 	if (zdev->has_resources)
 		zpci_cleanup_bus_resources(zdev);
 
+	if (zdev->fmb) {
+		zdev->fmb_enabled = 0;
+		kfree(zdev->fmb);
+		zdev->fmb = NULL;
+	}
+
 	zpci_bus_device_unregister(zdev);
 	zpci_destroy_iommu(zdev);
 	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
@@ -1122,11 +1137,6 @@ static int zpci_mem_init(void)
 	BUILD_BUG_ON((CONFIG_ILLEGAL_POINTER_VALUE + 0x10000 > ZPCI_IOMAP_ADDR_BASE) &&
 		     (CONFIG_ILLEGAL_POINTER_VALUE <= ZPCI_IOMAP_ADDR_MAX));
 
-	zdev_fmb_cache = kmem_cache_create("PCI_FMB_cache", sizeof(struct zpci_fmb),
-					   __alignof__(struct zpci_fmb), 0, NULL);
-	if (!zdev_fmb_cache)
-		goto error_fmb;
-
 	zpci_iomap_start = kzalloc_objs(*zpci_iomap_start, ZPCI_IOMAP_ENTRIES);
 	if (!zpci_iomap_start)
 		goto error_iomap;
@@ -1143,8 +1153,6 @@ static int zpci_mem_init(void)
 error_iomap_bitmap:
 	kfree(zpci_iomap_start);
 error_iomap:
-	kmem_cache_destroy(zdev_fmb_cache);
-error_fmb:
 	return -ENOMEM;
 }
 
@@ -1152,7 +1160,6 @@ static void zpci_mem_exit(void)
 {
 	kfree(zpci_iomap_bitmap);
 	kfree(zpci_iomap_start);
-	kmem_cache_destroy(zdev_fmb_cache);
 }
 
 static unsigned int s390_pci_probe __initdata = 1;
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 06e2e8bb2f82..454121bc274c 100644
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
2.56.0


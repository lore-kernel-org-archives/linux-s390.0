Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414522;
	b=aIXfRSBMjPVVgBoboHjeSiY6FlVZZtq9JLn/XZZ56trhf9Y+hoRXzlSp7h5pZJMiJ9D1
	 N/NFxF/F5asu1oaRu1SAA14tH+7x5KO6K+789CwHXlymQVAkMvywbMJ0ZQDvZa6BG7gm8
	 +BRnsGcU77rUveYCY5oyeVjGyCFkMVvsULpbzYw/Y/4FQ3okVPlr4qLxeocUIsLmuZSGG
	 tgZ0Ko4ujpgEya6D94i3EF0hgw8lFrovs4JpvilCb9Q6++c+dlZNGrCOOrlti8M4JRJDW
	 igp3ZKwWeBoI3TpT+FoL4NfuoNNZG/pluXxT1dMetZI84YCkW+c0foqYRkC26dlFDuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414522;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=imH3Hc23ZbrAoQ/2JJASk5HnUsXW8Xn2Ps4z4sTMkgY=;
	b=ppRYQrTuCUINUgV1FHhZ91BFuki92SG697iweFLEO3w1oTAH9PUxLBdKe/xeVZrfnU//
	 BhgrK3MtOefPVxBxFYZ4jQngzjp1Zip7+dH0CfPjw+GjFz82/03Q8FuHxVl0eqMMlrkjR
	 zPLp/CJ9Ig9AepuhphlUOopc6SoIS2TtJiRclyconVa8c9wbsacIpjyjLzUowYeVbWbI5
	 WvQxG+zdKgkiP7VsBWvOyPjLi7RCE2NS9mabSNbgYh5tAVe0UNYRFP/4TYr7LpcI2FwIZ
	 3XVlLuUQ4M2KKGBHLm7naEMRMa9yQ4eK6/f0hvr/NWygih/mPG76YelgYymA3d12KOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VayKa2To;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8704606A336;
	Wed, 11 Nov 2026 16:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8704606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VayKa2To
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABFEI2i1653021;
	Wed, 11 Nov 2026 16:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=imH3Hc23ZbrAoQ/2J
	JASk5HnUsXW8Xn2Ps4z4sTMkgY=; b=VayKa2TohXQWOKgCYRI1YYj+14hm2s+zS
	S1Ac2+Fu2f/ftddh8iFgUQ2p2xlqmXVTKfCGQgTcV19MKQCHc6kjefonb3wcNH1T
	mgy3ppWxC2e2ODXt5NOj3BrXErCDy5dqhUGVvKaMSUIL3/auEop2diZEORoa7u6/
	qcq2aRI/cYJ7WJSf4a38YJ9SYHXs+WPUtSceXuNW+6oLjTMO76PHUkCjxqsYOCa0
	GY7IwMh4+3qbXMygDlE15189vMHFyC7GsfcXJVVGpbYBWN3Yf2kaqt3NVIOU0D2l
	plDUgUWmm71Rfg9IiUsrIHVMti/HWZ61l7mnNZTfw46apKt9eYuXA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6bbmv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 16:28:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABF4vIW3451747;
	Wed, 11 Nov 2026 16:28:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv33256f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 16:28:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABGRhGU25690734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 16:27:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 339B658028;
	Wed, 11 Nov 2026 16:28:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90E6558017;
	Wed, 11 Nov 2026 16:28:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.243.186])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 16:28:30 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v13 3/5] s390/pci: Improve FMB memory management
Date: Wed, 11 Nov 2026 11:27:56 -0500
Message-ID: <20261111162758.9792-4-oelghoul@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: FfpfbKWTH5gNGKp_-tnoGyCFWILhCxdO
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af497b6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ANRpRwoEbYyGjrzp4ocA:9
X-Proofpoint-GUID: FfpfbKWTH5gNGKp_-tnoGyCFWILhCxdO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NCBTYWx0ZWRfX7KlJQPvOHCCz
 ENt5w7bYsAHwhUWOysMO9Lf8780T+z+DgMJrwowU5Kk1KZJB1wmfmyS1ldDC4hXB6x7g0Ob5VLi
 XPqmG3hdEUopUSwpCQO6b8qIt6/tBRCwGMBVt0HwliUKoKRIFD2mULGA2ujcHo8BEJkFMqPLKMz
 undT2WC/j+fGmoZxpc7e0ay/MFot5Oef7kLPjYpY8fmfRdLbPsc4aU2HKQTvnBUm19+E3eXwLpR
 LejO06T/1/iPm73/++dB3rw8sRrjEohw8kGi5Qif0/MEuI6GG+a7WRfFZWMWpR+NJXVE6vM26F8
 jeAEe3rt6pncjTeAMDRs05f76sfqxs1vr4khUcS4Ahq8fRyZ8K+MqTvXQD2dDfbtvFyJH31wFAF
 aU1ZPPJOfkzx1TQuBdh1e+y+QHAeCIaoVJqjnPAHr8OlOrOrNVfAVmGncvynpiuE0H9BkAQ0Mus
 X91ys+hdStTIAzPtqqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NCBTYWx0ZWRfX7DIv+Wbx/gdf
 C1prNByW+4a2gBJbkiLdmfz7gOUBEM4PyBFFl2r3QdVNOJVRpUIRhtGl+4pHsOAKryNxIIDMLiz
 S6nwQIOkXProwJ0r4Tk5y/qC5BwdXVQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110064

Refactor the FMB memory management code to use kzalloc() instead of a
dedicated kmem_cache. kzalloc() already guarantees adequate alignment
for power-of-two sizes, rendering the kmem_cache approach unnecessary.
This simplifies both the initialization and cleanup procedures.

Allocate the FMB once upon first enable and keep it for the lifetime of
the zdev instead of freeing it on every disable. Defer freeing the
buffer until device teardown in zpci_release_device(). Add the field
fmb_enabled to struct zpci_dev as the new FMB liveness bool, since a
non-null FMB pointer no longer implies FMB enablement in firmware.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         | 61 +++++++++++++++++++++----------------
 arch/s390/pci/pci_debug.c   |  2 +-
 3 files changed, 37 insertions(+), 27 deletions(-)

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
index 576e824c3107..0d799df1e533 100644
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
@@ -547,6 +550,13 @@ void zpci_update_fh(struct zpci_dev *zdev, u32 fh)
 		return;
 
 	zdev->fh = fh;
+
+	if (!zdev_enabled(zdev)) {
+		mutex_lock(&zdev->fmb_lock);
+		zdev->fmb_enabled = 0;
+		mutex_unlock(&zdev->fmb_lock);
+	}
+
 	if (zpci_use_mio(zdev))
 		return;
 	if (zdev->has_resources && zdev_enabled(zdev))
@@ -802,6 +812,7 @@ int zpci_disable_device(struct zpci_dev *zdev)
 	} else {
 		rc = -EIO;
 	}
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(zpci_disable_device);
@@ -1047,6 +1058,12 @@ void zpci_release_device(struct kref *kref)
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
@@ -1122,11 +1139,6 @@ static int zpci_mem_init(void)
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
@@ -1143,8 +1155,6 @@ static int zpci_mem_init(void)
 error_iomap_bitmap:
 	kfree(zpci_iomap_start);
 error_iomap:
-	kmem_cache_destroy(zdev_fmb_cache);
-error_fmb:
 	return -ENOMEM;
 }
 
@@ -1152,7 +1162,6 @@ static void zpci_mem_exit(void)
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


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4143A9017;
	Fri, 26 Jun 2026 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496604; cv=none; b=jdMejel2HCkxLura3oVY/Ur5drPFIm+q2Nzu6ZZc+m2VQz5ZDSK4Jc3q0s4nIPomBvuPifWx1lMz7jSeqnd3qv/YDakZ+Er8WVwefLJ7ugi4vxGXX9HTgHSsPp5ECntwtlSBM7AMdTZF4cHSbjdVIXL93nvATMK7kaUpQwahHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496604; c=relaxed/simple;
	bh=TTzYCKbnkedPTbQMz8w7BrH7tOlopcpPRN1zE/o7+xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtutCR074I/SsY0wIDlm/s/sXKItLMzMyZAj6cPSDcUFex3dc7KSAbop9Av0WKMv7JXJx/SEaHcUf1VGjGJrQczpXSqqF0Kkw4AF3pWahJP79dpNG2SwYk7YVjPkW2uJWc8Y2x5vqsdjapCXM91qiIiu1uFQNbrLNhS9a0Y7otE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kqLG0o2V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kqLG0o2V"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QFnaYP3362231;
	Fri, 26 Jun 2026 17:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GF0OxPjwJdQZTl9E9
	Ki1ytZU4JMgDalkgFG0OltwFx8=; b=kqLG0o2V45nkjCqUQvFitR2uXeHGgqEEI
	JTlnteoefEPueCKwSKrdADeJJiU1CdFBeM4CqQKGorfsV5m+xPrXxsAA9TviyhXb
	dOdJ3YhbvZQMxyoJR730lu/3cYE17uQVE9mFrr18gh9AW1gpybTOcacnmcGDW81N
	4FxV1ypmsea+aHGeiBpQtGlO1qO92YIbGrA7nUC7UFdxF9Z4m7qB8yhJ5FoYGdVf
	vIUB0Zk3E9SoVILRMqcr7jofJZOVqqpTM26fH1FhqjVkEJEIvVt9xDVV62jP7qas
	4nH8JsIqRMToDcLSwZkY1uY9bamM060nAjdrjDQSDRZog0p5qi5EQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9j86ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 17:56:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QHniQn021816;
	Fri, 26 Jun 2026 17:56:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qvdny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 17:56:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QHuajx10879580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 17:56:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E4E558050;
	Fri, 26 Jun 2026 17:56:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D98358052;
	Fri, 26 Jun 2026 17:56:34 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.243.21])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 17:56:34 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v5 2/4] s390/pci: Preserve FMB state in device re-enablement
Date: Fri, 26 Jun 2026 13:55:23 -0400
Message-ID: <20260626175525.37370-3-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626175525.37370-1-oelghoul@linux.ibm.com>
References: <20260626175525.37370-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bs13FM0vJ2-RA-u3buSvXrSZd9x1MMCm
X-Proofpoint-GUID: bs13FM0vJ2-RA-u3buSvXrSZd9x1MMCm
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3ebd57 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=oGupVoiG_xs3DRKMqNIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE0OCBTYWx0ZWRfX/yrZCOuMNzVw
 b1NSRgtQ2sDifzjAecug2q80O0/IM2bDfu9+x7/fqYixBJ7xV3uAhSrsawXX5FE9NKemt1va3+B
 FoNNGopPj1aV9RNmTLuK3bBDbRagCf10inP7qSf7B6hUpueR8fpPEn05EiLt16zBoMuMmQEW/eZ
 cxYzBH0B/hF39CV+A6UU0hMe9t9LsoYHt7Ym3JH5AerKDP/sd/mp0gCQQ60EqZOjbNXoH2iVq/Y
 gYkB1DpWm5gUxkxMGEze5U5/xiqxzlEIlevlP/WIBSJyx9d1Dss61gUa5ILI8G0L1XMjXF26FCW
 uuvtZ7HADVsDU7cq5QSutndoFJtnQGkH5QtXVgUUx9sHV4Eh0/OlUX+/L9Bw6Zv0cvfpZP2xdiR
 aVldK6XzTyJIwaU5SmwpHSL3m8sq/Gp5PxWI1d+Ns9ptfGnBHN7XQYu17amVpcDjKv3Fwtn7f8K
 imkGVRYotq5ZeAOey+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE0OCBTYWx0ZWRfXxEnG+aKVqDkU
 sxRz0zJ1E8PWcIOoPWhz2Bn5g/eb1e6F4PLyb2vVLn8odxY9hHZ/sAvJMbmrdUHZZWJ3PH2PKfw
 BmWlvQkZ2tdj+fR9so4U2/FOUnsRQrg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260148

Introduce a function zpci_fmb_reenable_device() that checks the state of
the FMB and ensures it is enabled. Reset the counters to zero, disable, and
re-enable the FMB if it was already enabled. Call this function during a
zPCI device re-enablement, which in turn implicitly ensures that the FMB is
enabled for host devices during their KVM registration.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

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
index 2910d4038d39..1eb6aa772eb3 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -231,6 +231,34 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
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
+	kmem_cache_free(zdev_fmb_cache, zdev->fmb);
+	zdev->fmb = NULL;
+	return zpci_fmb_enable_device(zdev);
+}
+EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
 
 static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8 len)
 {
@@ -737,9 +765,13 @@ int zpci_reenable_device(struct zpci_dev *zdev)
 	}
 
 	rc = zpci_iommu_register_ioat(zdev, &status);
-	if (rc)
+	if (rc) {
 		zpci_disable_device(zdev);
+		return rc;
+	}
 
+	guard(mutex)(&zdev->fmb_lock);
+	zpci_fmb_reenable_device(zdev);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(zpci_reenable_device);
-- 
2.54.0


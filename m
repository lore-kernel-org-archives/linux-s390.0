Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DBD4854E6;
	Mon,  5 Oct 2026 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215250; cv=none; b=RbcvhHDY+VJbYYAduJocCPxT5KDSHy/fePBlrpnuzkBsvH2O2nYGoahcQda7gtZxZAGsTrUMu4vhq/M+Xk5MUiUqvqYyuHvonEFB/uipoYR0ZDLh1ZfDIDhm59rkeCQa/buP5wyISbShHPcfR/2zNz3in1+XQbGWJ2NcMpJM/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215250; c=relaxed/simple;
	bh=Pp7DmVHziTjsngerGzAzS9ggZnFeUelWoLtKn7VLkkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erNNAhrZh8WP//Wgzf2DPhI1F249jE9cPtbDaIPKWMJsU+q/gkxuMD3ld3hB/fQdztcvTT3/pxns19B+SLW6L63l+ZwreWH7YNy/o+lDrqWR161Ra/Yc69WVtmEhbpSL2kDtoCQgtY5R0TV3RtzVxWTWMCSao9DaiyJqm4e3NlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zs7GsHri; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zs7GsHri"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EZTRr964180;
	Mon, 5 Oct 2026 15:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l0eLohf0bZd7cQUOX
	391fnN0GQ8lLsDWvhUe+M+IiXM=; b=Zs7GsHriI+IAP3HmIacZzk1Q+f76SmJjT
	qPXJToX+0GiT/Q6eFsMyeGCcZ1/T48M//PAosHJ9rX7RzC7G/TQ+9KfknqLt68r6
	bZkQ12Uaa9EB2988hs+oZYnV+Ig0blgTvQyqx2vudDyReF1NmBYQjdjalVOVE+om
	ZbI+jCNBwQFyBMlxaNhgBVTtvxVHu8m1mGysoSLKBleIp0I0wXLaKW51vCHI967R
	o/poTFptKx2A366jSpd4VzmyHvwLMGNXtPP3QImijO10GqXqwgWAr4SvOJZ67xe9
	ciwPw0UoAQ5u4rGIW/AVUu+AwmMF/ihz1tU4MC0kUl9KU9iH8XIAw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74k6rk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:47:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695EWVMI3025066;
	Mon, 5 Oct 2026 15:47:24 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jp3cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:47:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695FlM8G31064668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 15:47:22 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 771B158055;
	Mon,  5 Oct 2026 15:47:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71D4B5804B;
	Mon,  5 Oct 2026 15:47:20 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.252.89])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 15:47:20 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v8 1/4] s390/pci: Hold fmb_lock when enabling or disabling PCI devices
Date: Mon,  5 Oct 2026 11:45:54 -0400
Message-ID: <20261005154557.57801-2-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005154557.57801-1-oelghoul@linux.ibm.com>
References: <20261005154557.57801-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: atdte1Mp_DAIT_aCOEUlOJ0BoUPcGizI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MSBTYWx0ZWRfX/pPr8qVMEDSV
 rdB9DrXjFI7onngpy7iHdUleIO14OmryImZagN1ug/szlnqIiHNhA8isJjFxmAexZOR/HSS4D+l
 uzYCOMb7xwOJArUnTzhTNVOnqFptMJE=
X-Proofpoint-GUID: atdte1Mp_DAIT_aCOEUlOJ0BoUPcGizI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MSBTYWx0ZWRfX10A8Zfg8CKX2
 3ahiH3CRnk9Qss9lgXmIU1ECsXcp/vEdbuA8J9hSQ2t6hcxAeEprENP9fjCwUKTVxZfmGE34X+m
 oFmambltfaEkKOV4qNWKGpTf/ycYvS1ZwItsSrPh7Y1f4GdeMBVoAOz2bEu72OW4eJPkHqF1AcK
 dkxkWBhxccN1ViFzs9vr/HgQtLe9fL4XwGj1vYTSBqjrqieZRIXj3ynh9+G1MHVEPqSsP7o5bpv
 XCR83lrYRwkQsuGCDE0tzuUUGZ4KulkSSxW5msr97GkpT59Kc+khSll8qaYipiwt4gfTIDCuNhd
 cJrUOxX2SXd01zaH9XSvRvutuivihopt+O2+H0RF2XAf4L5QHEeHiyvvsFztVAh1eYkAVdeIAYP
 VqT3KHwgSnQdmJyB3uZx9RpcyZIix2qIaWN3Nqc3cxyCo7OUjn5WZKWNVR1kN3ssCG9gVaWGv3m
 H2c6oQPEYh4BmoexhjA==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac3c68d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5NbLduwtq9nBFWGw9KEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050061

Ensure that fmb_lock is held by pcibios_enable_device() and
pcibios_disable_device() when calling zpci_fmb_enable_device() or
zpci_fmb_disable_device(), respectively. Additionally, assert that the
fmb_lock is held within the latter two functions to prevent future race
conditions regarding new callers.

Fixes: af0a8a8453f7 ("s390/pci: implement pcibios_add_device")
Fixes: 944239c59e93 ("s390/pci: implement pcibios_release_device")
Cc: stable@vger.kernel.org
Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index d64c544b32b0..c055a9ad0972 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -173,6 +173,8 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 	unsigned long flags;
 	u8 cc, status;
 
+	lockdep_assert_held(&zdev->fmb_lock);
+
 	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
 		return -EINVAL;
 
@@ -211,6 +213,8 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 	struct zpci_fib fib = {0};
 	u8 cc, status;
 
+	lockdep_assert_held(&zdev->fmb_lock);
+
 	if (!zdev->fmb)
 		return -EINVAL;
 
@@ -639,7 +643,9 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
 	struct zpci_dev *zdev = to_zpci(pdev);
 
 	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
+	mutex_lock(&zdev->fmb_lock);
 	zpci_fmb_enable_device(zdev);
+	mutex_unlock(&zdev->fmb_lock);
 
 	return pci_enable_resources(pdev, mask);
 }
@@ -648,7 +654,9 @@ void pcibios_disable_device(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
+	mutex_lock(&zdev->fmb_lock);
 	zpci_fmb_disable_device(zdev);
+	mutex_unlock(&zdev->fmb_lock);
 	zpci_debug_exit_device(zdev);
 }
 
-- 
2.55.0


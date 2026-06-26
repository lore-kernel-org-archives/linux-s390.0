Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B039E190;
	Fri, 26 Jun 2026 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496602; cv=none; b=H8oIZeQllT9lhSN5OKG3ZVt+quhhhGegSLTMJmdPt9W1vZ50zkqITLqQgf5goM3SLT610e1KrjxQAF3w1ljxMXDaDt2ofQrUOg7Y237cjWzQdYhk0p+vENYdecPmmqCv6mw0gYVrp4I4luc7oi8f2Xq1YKIdqAE37w9rA8jGTp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496602; c=relaxed/simple;
	bh=MNFffotkc3sbM9n5Wo6cfZhCXqNaLzI/23NNBH/KLM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtS6UWQWZqwlkuex8G70vyBpcIkgjP19nd6auA3BQUOCilYS0ZoJFpkrsYycXLHm6jDIZT/QfJqdaMm/EgwklVJ2rDR4ZEYRhznJvbPau3xcwavxI/bOQY3VJCnylIiVB/cnHjWceERIC+ZB1DZWIiKrRSTJHgytF6hZsFutXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AsaF/zB4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AsaF/zB4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QFnZ0p3362220;
	Fri, 26 Jun 2026 17:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cGWDYzD7sk2qYfWo8
	Y1/9AftxDK7t1eHT6ZHFONArtw=; b=AsaF/zB45V1jNxNo+YbvrV55AZm4XQ20n
	bR900k4ZSWG6bp0m+xqOij9BADnrBJRdqw+ESjIO0h97CGhfFHcaoXjT1a1Dx3dy
	8QqqIwkVZPd0jr9njyO+Xft2vZFrIXmolme8NoqKwYeQk6FiPHds8o2DHUVVZyrp
	apk6aISEa5lf5R4qmvxpgpgjwZ/KavpzH+vJXmIAGIFjhiUXXhETAptzzI1gjSNA
	Z0gXh+oiBrfzNYauB1cxyQRNblBLSdn0W9wPjHRzcXSmn05lT31nO4E2kQaAkUid
	Ba8SxzrACpuHpNuiTgTz3cNXtdzzr2+2HET2WGsRiH1IwcajCzv+A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9j86ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 17:56:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QHnesP010322;
	Fri, 26 Jun 2026 17:56:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dgky8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 17:56:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QHu1p03736240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 17:56:01 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6140658050;
	Fri, 26 Jun 2026 17:56:34 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9ECE58052;
	Fri, 26 Jun 2026 17:56:32 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.243.21])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 17:56:32 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org,
        stable@vger.kernel.org
Subject: [PATCH v5 1/4] s390/pci: Hold fmb_lock when enabling or disabling PCI devices
Date: Fri, 26 Jun 2026 13:55:22 -0400
Message-ID: <20260626175525.37370-2-oelghoul@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: dwWJiPbn--97nCv2RXfb9G5fr0jT7Y5M
X-Proofpoint-GUID: dwWJiPbn--97nCv2RXfb9G5fr0jT7Y5M
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3ebd56 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5NbLduwtq9nBFWGw9KEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE0OCBTYWx0ZWRfX9Lf1MGw+PJ97
 F6TX64UT18CrhLqq7Rp9zO0T4BkZf7p/GQa+QMMfEpQgc7yT+WA+8EejwDHK+yCvPMAQfsrspnf
 2brYh0oTo2raejO0I0Y+k4McnmOcJ8gcPxk8+yj8Jny4ABTD3U+T9vVJ1xzUIVrbJwav1Ys5r7r
 H7hsEh2LhSrBg+GDhHjrn266es89GRmNaNP9VE4ythytpy/muK/tcYRTaYBeaqNa+7iHCAOIr78
 dehnsXuL7sgdwBPbCDSLSkxsqUrpWXUUiYa1Tbgy2GNwqnVwkneEK26BgWqPPxMYTWof4f6LTOC
 LBEbZqQD91XyVrJGpa5BP6cE7tdAVqixNmx+alBSYIeYrY6HyK+iKIhdI9KOHbAaxyXj3FQPTu0
 qQOv7A0I92167Xxf9iSug+hMRAXmK0YwSu8ljnPeOEvhLkj0x0ihVH5BRg8BUztu+T6cdqGDR5O
 auyWtuW7/yK5dQkfb+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE0OCBTYWx0ZWRfX59DT8whO9JPO
 VhXEtKwEX3LxWapjVh2J+EmcLgO0SDlnZ89ptaZ1m+mE57xlHNxnLzEoqZiI+6VYyfKy+ZCcBDA
 nCatUufk9vNJOKCf2al/gfQhEF1Nwus=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260148

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
---
 arch/s390/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 39bd2adfc240..2910d4038d39 100644
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
2.54.0


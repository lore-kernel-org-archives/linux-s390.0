Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4A94252AE;
	Wed, 19 Aug 2026 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129477; cv=none; b=Y4XpUVtM6mmGDSGnhS0b3tdCy8QvkCwR0o8tWc3BF6vx6dVCEH77OPsl3uKFX2OBL50WVi2/MBa9tM7qm4uV/8+6iXNuqIEyxreWW8EqKsOYNRY/xJvdjS0wPV4aDv994vzSKnhMFG6uoLyIqxGK+g07q2DSna3W33bda9faXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129477; c=relaxed/simple;
	bh=TUEkS8610yFZ5NGf0Xl4UBB7A3BrCqBlaqaQ5SiVQM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OZNMQEbQI24EfP9bsdjx/3gPc0kqDB2QUYD7OGhuuG5yqviuWH9Drm10XcMTcLCAgnXQWIDXxK/HOyUv90S8fj22g6YtSrspy0Gku8ZxLvNgophvZf3ppJjpAocDT5Pa2wtxCqcBHye9Enc0XghLKIgZnAykXJa9PZO/SE4CaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o4Slmqs2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o4Slmqs2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6W7sV1544811;
	Wed, 19 Aug 2026 08:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X2tJql
	l+Fi4HNShPax6UVCV1yJsPcFkMEGIW0WeqA9Q=; b=o4Slmqs2Y2OsEJyWuCGeuB
	6Q1jCk2gvwGXIbIL480gzvU3yeIIWICRFnKigb7MOepRUCjtAXUAum0QD6GBu5Qg
	s1xFeH+hkf+XhEJtJ76km0GTVZmgO0XHoLMBtITjiAw2oVLNFclDEAemiha3c84I
	mlAeTMip3PKlFCeGpuiwsY4gZj6u6f2DjqAJX0nVQA5xJOeT/NkUqjf+dizDCuGH
	vbZUV5kQLk3Mdkqglw24SfBQaCOhbCi4mA49VcOxsByIeuOEZQR0NGSS9OhHmjW+
	02oEs190/4urnyU2mjxU3eOa8pg0DFO2MW9eXSX1xYlv0JsMETn8XD5WGEYrjDvg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu22jvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J8fMg7018364;
	Wed, 19 Aug 2026 08:51:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek8169-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J8p9f643450734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 08:51:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0151820040;
	Wed, 19 Aug 2026 08:51:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C479E20043;
	Wed, 19 Aug 2026 08:51:08 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 08:51:08 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Wed, 19 Aug 2026 10:50:57 +0200
Subject: [PATCH 4/7] s390/pci: fix MSI directed-mode teardown IRQ bit count
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-s390_irq_domain_fixes-v1-4-826ff27b6e97@linux.ibm.com>
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
In-Reply-To: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tobias Schumacher <ts@linux.ibm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a856e81 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=HZfvwOHSaoXKuVtsHEEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GjJ6vVpTghGTrR3g2iY6JDSunex6PZwZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX2UZRO+yDlHG5
 PQo5VLaulvPLyXOQoFNsFZDL7MCQBvHYlqNuR19cFXDvW71ZIHWF3+csOnzkE6R3QkVRQEgp3ic
 rRRxUuV1sQxeATemOvbSRfuTCc0YNZw9ca8qPrdFx48LuPoa1ghzdOE+XtekYfuO+eBd4G1hfE0
 pla/eGRgCGSKNBWg91ehofzv8C+N5fbr8Tca3BktZrSNkCTnvnw+PnJct2JDEwivzlspJov/Tbl
 szATi6KMn7vrUcsjjgQDILbV41oQm6VGJieFaf50jeni7DB9iAhQT62ZeoIHegIs/6rP8/J2bHN
 m/I4Lap164ZRH6MMt5ost0yVtz/cRzYVN1ahSH0udvh3ltDw+HACI+Mh79NvG0EJ1Pj+Y/3XLKT
 kJRZ8UXwjxUQ4FxmTNE6TEN0wMYFsokQ9LP1WWZbDaWKGFzixAc+vbhFSbJwGce/y0yNCZ4oz8A
 01GgkakgyHTujwZ/4jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX5qaOCQhsIXnf
 XHvZ1JL2l1S63Xn0fKwYo/z4BrBNywd3shZSykv0K0fkwPvJWHObmoxRC1K7RKTEo0JFpsZkr81
 nHM//AqjZOuEc/MR8wrPA6tNbmGqsEA=
X-Proofpoint-ORIG-GUID: GjJ6vVpTghGTrR3g2iY6JDSunex6PZwZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190063

On s390 with directed interrupts enabled, zpci_msi_teardown_directed()
frees the platform's maximum number of MSI bits (zdev->max_msi) instead
of the actual allocated count (zdev->msi_nr_irqs). This corrupts the
shared IRQ bitmap used by all PCI functions, causing lost interrupts and
heap corruption. Fix zpci_msi_teardown_directed() to only free the
actual allocated IRQ bit count.

Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 5e934ac990ac..e9eda846cb2d 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -349,7 +349,7 @@ static struct airq_struct zpci_airq = {
 
 static void zpci_msi_teardown_directed(struct zpci_dev *zdev)
 {
-	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->max_msi);
+	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
 	zdev->msi_first_bit = -1U;
 	zdev->msi_nr_irqs = 0;
 }

-- 
2.53.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0D83BE161
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607245; cv=none; b=MGC9mEEtkPc+ieGwoDbX833/BJdfRZrrzbukgjWblQwkEO/v9RoA9vJlcsfqj4LoKTg8VAzxIrxrPUHvKAVe8KQ9voqf4TqMFtH3OXtJOJhUu56HQ844M28U9HXEVWisKlxMQVG/2LWu4wxne/HZk6CiAWW2AnYUHOb4MqRTZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607245; c=relaxed/simple;
	bh=3mlOf2ObbT50nQfYt8cyPlG7asVX+IV2TXlWXUydKcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHXCugAvvwagzbYSjOCJg2JC0Moc6pLYnbn0V/Xs9uP4TVsaHzAWCnGDvRlK4rAkFGR+dl1KDefM/EB54kB9bswsA6uFkLHQCyazFBvtd51xKfVaKBIu9rNiv4WpBVAjMFX9LYbTgJAtvSwSYTgZylpIw0WX6MQrql8IKRKX0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TfOnMUu9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TfOnMUu9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671FmGQ3876514
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eNJHyb
	Z37kq+4eiAlTDWByzuVqoeP7+KInXnGWc0gO4=; b=TfOnMUu9HKkrUu3cKamk6Q
	e2N/UBrVy4VsVzVgOcVnuR2UbMSR817EyfE3rVdnf+6ZirmBzZONMFQJkYzcR1VQ
	idb5DSWIaBm6CWydLd+6r3h6YkNIjSfOI9Hb5hjAa2y71xf886I+aGOEmA4bfO0S
	9wAHwA2RUlMLyK8t+I9IdqX/O6gNk1qhrNt35Tw4J15qUK1hVunANiKNx7+BzTZ4
	f0/8WQLy65EzSMIseyuk0Diz7SRZQIYzWWHF25+p6V0gf6JKtC5aJ5K0dlOx8mLj
	Ti5ugB+8gQLdq6BisgqVrY5gy3B3Iw6IexhezkPIp4eZR9S6N6+YQnSrMwbtHiAg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67ha9sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671HucCD030414
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhvmtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671I0aTm45875570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 18:00:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1B6A2004B;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA21420043;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v7 06/19] s390/dasd: Use GFP_KERNEL in dasd_alloc_device()
Date: Sat,  1 Aug 2026 20:00:20 +0200
Message-ID: <20260801180033.3679412-7-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801180033.3679412-1-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfXyobreDEPCqgT
 lh5nE5rqY9s+X9f3/vRtEz5N2oIG1VupUeJXIXUyyemKA0EQugBoJQmkzKj0nAxa0DmQOGYMNtx
 WmoX8aDRXbppyPledqFNbe4AZoNV5g4=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a6e3449 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=UI6KCb5P8mXHCHDg9v8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX4QRN0qf0QKUQ
 XrMJ9N2CTpZ3tMjdHQ3CJ/VIBT6egtkorm4VNdXr6meNusm/SIhQVmk72CDgKx/MsDZpeQX8FJO
 DX2zNVUmwMIAFw+ohwxpimzAmHn+naJn/Lv8L26CE0gwf/Bq4W59y2cA8fMjs7LArDNnsoE2AmV
 W8pRtqHSqmhPSlHv/0tv/R+2982TeuXs7JxV2DhWVVNrU1tEUEuEVSViA+P9IB66j+f0OUh/wXZ
 BaXY9lNQAqB/9sXvWaHoWWliLnznjD+fPxILnGw2TuDsxnNQwSloXgkTmyzojxOkiVnJXyPwiSV
 3FChWuHUSGcQpnBEE0VJpPiEpaZpya3vsJg21Us69tFrc6HtPkAGLm2jAnIMp5k7SDPGCAziQKO
 Z7R+U15jzGVAoPSy1n6rvim/84GFXJkMLUzZp69pxySRdP2UxiSV4bdjwbqZXXjebmiS3/XJWrD
 ddrnCwUQjCUv4nea7CA==
X-Proofpoint-ORIG-GUID: mU-Rhiz9A-taqeNIv6Aefhvw9FsYQEAA
X-Proofpoint-GUID: mU-Rhiz9A-taqeNIv6Aefhvw9FsYQEAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010143

dasd_alloc_device() runs in process context (device set_online), so its
pool allocations do not need GFP_ATOMIC. Use GFP_KERNEL instead, which is
more reliable, especially for the larger DMA allocations that later ESE
full-track work adds here.

No functional change intended.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 8ade71a22376..a691c2504c61 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -87,25 +87,25 @@ struct dasd_device *dasd_alloc_device(void)
 {
 	struct dasd_device *device;
 
-	device = kzalloc_obj(struct dasd_device, GFP_ATOMIC);
+	device = kzalloc_obj(struct dasd_device, GFP_KERNEL);
 	if (!device)
 		return ERR_PTR(-ENOMEM);
 
 	/* Get two pages for normal block device operations. */
-	device->ccw_mem = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 1);
+	device->ccw_mem = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA, 1);
 	if (!device->ccw_mem) {
 		kfree(device);
 		return ERR_PTR(-ENOMEM);
 	}
 	/* Get one page for error recovery. */
-	device->erp_mem = (void *) get_zeroed_page(GFP_ATOMIC | GFP_DMA);
+	device->erp_mem = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!device->erp_mem) {
 		free_pages((unsigned long) device->ccw_mem, 1);
 		kfree(device);
 		return ERR_PTR(-ENOMEM);
 	}
 	/* Get two pages for ese format. */
-	device->ese_mem = (void *)__get_free_pages(GFP_ATOMIC | GFP_DMA, 1);
+	device->ese_mem = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA, 1);
 	if (!device->ese_mem) {
 		free_page((unsigned long) device->erp_mem);
 		free_pages((unsigned long) device->ccw_mem, 1);
-- 
2.53.0


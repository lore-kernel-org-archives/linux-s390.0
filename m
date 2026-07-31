Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932A4457D9
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512349; cv=none; b=AERTpMF1IBAp6o1hrAobKvAY4T32mD7KZiFf3jUIN3xmPKMPLEnH9PC/FBsk9nkKs3Ees96xvdkm9O5eUe7pWsVLI0XBYyhGiDHU/jnUDsO7JsUY+vnPWlQ2XA+meqoij1kEM1tZjUnJl/2YnEos/xSqRQ/tcQKwxo0+Jhu5abM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512349; c=relaxed/simple;
	bh=vlkZzYnxPyMNz7eBPH6u1RVL90Fu7S6vAP1GnCuJ7g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlBZFyZ+mvqjc1kssf9lkj/oT7uukDwfHijSNGlJrgOKwn5P2DRx7k+XbFdZ4LGY84Bhf+Tf+8klVsxOubddVhF1uZp9qBQXLq1V1kGVuqgiIS7BJVaDVz6XDvUNz+U2v7j3NLEQnFILb+ShedrpgaBVwq7cu+w0AVv3ylO/92I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dQpooV0U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dQpooV0U"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBmQcZ1732323
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=57awsW
	2Nfl1hY3vLDeideXiiljWzsDFKj9CEww4EJSQ=; b=dQpooV0UqDU/IUii9VOjnM
	i1q+QVKGLj8iL1drf071D3GZnCkq6PVIhQU/rWKeZEbv483pfADtMh57r6kgLh/L
	g59T8hhrkITfq6jDjiRrr/hlbylBSSXPf/RepE+6g4Hnmp2vTmxuJ6FYeqmNsUQD
	i9QMEXkp1tsoEdT4SgL81n4AEBLZhShJwbjlWSx0YF5Lvlsi9GjIRKpvFYzEhumU
	uy32C8JBAXa+yJMywDL2ig+k/GdHXAPj+Y+sEhNCDzRZ9nFb24WjkkLk+p9BRjz3
	7p9PFKTJEBC6Gi0Z316nYP+uEycyTimzwq7ShAyQW4briStZXwkfWbVteKRMGkxg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7wsh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VFQkEX006739
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwgm6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VFd0ZM51970508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 15:39:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DE5A20049;
	Fri, 31 Jul 2026 15:39:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 091842004D;
	Fri, 31 Jul 2026 15:39:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 15:38:59 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v5 04/17] s390/dasd: Use GFP_KERNEL in dasd_alloc_device()
Date: Fri, 31 Jul 2026 17:38:29 +0200
Message-ID: <20260731153842.1729627-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731153842.1729627-1-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nUdm-UPW3ghxFdcax_PqK8gKGenk4BQ3
X-Proofpoint-ORIG-GUID: nUdm-UPW3ghxFdcax_PqK8gKGenk4BQ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX8441gPyDde7Y
 vhICpRYP3040ZaALgjpBgGd8yp4WUE7dQSwjjV6fyadpj88KLYbH5Ux05jU3zrmy+Cff4cvP9gv
 oLEAHxkFSbuZ+jS4e1HU3g3nwdBUj99b9tRHQtO6Mu412uODhLR7fvFmTgACdoOggvQD0dbtWCt
 oG1n8SS7ZkDvtyT3Wpm9zry69ZSRy0IOm547+TlADMebUjqIo0JTNMmgNetilqVuGJs31cRgQCR
 uGP6FQQ8d+Ktyxeu1RePLyWCh6eIF79YPtjPSUxHWuoLNXID/0jKxMwJHEopKZHskNjayqFttuv
 2quVVKs/uftUtwUJOmcnTazxNeWLwITlM9wWI7vYE6v0s1m1A4pFfeOOVttSKH+qvUq3ibL46h7
 Xw4TmJRZEHv7dKSrDzgle37mQTFAGy3l+na/CbA1/zRr1EfpP1gLrpkgvRgzQAclIdOsjJJMVDP
 jxm/NGLz7y1V5Rl39RQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6cc199 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=UI6KCb5P8mXHCHDg9v8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX6kK2lA0TDI0Z
 X1p9FBuvkyHRpCDz7W3y790inFnbbrCZJdiIFwME4X4aaYPOZruGc40SDXNaubc17gh8J6r18Ht
 gIt/bqjA3barzbtaiEBBLQLRwyV69HQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310116

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
index dc1c6d5ab3be..d696fab0807a 100644
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


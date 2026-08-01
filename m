Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165E356779
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582624; cv=none; b=FaEAUykoWFkH1qt2BzbTaXwJbHbegr2h/HbxBJ+qUwbDTEAsQDLIboqYgOAP/GbXtPI4AZV05xrdJ/ZIOz+QuwS+/41BHiUdtouFF1XepUfVivjLKqK58WMNwSXPcLf9tR3W+BPk/oWU2TGiZh+Y1L8emeCjj5Gv7e4L1Aiz260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582624; c=relaxed/simple;
	bh=7qX8wDDddxPXwEZMU0DFgbjjV4TD9ClXFjdYCJ8sqSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5SIssfcdSd10SwndN5J65I9AgiEQwJuTzw/OUzaYhfMDHE22O7AoOtsGbBvZFVBvDQ1W4DlZUYgHQIkpt0fvBsMRx7VxX5jO+hYeOLw9q4H/PAkalIVvZDsOZW7vYsMQi0aW8R98z3DJFcgRGf+sQTpxAfWc03IZ2b9kN91Y0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CLrIjY8S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CLrIjY8S"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6712x9Hv1786404
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RFdRKR
	kH+IWWFbPC5qkfzX9HnEjI7JMIw8aa5i/f94U=; b=CLrIjY8Sys4VCcf4U7Usi0
	YqigI54BTrEp7M9Dn/nTCgOyrRhRbBtWBQj5FdbqX7g5LFV3alYocVW+sMbyAcA1
	fdWHze1anSQXMdVWCfHOyKkw9NzGpaifpxEUHebfqUKpnoBL5dsAwv1eVNAuZrgn
	/uoGot/YkwYhnRahPlYQwXaBlPYIdvSOhwzXBmzHbArRs/CJbWtGxKz6y5rXzvtE
	MRddMx4s0NkjKf04pNnIPeabZHVfi7h1N0/R1lrU1tlAlBFJy7uZElAMw2NcUK2s
	4gJEXPANMc/NSI8UYcDgcXCkLW4MHr6M4WJV57lskIccHJEi1am9AaXBC2q7nqdg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fq9392-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671AuFcS008192
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fquvb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671BAHfS32375066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 11:10:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4985E20040;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FE3E2004D;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v6 05/18] s390/dasd: Use GFP_KERNEL in dasd_alloc_device()
Date: Sat,  1 Aug 2026 13:09:55 +0200
Message-ID: <20260801111008.3391031-6-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801111008.3391031-1-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XkvbeiDV2DlL3zUPGto-JvJVQH_JnJeC
X-Proofpoint-ORIG-GUID: XkvbeiDV2DlL3zUPGto-JvJVQH_JnJeC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX455nsGZP70E0
 9xVa9qmdnVs82y3RavN9vK7IQLrWHYlvfw6hVPttmHh2w8XoV8IMlKJFRFFVIXtRyQHLWT7IZP6
 nhUpWVhqG6UX2ciZdE4oLU9aNh/CU40=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a6dd41d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=zlBFJsLMUX_O9EfFlYcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfXwg3yFLghxvSA
 tI+kgte0jJ0/NpUnijiF40AmY7A3Uxha3TfFKLmE6X9hdEPjlC/+LsjKPftorXH4MgiToUMDLFG
 akDrPnOV0IgweyascMIWidiRXVQjHJsJGDoHMpI4b6U0qY4FD3RsEHcvptgbckFw6qeVxiNc8g+
 I5YWpiaWqd93xFRoMzk/k2HWL7dziapWGBk32OxaJpzr2oE/E7wfcIb+XzFfbNgy4i5MYZ6imys
 0CaUV9jmxJ0VQO2Zt4FW0v3oogjGPkANuShBKiuByj7YCGCypebRBkPt+ANaMZQnwxcs+N3Ob0R
 G3DoRjjybfD0lVn9fYeE6cu0J1Xks1/GvgY0CUEYOaG0kZBiFehsAK3xI29hlRmOYE751iuHwEx
 B9a1kWE68bGhApZAzpehasJ9Bb5i2IQ7z/q7JydF9W1XKvP9NLf89C0Q14fYGzzEcdTBoVKHO8X
 +w4/cJjrRCdfg2Rt3Gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010083

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
index e9f0722af104..9c24ae54b2d5 100644
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


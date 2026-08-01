Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002C3BB124
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607247; cv=none; b=sYKvW2LH1s4PyJxgpp4oqiEL93OCDsc6UumIU3YFxkmvOjsglMElDM3rbHY+vU66oicQ0zLo7yiBIgvKrf8R4lm+glTTLuwN4W5aMtzAgMzCK8lSdxRs4Y1jkAVfaIia4nXuizzFos5R7a/Q9qg1RK/gADXjXQiqGQjBCn4WFQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607247; c=relaxed/simple;
	bh=D8gBi7XB0yduH4O08+N0A50uU6nguDNHYOwjyDijilc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iqo6l1O0DqU/exXZF0RXLunIkKLvXiIzfk6iYdgruGr2MAWNfqAZzwRDS+yifmrk6qCRRUip5HIk1KixZb4ngOJDFiotciTwQD+P5jarqG0rr6iGgRDers5wTjUNrnhfUdEeWDDXWuZEbnHuTtd1D9GpUdGt3Z0UNSo8WND3lSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JATJFJah; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JATJFJah"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671FmhI9882935
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wf9y/u
	9bVEdGV5ByqNP+vZcwY8zaWyj7aErFs9R2dsY=; b=JATJFJahDlueZEZFnQOhJB
	sPap/DneD9cnVLo2gAXZVyZ7Y237DYZZYFrsqz1iAK8FwFn+A+R4V4IZMjlL9q+Z
	rT5uWUyGDwAmt4h977zWWoKNJXv6jm0x4v+0mlPDlp69HM0potUVHgdxOI4y/cc7
	iFHaLDAw+FS/GZj4bDAXUeEWvBeLhuOAbL8sRBq7S9d1Nb39tv/6JLKhEtgaJHk3
	ouSQKzodrLBwInMYepo3TnpQ72CQU7NKUDbI1H4DsbhvMbQpVbLrbH7jDLWFKL9P
	vQQx5aP8MqoRfYaMxwYsoDKE6UokSrY/maaBcY68l2T55fTR7G6J8gEV7futYhSg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77ft5j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671HuJLm014480
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkmr9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671I0c2B30147106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 18:00:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80FC42004B;
	Sat,  1 Aug 2026 18:00:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6952D20040;
	Sat,  1 Aug 2026 18:00:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 18:00:38 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v7 17/19] s390/dasd: Report ESE capability and format mode at device online
Date: Sat,  1 Aug 2026 20:00:31 +0200
Message-ID: <20260801180033.3679412-18-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX35S5dRehxp4m
 jO2TP5AM8KFWuMmJbzu4MwIJBIcun1i/QIzjhfMORxe9idOmGoPteaj2qdyICPwPZM3cBxhtNy8
 WkW1PkiTfsgj2vMs/df6tC+6a2TNwkj0Rew0hC0bU7jxUL2gSr+rH8WfPanH3G36NEdmEJmI29F
 C6nEBhIoV/pf0LaB1P9EeSs0GuRgyBdphVXLnmWukFP5k44THTQzMUr+DXBc6AnSSF9aW/HBl8g
 EKm/aZlG/0zt2UiVhAhBGpEZ8fPO4AvYHr6ncM1vloJDCtGh9Q5377VxfYG3eBvTuHhTFbMYAgg
 t19n3FKDi8tk4rJiapfdTcJkqwRb7gWqKz0pMizJQMl1EWtvS6QiVxJMBD2HKJBqW/qGNIJcskM
 vMbxi+OJsGWiRqK5IF+W9a7ksmI/SqHH+ZLfYZbS2zKwQHLm2JtGwB7BL1YdHi595vdAUsQ9Z/9
 3te9u1pp4f9kPf9SOww==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a6e344b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=_yd_xlNYP7hmE0PasyQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YBkNFTe5XZT2PJ8a8gJfC5TadHyO8tPI
X-Proofpoint-ORIG-GUID: YBkNFTe5XZT2PJ8a8gJfC5TadHyO8tPI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfXxTU7AHOujMGg
 9Y0Wn9j+DM+7go+j0jtacPnu95nSk8dZPHUDbycQgWbNF/voHFgd58XWrdpkXoX5iJU7Nk9fV7+
 qor8cKlRAM2JTIFQfuVR4pLR1RSu4WE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010143

Extend the device information line logged when a volume comes online with
the ESE hardware capability and the on-disk format mode. The format mode
(full or on demand) is derived from the on-disk format label alone, so a
volume that is not backed by ESE hardware but was still formatted on
demand is reported correctly.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index ba67a3311193..b8b862205db0 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2522,6 +2522,7 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
 	struct dasd_device *device = block->base;
 	struct dasd_eckd_private *private = device->private;
 	struct eckd_count *count_area;
+	const char *ese_str, *fmt_str;
 	unsigned int sb, blk_per_trk;
 	int status, i;
 	struct dasd_ccw_req *init_cqr;
@@ -2608,15 +2609,29 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
 			  private->rdc_data.trk_per_cyl *
 			  blk_per_trk);
 
+	/*
+	 * Report the ESE hardware capability and the format mode. The mode
+	 * comes from dasd_eckd_on_demand_format() (the on-disk label, or the
+	 * ESE state when no label is present), matching the on_demand_formatting
+	 * sysfs attribute.
+	 */
+	ese_str = dasd_eckd_ese_capable(device) ? ", ESE" : "";
+	fmt_str = "";
+	if (dasd_eckd_on_demand_format(device))
+		fmt_str = ", on-demand format";
+	else if (dasd_eckd_ese_capable(device))
+		fmt_str = ", full format";
+
 	dev_info(&device->cdev->dev,
-		 "DASD with %u KB/block, %lu KB total size, %u KB/track, "
-		 "%s\n", (block->bp_block >> 10),
+		 "DASD with %u KB/block, %lu KB total size, %u KB/track, %s%s%s\n",
+		 (block->bp_block >> 10),
 		 (((unsigned long) private->real_cyl *
 		   private->rdc_data.trk_per_cyl *
 		   blk_per_trk * (block->bp_block >> 9)) >> 1),
 		 ((blk_per_trk * block->bp_block) >> 10),
 		 private->uses_cdl ?
-		 "compatible disk layout" : "linux disk layout");
+		 "compatible disk layout" : "linux disk layout",
+		 ese_str, fmt_str);
 
 	return 0;
 }
-- 
2.53.0


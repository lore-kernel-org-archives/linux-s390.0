Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C508137923;
	Wed,  5 Aug 2026 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928590; cv=none; b=IZ+shbybmKoFXA2XHPKkzvkLLIPXAQIBOk6ID2Aq0bfBPtumRvzFgtRWOlYy40j8Bycg7WYt2xQyQs9NQkktlK5ecORVauwAwqAYXnxkV/Bf2i+VX5XcbQ/8pA67U4fIte2E+GdWXrnAR2TG7jIWA9bg4HLo8435dH+hbSrBIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928590; c=relaxed/simple;
	bh=+bwqcI3KwprWHmyUHDfGlwKyahSoh8jLjC/SKg7ATR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqtiymoSWkdNIpp2WRMMperZOrDhn1KwYP2NNt91tmozER3FLdLsGw+iOMExc4N/VkiFa29PqTO8QJ8IMThVAUYcddxqO+Gez69yxrqsuXukdDTDJzvs698QfZDuK1Jntn/4d8OgwWzzKgHTZxunQ/B6XLhYgsZuiPsOqYbi94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tif94OMx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tif94OMx"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lmab1503298;
	Wed, 5 Aug 2026 11:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8yESEo
	KBead9Q3Bq7tgEml9GbVrdKzCFm6n5g720IGQ=; b=tif94OMxt/+QmcoWtfC8la
	TxpWWYA9KbGZi8pXNx23xkwp8104vk4Clnb8MOHJQT1nSO/nQiaBkLu+VsC12AZZ
	90WNihaNvcylgWG4aoviln4DGyiSUiFoChucBgkDTZBrows2Uxf2o1Mnh6yxdM7G
	azDyIb1O7ptiFK2lvqZd7AvQLs9sSijbz4BS+pRDbhkHh32uA5RTBCx9VPGvNYFF
	tPYDsmCcuiFx59FBfBcRxVn+T0RgvdwDD/jxwu2ThVJ60agmg1z6bEKtN30WjdBT
	R5FYNDoRFqnQKU2b+sWBJ+3afPHRc9RHRnDfWEQ+HNkpe/c/lKehWVHwwkP6OMWg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqtm6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BBE20012703;
	Wed, 5 Aug 2026 11:16:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyp0ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGH9u49676722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2089820043;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0330B2004F;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:16 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 03/19] s390/dasd: Guard sysfs discipline callbacks against unallocated private data
Date: Wed,  5 Aug 2026 13:15:56 +0200
Message-ID: <20260805111612.1285190-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805111612.1285190-1-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gjITN24cvWARj90i9WlD-L6L_HKIl-sm
X-Proofpoint-ORIG-GUID: gjITN24cvWARj90i9WlD-L6L_HKIl-sm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX079eEcqHBQUc
 6T2QzWzsAYhIg8dJZWu10+V2HzxdgJYvW5i2FWsDpLtmfcz7lmSGl5RFN+qRiQUp5udPOa3mOL/
 bNIsIpStmB3vUpA+62d+uJXO98N8MOI=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a731b88 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=otpBJI0RWbrHn9utmiEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX4AVddGyKWssC
 mE+pNFiXREaLUboEkrOzqcGn9RSnWPoC74huP58Aa3WX0hYOGyMKB0/vWUM7/i98o2BPywUAnbC
 OEyBxrouAyf+KJFnRaRnzhyH4ZBcfjO4mKbe8f9b9FcdgiW8tE5UJESEPRDNQsCOv/v0qLwAnQq
 XcQPxyQYisaA5/h2lwtwA/IfeNvQDfwX64EHSXT0q+gxcgERKmLYRbJmOHRDKA3+6CNS/qXAaUr
 mnmUJipcFlKKgmCxNpso3nnXX22Y9a4wO8h3pmt0H37VIrbUe+xbrYeSJI7JI9iVT37qdpclA9X
 lqWrcMToS/bi8Tt26epdNlaEFB3GgaKMBLxobHSnm5TiPpwekBlhAdyB5cpDlyxnEtJdVGDEzYY
 L2DiaBR/cR+qdtvEG6hcY5diwTAeVZIRD6MQKZhkt3SNPX081klw97sqN8+aeFb8T5bbksIxlRV
 VGa7GlS7w2ArXoy2kSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

Several sysfs show/store handlers call a discipline callback that
dereferences device->private, either directly or through the
DASD_DEFINE_ATTR() macro. During dasd_generic_set_online() the discipline
is assigned before check_device() allocates device->private, so an
unprivileged read of one of these world-readable attributes in that window
dereferences a NULL pointer and panics.

Guard the dereference inside each callback that actually touches
device->private.

Fixes: c729696bcf8b ("s390/dasd: Recognise data for ESE volumes")
Cc: stable@vger.kernel.org
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 40 ++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index d356a9f8f016..b64ca714b53e 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1492,6 +1492,8 @@ static void dasd_eckd_reset_path(struct dasd_device *device, __u8 pm)
 	struct dasd_eckd_private *private = device->private;
 	unsigned long flags;
 
+	if (!private)
+		return;
 	if (!private->fcx_max_data)
 		private->fcx_max_data = get_fcx_max_data(device);
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
@@ -1647,6 +1649,9 @@ static int dasd_eckd_is_ese(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
+	if (!private)
+		return 0;
+
 	return private->vsq.vol_info.ese;
 }
 
@@ -1654,6 +1659,9 @@ static int dasd_eckd_ext_pool_id(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
+	if (!private)
+		return 0;
+
 	return private->vsq.extent_pool_id;
 }
 
@@ -1667,6 +1675,9 @@ static int dasd_eckd_space_configured(struct dasd_device *device)
 	struct dasd_eckd_private *private = device->private;
 	int rc;
 
+	if (!private)
+		return 0;
+
 	rc = dasd_eckd_read_vol_info(device);
 
 	return rc ? : private->vsq.space_configured;
@@ -1681,6 +1692,9 @@ static int dasd_eckd_space_allocated(struct dasd_device *device)
 	struct dasd_eckd_private *private = device->private;
 	int rc;
 
+	if (!private)
+		return 0;
+
 	rc = dasd_eckd_read_vol_info(device);
 
 	return rc ? : private->vsq.space_allocated;
@@ -1690,6 +1704,9 @@ static int dasd_eckd_logical_capacity(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
+	if (!private)
+		return 0;
+
 	return private->vsq.logical_capacity;
 }
 
@@ -1832,7 +1849,11 @@ static int dasd_eckd_read_ext_pool_info(struct dasd_device *device)
 static int dasd_eckd_ext_size(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
-	struct dasd_ext_pool_sum eps = private->eps;
+	struct dasd_ext_pool_sum eps;
+
+	if (!private)
+		return 0;
+	eps = private->eps;
 
 	if (!eps.flags.extent_size_valid)
 		return 0;
@@ -1848,6 +1869,9 @@ static int dasd_eckd_ext_pool_warn_thrshld(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
+	if (!private)
+		return 0;
+
 	return private->eps.warn_thrshld;
 }
 
@@ -1855,6 +1879,9 @@ static int dasd_eckd_ext_pool_cap_at_warnlevel(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
+	if (!private)
+		return 0;
+
 	return private->eps.flags.capacity_at_warnlevel;
 }
 
@@ -1865,6 +1892,9 @@ static int dasd_eckd_ext_pool_oos(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
+	if (!private)
+		return 0;
+
 	return private->eps.flags.pool_oos;
 }
 
@@ -5938,8 +5968,11 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
 	struct ccw1 *ccw;
 	int rc;
 
+	if (!private)
+		return -ENODEV;
+
 	/* not available for HYPER PAV alias devices */
-	if (!device->block && private->lcu->pav == HYPER_PAV)
+	if (!device->block && private->lcu && private->lcu->pav == HYPER_PAV)
 		return -EOPNOTSUPP;
 
 	/* may not be supported by the storage server */
@@ -6804,6 +6837,9 @@ static int dasd_eckd_hpf_enabled(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
+	if (!private)
+		return 0;
+
 	return private->fcx_max_data ? 1 : 0;
 }
 
-- 
2.53.0


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F038F649
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582625; cv=none; b=bXOEK5khEv5zM0yTC3kso38ctHGAbSIVUPgve75wOXx091IfcaGpSxrOaaKK2GSBf4m3WuNCkysMtj302nuKYtXQccT89uUmDCwz8fKrl6DNvsWMQ8EgD5YiB1GMyivHIjSPk3UI/mT13Wm7OlXjdJAAkQbXwsXDxXJbjtg0ZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582625; c=relaxed/simple;
	bh=JmHFNol8/IfQytGkmJauODXMo9Dk/u2F2PypmeqQBYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwUmNUA8aR+5ra1blu1xFrF5ZvByLYGm0A2jW7xyn1gRhhIqHrIEou2Wa4RaqAMwMBZIk/O/OHKHbFBiQxS3IS1SrfJdlUoIUMazYDSh3CoqSh0gxBSTsOQdJBgiBL1EKQZCvIU3BicrOvAlkh5HVENSqrv6xcO1n61IAAIp6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XrVagCgi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XrVagCgi"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6712jwvg3616950
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q++krRJjzqLJ7gnIm
	dAruss4jF6rWmwWup2NxDocGng=; b=XrVagCgi9FaCcNLfnysqT5Qjt6kSermy8
	N+D/fISosZW6sgg0fJXFDhAYQKCNAvfZaewXzd8/3ugAGZGijqFyQpqIGWPWds+H
	vY8OPZlft1Egl/eXUTXzVwKjzCy5MOSexxFoy7l3FRUN8q+cTyFMb9kuqkrGkYXn
	J4R7e+/mqMmMl8TzkoTv0SSc/vdbK2BHQiBa5wEQ1mbVug2ohgC/oWfgFe6YLT08
	6aKnrePtnCcvR3YAtiQ7KK/yOEDvQxTZmzvua7DxvmVj89ycqr0ysxR4cupCg/OZ
	d9nAXgMECDfcjK81EZtT5d4rMrCPKXgf4v3Fz2L71AWsfL6UNFwzQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3h4f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671AfNQb015774
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkkqgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671BAHdc48103854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 11:10:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 010BD2004B;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB88720043;
	Sat,  1 Aug 2026 11:10:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 11:10:16 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v6 03/18] s390/dasd: Guard sysfs discipline callbacks against unallocated private data
Date: Sat,  1 Aug 2026 13:09:53 +0200
Message-ID: <20260801111008.3391031-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801111008.3391031-1-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a6dd41e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=otpBJI0RWbrHn9utmiEA:9
X-Proofpoint-ORIG-GUID: 70YHyGQYZql89evv3pkvjxLC6BrKvUjN
X-Proofpoint-GUID: 70YHyGQYZql89evv3pkvjxLC6BrKvUjN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX7qbJN12cktXH
 32uQvM5XgAsdDCj+JZSJvMUmH2lGSuoMnyBU+jx2VqPuxhQBegifdOjx+kVDZw/yUGWopqeqIDb
 KE+F0QMZLYGzPiFcNAnoIMuOvCAe6N0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfXxDXcK9Fm+fq6
 yzkzUwrQ4Sjw6BlQmHJjoVWDNHGWs+g+BZAmJHiN4VUyA2rQghHd8ISzFKCKYHwS4BRmB50HJUh
 KK+/xZ9TAnIhAh9f9XTYdBZd9N1Zir6aZrm5+iUuDuerKzr/hhu3g0kPAwG+/JtJyqFMr38UbDX
 rZUJtPMRX3HdVh1bCC9HaZESrVA6op9LQzES4Jp+j923i9AmqAE7Mn2g5P2YZ7mj9zwMjtYvWVb
 LSxEyD4zuBDN7XpJgnqLy1XBcPePJKqyQ9eJzh4v7aPvCH+LqRZ2Au3JsyBsgedi0riOoKE7Is+
 4D0V4aKuEpQr/isrjza7NbwJ9PZ7N2GnZ+wIB2/RX7qpJuoHhzMSi70NSwBxO2apSp7w/Z8whyg
 b4eI/+PVwbIeUW/HNDtSve+i+ClOHX2ZPzDsiTIGVioAwhBoN5xJXCPm1ZagRUW7w/xEetr3uMh
 ds8r++owAHq+9IhOrrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010083

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
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 40 ++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 073795ea7cd0..7ce8a82d951d 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1491,6 +1491,8 @@ static void dasd_eckd_reset_path(struct dasd_device *device, __u8 pm)
 	struct dasd_eckd_private *private = device->private;
 	unsigned long flags;
 
+	if (!private)
+		return;
 	if (!private->fcx_max_data)
 		private->fcx_max_data = get_fcx_max_data(device);
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
@@ -1646,6 +1648,9 @@ static int dasd_eckd_is_ese(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
+	if (!private)
+		return 0;
+
 	return private->vsq.vol_info.ese;
 }
 
@@ -1653,6 +1658,9 @@ static int dasd_eckd_ext_pool_id(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
+	if (!private)
+		return 0;
+
 	return private->vsq.extent_pool_id;
 }
 
@@ -1666,6 +1674,9 @@ static int dasd_eckd_space_configured(struct dasd_device *device)
 	struct dasd_eckd_private *private = device->private;
 	int rc;
 
+	if (!private)
+		return 0;
+
 	rc = dasd_eckd_read_vol_info(device);
 
 	return rc ? : private->vsq.space_configured;
@@ -1680,6 +1691,9 @@ static int dasd_eckd_space_allocated(struct dasd_device *device)
 	struct dasd_eckd_private *private = device->private;
 	int rc;
 
+	if (!private)
+		return 0;
+
 	rc = dasd_eckd_read_vol_info(device);
 
 	return rc ? : private->vsq.space_allocated;
@@ -1689,6 +1703,9 @@ static int dasd_eckd_logical_capacity(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
+	if (!private)
+		return 0;
+
 	return private->vsq.logical_capacity;
 }
 
@@ -1831,7 +1848,11 @@ static int dasd_eckd_read_ext_pool_info(struct dasd_device *device)
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
@@ -1847,6 +1868,9 @@ static int dasd_eckd_ext_pool_warn_thrshld(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
+	if (!private)
+		return 0;
+
 	return private->eps.warn_thrshld;
 }
 
@@ -1854,6 +1878,9 @@ static int dasd_eckd_ext_pool_cap_at_warnlevel(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
+	if (!private)
+		return 0;
+
 	return private->eps.flags.capacity_at_warnlevel;
 }
 
@@ -1864,6 +1891,9 @@ static int dasd_eckd_ext_pool_oos(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
+	if (!private)
+		return 0;
+
 	return private->eps.flags.pool_oos;
 }
 
@@ -5935,8 +5965,11 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
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
@@ -6801,6 +6834,9 @@ static int dasd_eckd_hpf_enabled(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 
+	if (!private)
+		return 0;
+
 	return private->fcx_max_data ? 1 : 0;
 }
 
-- 
2.53.0


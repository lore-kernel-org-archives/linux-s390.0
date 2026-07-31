Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC884457D7
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512349; cv=none; b=Lam+vuQiXPQxP5WrmDJYDYh88FEbbZAluuROTtekyZjuto72Wlj2/lNKUR4c0kiAfmYKMRFEcarFbKyRKcgy0coBU621RB1y+AZacQ+vlxJrei14qer/cHOqfv82ASiQWOR/15SDKmQ8ZIpzfYGrXOF+zY0h6A98QvSA/oBxPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512349; c=relaxed/simple;
	bh=2IqNkvMrKDD+kup2ul5pZpH7myavFPf0DF2JULAQE4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSU6nkqJ4+6sAAVSEjEEp1EyALcHiPkyEgN/d9sI/wAKnzpQIJZwQFcYhqcy/405bSZQZHzJ8sn8JOAD18Q/E2Sr7FuNyvG8tJb47RtXQdOeOeD6cPJTn8hObv8s1hr83HkG6eNTd0z542fJr35cFUVBEyUGpCVoTRPYCxLtye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=arEDhKKc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="arEDhKKc"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlkfN1765505
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1SMY+8OrHIXFjNlW8
	nYb3OwzFBfLzr5cQwIGkpM4mrQ=; b=arEDhKKcD74ZiW+vGhsctyZAXoW2VVuT+
	cdJt0r8W4Tgpnttsm9eF8QthuqdbvdGh6X/MZtiMy5MxxRu1qcvQgBFcyDIVeR4I
	2Sa3H2d/dVUjpYt5vSqXcttbfLa9aM3YGnf4Nn4kRCiF4Co2XfVmEJg0vLjPbFU4
	7ctWz6ncxOvzxq6UY5FIXatdb5iRjgFHuU2fPHcUIgY8X1hKZcRFDRNbMrlviboS
	3+CFmLiyyY0aqFoqmus8VoSx0MzntMDbVmyQ4sQ8ios01yNrsCE1SmiKEpXs/7Qr
	PeDpFoGe20Yo43+Yv5WlWjU5AR/8KjonC97NryLeFETCTpNOE45qA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y5u6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VFBNeq026012
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhrd8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VFcx4V30474570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 15:39:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D699D20049;
	Fri, 31 Jul 2026 15:38:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C18462004D;
	Fri, 31 Jul 2026 15:38:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 15:38:59 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v5 02/17] s390/dasd: Guard sysfs discipline callbacks against unallocated private data
Date: Fri, 31 Jul 2026 17:38:27 +0200
Message-ID: <20260731153842.1729627-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731153842.1729627-1-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EqmTHP_dB4dvtM47EQBmeOX01waSEckL
X-Proofpoint-ORIG-GUID: EqmTHP_dB4dvtM47EQBmeOX01waSEckL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX/jlyBQLc67FU
 icEKgkBYjyW99GfmsO3EAQTQ3FpMizuWQk+6pKXsdTbHYkv8V9aN4BJ8srSxF0tjYcAtIjs1ijC
 0G3upOxQn9c+SkqEMt9C3nNbT/eWrg0=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6cc199 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=NIGdv6XigjpEyK0BJgoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX0QBJg685EuCy
 phBa57BV4qw0f9qWUpfLipAZnpjsqBFtYV+I0vs5VUhgwYTUMtItBzaQfOk7PMhJQnlnA2pgeal
 cP3Ykr+vLoNnIWp523nEbsAnpwR+C9mXtxleERkjZ6bksWf2Jjrlni0PjuVOzGpXtSU3h00hgZ+
 alw9JyTSd7XmilBR4rjONCn4604bWmDaNvJrWUxQ3Pfh0rAANfaudOeb6OdQDRJYOJx/Wy72K0M
 sW794vohJz/6zo6P431NBwgwJQnvE0zLMapg3G/Jwx4Hzvsu50qHZZt7UZQGOo1M8TQFpVaepNQ
 FOF1iKczKiaM4QxIqwh5lWe3QMhJLl6Xb9GYN9Xo1bwRu9iLio1lmLyKN/WAHy1kN9c4vvtU7RC
 /86c6bgCV6Tm5PViubq5+2ENWM0JcatZ25WdueL8PzRNB08mhigDFchfwQe/Vezkoe5pxpqDUAB
 lrtx2H6QPyz4/Ye9e7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310116

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
 drivers/s390/block/dasd_eckd.c | 38 +++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 073795ea7cd0..5593013c9db2 100644
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
 
@@ -5935,6 +5965,9 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
 	struct ccw1 *ccw;
 	int rc;
 
+	if (!private)
+		return -ENODEV;
+
 	/* not available for HYPER PAV alias devices */
 	if (!device->block && private->lcu->pav == HYPER_PAV)
 		return -EOPNOTSUPP;
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


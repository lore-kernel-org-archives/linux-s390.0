Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B803A75B1
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607243; cv=none; b=A+yj/UmRisyzB26TrT3ymfVnvMemk0gxm9ZvjNfmWASJm4hQ7JHLho5+IoqEl4JJbdjytJ/2mdlIe8vPZ/DHQACFZZ6yAPIInzdNC4KMU2IhFr3Rgx+Wnl5GuNY60XbQMIJbcJnBNwzycvLoyEOrjC9yVRH+3MBSsfQDMCrjUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607243; c=relaxed/simple;
	bh=JmHFNol8/IfQytGkmJauODXMo9Dk/u2F2PypmeqQBYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTKyN44btvAcbknLXZrid9Eup0ZTFsV5zmbr4xhVnCCSSrTNCITy38S7TsXgfE3SK3a5Ekw3IQTWF+H6AKbY3wIneHxgMi92eKzMh4wtU+CciztjSwTPd2kvt1s8BbkUzq6fn2mdUgRpi2fQm7+67wKJU8QD8rjY75l6zVpnzOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p6GlgVwR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p6GlgVwR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671FmFaV3273109
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q++krRJjzqLJ7gnIm
	dAruss4jF6rWmwWup2NxDocGng=; b=p6GlgVwRo244375CucRE2edx7vCNVtC2e
	khXVwBKzIKNWsaQOztbDtsGJbF0KBm0CbrnwiprwfW9B87DpMOyymcKRfYZa1mh5
	bg47aWtF5QyK70Qa+sfjQni2VZYQMGtY/8DCl3GCBFlew1iv+ZKt+FLH1k0TSyVI
	wvIfM+v9uccBaUW0cuwNx17s5mmV9wydnx0d6lPh3k4iX1qO7FbO9wIy0h8pMT4q
	WjUju1B7mWoymJihNr/eVUK0Fw9641QLFdRMBhpcKL7vVp04EA4KrmzW5cYbM5t6
	ssO0EETilxr6wYvIcabWXqf2eD+9AZiB6NjL7NCGzu7q+vLS8Q/ZA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqa23x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671HujaF030913
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhvmtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671I0acW45875562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 18:00:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8277A20040;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B1142004D;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v7 03/19] s390/dasd: Guard sysfs discipline callbacks against unallocated private data
Date: Sat,  1 Aug 2026 20:00:17 +0200
Message-ID: <20260801180033.3679412-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801180033.3679412-1-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F_CUDuePfWPjFcD8GTYirofdiEVoaOxu
X-Proofpoint-ORIG-GUID: F_CUDuePfWPjFcD8GTYirofdiEVoaOxu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfXw5uGR5SjBIgO
 Rvq0liPAgDoB2vbqr1P4PGG/w1vpSkxAqFP1+73JCavDQ6itSrQpSTXU0r8CU7+SljuP2TqH/gZ
 5uXiOVNRdwoCwLXEiYnenSgYXCAq7eA=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a6e3449 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=otpBJI0RWbrHn9utmiEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX3Y44bPiI+rnp
 +Jbu5jeRJgFDZFeS7jxQAChhzfBA2qRXecEofcNiWjAn1EHtxm+Dul+SBDaiGFV7Il6UIMEdt4m
 mePkiH/vD6GbzZVYwHfTdvkpGMtfjV1XQey+ChjT8W2uXEhH5YsP6Iz0Kwbb472RQBJg7SVkShW
 /tMMChmShfHa+UR4hW3jPL7EcdhiLHpJz2gDvGd8124dOiI4dSH+DI6+1XvfsZUGsyAcNT3SU3D
 f4sKLeMLB0jTpuVaeqFYCFwUq+jOMYq6SeevdvyKVZG5hjEK6bByip9YCk+oBL4RZ+1E7yCnFES
 bJyhpK4ldDvAohPplLlKM9VfcnSruynndIB/VHKxHuxsPAYR7Cv55ZGIsH8MqQSVr+VLKsBo/gk
 kezveh/QGzfB5HA6ZgVlnJ/7ZMS8gyJq3GkOlt2XHrUhuTSMzTvApDdzn0+Gio2nWUhsMN3Bavh
 pvCLZNhb+IrRJMJyz7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010143

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


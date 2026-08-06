Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E92EEE86;
	Thu,  6 Aug 2026 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021264; cv=none; b=cloDYyUq4X2A9iamR4j7ogkI7Omh1xc2RDGNkP/AU3UEpmx6l4Q3EObLscqjDsVulEuegy5UggRwuAkNGI0c0hjOBfq+3aRZqWMRzGzXcLSQPVtDNKO5eabYuUMoBGT3P9J52IZCR63ycs8+OvxesnOLA35KMgg4Y85VHNXYQfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021264; c=relaxed/simple;
	bh=/doYJ9aVz21Sj+DslApLkZ9TXPYOoiISm4WObA9aVFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSZkHNTHWOuDrkblFW+6IFMw5eH04mgjt9EHJrwjLnCEogzJPy3ANHKbUHZrXpoCg6D6oxe/7K47BckzTtNHH2LUpMztDcZ2W8SB7V28+zszlMe/bQODtS3jKTbbR5zc5sNa5XbgsoplnKVtMU57MowoCiayQqHw3GrIPUDYxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AzyKsH2b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AzyKsH2b"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NndL71145739;
	Thu, 6 Aug 2026 13:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=41hNCW4vIE3Tw58bf
	i9Bg/W6ekRCDj0g2jzv6oa41XQ=; b=AzyKsH2bnO7S4nUnTs/shhd6lL0oiMSf1
	VthI4DDa8ED5jlcW5s1fA/9svGCW3KED5zlvU6APPMKKcvgGZ43tNFAb8Tq7Xj77
	eaeneq8ktqJfIsrz4A7mh1QpAF2JApCHjPFOfQmsidTw0fAfm0VDHw0eSCcKXmHu
	28cUF67IuvmtCz8q53LpmpoedmegDwvu2kJTIDZ2+HJE6hDWua8IkJsKxZhltPDa
	6PaVEgSN+Rcnk0VcUmew1yWMu38h4aOyPH69uuzOgvwpLJZljcR8gZg+tun5geaz
	EGeF4RrCpjvKQEnayuxYGPHSRVmesaECaYK6z2MwUvn8Ew4cOsWvQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euymwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 13:00:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676CuHQ5032406;
	Thu, 6 Aug 2026 13:00:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qubb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 13:00:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676D0pJ143516354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 13:00:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E54392004D;
	Thu,  6 Aug 2026 13:00:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB2E02004B;
	Thu,  6 Aug 2026 13:00:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 13:00:50 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 1/2] s390/dasd: Add __context_unsafe() attribute to various functions
Date: Thu,  6 Aug 2026 15:00:49 +0200
Message-ID: <20260806130050.2057443-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806130050.2057443-1-hca@linux.ibm.com>
References: <20260806130050.2057443-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ou3FYQbJipKrInqOG4c89aAh69GKtqST
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX+3puk06dqNxh
 7rGHT8Tqg6vZLjJS+tjy8vmTfBFkRpn/OsnPcOXK4YpKsB7A67z4jKJBKnvVxIhygBVd+BPyUq/
 vhH3L9DsvC2zCWzFpWV3aQ85XhkU/5w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX33cuD56PWDRE
 8dOf2nUFkGVhn5Bp4Qr14qYYQJLM/6kQUok2NDnf9/oY8gLlS0LvoFQ6VgYZXs8/cxKxJ07VPG+
 StUoaXK/DTxRYx4XOM11Sglo1Y+sh2trOZlGF99zzczj3HTkDyuiRuUjcMCy1cLi6pnT+Br6BAy
 Zih9Fqk225lBNPW4J4kjdeDbLtVJbTMfV7/r6fcKl0AVDfjjQvxIkzNtfCisVGxERQD50Jh/TwH
 taksBpDToOuV/3TtB0AQfXXw2tbp4gb7oQI+uZDEGndmRVw1O42LH5rC5hysvETnkRn6MwZqRw4
 zwABxyjZN2Ev8z2Vt/Mq+WeK9VKS32jRhQJeuTfuGbBCLH3nT65jJNVDciZXuFhAIBJusO7XPHX
 lGDNUyZmKMlFU+rBcxtnBH09OIsNVoSze3AQZHKw0MnnYe4pHoKyfvViddVxqkaKUOvCUc7pncI
 34cXgNoxLs5ym2ATleQ==
X-Proofpoint-GUID: Ou3FYQbJipKrInqOG4c89aAh69GKtqST
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a748587 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1LwlDi0odvbg_fIaxPcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060101

Disable context analysis for various functions to get rid of context
analysis compile time warnings using clang caused by conditional
locking like e.g.:

drivers/s390/block/dasd_eckd.c:1462:3:
  warning: releasing mutex 'dasd_pe_handler_mutex' that was not held [-Wthread-safety-analysis]
 1462 |                 mutex_unlock(&dasd_pe_handler_mutex);
      |                 ^

Use __context_unsafe() to provide a short comment why context analysis is
disabled for each function. It doesn't look like those functions can be
easily reworked to get rid of conditional locking.
Therefore disable context analysis for (only) those functions.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index bacf770c0e1f..b4dcef06edaa 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1468,6 +1468,7 @@ static void dasd_eckd_path_available_action(struct dasd_device *device,
 }
 
 static void do_pe_handler_work(struct work_struct *work)
+__context_unsafe(/* Conditional locking */)
 {
 	struct pe_handler_work_data *data;
 	struct dasd_device *device;
@@ -1501,6 +1502,7 @@ static void do_pe_handler_work(struct work_struct *work)
 
 static int dasd_eckd_pe_handler(struct dasd_device *device,
 				__u8 tbvpm, __u8 fcsecpm)
+__context_unsafe(/* Conditional locking */)
 {
 	struct pe_handler_work_data *data;
 
@@ -1601,6 +1603,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 
 /* Read Volume Information - Volume Storage Query */
 static int dasd_eckd_read_vol_info(struct dasd_device *device)
+__context_unsafe(/* Conditional locking */)
 {
 	struct dasd_eckd_private *private = device->private;
 	struct dasd_psf_prssd_data *prssdp;
@@ -5965,6 +5968,7 @@ dasd_eckd_fill_info(struct dasd_device * device,
  */
 static int
 dasd_eckd_release(struct dasd_device *device)
+__context_unsafe(/* Conditional locking */)
 {
 	struct dasd_ccw_req *cqr;
 	int rc;
@@ -6020,6 +6024,7 @@ dasd_eckd_release(struct dasd_device *device)
  */
 static int
 dasd_eckd_reserve(struct dasd_device *device)
+__context_unsafe(/* Conditional locking */)
 {
 	struct dasd_ccw_req *cqr;
 	int rc;
@@ -6074,6 +6079,7 @@ dasd_eckd_reserve(struct dasd_device *device)
  */
 static int
 dasd_eckd_steal_lock(struct dasd_device *device)
+__context_unsafe(/* Conditional locking */)
 {
 	struct dasd_ccw_req *cqr;
 	int rc;
@@ -6129,6 +6135,7 @@ dasd_eckd_steal_lock(struct dasd_device *device)
  */
 static int dasd_eckd_snid(struct dasd_device *device,
 			  void __user *argp)
+__context_unsafe(/* Conditional locking */)
 {
 	struct dasd_ccw_req *cqr;
 	int rc;
-- 
2.53.0


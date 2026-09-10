Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CA03DDDDE
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032736; cv=none; b=J0DEacw0JNBiaiOPhTQ4vEsZPwQTjyz5sponPGLz/Mfc8w7ppj8W3MiXKHx7V91HIKOegDrhC6wb6EZ9hubmwnuyoJfQLHpnUaoAnxTcxsf8IlaHbfzuv5cnNJicZtjZD6kGbE6e9lTZe9hjZwLxXKmsEnvc6jxQMm67PvM9hP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032736; c=relaxed/simple;
	bh=ROUzSabC12UVKHYlR1mm4jBdZ7c8LtfJi5zGJ7YsMHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpQOp5IiwQEoofjg05lG78CeEiQ3TGrIlCkkkEygoyPdm6Gm6O8M/sX6mlG5dDcxLvn1yb49DFL77gaTz+2h/RRDpw9iskTwRCrpnrqLGid8pe/UyCfrKsiMrUFkd+U6PE1Jwh1CVp4sIAdGhw7a35GNe1CXYv6unenKNG+jetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=siExSH/U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="siExSH/U"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A91dIC2447209;
	Thu, 10 Sep 2026 09:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XiL2bzVbHw3XGLovI
	YX7xK8Qw+OPnQN5+esJlp9dFvQ=; b=siExSH/UXZh2/9BHlBe7dHt5/fi942SIu
	Vup6p+qmBQqKt5JanEQ1rXFliPFXD4qviWD+VDSrXJdDHZNcL0HPZ2j+TcbrMMQJ
	O8IuvJTOVWT0pJOP9mYHmA//uUBJ4+3bdEVQiXuylBhbdVzjQNgBpUJqzVI5w6iu
	g8WJshckeSps571D5+vCduM51v2CqHEkDiK8+Laceejs+lPFqdvEkWw3XR9ahbdO
	zHTjMSo0JOkNKVn3emYrj/seS6QwAvp/e7bPONJYelNqm4Qn6VJpqRH96zeLgN/l
	vWJil+zoC7PNA8H/OhBeS6whCF0afQDy3fbLFaOF4zISV1wAvFmMw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8pkn13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 09:32:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68A9QGiP023787;
	Thu, 10 Sep 2026 09:32:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkcr33m57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 09:32:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68A9W69e46924158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 09:32:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B8AC2004B;
	Thu, 10 Sep 2026 09:32:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 645872004D;
	Thu, 10 Sep 2026 09:32:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 09:32:06 +0000 (GMT)
From: Vineeth Vijayan <vneethv@linux.ibm.com>
To: wbezenah@linux.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com,
        farman@linux.ibm.com, mjrosato@linux.ibm.com, oberpar@linux.ibm.com
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 3/3] s390/cio: Guard PMCW field accesses with dnv check
Date: Thu, 10 Sep 2026 11:32:03 +0200
Message-ID: <20260910093205.3357827-4-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910093205.3357827-1-vneethv@linux.ibm.com>
References: <20260910093205.3357827-1-vneethv@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eM2GH3p1 c=1 sm=1 tr=0 ts=6aa2791b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=4gMwTVHVtoHQdt2BDcwA:9
X-Proofpoint-ORIG-GUID: YoBJNa8ldI6859Qt0tHF1cG-Qbcu4Ko6
X-Proofpoint-GUID: YoBJNa8ldI6859Qt0tHF1cG-Qbcu4Ko6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDEwOCBTYWx0ZWRfXysZVV40RWrkp
 7h7jQ0GjSOx28+QGvK3fpPRZ9nq9CSdOFKsziJmfZKjRG6NJdiayXjZO7wLycT0iLCc/Pu20Hz8
 hgboKrjZlWoqNjIUkyu+gUI0s7agFfk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDEwOCBTYWx0ZWRfX+YYY9Dm8jfh0
 Ie9ns6Pk2wNaDuCJ8WITWECNyfe0XK6E6pXLS9A171AvDUqLkyMbknAvvxhHwL2MbMzizrunpSx
 oFfOgwDZVpwlOe6lZ4ZOdZb+38ia6jTSV60HesWZn6T4tVp8MCL/wMbYDHuhlzLU6xkjSs8MWls
 B6+jcc1qdV7N6Ab1dpq8GHVpViQimcuxKLugvWTFIjLJTf0usqcje73WMHBSFR4U5IEu87MvQ3T
 DPKhxLLZxmDuSi5T85sFio1mXekRUn4n3gIkod4am6MmbzXDm0Z1ZRS0J0HjXo1ketnNUSEGY3s
 Mj5aLoiQYEUk2uD7Ys/ehAAkdcAdW5Vmjmi3Qo4xss36E2jVNLj9W+ZnifjK+98dWuGOkWm3YE4
 jfeSJc1zY+AiPSlOwje6bTse/2HZWx+yypiu1m1S/5VYf65J7qg7piCB+PH3k8c9w2kQZLdIf6w
 AAhJhF/9fquXzAe5K1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100108

When PMCW.DNV is 0, no I/O device is associated with the subchannel.
However, several code paths access PMCW fields directly from the cached
sch->schib without first invoking the update helper. Add explicit DNV
validation before accessing PMCW fields from the cached SCHIB to avoid
using invalid data.

Reported-by: William Bezenah <wbezenah@linux.ibm.com>
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Fixes: 8c58a229688c ("s390/cio: Do not unregister the subchannel based on DNV")
---
 drivers/s390/cio/chp.c          | 3 +++
 drivers/s390/cio/device.c       | 9 +++++----
 drivers/s390/cio/device_fsm.c   | 3 +++
 drivers/s390/cio/device_ops.c   | 9 +++++++++
 drivers/s390/cio/vfio_ccw_fsm.c | 2 +-
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index c890f21a82ce..eaf0527bff6c 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -78,6 +78,9 @@ u8 chp_get_sch_opm(struct subchannel *sch)
 	int opm;
 	int i;
 
+	if (!sch->schib.pmcw.dnv)
+		return 0;
+
 	opm = 0;
 	chp_id_init(&chpid);
 	for (i = 0; i < 8; i++) {
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index fb591118ecb2..68dd4a62975d 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -922,7 +922,7 @@ static int ccw_device_move_to_sch(struct ccw_device *cdev,
 
 	if (!sch_is_pseudo_sch(old_sch)) {
 		spin_lock_irq(&old_sch->lock);
-		old_enabled = old_sch->schib.pmcw.ena;
+		old_enabled = old_sch->schib.pmcw.dnv && old_sch->schib.pmcw.ena;
 		rc = 0;
 		if (old_enabled)
 			rc = cio_disable_subchannel(old_sch);
@@ -941,7 +941,7 @@ static int ccw_device_move_to_sch(struct ccw_device *cdev,
 		CIO_MSG_EVENT(0, "device_move(0.%x.%04x,0.%x.%04x)=%d\n",
 			      cdev->private->dev_id.ssid,
 			      cdev->private->dev_id.devno, sch->schid.ssid,
-			      sch->schib.pmcw.dev, rc);
+			      sch->schid.sch_no, rc);
 		if (old_enabled) {
 			/* Try to re-enable the old subchannel. */
 			spin_lock_irq(&old_sch->lock);
@@ -1207,7 +1207,7 @@ static void io_subchannel_quiesce(struct subchannel *sch)
 	cdev = sch_get_cdev(sch);
 	if (cio_is_console(sch->schid))
 		goto out_unlock;
-	if (!sch->schib.pmcw.ena)
+	if (!sch->schib.pmcw.dnv || !sch->schib.pmcw.ena)
 		goto out_unlock;
 	ret = cio_disable_subchannel(sch);
 	if (ret != -EBUSY)
@@ -1254,7 +1254,8 @@ static int recovery_check(struct device *dev, void *data)
 	switch (cdev->private->state) {
 	case DEV_STATE_ONLINE:
 		sch = to_subchannel(cdev->dev.parent);
-		if ((sch->schib.pmcw.pam & sch->opm) == sch->vpm)
+		if (sch->schib.pmcw.dnv &&
+		    (sch->schib.pmcw.pam & sch->opm) == sch->vpm)
 			break;
 		fallthrough;
 	case DEV_STATE_DISCONNECTED:
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index ab419d40a8a7..b5686c25c83c 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -170,6 +170,9 @@ __recover_lost_chpids(struct subchannel *sch, int old_lpm)
 	int mask, i;
 	struct chp_id chpid;
 
+	if (!sch->schib.pmcw.dnv)
+		return;
+
 	chp_id_init(&chpid);
 	for (i = 0; i<8; i++) {
 		mask = 0x80 >> i;
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index c1ba4a19368f..f2f7f8cba410 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -490,6 +490,8 @@ struct channel_path_desc_fmt0 *ccw_device_get_chp_desc(struct ccw_device *cdev,
 	struct chp_id chpid;
 
 	sch = to_subchannel(cdev->dev.parent);
+	if (!sch->schib.pmcw.dnv)
+		return NULL;
 	chp_id_init(&chpid);
 	chpid.id = sch->schib.pmcw.chpid[chp_idx];
 	return chp_get_chp_desc(chpid);
@@ -510,6 +512,8 @@ u8 *ccw_device_get_util_str(struct ccw_device *cdev, int chp_idx)
 	struct chp_id chpid;
 	u8 *util_str;
 
+	if (!sch->schib.pmcw.dnv)
+		return NULL;
 	chp_id_init(&chpid);
 	chpid.id = sch->schib.pmcw.chpid[chp_idx];
 	chp = chpid_to_chp(chpid);
@@ -662,6 +666,9 @@ int ccw_device_get_mdc(struct ccw_device *cdev, u8 mask)
 	struct chp_id chpid;
 	int mdc = 0, i;
 
+	if (!sch->schib.pmcw.dnv)
+		return 0;
+
 	/* Adjust requested path mask to excluded varied off paths. */
 	if (mask)
 		mask &= sch->lpm;
@@ -798,6 +805,8 @@ int ccw_device_get_chpid(struct ccw_device *cdev, int chp_idx, u8 *chpid)
 
 	if ((chp_idx < 0) || (chp_idx > 7))
 		return -EINVAL;
+	if (!sch->schib.pmcw.dnv)
+		return -ENODEV;
 	mask = 0x80 >> chp_idx;
 	if (!(sch->schib.pmcw.pim & mask))
 		return -ENODEV;
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 5fd94e9d5c61..9a000b0231d6 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -399,7 +399,7 @@ static void fsm_close(struct vfio_ccw_private *private,
 
 	spin_lock_irq(&sch->lock);
 
-	if (!sch->schib.pmcw.ena)
+	if (!sch->schib.pmcw.dnv || !sch->schib.pmcw.ena)
 		goto err_unlock;
 
 	ret = cio_disable_subchannel(sch);
-- 
2.53.0


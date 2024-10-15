Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0B21B0137;
	Tue, 15 Oct 2024 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982062; cv=none; b=XDI+ZHmyejUeh8oHNFX9TJv9jodkZF9uY3N4ZrSIVUzCxFkeqne9hBf/FGwCExY+uqxBMLys5ZbMZrmg5ScUlpI9upIeRf8eIzJHYoOhizpyr32Jll6/QMkDLQaVh+O8lNJD/qYTCWHuquXF2WabTJq6SK8fMB6Vdeo50gDsr0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982062; c=relaxed/simple;
	bh=mb8viPyMs/YgCnd0NhSDzywPj0pSTesU7yv21kyCwFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9aFlExInw6tjKS+U9p/Q2WmhlbCG4MCk1h1H2xt1bndzzm9oQaDKLbRMVW9sy4HRDYirlGTlvmFiiwR+zcs9KSC93Gn4eM2GMl98dyg89uIbDyFsY06S2xbpc+zXDUJfU0W1h+Hk+uJBjBHRgbFuZF0oe2o22mxWoPcPtgU3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZfpgVOP+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZfpgVOP+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7KdLH031170;
	Tue, 15 Oct 2024 08:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YTrKc8qGOtsgzzS7n
	hDb2PvcvIuMgk1i3gDEtvIYVSc=; b=ZfpgVOP+GnTJjNlEquQ9OPZqvACp76MQe
	lOXjtHWi6DgZz3vdF8wdv/nwH7L7Avkr3rw8fX9i+v2+M2dUVLcngh6RIJQu/4vK
	jyY+0hA9wx1AQsvqY6XiVxrUZnKZzBp9yziR1SrrxK5fOgfdkOQC62h3K0NorTYR
	0kIblmVSGOCOdw8GL0Qy1nX7jlxCH4e0arSzPGoovdHUH93PrGfh/1Zs29x90kEx
	AdsGL0Y2qCbiS92d8tnmSPBBJKb0rcES83ZTF8LTO2Ja4ZPR+SsrMYiYgPYCwFVI
	NWJTHJaycRfkC3wcAxIeLSsiJe2c8lRgGaEV727tuU8VVY8QEF1PQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429kwvrdjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:47:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49F8hiqs031681;
	Tue, 15 Oct 2024 08:47:37 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429kwvrdju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:47:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F5PXB0004988;
	Tue, 15 Oct 2024 08:47:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nj2hya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:47:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49F8lYQC54133184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 08:47:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C64662004B;
	Tue, 15 Oct 2024 08:47:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7CAD20043;
	Tue, 15 Oct 2024 08:47:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 08:47:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 8C9AEE0125; Tue, 15 Oct 2024 10:47:34 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: linux-s390@vger.kernel.org, Yangbo Lu <yangbo.lu@nxp.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ptp: Add clock name to uevent
Date: Tue, 15 Oct 2024 10:47:24 +0200
Message-ID: <20241015084728.1833876-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015084728.1833876-1-svens@linux.ibm.com>
References: <20241015084728.1833876-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Kr2gUr7PFA0-dj5xAv86AW5DSTglgHCo
X-Proofpoint-ORIG-GUID: PBP1fUD3QOg1OLp-hDRZ1Hl1FTUIq74D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=888 lowpriorityscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150056

To allow users to have stable device names with the help of udev,
add the name to the udev event that is sent when a new PtP clock
is available. The key is called 'PTP_CLOCK_NAME'.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 drivers/ptp/ptp_clock.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index c56cd0f63909..15937acb79c6 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -25,9 +25,11 @@
 #define PTP_PPS_EVENT PPS_CAPTUREASSERT
 #define PTP_PPS_MODE (PTP_PPS_DEFAULTS | PPS_CANWAIT | PPS_TSFMT_TSPEC)
 
+static int ptp_udev_uevent(const struct device *dev, struct kobj_uevent_env *env);
 const struct class ptp_class = {
 	.name = "ptp",
-	.dev_groups = ptp_groups
+	.dev_groups = ptp_groups,
+	.dev_uevent = ptp_udev_uevent
 };
 
 /* private globals */
@@ -514,6 +516,13 @@ EXPORT_SYMBOL(ptp_cancel_worker_sync);
 
 /* module operations */
 
+static int ptp_udev_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
+
+	return add_uevent_var(env, "PTP_CLOCK_NAME=%s", ptp->info->name);
+}
+
 static void __exit ptp_exit(void)
 {
 	class_unregister(&ptp_class);
-- 
2.43.0


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670101DD86F;
	Tue, 15 Oct 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989687; cv=none; b=oWrGJNLJerjr2an8CRItt7aICRjTzWdyD/0eNFVsVprUfSHhHerBZhQJsmlq+ZNBphNpkkavbgfip8mScZHOlbomY7G3r46KlRKKQs6qk068A10h0rzeky4sVnRuqo8bPxzH///6xlsKQMPfaTO7QzDJRN1u4TuELpkgZAlx9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989687; c=relaxed/simple;
	bh=mb8viPyMs/YgCnd0NhSDzywPj0pSTesU7yv21kyCwFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sW0D4ggoQx/KXEnF0grqYzYcmvZIVwexnW46TsyQztE/xHyifG9WH/D+2wx45rUCEdrjJKl69qGMoMdIGG4/5+Y2tKDna+BXgB9zg+lrTUME4Qz7OymOZ27Lzcx4J1BzFYs3de47CCIA6qs4YPdQAmwFYTOAVniaNz6/Aboa/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cuy1cgkl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cuy1cgkl"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8PZoV024028;
	Tue, 15 Oct 2024 10:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YTrKc8qGOtsgzzS7n
	hDb2PvcvIuMgk1i3gDEtvIYVSc=; b=Cuy1cgklOiOsaB+3syoOqQB775YAEo83+
	immlBTBsTyincHZhLDr0ynIzuPmSUvENS8OaeNxeDHzBBgjZFNef78CfNAZ9xSs8
	GtEdNSd2DCFaJJssSi85y4A55btV8bgulHQmwS6PyNXTd9meW5mgpq66hYJleGv1
	BZqI2ywT58HUhqh+0z3NFiyVQrqBf3JiNbu5UNJvfYiyOU7ppa7Iguu5j+doN7Ny
	4HhjE/d00yOKwuMTNEyaZDpIDT/b8ltXRu+Qc/a4rTfGSVselfEDQ1c2Sp8/ZfcV
	JWpzMggSnMgUVmKCjT6ISYTtdWm5Khbwy14vGtkyX04xT/DqnM4tQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429mv4rq5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 10:54:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FAsY7Z030277;
	Tue, 15 Oct 2024 10:54:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429mv4rq54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 10:54:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8eBNn005381;
	Tue, 15 Oct 2024 10:54:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nj32ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 10:54:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FAsT6M17695098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 10:54:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB6DE20043;
	Tue, 15 Oct 2024 10:54:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8EB320040;
	Tue, 15 Oct 2024 10:54:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 10:54:29 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 7E4FFE04CC; Tue, 15 Oct 2024 12:54:29 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 2/3] ptp: Add clock name to uevent
Date: Tue, 15 Oct 2024 12:54:13 +0200
Message-ID: <20241015105414.2825635-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015105414.2825635-1-svens@linux.ibm.com>
References: <20241015105414.2825635-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oOyhYqkVcEgIe3WJT3JvYRU7NYkKAG__
X-Proofpoint-ORIG-GUID: pYhgNmqMJwwYoG3Bdjuh0Q7QdzuQ3VAI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=965
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150072

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


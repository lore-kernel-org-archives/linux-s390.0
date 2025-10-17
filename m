Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5CF20C48A;
	Fri, 17 Oct 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694609; cv=none; b=Xo7Qe55c/2x9I+E5Yv7f4ayUJv0ZxTRdYVUr7Y1E0HYhsVQR2pq6c3RTZar/CqokwPX1jDRkcvU4UEPQDUVmB1pnP0kNNTWZjb0wh5MzHbbduHXDDh5+BLgFjBSf/ezUWasQE+AgYJTyPhmYe8CAJjyzbFQYhk/a+JYD5SlzKJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694609; c=relaxed/simple;
	bh=9mhSuL/sVNQdFjnEflFrrws5JkwpqIwUo6uU6WJZAmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhkEHdRAEu1Ip414mGEILDW7wg+4lACS/1dm3oNnB1Ff8QxpSfmTZhJRXnHHSBOvqMXDkPQmVmlAfTjepFbFuTOzGFrOP0pnXZGRBm+v2Oh/UgKBk2rC6Ep9Tm0BuijtXg1Zs08arZ3vKNih8RdjhMpJYQBcz9DWzBK0PW29w28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PdFutatP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PdFutatP"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8Ti0J021709;
	Fri, 17 Oct 2025 09:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8nHVxhD/BATOc4YfzIbbQ5gjlyGGbKAL1gLEYD4Vu
	/E=; b=PdFutatPvhFdZjdF+D+jYl71ScGQMMTSDRNf9pmhM+3ZQAT1p5ONwv/vv
	jYg2PBxDlRo8S7aNATrBIiysljqXcboKcoj1KxpKntAMYFrkMFqO5K2PQtgHsPhp
	lkNc++4PX9Yi0R6/rmyUmubNgdNNzNS107HpAiu+eojrwBOAFDMqCuD7N3ylTtdl
	QxOV5GJIOh0kLq+CFHa+/umx0eYzv97RMWVeN0SFQTmDevbjJPRjT+HGX5HAsvAz
	ywXLWGvmcJWYRsGZoSuQIYK9Du2XPhKjqwpm0WgRvByrYlt/DL75WG04vzBHpj3T
	56YeS1+i3Dd9+JLbE2eIKE+DtztKg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey9a009-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 09:50:00 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59H9juXY029128;
	Fri, 17 Oct 2025 09:50:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey9a002-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 09:50:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9IPnk019007;
	Fri, 17 Oct 2025 09:49:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jn4nsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 09:49:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59H9nseQ15729048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:49:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 798B82008D;
	Fri, 17 Oct 2025 09:49:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 680E92008B;
	Fri, 17 Oct 2025 09:49:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 17 Oct 2025 09:49:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 3AD93E050F; Fri, 17 Oct 2025 11:49:54 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] s390/iucv: Convert sprintf/snprintf to scnprintf
Date: Fri, 17 Oct 2025 11:49:54 +0200
Message-ID: <20251017094954.1402684-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J7O1aBRahrIpQMtZvf6-mg90wLSjSy5R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX57DRGpz3znNX
 CGYn6g4Xi5OeOMdITxnAbABmtNrTC/MNJCf2q83hkT1RAlU2DxtDpl8pc5RlSV07XRDInK49yGH
 0ZFBRkperBLc3xDGyZr04qcvt6lflHeWgokUn5zTnyJUIPyEiNC3nbIRCZVJpC/DOlPIRnU6/UH
 oLP/LDdfRY84Mqc9UlQmn9pF0ag4KEMt4e5zppP9BwnPdhbbyGW6KvFrZfeOyU4JP4Ze266PjUZ
 bXFM3ROR52HqQGoTLEHCNt+nECt+urA6n9dW1sbP0SLxUxbSEZsj+7vdoigzpkcGbZYd768ZuVD
 yAVQIDI37yIGfVaZH/EXiqqEJDAd9wDHqpUE6OGUOjlbIeYYgzP//T7FIUguyEv6gJWX9LR6TX3
 8qBvUXAi7Ygi0mEA/ZLuwWz+PylR4Q==
X-Proofpoint-GUID: aHqdfal3Vg_6u-bxbWgYyh5fuemAFqPR
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68f21148 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=07d9gI8wAAAA:8 a=VnNF1IyMAAAA:8
 a=lHDQxDT7zutfACCrFRAA:9 a=e2CUPOnPG4QKp8I52DXD:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

From: Aswin Karuvally <aswin@linux.ibm.com>

Convert sprintf/snprintf calls to scnprintf to better align with the
kernel development community practices [1].

Link: https://lwn.net/Articles/69419 [1]
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/smsgiucv_app.c | 7 ++++---
 net/iucv/af_iucv.c              | 7 ++++---
 net/iucv/iucv.c                 | 2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/net/smsgiucv_app.c b/drivers/s390/net/smsgiucv_app.c
index 4bd4d6bfc126..768108c90b32 100644
--- a/drivers/s390/net/smsgiucv_app.c
+++ b/drivers/s390/net/smsgiucv_app.c
@@ -88,9 +88,10 @@ static struct smsg_app_event *smsg_app_event_alloc(const char *from,
 	ev->envp[3] = NULL;
 
 	/* setting up environment: sender, prefix name, and message text */
-	snprintf(ev->envp[0], ENV_SENDER_LEN, ENV_SENDER_STR "%s", from);
-	snprintf(ev->envp[1], ENV_PREFIX_LEN, ENV_PREFIX_STR "%s", SMSG_PREFIX);
-	snprintf(ev->envp[2], ENV_TEXT_LEN(msg), ENV_TEXT_STR "%s", msg);
+	scnprintf(ev->envp[0], ENV_SENDER_LEN, ENV_SENDER_STR "%s", from);
+	scnprintf(ev->envp[1], ENV_PREFIX_LEN, ENV_PREFIX_STR "%s",
+		  SMSG_PREFIX);
+	scnprintf(ev->envp[2], ENV_TEXT_LEN(msg), ENV_TEXT_STR "%s", msg);
 
 	return ev;
 }
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 6c717a7ef292..4ddfc633d30c 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -553,10 +553,11 @@ static void __iucv_auto_name(struct iucv_sock *iucv)
 {
 	char name[12];
 
-	sprintf(name, "%08x", atomic_inc_return(&iucv_sk_list.autobind_name));
+	scnprintf(name, sizeof(name),
+		  "%08x", atomic_inc_return(&iucv_sk_list.autobind_name));
 	while (__iucv_get_sock_by_name(name)) {
-		sprintf(name, "%08x",
-			atomic_inc_return(&iucv_sk_list.autobind_name));
+		scnprintf(name, sizeof(name), "%08x",
+			  atomic_inc_return(&iucv_sk_list.autobind_name));
 	}
 	memcpy(iucv->src_name, name, 8);
 }
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 473a7847d80b..008be0abe3a5 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -95,7 +95,7 @@ struct device *iucv_alloc_device(const struct attribute_group **attrs,
 	if (!dev)
 		goto out_error;
 	va_start(vargs, fmt);
-	vsnprintf(buf, sizeof(buf), fmt, vargs);
+	vscnprintf(buf, sizeof(buf), fmt, vargs);
 	rc = dev_set_name(dev, "%s", buf);
 	va_end(vargs);
 	if (rc)
-- 
2.48.1


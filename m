Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED36301004;
	Thu, 23 Jul 2026 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815272; cv=none; b=qlThRwa+/5r2PEwY32oqnLSbp8dSdaCfjl0jyNWpmzU1IgsyW0O4NsfBxmyyyob0OyGONdQQ8L3wGlmT8szsq5FAB3kt+ql9m0ldYsaYiuoCmGZVh34OJzodve035ibgOBpyL9PVcvfVOb3cDVQ0t4WD9gxVPJWjCcloVG1tXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815272; c=relaxed/simple;
	bh=svkWmH082FIs+NYzd9fVTUvrFOKjJq1MAswMvtlUvs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qS/jfvKrF1RYHVELrzP0O5rZviNt4cGIA9AmylOdO43xuhP0Kv+3gimYclII8Duo4tTVru4cSn8n/KitPa1LTpC25F0MnNk0OrJjQ8Q6dmxUj8ihAiz2aeYYtgHODwJe37VcCSzIfpr+3zA+ltlYQMCrBBzlV2wm3CWSLjZt5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AwdCoBAH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AwdCoBAH"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBkXg1210645;
	Thu, 23 Jul 2026 14:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NUNFmQwVphrr+G5AC5Kp//AQwE7U/ugq8ao7jLrQH
	c0=; b=AwdCoBAHY+FEbzw3kHm2abJfXYVk3UWYEBl3/6+uRVrZM1dPIKc09QmSU
	qyrrqn8cfJAPMnMsOJz3bi2jUyxg5E5bFRbWIa4jEMgEaPBrWpFWhmaP9YqH459e
	Jv4NDJ5tPA4HMmF5II0Bz+4O1hZg60PcBDqIxSDz0KWlGhzVsYFMPf9lA7kpJ4NC
	NWNFb7g8Za3hzHxWSialx6eb3SOQuLIfMZnhIazmUrwWyjznnrbl8ftT/HyOiA0Q
	px/d50l0EhhsRjeb+GQWd6Jk7X4CCuDpcrSZ0kIMbZE6YRXWol0DPdg5pk3nAoj7
	lYzMJCe491el/EO4Oyy7LGFaYMMuw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77aqv4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:00:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NDnjKI006571;
	Thu, 23 Jul 2026 14:00:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahcdcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:00:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NE0oIi30409394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 14:00:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA224200E2;
	Thu, 23 Jul 2026 14:00:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68336200E1;
	Thu, 23 Jul 2026 14:00:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 14:00:50 +0000 (GMT)
From: Aswin Karuvally <aswin@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        arnd@arndb.de, stable@vger.kernel.org
Subject: [PATCH net] s390/qeth: Check CAP_NET_ADMIN for private ioctls
Date: Thu, 23 Jul 2026 16:00:50 +0200
Message-ID: <20260723140050.762991-1-aswin@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX6JSyPB09lWt+
 IrQMkj2Vap9skgl2xnlOljTLjPIWgw3QKOTGIOQZRVLP/6ZWhUxmrSTk0YguOV4jF2LKrvoBm1O
 3B4gLuX0++gT8g+jB+f4aae7SAsUGrseeCUuF/bRTHSJfTphCanx0nEr27+ototDPGrKgzKygse
 UCBfgrC0ZOHz9da0+5HSe8+NldDDz81BZWntCvj3IeklOo2ByWFJavn3RdDq0rDTC5/bVfSn8zT
 +aiiuQ1Mpk5homtW1lp4ByAw4wngDIotuwFUDA2fdQqsbSPk9hr/HTdekuBtOH7tgnEHQGAcVtd
 qMboO+w7NxKeg29FgHHJjklMifn/wcn/n/Yfek08CmvJYuSU01OTbpsIZ01tbRhJUMcJYALw39j
 Pytxxhqq1tSDPbAHhUXxsdmvoCE1OQ==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a621e98 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_kRH_JVfn-j37NcTvyMA:9
X-Proofpoint-ORIG-GUID: IE4Kdwab4VNdqIlyZF6k-76rXg56jAKc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfXwUUlnx3VuZV6
 wLPuX59shn3E5x19LWWOAHrFX9nyoCRUBf3HSEdH7dQZdozfyNkuwYJVwsC39cmUnUSvRNw0T5B
 lQFc8EQ4UkZwmSBDuVUgFtKFTpTnNo8=
X-Proofpoint-GUID: jBqmKAVul1GehM0HkNAeNtAap1TJKi14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607230135

Gate the SIOCDEVPRIVATE ioctl commands SIOC_QETH_ADP_SET_SNMP_CONTROL,
SIOC_QETH_GET_CARD_TYPE and SIOC_QETH_QUERY_OAT with CAP_NET_ADMIN
capable check to ensure unprivileged users cannot invoke them.

Fixes: 18787eeebd71 ("qeth: use ndo_siocdevprivate")
Cc: stable@vger.kernel.org
Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 20fb0d2e02a9..f18eed9df3c7 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6525,6 +6525,9 @@ int qeth_siocdevprivate(struct net_device *dev, struct ifreq *rq, void __user *d
 	struct qeth_card *card = dev->ml_priv;
 	int rc = 0;
 
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
 	switch (cmd) {
 	case SIOC_QETH_ADP_SET_SNMP_CONTROL:
 		rc = qeth_snmp_command(card, data);
-- 
2.53.0


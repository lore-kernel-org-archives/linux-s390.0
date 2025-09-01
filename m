Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB2332C336;
	Mon,  1 Sep 2025 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738737; cv=none; b=INqxbzPSYe36EosmtFuovuogbc9Ko9xNi11O/nc4xEqedCOhVMrg18JYgRAzexoqmOirDt31XG78DDJsxgloYuKTXemA6Lwo4LeTaAx1hXzeoJeH6jHi08DkCxmCQVne2Uh+vZv9jR+mMG4ANkamOvZ2HufZcUuF7NeC0MWO9eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738737; c=relaxed/simple;
	bh=DmaIvhNE65C8m0COK4dR3f13N9Tym3PINAM1R2ebqyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZAr2vrKwG5MnsshgOSTQpeZvT40isPe2kpFBA3YHNep3w47FkckIa8WC+iU2jRhzGK47kqbzWYy6RqS0Rc7kgeix2L0n3hB4kMy22jv8Vxi2CTtDL1BnizKw/yHwgKOg5EqhjYPnjM5xr5eLan05AOWCciuKXJygMjoK3J707s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SQZ5Cv+g; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SQZ5Cv+g"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 581BmrLp000630;
	Mon, 1 Sep 2025 14:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=swAvUAj5PQgoVWEs7
	wMM6aHZr1vUBFBkmXjiI+g+Wek=; b=SQZ5Cv+ghfAiZRQSKCR58+NGhzIE5NaqO
	yqyQC3W3EBYNlRdy7/7u2zwf3nG/Gx6qpgz2BG7ONmTorF6nrPuuawtYcplOtgur
	FvlpcJuI1IBHlaJ6CX2OjiRouFuVZIBWqOstfmTUbcGeFplz7GzH9RiGRqMsctzM
	Lo3778fEhPGkvQ9+FXf1hhE3wFOqBpU6GytPdVNxmuFI0GYncYKQrPQdpefx4mNP
	cIub5f1gmCQc4w3BRhO5cBlyQU7aO/x2tjyL8NzuBsaoEXg0k+Hy5fctZaqb4sG0
	6FU0HzMoDH7S2V5sK+g/1cWbeTQxx1TNBxTtL3jINSjxy71lO4NVA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuqskc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 14:58:49 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 581EteSR009421;
	Mon, 1 Sep 2025 14:58:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuqskbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 14:58:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 581DOIZN021170;
	Mon, 1 Sep 2025 14:58:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vcmpecsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 14:58:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 581EwhKW25494116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Sep 2025 14:58:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0392D2004B;
	Mon,  1 Sep 2025 14:58:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E521B20040;
	Mon,  1 Sep 2025 14:58:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Sep 2025 14:58:42 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id BE13EE0C40; Mon, 01 Sep 2025 16:58:42 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 2/2] net/smc: Improve log message for devices w/o pnetid
Date: Mon,  1 Sep 2025 16:58:42 +0200
Message-ID: <20250901145842.1718373-3-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250901145842.1718373-1-wintera@linux.ibm.com>
References: <20250901145842.1718373-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfXx7ZX25uzZqG/
 +UeNS2dFs2ihkQkVADhLg6Yk8YuhyLxhnSxDaYn1zqOQAfsXQxInR7IntIa5KHMM7MstvA1in6F
 OtvAuQW0hU4ttqC/KwX3Z47GZUB821OWLLusemTnFjAKh0WguhwMRvcsvRgZF9G5jr4WsFFuo8w
 Qi+4EkqCqccbFbVDnYfD3sYcBbXD6nlD+FRvb40T+3tMePw67DonouqRfHx2eZdkC+A7aObwC/D
 hjAIFZxhuIP9e1GuSRe8FH6zQjYGsYIB3W+/y9plQHuvqURcmpbI2hPPSbxv3KGcRinj7x+99xC
 uz4VIZ4kirANmL1rPt7pNpbm5WgVjJe3swtVORlSFl1typTg530tuvIjVRIu7XuFHCPi+o3T3QH
 gcsEHCSW
X-Proofpoint-GUID: CFY1ICfGyRJC5Xe3NjfjT1V3_4VvIol6
X-Proofpoint-ORIG-GUID: bAh_gx-xzHbgig55dtAqqz48rnrgL9Bp
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68b5b4a9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8 a=ZmQWjMfew9ivcFZuHVcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

Explicitly state in the log message, when a device has no pnetid.
"with pnetid" and "has pnetid" was misleading for devices without pnetid.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
---
 net/smc/smc_ib.c  | 18 +++++++++++-------
 net/smc/smc_ism.c | 13 +++++++++----
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 53828833a3f7..f2de12990b5b 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -971,13 +971,17 @@ static int smc_ib_add_dev(struct ib_device *ibdev)
 					   smcibdev->pnetid[i]))
 			smc_pnetid_by_table_ib(smcibdev, i + 1);
 		smc_copy_netdev_ifindex(smcibdev, i);
-		pr_warn_ratelimited("smc:    ib device %s port %d has pnetid "
-				    "%.16s%s\n",
-				    smcibdev->ibdev->name, i + 1,
-				    smcibdev->pnetid[i],
-				    smcibdev->pnetid_by_user[i] ?
-				     " (user defined)" :
-				     "");
+		if (smc_pnet_is_pnetid_set(smcibdev->pnetid[i]))
+			pr_warn_ratelimited("smc:    ib device %s port %d has pnetid %.16s%s\n",
+					    smcibdev->ibdev->name, i + 1,
+					    smcibdev->pnetid[i],
+					    smcibdev->pnetid_by_user[i] ?
+						" (user defined)" :
+						"");
+		else
+			pr_warn_ratelimited("smc:    ib device %s port %d has no pnetid\n",
+					    smcibdev->ibdev->name, i + 1);
+
 	}
 	schedule_work(&smcibdev->port_event_work);
 	return 0;
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 84f98e18c7db..a58ffb7a0610 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -518,10 +518,15 @@ static void smcd_register_dev(struct ism_dev *ism)
 	}
 	mutex_unlock(&smcd_dev_list.mutex);
 
-	pr_warn_ratelimited("smc: adding smcd device %s with pnetid %.16s%s\n",
-			    dev_name(&ism->dev), smcd->pnetid,
-			    smcd->pnetid_by_user ? " (user defined)" : "");
-
+	if (smc_pnet_is_pnetid_set(smcd->pnetid))
+		pr_warn_ratelimited("smc: adding smcd device %s with pnetid %.16s%s\n",
+				    dev_name(&ism->dev), smcd->pnetid,
+				    smcd->pnetid_by_user ?
+					" (user defined)" :
+					"");
+	else
+		pr_warn_ratelimited("smc: adding smcd device %s without pnetid\n",
+				    dev_name(&ism->dev));
 	return;
 }
 
-- 
2.48.1


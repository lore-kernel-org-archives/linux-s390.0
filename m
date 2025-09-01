Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A42F1FFE;
	Mon,  1 Sep 2025 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738738; cv=none; b=HvrvjUqodv7vc8yI+ds2FueDZHkpFdGEJTG3WJetexcrZ8DVKg3vlOuXLVMkQhJWVkQlgHYNWP6YLZgW833y6NALpmKqUfTmn8mpeynyab0sVO8bftE0tTSKwTrKv0SoSc1HEVH9CYngv9UwdGRt0Vu50bMEPJAkjzPn3DG49Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738738; c=relaxed/simple;
	bh=A0cEO1IjMFQGU/91KruzluQEM+jZalZQ6j3GdwIZK98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzKS+gkAHH51Gg4vi/1/PwAQCPPttxY6qhBhQTEyFNlWkVqYTHPrNOoVJH56tvLPsmtc/nn+mi8l+5CjYndoNs/wnstpe8TUnq97X6ISd3pnsDtHIj++mryeCbsbpp0NkaTO485K/Q1Yo09eICWpAt77QIBGmD+eJ880rSDEWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QRPRjmIY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QRPRjmIY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5818b01O026963;
	Mon, 1 Sep 2025 14:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WJKed3KXMGV5ekitr
	OAXUYfuousL4aKXDGBZu9XEUzQ=; b=QRPRjmIYlzcurXswk4vI1K2aUOdIQ+vwo
	sNaK3IZ2B8pL0GJoP/QzTsGavWjU32GE7UeGgsovMraw6UBWVPReNtguA/dkJLzm
	asZ/xVbWWYMcbuxUO/90DHHtpFIyl32TFcmhD5y4cqr6N51Un8pLnQ7UFEXN6GIz
	FzaCzwn0Vq/Rr5jdo+29W7VWvmghkhGKneYja1qfiw38MVYbvdmh93jD8aBacTLK
	+u5lWzLoGQ4ARqOgLmxYqhPG6LrTnzXu2QQnWwN8mlbUWergi2SnCMHdR4wwpTye
	bDA8NaWQ7FqV2Kd8bBA3kNP/A5JIGF4aWI3FnqhZTClmjCOlNPMlw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswd1jw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 14:58:48 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 581Eu3SJ010795;
	Mon, 1 Sep 2025 14:58:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswd1jw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 14:58:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 581EYO4d009000;
	Mon, 1 Sep 2025 14:58:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vdum6754-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 14:58:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 581EwhiO41288154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Sep 2025 14:58:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BB262004D;
	Mon,  1 Sep 2025 14:58:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC9372004B;
	Mon,  1 Sep 2025 14:58:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Sep 2025 14:58:42 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id BAC3DE03EC; Mon, 01 Sep 2025 16:58:42 +0200 (CEST)
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
Subject: [PATCH net-next 1/2] s390/ism: Log module load/unload
Date: Mon,  1 Sep 2025 16:58:41 +0200
Message-ID: <20250901145842.1718373-2-wintera@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68b5b4a8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=2SnCHD6kJk22Aa3V3LsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX0T+qvhgE8XwI
 97dW0eNVMroEu/QJBwu47HTNHIKSzTurSfwKBbkpSR/0bYrDvcGs3Bcm7sP+XIxTTT6vQsXS2aX
 W/ELFFuvtplwdx0BUADeNgDTxFIAygW5cpDd1pz10XVy2ohZuZL7j5gLmColeSVmhre0BSPTe3Q
 1KlRpvKC6ec1vIyfozRWISOH8DWFUT0fg27zOhjCI4DM+sfqxRdfATGVNhz8CUJ/Ik8CqEe0j2k
 NJH7J6bYYfx7qzM36LzCccoJCDYI7loJUISqx5qwZ8VsLGXcTI4V3mLAk+/Gnhhtz2bqKqdQHBS
 wdUI10Hm7uS5xKKLptCyN4S3Gdomg0TqSu/xJrH2tpX8pHbTWHMmjt3D1I4OH5Q7456Wd9YDfNg
 Sp+Bgjkz
X-Proofpoint-GUID: EfWWik7Gju2gLByFH3F2LQ9nGbLOfCu2
X-Proofpoint-ORIG-GUID: EUWkznhnBz4UoROmP5mKveu4h7QFNgIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

Add log messages to visualize timeline of module loads and unloads.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 6cd60b174315..a543e59818bb 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -718,8 +718,12 @@ static int __init ism_init(void)
 	debug_register_view(ism_debug_info, &debug_hex_ascii_view);
 	ret = pci_register_driver(&ism_driver);
 	if (ret)
-		debug_unregister(ism_debug_info);
+		goto err_dbg_unreg;
+	pr_info("module loaded\n");
+	return 0;
 
+err_dbg_unreg:
+	debug_unregister(ism_debug_info);
 	return ret;
 }
 
@@ -727,6 +731,7 @@ static void __exit ism_exit(void)
 {
 	pci_unregister_driver(&ism_driver);
 	debug_unregister(ism_debug_info);
+	pr_info("module unloaded\n");
 }
 
 module_init(ism_init);
-- 
2.48.1


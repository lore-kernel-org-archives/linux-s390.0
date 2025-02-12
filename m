Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA6256C74;
	Wed, 12 Feb 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378239; cv=none; b=jCZMr8zRtSDOX0iTD9Zi4lbQQzLzUu3oN2rIFrapJJUhSMlmzAtqwsxyRsV4XniazYeRY5CbEEHVRNso38uAH4X+cqqDQWhXXSplvMZ2j+2KXWqTOj/WGHxsihNPQrQyq9Ea0QVmYARDbrquuNKwT9X6xOpKA99SN8vcnLfL994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378239; c=relaxed/simple;
	bh=81vufag9QYMCMT3+26a0Zhg5TKB87NY4aCq/Ag+FxgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sysc0J4D/pNQWIrnINVxXlRskmAhAjmnDIV1CYgtoIKI6GoHuBf7s5ffKhSaRG5Kq1DfprlkXebT81aA5+nRyOujqF21NPpNcVIZT1aRr5DfYj8CWtxHWas/eud8f6WQwWIp6CnDlnxINEZZDIhBLADBdJDS0LFmBUcq5mrMH2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V+QW4Ya3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V+QW4Ya3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CGXfjH029508;
	Wed, 12 Feb 2025 16:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tC30YY7Dq02s0isivKXEgkOELRTi3AhieaLmOPz/D
	rQ=; b=V+QW4Ya32bO7o3NDEeA95pWIGIX9afK5W7cmNpQ7h1B6S9OYHAuLIF6Sh
	7cnX4ZAjV1Ig1QXuirsQFTW1hJBc5eBX+th5qWfpANjDHMXVB1u0Qr6mkxG4KGD8
	4IJhQ+0X4grsRWRMVda+f0ng0iTt73A+gR4WAb7ojsQH+NlLrbi1fpQ7M85+sYrI
	acKzOJXjx/2BqqJWQqKoMH53SP8CcDkliIb///HcoCQ5lBFqzGfnhPLiktmQ19NW
	pkHOquq2qvAZQCi/FZH6lK9cdION6MwsrMCWi+ohBZELV3gEEu+GxkrZBtc9cvH5
	kORuH20w9DcRYbgiZ4Rn8i+eIQR5w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rqbpaxem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 16:37:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51CGTFsU010180;
	Wed, 12 Feb 2025 16:37:04 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rqbpaxeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 16:37:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CGU2rY011605;
	Wed, 12 Feb 2025 16:37:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pktk1hu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 16:37:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51CGaxpA17039632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 16:36:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F58A20043;
	Wed, 12 Feb 2025 16:36:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DDB520040;
	Wed, 12 Feb 2025 16:36:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 12 Feb 2025 16:36:59 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 3607CE07F0; Wed, 12 Feb 2025 17:36:59 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Joe Damato <jdamato@fastly.com>
Subject: [PATCH net] s390/qeth: move netif_napi_add_tx() and napi_enable() from under BH
Date: Wed, 12 Feb 2025 17:36:59 +0100
Message-ID: <20250212163659.2287292-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S6ETxGMwYkgPLUW7M1YX1PLUVePRYZGx
X-Proofpoint-ORIG-GUID: boSTjGIhFiKXgGNfSFKo_ts6aYVB3joY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=987 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120122

Like other drivers qeth is calling local_bh_enable() after napi_schedule()
to kick-start softirqs [0].
Since netif_napi_add_tx() and napi_enable() now take the netdev_lock()
mutex [1], move them out from under the BH protection. Same solution as in
commit a60558644e20 ("wifi: mt76: move napi_enable() from under BH")

Fixes: 1b23cdbd2bbc ("net: protect netdev->napi_list with netdev_lock()")
Link: https://lore.kernel.org/netdev/20240612181900.4d9d18d0@kernel.org/ [0]
Link: https://lore.kernel.org/netdev/20250115035319.559603-1-kuba@kernel.org/ [1]
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index a3adaec5504e..20328d695ef9 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -7050,14 +7050,16 @@ int qeth_open(struct net_device *dev)
 	card->data.state = CH_STATE_UP;
 	netif_tx_start_all_queues(dev);
 
-	local_bh_disable();
 	qeth_for_each_output_queue(card, queue, i) {
 		netif_napi_add_tx(dev, &queue->napi, qeth_tx_poll);
 		napi_enable(&queue->napi);
-		napi_schedule(&queue->napi);
 	}
-
 	napi_enable(&card->napi);
+
+	local_bh_disable();
+	qeth_for_each_output_queue(card, queue, i) {
+		napi_schedule(&queue->napi);
+	}
 	napi_schedule(&card->napi);
 	/* kick-start the NAPI softirq: */
 	local_bh_enable();
-- 
2.45.2


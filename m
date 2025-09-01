Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C03519D88F;
	Mon,  1 Sep 2025 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738737; cv=none; b=ZVwAzaGnn16C8rw9hgsTj2o4ZnlbL7xrpsUEC4p9p4TT0lVx6OH0bCjHK2Yh2lLWtv635D5LP0O49ufxegDlUGD3KNJStURx55NGXyCZwBRCFtn3uuSAS7TOLNpyMeDUyn6f8/MrBWuDyG3JYZoAHXTMCQHPyoSwwYxxfQh1+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738737; c=relaxed/simple;
	bh=VtOusfuUU9IM2S8ltuL/zuBXWLNbej6g9WYY8NZ1/gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gy1tPsJKxpGiMtdGFbu21t5q24U6t/sHmnqK/IReUmoctd/r0CUw2sui6x+QzuM4PGuU5g2KJeKlWIc8Abyv+SWRGHEIcrSuRgAWzbhQUuyiawg1Z8SE52b0Tq33ahM3sFI0v6qyk71BCnG/euYmTegP6zp6sWOTtDnKjIKJmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CrRmtdJm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CrRmtdJm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 581Bf86I006549;
	Mon, 1 Sep 2025 14:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TgLECnS+aJdhbWV3881/hGKEg5pA6BDfCnMxfLFGN
	2Y=; b=CrRmtdJm7t3SEWfOqsWomZL2ZU4k7UiZ8lxmEWtZnCNstRlaxwvlKekhZ
	fyuiQY3mSxu8cDtKdbVUqDudnZuSbOKnB3Tz3jb6i/J9mFOYAMyG5MWz4P0jZObW
	s5TX4jtQwK039qp7/Bsai3j4KWEvUhuXyfRR7eF1grMWyGBrb/0LyM2WvJW6KL/A
	gO3+StdoBYUI5be2UddXd3gR3EWsF0rEFglb48hK+W0TSQ6/ZgCQMXL96BqNUI1a
	Y2FjK8ZRPM+Xh39QkSXofaZWi478Kp923GgDSs2ZUXIj9Mpo9OEwBshGazOaaOmC
	AAHx2C9HYdjTHY1Oj3iXMEr4p3vXQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuqskc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 14:58:49 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 581Ewmwq014487;
	Mon, 1 Sep 2025 14:58:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuqskbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 14:58:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 581DOIZO021170;
	Mon, 1 Sep 2025 14:58:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vcmpecsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 14:58:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 581EwhQX16908622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Sep 2025 14:58:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10CA520063;
	Mon,  1 Sep 2025 14:58:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F076D20040;
	Mon,  1 Sep 2025 14:58:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Sep 2025 14:58:42 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id B9204E098B; Mon, 01 Sep 2025 16:58:42 +0200 (CEST)
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
Subject: [PATCH net-next 0/2] net/smc and s390/ism: Improve log messages
Date: Mon,  1 Sep 2025 16:58:40 +0200
Message-ID: <20250901145842.1718373-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfX7RXBW1ZQ+1Db
 9/mRPx98++0eK3IIb7Dvz2yPtoa70IdIWQPSIZ4fyzSxvIb90NG+JLwxq1QYIaxR3+SuCQoItJL
 XjJP0GY1/TIiRkO14yKYG1pLXW3lamLVclzp44Uw8vQL6FuGxBqyPGYNk64eQfEBssti0wN1MSt
 fFUABTI7IIidOUscN/siTXSqY8eqM+FewkTzhBiYYj4DoCIxSXViMeVwl/T11Pr/baDzWO7rrdO
 5alVgYNLQITGHT9/ehGptHCIKdjR8jH+UpjwQlWo0ndJekCIl27m9B/yS2nM8Hh3xf+A/1YdD58
 9263OUtEatpu/rLbKJFM38ZtBPMHe6kK3c+h9YV/lZPDMIWnaeA/Z0D8G3pHDoah4ulRq821to9
 9gr0lg8o
X-Proofpoint-GUID: bY_O6wkTOZqVRhZ3YjN6oDFVaWSu2xLm
X-Proofpoint-ORIG-GUID: ERndmP8NnGcjHmxf4PbKjU1IrPnB6Ku-
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68b5b4a9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=q7gGKxmBYyU98WSWftQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

Separate these two improvements from the dibs layer series [1], as they are
actually unrelated.

Link: https://lore.kernel.org/netdev/20250806154122.3413330-1-wintera@linux.ibm.com/ [1]

Alexandra Winter (2):
  s390/ism: Log module load/unload
  net/smc: Improve log message for devices w/o pnetid

 drivers/s390/net/ism_drv.c |  7 ++++++-
 net/smc/smc_ib.c           | 18 +++++++++++-------
 net/smc/smc_ism.c          | 13 +++++++++----
 3 files changed, 26 insertions(+), 12 deletions(-)

-- 
2.48.1


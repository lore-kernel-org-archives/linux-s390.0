Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07C1CEADF;
	Wed,  4 Dec 2024 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320980; cv=none; b=u8sG5ChJ34ztIX0lCI1dbDZjr+ZpnirSm15nwiCw7R1a2Jyqiu6K6LbP8z2xOeTl2rDoXjFme7wdaQcyi7XxuYwa1sHFT7SztdgnuzdlIeArIU9Apkg7G5SSdU0C2q99fcIH8Wx5xxrIQDC5OHRHrYvZGXD5bl8+DUdiAYdF2XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320980; c=relaxed/simple;
	bh=y0oAHHEAf/jLUw+oPniy2chA+dzwlDRLzGB7DxkGF4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WShepuYQw7tWdVYX/LlfAVksFNVxLiOqfXx2qQY+lydX6737nQkgpcsNDeFII23WD1ku1HLctQBzEVgezt1PgiiacoW8qWOtY3OvVf+S2R5sgJ9WB5xzz4XMjAeu8jxqptKow/vB8blSJ6Hm8GobLG7vFVvPTYcjJTbj1if4UZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dVie2Qfk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dVie2Qfk"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B480N9t005582;
	Wed, 4 Dec 2024 14:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kc+cLkePYKI1a0U9UKKEWLLtvUq4zsoHCKdEMA4A0
	r4=; b=dVie2Qfk6MeL5ZJx9WHYQ/hkZJ+5jpHKQUbqaTwXi7pK3c2SdkY1GjFHh
	geodkw/oOdQgDLqlp9cHHfV3pdthrc/7L4s1SL1CnK7hSyIvrLCl0IRcSX7i1pq+
	09M7th65LYiMWKhOm2Xizv3rtbiIIwx00OQ0kzg58Qyo+7NtmJOKO2pkn4Kc38OH
	2wGS+q9k6iDHarkP7z6dKlLrMwdPwWaO9TG5LrX7gN8Za1GbhGCA4GV17cVg63Sb
	wrDoLHj8IZav77h7ddFGQA87sqmWvVTCdmjY8nOK20gGoh6yJc/k6FIZaC9UiM+H
	M68UHB0ZvYw0vmmiGoArmuX1jAbtA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437te98xd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 14:02:36 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B4DxFAF009627;
	Wed, 4 Dec 2024 14:02:35 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437te98xcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 14:02:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4APEX7007467;
	Wed, 4 Dec 2024 14:02:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8jn0xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 14:02:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B4E2Vgn21234168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Dec 2024 14:02:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 401C02004B;
	Wed,  4 Dec 2024 14:02:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28BF320040;
	Wed,  4 Dec 2024 14:02:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Dec 2024 14:02:31 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id BA37DE0788; Wed, 04 Dec 2024 15:02:30 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Nils Hoppmann <niho@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
Date: Wed,  4 Dec 2024 15:02:30 +0100
Message-ID: <20241204140230.23858-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 49W39RiHlGhq9C68PtpvaJtRfl09BlnE
X-Proofpoint-ORIG-GUID: kU1xrMSuKHv2JksqzIUyy2V3I12o5UpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 adultscore=0 clxscore=1011 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040107

Linearize the skb if the device uses IOMMU and the data buffer can fit
into one page. So messages can be transferred in one transfer to the card
instead of two.

Performance issue:
------------------
Since commit 472c2e07eef0 ("tcp: add one skb cache for tx")
tcp skbs are always non-linear. Especially on platforms with IOMMU,
mapping and unmapping two pages instead of one per transfer can make a
noticeable difference. On s390 we saw a 13% degradation in throughput,
when running uperf with a request-response pattern with 1k payload and
250 connections parallel. See [0] for a discussion.

This patch mitigates these effects using a work-around in the mlx5 driver.

Notes on implementation:
------------------------
TCP skbs never contain any tailroom, so skb_linearize() will allocate a
new data buffer.
No need to handle rc of skb_linearize(). If it fails, we continue with the
unchanged skb.

As mentioned in the discussion, an alternative, but more invasive approach
would be: premapping a coherent piece of memory in which you can copy
small skbs.

Measurement results:
--------------------
We see an improvement in throughput of up to 16% compared to kernel v6.12.
We measured throughput and CPU consumption of uperf benchmarks with
ConnectX-6 cards on s390 architecture and compared results of kernel v6.12
with and without this patch.

+------------------------------------------+
| Transactions per Second - Deviation in % |
+-------------------+----------------------+
| Workload          |                      |
|  rr1c-1x1--50     |          4.75        |
|  rr1c-1x1-250     |         14.53        |
| rr1c-200x1000--50 |          2.22        |
| rr1c-200x1000-250 |         12.24        |
+-------------------+----------------------+
| Server CPU Consumption - Deviation in %  |
+-------------------+----------------------+
| Workload          |                      |
|  rr1c-1x1--50     |         -1.66        |
|  rr1c-1x1-250     |        -10.00        |
| rr1c-200x1000--50 |         -0.83        |
| rr1c-200x1000-250 |         -8.71        |
+-------------------+----------------------+

Note:
- CPU consumption: less is better
- Client CPU consumption is similar
- Workload:
  rr1c-<bytes send>x<bytes received>-<parallel connections>

  Highly transactional small data sizes (rr1c-1x1)
    This is a Request & Response (RR) test that sends a 1-byte request
    from the client and receives a 1-byte response from the server. This
    is the smallest possible transactional workload test and is smaller
    than most customer workloads. This test represents the RR overhead
    costs.
  Highly transactional medium data sizes (rr1c-200x1000)
    Request & Response (RR) test that sends a 200-byte request from the
    client and receives a 1000-byte response from the server. This test
    should be representative of a typical user's interaction with a remote
    web site.

Link: https://lore.kernel.org/netdev/20220907122505.26953-1-wintera@linux.ibm.com/#t [0]
Suggested-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Co-developed-by: Nils Hoppmann <niho@linux.ibm.com>
Signed-off-by: Nils Hoppmann <niho@linux.ibm.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index f8c7912abe0e..421ba6798ca7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -32,6 +32,7 @@
 
 #include <linux/tcp.h>
 #include <linux/if_vlan.h>
+#include <linux/iommu-dma.h>
 #include <net/geneve.h>
 #include <net/dsfield.h>
 #include "en.h"
@@ -269,6 +270,10 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 {
 	struct mlx5e_sq_stats *stats = sq->stats;
 
+	/* Don't require 2 IOMMU TLB entries, if one is sufficient */
+	if (use_dma_iommu(sq->pdev) && skb->truesize <= PAGE_SIZE)
+		skb_linearize(skb);
+
 	if (skb_is_gso(skb)) {
 		int hopbyhop;
 		u16 ihs = mlx5e_tx_get_gso_ihs(sq, skb, &hopbyhop);
-- 
2.45.2


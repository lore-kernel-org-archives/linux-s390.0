Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D964B4043;
	Mon, 28 Sep 2026 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596075; cv=none; b=dsKP8anb+FzCNAmhp1BC8Ippr3YoeY3db+vDurmsAtYKkw/jbYKtWx2xD9PTyeWgy3n3zvCgjXMnBgW97NVx1FmkjVY7f/YZmRFv6CxzuG35IwGC/DWwMgQ4I1P7nZzltRbvD6lonWXZ3/h/iMBb+8CTIZrj3NMNbJ9dNqNktPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596075; c=relaxed/simple;
	bh=gKexWYj4TECJgjQ3HIK+q3fhPhIvU0FyrGQh73gBwyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axbninAitQ4jO7cR+NJ7XisQ/9FhAD2Ot6Rw+VU4J9NX6wJFs8NWZhzNLNNNiBHbZHZ9pPCuv8pbaujTdQXahPnMH/NWYL8Z3pTvaCwbTlNzjYBTuy0PHd+3eo4Liu6jZRpiASbvfwtc3OsSryNOdgu1LzBGwBJ3H088heUqGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nrEXB6Tp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nrEXB6Tp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBa4ZK824443;
	Mon, 28 Sep 2026 11:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=lp9alhCtwld/A22A4Gj2pxE1ElKr1x9Zcht5P/StL
	dY=; b=nrEXB6TpzUWqvkRZHND+eLV1QCnVsNYgJ0Y8WweeabywETsyN7BNLJT1n
	Av6xBUk8k0KYnetTn2kqIiBGj7BLHKxPUM49gZ7j9bwGH0ZfszXuqeuDGaXq8jub
	Tz9O0U9tF29TBtHKzh0F/Av3SGBLuAjx5DjfiZxUswjKy2Eh4zODVnP+1Wv9Hf1X
	O/+v3DlXgr4GcilXOePnJCf0QfJn7AU90ijJJvcqKKPrt+u3zIL0YyT5wPQEGmFA
	DSih9LEPz7dZUWLagKKH3ubTMpdxTY0xXBALueGf8GPoWEioJGxdZnyXd9NoMRtO
	FouoUkbzNdGYPKgyDrC1LBH0186Lw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk102j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 11:47:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHYNr2943219;
	Mon, 28 Sep 2026 11:47:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxtkg4uyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 11:47:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SBlfZh45220210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 11:47:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE51A20043;
	Mon, 28 Sep 2026 11:47:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90E0220040;
	Mon, 28 Sep 2026 11:47:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 28 Sep 2026 11:47:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 4A112162099; Mon, 28 Sep 2026 13:47:41 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: Aswin Karuvally <aswin@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net] s390/ism: Zerorize dmb at allocation
Date: Mon, 28 Sep 2026 13:47:41 +0200
Message-ID: <20260928114741.4135978-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: uPbcHMsHIozt5wumsDcRDrbo-GIhgVRs
X-Proofpoint-GUID: Hz2SG6c1D61ZAEepy2SS8eAo4bMcVwSE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX20HfrasHbat3
 x02banvnur/bxlrvNoBLRug+CTAsK0E/GVpdZ5jB5ZfQDJEArpbRCCWZbDEv2bW56bfYEF/RmV4
 xDokBBWFdB5488kbV+v1XqkyEjhhANw=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6aba53e2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=BBuY1RymvebusuJm9ysA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX454akF/7yk9G
 6CtCuGKTjZs7cdyEFwMaY0OBgZ2yvzC8kO7EW/URhQbcKm8hNw0Xf3T1OnpLkTMRxDdvXxUvmtR
 A4HvQhb4s/AY897MjrXLKlj6leHdnemfk6W+RrJElshXrq5LZskx8XstRG2zxdoy9ubeySHpTW2
 dHWog8bHBWDmvhBW0TR9GxTj3sdrLLlvbug4EJZHgtv/hAdWUpcV6V2D83dK4UUE6405mLyBFPP
 SU4MQuFwkrB2oZ2Ckvr+9ahAQi1TABReZQ6J6dysj/49kPURQSjQFK/A1oqs8QCSLnMLH8xhfmd
 ux27f1YIf8qtRIPsI4TLRP/+f4NM8D+naSUhgeUaXh5XJCnOpwiC3n868CDO49uSgTG9EZPlDce
 JB0jF0sNhoQX50zRr0Pmj7HoM9+vFFV/uVSVlVkb/wXkWQ+BEineHncjR0odVPtxQnXjntpk0+u
 8fkD5xtQ/8ylY8w7+aA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280046

Sashiko reported [1] that 'Missing __GFP_ZERO in folio_alloc() causes
uninitialized kernel memory to be exposed in the receive message buffer'.
An ism dmb is receive-only, so the data is not leaked to a remote peer. I=
n
general the smc kernel module (dibs client) will only push newly received
data to userspace. We still should not have uninitialized data in a recei=
ve
buffer.

Since
commit 750afb08ca71 ("cross-tree: phase out dma_zalloc_coherent()")
dma_alloc_coherent no longer required the __GFP_ZERO flag, but when
commit 83781384a96b ("s390/ism: Properly fix receive message buffer alloc=
ation")
switched to folio_alloc(), it should have added back the __GFP_ZERO flag.

Add __GFP_ZERO flag and state in dibs.h that register_dbm() provides
a zerorized buffer (dibs_lo already does).

Link: https://lore.kernel.org/linux-s390/20260903143746.A5CC41F00A3A@smtp=
.kernel.org/ [1]
Fixes: 83781384a96b ("s390/ism: Properly fix receive message buffer alloc=
ation")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 3 ++-
 include/linux/dibs.h       | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 035b233abb4e..405abd99c820 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -256,7 +256,8 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct =
dibs_dmb *dmb)
 		return -EINVAL;
=20
 	folio =3D folio_alloc(GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC |
-			    __GFP_NORETRY, get_order(dmb->dmb_len));
+			    __GFP_NORETRY | __GFP_ZERO,
+			    get_order(dmb->dmb_len));
=20
 	if (!folio) {
 		rc =3D -ENOMEM;
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index d3e0777f25ae..0c10c224bcca 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -261,12 +261,12 @@ struct dibs_dev_ops {
 	 *	@vlan_id: deprecated, ignored if device does not support vlan
 	 * Upon return in addition the following fields will be valid:
 	 *	@dmb_tok: for usage by remote and local devices and clients
-	 *	@cpu_addr: allocated buffer
+	 *	@cpu_addr: allocated, zerorized buffer
 	 *	@idx: dmb index, unique per dibs device
 	 *	@dma_addr: to be used by device driver,if applicable
 	 *
-	 * Allocate a dmb buffer and register it with this device and for this
-	 * client.
+	 * Allocate and zerorize a dmb buffer and register it with this device
+	 * and for this client.
 	 * Return: zero on success
 	 */
 	int (*register_dmb)(struct dibs_dev *dev, struct dibs_dmb *dmb,
--=20
2.53.0


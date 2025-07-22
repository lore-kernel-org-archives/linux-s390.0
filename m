Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1291DDA32;
	Tue, 22 Jul 2025 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201126; cv=none; b=QjuS7OToIgiWuN9nrAdvPTRAr10dUsAwifNcwU/VeOkmWDZXmR52ewMVQ86hd57v4ijBeZgnsX0fZjPMj+vam4PgIVKDyBl/KRZS/h+K1qy5EN/zovVtsPy+oONDXLa8oVSUdTpmOWoRkLQf6bQmqzL8IdavB+t6LrgrLWI1gxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201126; c=relaxed/simple;
	bh=wC2QBmKD1GTiNhv+rPLf7dvvsC36d9AYwBdxKUY5G1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hzd67NuVQJj548yX2lmleTMWzrSFxvTfxAc+xA7oJO2t40azkxEM4rEPQEWhmZvCIgTpor6xOjNAspl/RsRVjRYEmPN1tJQSU8UOSvKetDX4xJ2UBPaBSIOC9vg56PJlDRblVZCPlR+Gly4APQpVQTsrjujnpSEpMRO3m3eEjpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bxeVVGzE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bxeVVGzE"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MG8o3f025065;
	Tue, 22 Jul 2025 16:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FrBUCus7BzHqtCvlsfkIewdsWUpoQYpZWe9EbvaOH
	rM=; b=bxeVVGzEv2aQ8j1pNhoybAwQnp1prdoJ/fJambV7teSFyPlmC1dF3UdqJ
	32iXxzGGWwMR4zfOm1e3diq9awmKSIeQR48WDllrri/EG0IOg1dmV9+O4z0fuaj5
	R5WVRxq43LKltmHbxkSJeHRNKnkZ08MiBk/LlzbC11Ij6IJQLNfqUy68ZwwbfUKT
	1AzIa0OtU64RL/yEcxt1Q5MunXLCKe/th9mSIx/dQDpfKMV1siMLKH+9NovZjIPE
	wz5ZnMOgOHm5KH2Az0DJUdjV08IPLb5VAsyTr1G4a27Qb44saDx/wHePUFNav3UN
	+4BjrP4R582mV9Ij6P7MWTLOmkHgQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805ut7tu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 16:18:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56MGBEms030471;
	Tue, 22 Jul 2025 16:18:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805ut7tu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 16:18:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56MEwLuU024972;
	Tue, 22 Jul 2025 16:18:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptku1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 16:18:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56MGIHEB34799924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 16:18:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 936672004D;
	Tue, 22 Jul 2025 16:18:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80F7E20043;
	Tue, 22 Jul 2025 16:18:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Jul 2025 16:18:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 50AC3E03BC; Tue, 22 Jul 2025 18:18:17 +0200 (CEST)
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
        Simon Horman <horms@kernel.org>, Halil Pasic <pasic@linux.ibm.com>,
        Aliaksei Makarau <Aliaksei.Makarau@ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: [PATCH net v2] s390/ism: fix concurrency management in ism_cmd()
Date: Tue, 22 Jul 2025 18:18:17 +0200
Message-ID: <20250722161817.1298473-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEzNSBTYWx0ZWRfX5Ydx/ykd9rnp
 sXmuvN2jYY//1d1zmICdyCTGOFSd0DCyOLkeSOF8dzja4O82Ryor24/lqXdM29svW9bIeajp8px
 goHkWKtC8P3xw9UfMLPX8TcOCM07wYEWqEtU+jYKhEprjHUuypnW5aI0Vcv4/MGgHE2MVS4a18u
 fQGUFl7iS7wzHOR9lT5D8Htijyv4wazymRh2TRo55YrSfEw+C4OXGP3H6LyUtE/Rxutrvqt3bv8
 B6yfnFE6/If3AxvxpX32TXgTkngOenPbFxtfvapuTHu64FApEKjUF29AzhPn0RsojQV5npK4ak6
 8y9HapPB76k6Hf8F3eBx9jWF/PlmmJ2xiXi4N7OZvp3vHQVD5bnssym70SYEuKJuuIN/KqL6Hpx
 gR66Jj4An1/l2sKY8wYbhMUWf8BAgNC8eEbbYIl+yL9qjOoW4N6iXD3XqlPo395cjQxJb3T+
X-Authority-Analysis: v=2.4 cv=Nd/m13D4 c=1 sm=1 tr=0 ts=687fb9d0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=qzj1OK7t_Lbxma-giU4A:9
X-Proofpoint-ORIG-GUID: _j6Io_zSFu_arDUvDmqp8N3lbMkZYYCS
X-Proofpoint-GUID: yY_nvzCCWQVugYrAVL_p68T5xZHZ9Smg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220135

From: Halil Pasic <pasic@linux.ibm.com>

The s390x ISM device data sheet clearly states that only one
request-response sequence is allowable per ISM function at any point in
time.  Unfortunately as of today the s390/ism driver in Linux does not
honor that requirement. This patch aims to rectify that.

This problem was discovered based on Aliaksei's bug report which states
that for certain workloads the ISM functions end up entering error state
(with PEC 2 as seen from the logs) after a while and as a consequence
connections handled by the respective function break, and for future
connection requests the ISM device is not considered -- given it is in a
dysfunctional state. During further debugging PEC 3A was observed as
well.

A kernel message like
[ 1211.244319] zpci: 061a:00:00.0: Event 0x2 reports an error for PCI function 0x61a
is a reliable indicator of the stated function entering error state
with PEC 2. Let me also point out that a kernel message like
[ 1211.244325] zpci: 061a:00:00.0: The ism driver bound to the device does not support error recovery
is a reliable indicator that the ISM function won't be auto-recovered
because the ISM driver currently lacks support for it.

On a technical level, without this synchronization, commands (inputs to
the FW) may be partially or fully overwritten (corrupted) by another CPU
trying to issue commands on the same function. There is hard evidence that
this can lead to DMB token values being used as DMB IOVAs, leading to
PEC 2 PCI events indicating invalid DMA. But this is only one of the
failure modes imaginable. In theory even completely losing one command
and executing another one twice and then trying to interpret the outputs
as if the command we intended to execute was actually executed and not
the other one is also possible.  Frankly, I don't feel confident about
providing an exhaustive list of possible consequences.

Fixes: 684b89bc39ce ("s390/ism: add device driver for internal shared memory")
Reported-by: Aliaksei Makarau <Aliaksei.Makarau@ibm.com>
Tested-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Tested-by: Aliaksei Makarau <Aliaksei.Makarau@ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 3 +++
 include/linux/ism.h        | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index b7f15f303ea2..967dc4f9eea8 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -130,6 +130,7 @@ static int ism_cmd(struct ism_dev *ism, void *cmd)
 	struct ism_req_hdr *req = cmd;
 	struct ism_resp_hdr *resp = cmd;
 
+	spin_lock(&ism->cmd_lock);
 	__ism_write_cmd(ism, req + 1, sizeof(*req), req->len - sizeof(*req));
 	__ism_write_cmd(ism, req, 0, sizeof(*req));
 
@@ -143,6 +144,7 @@ static int ism_cmd(struct ism_dev *ism, void *cmd)
 	}
 	__ism_read_cmd(ism, resp + 1, sizeof(*resp), resp->len - sizeof(*resp));
 out:
+	spin_unlock(&ism->cmd_lock);
 	return resp->ret;
 }
 
@@ -606,6 +608,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	spin_lock_init(&ism->lock);
+	spin_lock_init(&ism->cmd_lock);
 	dev_set_drvdata(&pdev->dev, ism);
 	ism->pdev = pdev;
 	ism->dev.parent = &pdev->dev;
diff --git a/include/linux/ism.h b/include/linux/ism.h
index 5428edd90982..8358b4cd7ba6 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -28,6 +28,7 @@ struct ism_dmb {
 
 struct ism_dev {
 	spinlock_t lock; /* protects the ism device */
+	spinlock_t cmd_lock; /* serializes cmds */
 	struct list_head list;
 	struct pci_dev *pdev;
 
-- 
2.48.1


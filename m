Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83952382;
	Sun, 20 Jul 2025 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753045920; cv=none; b=BvZjE5JKCO6EOup5JvviHBmQS6OSyFmYX6SuQ37UfRVJ9T95W1Sf52WrmKVNAF+n7RkPdQTiQXdItJ1HNE8tLdyGFYV2C0d0q4WqqaijQ54IoueVvjH0vj6i/WWXcSLo2WWeePm3n3MvICFUiVItm8L53uC9X62hTAaRjasMJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753045920; c=relaxed/simple;
	bh=+RYJ0uwX/zw8nqvpp0fJDSFLWYQQ70j0FHtcEbEAAQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=anhYmkl/BGqnhV/i16i8ocNcbmQ7a+H9z/DdJ66TT+BwOvKWqPPxsYCFLL0ePRSioJ0Ro04LyijZKK1QGRatdl4VaXP8myXTcyrWGKPh6jpk3MMWXL4S6ypFz7rDvOBxCj/zIC15K8e82oUcZKidVpB6QiTzwtr15gIPAbt29Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gPINocQd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gPINocQd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KJbbx8010184;
	Sun, 20 Jul 2025 21:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=P3zOlRzIaZNMSPHi9ly3Guwl7F068VzL0s3I/dzFF
	Dc=; b=gPINocQdX6mad3SLpCo4UVyli5u6ZL9RBcZPe1j7JLK1jG2hNzbXQ9mGC
	9GSi2VPBPE9jDsep/sdGGcIUqbzxsZ+v7auGq2wwRw/mWB8OGrEO9G/VL6xMuKVL
	ec3dyhUpjTGUu5fa1zQpQCpH7CxIzc+1ANuZcQusvttM7kpKBJMDkCgHShgiDyVB
	d6kCpU+vz2oXzKAxA2r0ZOiDcz3nNyC7kyS+kwe4878UQL//IJC0uec87atxnAhm
	qtYnWokt1/EUlP3iQxhymLkssC0Rk+VTpYHijFA2ysVrOOicfQxolGjxbLhMeNWQ
	7cjSTvzZKTu7npozzMqSBlRceDVbw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805hfnjkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 21:11:49 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56KLBmmj012353;
	Sun, 20 Jul 2025 21:11:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805hfnjkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 21:11:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56KGQNrv025138;
	Sun, 20 Jul 2025 21:11:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptbeta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 21:11:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56KLBf6D34472334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 21:11:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0954C20043;
	Sun, 20 Jul 2025 21:11:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB74F20040;
	Sun, 20 Jul 2025 21:11:40 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Jul 2025 21:11:40 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Aliaksei Makarau <Aliaksei.Makarau@ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: [PATCH 1/1] s390/ism: fix concurrency management in ism_cmd()
Date: Sun, 20 Jul 2025 23:11:09 +0200
Message-ID: <20250720211110.1962169-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDIwMyBTYWx0ZWRfX6s5dvxnjZSqi
 +MkDIPLKEK0Wn5nxJxuVPXQyS/QtN4dCbc4ZmFezxHfm3FBVOhPc+slASebCGykmIeoMS6L+d88
 /yVLQURwu463r0GvFL6LGNjyxrNhs2lhQ/WsCsrUtdVNB9cidIt8Fg7dLrwWjrawo/hjFTrR5l/
 c3OYCVvtRFSw/YQy1/MISDOYQ3RlErzzCD9c5hqUSQrUMqqijo3chYo6jvyRTRlT7lfNKLISyWv
 3IRO5ezD/8hYG/qqfyjoysIvgVd1rEig39RxjyS5O5noP90W2U3eonOyf05PZuwD9xoyZV0de9n
 ZKGrhZF12V7v98ySuBPEWAcspm42zW/wWq4Fi2ZVfNRgPkuusrZOesrqrzBhPm64kgOmEmAGxPy
 fwH2Io8YoN+nI75n8x5onFwTcpbhGJlX7zPbmdnQXqPCvP2UvjAl1GkvpDw8ASJD0sxvHOVQ
X-Proofpoint-GUID: NmpMoyYLtCPmimDwCl2_27Nx-io7ZIRY
X-Proofpoint-ORIG-GUID: L4y0NCyNFhSvVCMg5pD5FXsPwnD-N3Z7
X-Authority-Analysis: v=2.4 cv=X9RSKHTe c=1 sm=1 tr=0 ts=687d5b95 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=qzj1OK7t_Lbxma-giU4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200203

The s390x ISM device data sheet clearly states that only one
request-response sequence is allowable per ISM function at any point in
time.  Unfortunately as of today the s390/ism driver in Linux does not
honor that requirement. This patch aims to rectify that.

This problem was discovered based on Aliaksei's bug report which states
that for certain workloads the ISM functions end up entering error state
(with PEC 2 as seen from the logs) after a while and as a consequence
connections handled by the respective function break, and for future
connection requests the ISM device is not considered -- given it is in a
dysfunctional state. During further debugging PEC 31 was observed as
well.

The kernel message
zpci: XXXX:00:00.0: Event 0x2 reports an error for PCI function XXXX
is a reliable indicator of the stated function entering error state
with PEC 2. Let me also point out that the kernel message
zpci: XXXX:00:00.0: The ism driver bound to the device does not support error recovery
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
the other one is also possible.  Frankly I don't feel confident about
providing an exhaustive list of possible consequences.

Fixes: 684b89bc39ce ("s390/ism: add device driver for internal shared memory")
Reported-by: Aliaksei Makarau <Aliaksei.Makarau@ibm.com>
Tested-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Tested-by: Aliaksei Makarau <Aliaksei.Makarau@ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 4 ++++
 include/linux/ism.h        | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index b7f15f303ea2..c3b79e22044c 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -129,7 +129,9 @@ static int ism_cmd(struct ism_dev *ism, void *cmd)
 {
 	struct ism_req_hdr *req = cmd;
 	struct ism_resp_hdr *resp = cmd;
+	unsigned long flags;
 
+	spin_lock_irqsave(&ism->cmd_lock, flags);
 	__ism_write_cmd(ism, req + 1, sizeof(*req), req->len - sizeof(*req));
 	__ism_write_cmd(ism, req, 0, sizeof(*req));
 
@@ -143,6 +145,7 @@ static int ism_cmd(struct ism_dev *ism, void *cmd)
 	}
 	__ism_read_cmd(ism, resp + 1, sizeof(*resp), resp->len - sizeof(*resp));
 out:
+	spin_unlock_irqrestore(&ism->cmd_lock, flags);
 	return resp->ret;
 }
 
@@ -606,6 +609,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
 

base-commit: 07fa9cad54609df3eea00cd5b167df6088ce01a6
-- 
2.48.1


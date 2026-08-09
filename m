Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F273CC310;
	Sun,  9 Aug 2026 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786272963; cv=none; b=WFpiUmlUduaZUlRIQvuVCAGNIETygUduKcJT9CvrD7ZPwKRxCJnCCtnHzqdhYfhPDqRBY+OGV8mklpbMWCraFtjvftLcoNpX+62zXjPl/MpQ1/87mp9vRSeYB6RKazDQRgI9RoBsmB2o9eG7tv+Tw9KwxLbHXhhmXAW393htKn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786272963; c=relaxed/simple;
	bh=KcooomG/N7c42eTuLgNXB5Qr0Tr88R+Byg8Pv/56GBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6eYVgoIrDakt7oAzYEvbjv5rEvT/mYHMirMWXf4R2KGYBjlZVvhPk88m1dpiHrjHnVwg8oHkdk8jyALwXZc/kPq3hxJS7+WwJfF8qAoEuF1eHvfF7ymzr2Pphv3Mf6K0tFQPCwXLOHmMf8WPVp7QQyjoCZKJ20FgFbcH6q1Q1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H1H9iJU2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H1H9iJU2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6799201D2444502;
	Sun, 9 Aug 2026 10:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QIvO4B8LUmClQ2MRTWfabEAyNVq3RyN7PxlvvMOFH
	UQ=; b=H1H9iJU24O1qTpfkoJ2GH3+LRxgjtsH+LC0ojFUIc5xzeIuN9UP1qQF5e
	fG+P9nuAGehxc9pH/PWtVglo6nnAtt5cSJ7tWMf3ru/2e3xrc2wUFPmda81EJWq/
	kayTiXyCIHGZbpRLJw7Rs0fxqMF0zwOi2sMngAYmqtZgWI282Z1B5GZBgaZXCE7K
	fxTK3OMWUTqROaed00PI1McGCj1EmZOyGos343F/S9L4ynwKAzCr+AalHQbmS6/c
	8KTwM4WA4Ab7qJrxLUvjEgPQD0gHzpm0L0eLE1YTXCCv6ySDfjtj1WD5RVcGD1u2
	H33R0aVDpKyvX3u9pyeVuVscfq52g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvkckqba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:55:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 679AfnNa026952;
	Sun, 9 Aug 2026 10:55:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g0xr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:55:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679AtaN935586336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 10:55:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8F372004B;
	Sun,  9 Aug 2026 10:55:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C01320040;
	Sun,  9 Aug 2026 10:55:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 10:55:36 +0000 (GMT)
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
        jeff@garzik.org, stable@vger.kernel.org
Subject: [PATCH net] s390/ctcm: Prevent XID null dereference
Date: Sun,  9 Aug 2026 12:55:36 +0200
Message-ID: <20260809105536.541453-1-aswin@linux.ibm.com>
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
X-Proofpoint-GUID: NGijARh0JhpdpY3-rge1sH6WGfOF_BKC
X-Authority-Analysis: v=2.4 cv=J86aKgnS c=1 sm=1 tr=0 ts=6a785cae cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=OtRM_J3iQteCy_yeMqoA:9
X-Proofpoint-ORIG-GUID: mtY_biLqyrpEQxQsmnQ-GGY3hxHW1hPe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA5MyBTYWx0ZWRfX9n0th8hqHwmO
 zPq5QiNIEgDqRQyAoxdqE/ckaj0CXI1MIe+8Q6Yhh6/aHzhnLx4xyi2UnK+nRuGfo9lro7zakI5
 AqEDnIcMhK6XJFFHFLAc+jWx0YuRZo4HZlUpeGyawwa5buGndIeFCx4ARYaaJl1w3V/5F+0KZUB
 61JyKnYz+nMmjfpDMOY4Fj5Xh6Wq6TG7B4IHGCrqxBctXMOSFl4482II/Nq2gEMBbfqxPPudab6
 f72SuhLQLR+FKsHadcSBRcl21VDkP40/ffn4jyztaAoVkOCOONJJrDrmarZfohDRAihouB4JIJ5
 uSauYFlbQJWktP+3WiW1AGmeveAGgyisDO35WzZxlS2ZRGoUFBQOKFfCDIPHtLXzd6JYADeVdGA
 LkxRzkMnC+zECGoweo461/M2FXAfsMkuUSA1IjdHAGgo87aKvqK0XkZCj4lx3IpJMqGLcjB8Uom
 Lk1yEBCe9IzYQRPxkWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA5MyBTYWx0ZWRfX3bN1F5WOEeXy
 t98/rTBrsPiDZzSDlRsTCSI8h6GTi1XrzQMFez+yBeHNXRVNU61olLKWr/xAVRxDBEkrKpLGidg
 sA2bM9IXYRuDPnHaxlvZWYmZ5gJ3QFw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090093

The mpc_validate_xid() function sets grp->saved_xid2->xid2_flag2 to 0x40
to signal XID validation error. If peer XID is NULL or r/w channel
pairing mismatch happens, grp->saved_xid2 is never initialized. An
attempt to set the flag in such case leads to NULL dereference.

Fix this by guarding grp->saved_xid2->xid2_flag2 with a NULL check.
Also update mpc_action_go_ready() to treat uninitialized grp->saved_xid2
as validation error.

Fixes: 293d984f0e36 ("ctcm: infrastructure for replaced ctc driver")
Cc: stable@vger.kernel.org
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>
---
 drivers/s390/net/ctcm_mpc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index aeb102537e7f..a5b55fe6b110 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -826,7 +826,7 @@ static void mpc_action_go_ready(fsm_instance *fsm, int event, void *arg)
 
 	fsm_deltimer(&grp->timer);
 
-	if (grp->saved_xid2->xid2_flag2 == 0x40) {
+	if (!grp->saved_xid2 || grp->saved_xid2->xid2_flag2 == 0x40) {
 		priv->xid->xid2_flag2 = 0x00;
 		if (grp->estconnfunc) {
 			grp->estconnfunc(grp->port_num, 1,
@@ -1636,7 +1636,13 @@ static int mpc_validate_xid(struct mpcg_info *mpcginfo)
 			"The XID used in the MPC protocol is not valid, "
 			"rc = %d\n", rc);
 		priv->xid->xid2_flag2 = 0x40;
-		grp->saved_xid2->xid2_flag2 = 0x40;
+
+		/* If xid is NULL (rc=1) or r/w channel pairing mismatch
+		 * (rc=2) happens, grp->saved_xid2 is never initialized
+		 * and becomes NULL
+		 */
+		if (grp->saved_xid2)
+			grp->saved_xid2->xid2_flag2 = 0x40;
 	}
 
 	return rc;
-- 
2.53.0


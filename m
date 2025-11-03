Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6F82FCC10;
	Mon,  3 Nov 2025 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165029; cv=none; b=W+qHpkBSFffTNsfzKuqFxULpgNDbRvhEQ4SWmGlq2S96UE0kDLn+fjxFRrc+UPsA+9Hrdd/6uN2euKtCKHS5wzzhUsboufdLVRUvW1cqTzukt4s2+OeG/LYgwwckWl2Ngf5fTcdx7715yxBBoxvOf7c8p8gCogrW2Dfm6EHDVAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165029; c=relaxed/simple;
	bh=Lu3DRFUz68s5hffqcbHlj9MCZY8fROLv0KQlDl/tQvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkpSIc9YJRI7cOw76uFl0GbwnZbBQUIJu9IlUAHoK41cpEvNtZr+8TxpTCNHxj/i+BiZVO+ym2y6vXgkevlnXsUPlqfWS7+LjCdM9xkWIuGaLsWAeulpl7NzBWL9TO6CsEuDl3dVOlNWjf0rGQoQ0TA0SjnTtEnwQdAyIY2wDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yu1LxBl8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yu1LxBl8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2Khw3v011187;
	Mon, 3 Nov 2025 10:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8bTqFCkmYKIUFPeaZNVkOdfYtf5t10OTsCmkV7+J7
	3g=; b=Yu1LxBl8h+ZPOrLRaIPdYsEAnaq0d4wf5F05gDmnhtO3X7FtUMwcHVQrO
	A035S5THPzP0dj8i+6wt5hs3G4+5LvaN1xq/tpkubfl3ZrZ8ji9nWc7wmanZtuQ0
	KX5izFG+eCLKV3RYwTw6YxGKwXGcptZ/jK8q6iRWNqrOgTUS7mxkom3C4BoXRW2L
	lRLl6UpHNcLqoydsnluLoLX+mNa4eBZugld7W5znpEatRYngYfZ/BbNu+oyfyCiv
	PfvB8S5qa/GtElB8zAPYycDjekEcWztpDD8YRKOTLawjGm01eQJf5UyezAH/1+Kf
	kVorCH1+YEEcrQsTgWawN+/OjxCFA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mqx5v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 10:16:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A3A2u7o005859;
	Mon, 3 Nov 2025 10:16:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mqx5v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 10:16:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A36wp6T027379;
	Mon, 3 Nov 2025 10:16:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwy579y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 10:16:56 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A3AGru155640534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 10:16:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0944D20067;
	Mon,  3 Nov 2025 10:16:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1C2920065;
	Mon,  3 Nov 2025 10:16:52 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Nov 2025 10:16:52 +0000 (GMT)
From: Aswin Karuvally <aswin@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] s390/ctcm: Use info level for handshake UC_RCRESET
Date: Mon,  3 Nov 2025 11:16:52 +0100
Message-ID: <20251103101652.2349855-1-aswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rJoTwJgMvK54ZXpp-q_DIGMzMq9RDv2M
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=6908811a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=q5eb_lFJGzSj3ViXpxMA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 0FrKvHcmofj7sqY2DobuyHsz_eVmGCEh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfX0IjT/FVqh6Pv
 aQ/MU45KJrQAu1Pq0+7crsjlZ3uISFyrqegJ4FY4JEnrEq3nwBoWhnn9TS2n+rTirFjXttrF3ux
 5eBTbCwkbMiBf+Bqt+7PQrcyfl435Q9HRFmui7lugtZcic7qhpNH+os4v3ogEI8RXauSH/OvW+O
 s84FWjxoi+PLuniOso/sbexrDZj2691zz64eQu/8dso7RIG5WROWaSYrHAN1VodOB5tnB5ZAjgS
 pkdjiOO7y87ctb4b6dtvBJxzW4c1eR2AL+LarpSH2qXaIPB1/Yy6aJ227x2QBCQN+flqAoxhf8O
 9hLdrV0CVQD8C/VZYxfUwtLhCR8i+E7QPXfS+/bpfPNs3q26b54gV0S12xWoJ83uZeoBclzdRQr
 mZYW3UJE1FEW90azyBgc5GU6vHnEhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001

CTC adapter throws CTC_EVENT_UC_RCRESET (Unit check remote reset event)
during initial handshake, if the peer is not ready yet. This causes the
ctcm driver to re-attempt the handshake.

As it is normal for the event to occur during initialization, use info
instead of warn level in kernel log and NOTICE instead of ERROR level
in s390 debug feature. Also reword the log message for clarity.

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>
---
 drivers/s390/net/ctcm_fsms.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/s390/net/ctcm_fsms.c b/drivers/s390/net/ctcm_fsms.c
index 9678c6a2cda7..1a48258b63b2 100644
--- a/drivers/s390/net/ctcm_fsms.c
+++ b/drivers/s390/net/ctcm_fsms.c
@@ -882,6 +882,13 @@ static void ctcm_chx_rxiniterr(fsm_instance *fi, int event, void *arg)
 			fsm_newstate(fi, CTC_STATE_RXERR);
 			fsm_event(priv->fsm, DEV_EVENT_RXDOWN, dev);
 		}
+	} else if (event == CTC_EVENT_UC_RCRESET) {
+		CTCM_DBF_TEXT_(TRACE, CTC_DBF_NOTICE,
+			       "%s(%s): %s in %s", CTCM_FUNTAIL, ch->id,
+			       ctc_ch_event_names[event], fsm_getstate_str(fi));
+
+		dev_info(&dev->dev,
+			 "Init handshake not received, peer not ready yet\n");
 	} else {
 		CTCM_DBF_TEXT_(ERROR, CTC_DBF_ERROR,
 			"%s(%s): %s in %s", CTCM_FUNTAIL, ch->id,
@@ -967,6 +974,13 @@ static void ctcm_chx_txiniterr(fsm_instance *fi, int event, void *arg)
 			fsm_newstate(fi, CTC_STATE_TXERR);
 			fsm_event(priv->fsm, DEV_EVENT_TXDOWN, dev);
 		}
+	} else if (event == CTC_EVENT_UC_RCRESET) {
+		CTCM_DBF_TEXT_(TRACE, CTC_DBF_NOTICE,
+			       "%s(%s): %s in %s", CTCM_FUNTAIL, ch->id,
+			       ctc_ch_event_names[event], fsm_getstate_str(fi));
+
+		dev_info(&dev->dev,
+			 "Init handshake not sent, peer not ready yet\n");
 	} else {
 		CTCM_DBF_TEXT_(ERROR, CTC_DBF_ERROR,
 			"%s(%s): %s in %s", CTCM_FUNTAIL, ch->id,
-- 
2.48.1


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE32931DC
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234687; cv=none; b=E3u9AuFVdktcEV6/46d/gzSQrEeMCrlj7Uk0krINAFijSoV87efcCTkb+EBgxeLR9muWmGKAoKxabZYobfB7YgQVXW0FkxjxNATrFA8kvRQ6VFFlmoQBYk5U3PqOmcufrrRFSn2zLliqE32akA/lYvURoK1j40SGC/8PWUWWvQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234687; c=relaxed/simple;
	bh=kNsTkZiKGJEuuMaYj/uPER8Jd/405Nr9BLgMxydXp/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXkceyxtf0dHaVZN/fueO6xjqR2jYAb56g+sTj6t1L7A4qyxd+e+78/eD1O+4zA4+zhQXzH/uWkYwFpl0LK7vQQNKIWCxlwkNEMyaXIlA3WtFyTmqs/ef5Wb4/LaEn6z3Ulk6FGQ4IwjZuCW7lNTtlQO7uoVtPh+9YjzTPgBqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U/Y5xRxE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U/Y5xRxE"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K90ftI2794740
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=a2vHl8JHqE32LDxKx
	zXaMsC5Thc9SpQBoKX0CmxvngA=; b=U/Y5xRxETwRqvhHWsz+4/D+XyO7WUXrvJ
	FEFSnxc4vTW/6R2QKWPSBgHiCc64KVbYggC94hbnxuoKsYFTmkzR/wsoqMPWVQD4
	UTe3MzQuV+oqA9Z8EoKIDcd2jQSJ4vnTrD7Aod3GX+/CB+Olf6z52aPcCN7rBhBE
	VVz9lF9rXuXhwwP7ct/skJtL1x/PF3bcilNvPJAZWNl/FH+uis58mN0c7vueB6SV
	OLD6PsA0wMhM5ShUCE+yDVZHKAWFMuI9QKYvIMEes8sxaRAHXepdQYvNCZCkNlYX
	osW1jCQqJBXux+pxNHKiKbNo5b2es51hCQir5u+oZgT6TA6wtQ+eQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0as7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:04:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuH62027511
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:04:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqf3jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:04:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KE4djH44171730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 14:04:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8F7020040;
	Thu, 20 Aug 2026 14:04:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB1822004B;
	Thu, 20 Aug 2026 14:04:39 +0000 (GMT)
Received: from ibm.com (unknown [9.224.91.220])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 14:04:39 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>
Subject: [PATCH v1 1/1] s390/zcrypt: Validate length in reply before using it
Date: Thu, 20 Aug 2026 16:04:39 +0200
Message-ID: <20260820140439.892324-2-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820140439.892324-1-dengler@linux.ibm.com>
References: <20260820140439.892324-1-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EAXy_sUXc2-hBR1nh5evT0ids6QGrjVm
X-Proofpoint-GUID: EAXy_sUXc2-hBR1nh5evT0ids6QGrjVm
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a87097c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=_SsTBdzez2EMuKIi--UA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX7/lZ7hdQWDIR
 YIs0AxGHNvnEkjiUmxiGFO0d1kMVSTvREud6Ijw0wM/WcScA2KrOnXwUaYLGiuWmSa5kiBXviVL
 E6RV++HR4lObITh8dlz5aehiQxmCW/k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfXzE8MK8M7wK3P
 6u4wh2fsFkHqESaF8yDzHYbD1xTpHqc8+9ywTnVi+gbikxjW5Ob+CXwVWNMjJh81WIJkpUhvMKB
 dVlqtsaOglHW8jn9DwdK9CI9p9FNS2GifJ5LM4tH2z75K/xyRCNh12vaZq9AtEEPhS2pOfc/SI6
 vLtTEi5IcH0Gznu53HMNCBHi0Ggm03p1ig+6+aRO+rHfHw2IPNuN9LnJyg0xMasdJATkuH8k4ju
 ObGaTMBZKN8S6rusKA6JKm1uxQtCcD23nJCPw6K6qOm/redkbbP7rov3DqzrLbTvu+zrMnGfc5R
 Q8Rib5jcNMb7zJO+8cboHU3KYXJ4rjZSGBrDa3tfyzEBPRA5CUGQseoLIM5AH/PCDSBRgPvfsuZ
 NCUljkBE/gyJcAaDl7/s3Pnuy0KvbS33CTLL59mvCoVhH/Ws/reOF5Dec7HhBewq+gC21hjh4XQ
 QiviaFf3fsr66nB9yGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105

The length information in the reply is used to copy the key token to
the target buffer. An invalid information in t->len of the reply may
cause an over-read of the target buffer and also a over-write of the
target buffer. To prevent that, check t->len before using it.

As the available space in destination and source buffer is always
larger than the valid length value in the parameter block in the
reply, compare t->len with this (already validated) length
information. As a side effect, this check also prevents buffer
over-read and over-write.

Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index d4ce6352b5b2..54b8edd1dfc7 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1158,8 +1158,21 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 
 	/* do not check the key here, it may be incomplete */
 
-	/* copy the vlsc key token back */
+	/*
+	 * Copy the vlsc key token back.
+	 * The available space in the destination (key_token) and the source
+	 * (t) buffer is always larger as the valid range of prepparm->kb.len.
+	 * Validate t->len ba comparing it with the length information in the
+	 * param block of the request (prepparm->kb.len)
+	 * The value range of prepparm->kb.len has been checked above.
+	 */
 	t = (struct cipherkeytoken *)prepparm->kb.tlv1.key_token;
+	if (t->len != prepparm->kb.len - 3 * sizeof(uint16_t)) {
+		ZCRYPT_DBF_ERR("%s reply with invalid key_token length %u\n",
+			       __func__, t->len);
+		rc = -EIO;
+		goto out;
+	}
 	memcpy(key_token, t, t->len);
 	*key_token_size = t->len;
 
-- 
2.55.0


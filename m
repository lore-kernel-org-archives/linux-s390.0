Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031E332601;
	Thu, 27 Aug 2026 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812463; cv=none; b=qTf2rISQqFHoRr1dRt7LreD7kqMrTbDrpj+45Mf8eFYEF1RuyamjzVo/JQhjoC9Mh/WB0K/r5FrXOGFeKw6HpIVFhOjtGYOU2sjl5KisQjhBSjy4sr6eHGbGy8Amv0fi6BVRsI6FziR17lVkmUV8fT8CfKF7XpjBj/I4T0sVw1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812463; c=relaxed/simple;
	bh=xJc+PFbYXZlDDxBThfzDJhi4RR2IJmSUnfUaEbcKXzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mr0evGwzG6kLNOTzZ2k5hecd7uMzsFW5uiu+OISTOIFMimHEFnSnq2Wy/GWm/X8WG6HZ+hUOsx7yLXMrIq06er8Dw32wB4EkNtgy1u+0G7XJspXX2QEm0cRF74AHzDXoMVx9lW/SHVHu1mU5fiefCFPjqQtIFnlOadlRIvhX96Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qiMKPu92; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qiMKPu92"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6Vd4E2210175;
	Thu, 27 Aug 2026 06:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ucz1NzMG7UG1Ra9zk0/01qWlK+f/HZv573tGt0HO1
	ec=; b=qiMKPu926FcTEGyqxbzXEbs69pLR3pFGjZ04enEhRRg2Fh4aWpTb4hyox
	ei5n1F11A3U78xXtNXpmlDyJs8ivBpkyuWqSb7rv00RN1zGwC8PYcGFeRF2CDhxL
	bwjskWDb0E03wxVlI1wJOMfr2RDgpJ9Im8kSqwaaPHpK8whQY2UTHykZNtp4nKq6
	52i73yMMq4oa39DRNZcbadSY6iprMdQqZa9/BJXN52ZzhfQf/DhezHA31tUlxsXI
	mTzNFm8NZSuC9l+t1WtrYAhATz/09tTvNDNLxuFOyKGh5Ngy3OU0r3OdJ9ZUxMvR
	h1rG+okdZycq3EWiUONXBNYcnxSuw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g53pkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:34:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R6Qfw2028939;
	Thu, 27 Aug 2026 06:34:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsye96g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:34:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R6Y94B47382904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 06:34:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FD1020043;
	Thu, 27 Aug 2026 06:34:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D339020040;
	Thu, 27 Aug 2026 06:34:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 06:34:08 +0000 (GMT)
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
        stable@vger.kernel.org
Subject: [PATCH net v2] s390/ctcm: Prevent XID null dereference
Date: Thu, 27 Aug 2026 08:34:08 +0200
Message-ID: <20260827063408.2168914-1-aswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 762s6FFUaum0lzydxH7_aC0VwQ_7nxTh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA1MiBTYWx0ZWRfX+EJCg15VLrsJ
 s6nNOcFjveuvQZMHOElkVVAkqEnJ4DNiOS1Pf3SPl+5yPDCBQCyAOC6COdvODQVD/e4+HIPhc1e
 HBXtocShl2Rxf81A5zlhkB+O3AIBbyA=
X-Proofpoint-GUID: xeY1t9zm4bbETlLclys8avAOd8CZdbBa
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8fda66 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=OtRM_J3iQteCy_yeMqoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA1MiBTYWx0ZWRfX7OytTd7l2ozB
 zCMfqgcHE0KQr9y/RhsSC29TlD23zXiJQJxduO9jJ7S+FZhioAgyACl1Wb/3s119Y3IiXiaJmG3
 R1rbSD3v8AdNIyVsChJpE8r/eVB5HovD3lOp6ciLskpUpmnKhdzefUcf1osrwMOwNTrMXzAst9l
 HA98mNMnZP0kfdQG2yAZ5fUWoj1EhYkEcoZZYrMATt3dOFIN3N1A+PX34I0aKCgnbWb04P+eYlr
 ybWCRYAWp+YNsye020YINESg0HX6TVAvSX6xX9fdleROB5lmvO36t1wUT3raTPrizX7dBLxUQOQ
 Bl4ktFzjqcijUPyXNZ84QYf437h1NRN29Y/0CYUJykulvktU+lP0x+pqYUEDxdFS66xrxXOmz7F
 BEj4TAQCJEnKj75WkpsysNlVDbR9QjecqAwd1bgXL03zDFD+YIFX4pW3F/xinHDdqY4ZcXJbcOk
 fhYu1kQ/OmvfkSS1fPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270052

The mpc_validate_xid() function sets grp->saved_xid2->xid2_flag2 to 0x40
to signal XID validation error. If peer XID is NULL or r/w channel
pairing mismatch happens, grp->saved_xid2 is never initialized. An
attempt to set the flag in such case leads to NULL dereference.

Fix this by using the always available priv->xid->xid2_flag2 instead of
grp->saved_xid2->xid2_flag2 for validation errors.

Fixes: 293d984f0e36 ("ctcm: infrastructure for replaced ctc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>
---
Changes in v2:
* Ensure FSM goes to INOP for XID validation failure of either channel

 drivers/s390/net/ctcm_mpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 08e36685e578..61c88fe853c5 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -826,7 +826,7 @@ static void mpc_action_go_ready(fsm_instance *fsm, int event, void *arg)
 
 	fsm_deltimer(&grp->timer);
 
-	if (grp->saved_xid2->xid2_flag2 == 0x40) {
+	if (priv->xid->xid2_flag2 == 0x40) {
 		priv->xid->xid2_flag2 = 0x00;
 		if (grp->estconnfunc) {
 			grp->estconnfunc(grp->port_num, 1,
@@ -1636,7 +1636,6 @@ static int mpc_validate_xid(struct mpcg_info *mpcginfo)
 			"The XID used in the MPC protocol is not valid, "
 			"rc = %d\n", rc);
 		priv->xid->xid2_flag2 = 0x40;
-		grp->saved_xid2->xid2_flag2 = 0x40;
 	}
 
 	return rc;

base-commit: f967455fb2a5a2079b9eb5823e9ccf359174bf9f
-- 
2.53.0


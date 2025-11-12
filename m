Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED48234B410;
	Wed, 12 Nov 2025 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972060; cv=none; b=lYYM1v9EZk+cOrbnB1xwMbzmfotDWj8LeZ3pu2Yj4WmIySkkCy2Ped0yTlYcTtyBHyUH32Ww8TSRifh3H3RTQ2m6TU6QNNugTBEy5Of9XWFbnPUkRs71TbkrKb6vWK8gqC8hyJyp1Y7OpL9lsfn6wgOTwk0aIDxobphsVy9WCFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972060; c=relaxed/simple;
	bh=hpR5/eJy84xl7p8JuOygWtFX0UiA00tX14otHuZG1bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pq4QFejgHotAOXvuoc+gJN18wJeTkoJSJgsI3+O2sfvQ9L9dRZNF9YLlOULnTcouXuzsD7k30Y0zQY5BEL4AoDghadnltzj4K+gzwA4RYbDBMTaYCd2pzUmwwSHaf+KYYl9GlxweMgpeGA4OegYaoLhNnrfaDhuHc1IWc/oYgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pZESgGhG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pZESgGhG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEacDX003733;
	Wed, 12 Nov 2025 18:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yL4OSp/QnzWt3dJWOnGVF2xym4tQkPDmZN3+yy/+K
	mo=; b=pZESgGhGrmWK+EJK4wtGfxGlyoMYV4NlzQuG2rKqy4vAbu4QlnMhbON3h
	gJkp+HuRtUKO8lu2b5qWP2abAFHljUn1YaYxprwIIqW+6IJH2jntdWywhShHtMt3
	5GdDMuwgvyiMK/Dj9TmwFJVRKPnClw0q0hqvpZHarWITaWrk6jEKQ7/n7OToFJwf
	WVlZipQgxX5p4Z+GZoa5aSMYGfgeOdW+qyz99z/dRLcf8CgvwGXE5HzPJqrqrwqu
	gDjd2Ir8NbO44YjDsESmOXN9FEG+7aqCQ2CDnMDF8QJN8LHkkustm1O29yVRH+JN
	fvJ92hWoD2obT4x7Ofl3NbppUKBAQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjaygm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 18:27:30 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACIP80i025729;
	Wed, 12 Nov 2025 18:27:29 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjaygg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 18:27:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACGNmTc007298;
	Wed, 12 Nov 2025 18:27:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdjhn8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 18:27:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACIRPBu42991956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 18:27:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1FEC20040;
	Wed, 12 Nov 2025 18:27:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B272620043;
	Wed, 12 Nov 2025 18:27:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 18:27:24 +0000 (GMT)
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
        Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Subject: [PATCH net-next] s390/ctcm: Fix double-kfree
Date: Wed, 12 Nov 2025 19:27:24 +0100
Message-ID: <20251112182724.1109474-1-aswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=6914d192 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=mK5E5EQbiCHRqPeLpLsA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX9rWG15lTk1A8
 SGd8iwaDnTt5D4pmlz4zCd4erdbczTnElyVt23794RW4CsWRzsrkFA1y9zmxcRmF5jjzuVIEo/4
 8EScwxFJF0RY1CgRJ1stg+ecp5rwi2ZBgbMxCnz07xsxOzEGKPCkdFdWpdnjAuRXEnc8TUZ1+il
 wNt5pWusvFvNdFRN68dbHSO3lBFUrf6hwM0omO8W2AfGGZiGu38FzC/RJtR1Vu8qpARjVHeBC5V
 2s2qd5wj//Puuod/mKUypsOHsJWWESfrd903J8VXAHYCLrMsSpm3CKipAvN8N2BfKv0dnAtrHyV
 r/naOdRlFB++0oaS0pOmF3r9elHudvvQGFQ1YaCNNy9wgblpV2uY1rWOGWMv+t9S9GJFnz70cL6
 N1Zg0tUxtTyvk83QB/oWT/YMtlGaHA==
X-Proofpoint-GUID: N5Q1zVAlqHOIsiTAnsxT2r7BkCD5uw0P
X-Proofpoint-ORIG-GUID: MPLBTN_jhWxzU3KlOT2xzl11XveEXbMB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

From: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>

The function 'mpc_rcvd_sweep_req(mpcginfo)' is called conditionally
from function 'ctcmpc_unpack_skb'. It frees passed mpcginfo.
After that a call to function 'kfree' in function 'ctcmpc_unpack_skb'
frees it again.

Remove 'kfree' call in function 'mpc_rcvd_sweep_req(mpcginfo)'.

Bug detected by the clang static analyzer.

Fixes: 0c0b20587b9f25a2 ("s390/ctcm: fix potential memory leak")
Reviewed-by: Aswin Karuvally <aswin@linux.ibm.com>
Signed-off-by: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>
---
 drivers/s390/net/ctcm_mpc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 0aeafa772fb1..407b7c516658 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -701,7 +701,6 @@ static void mpc_rcvd_sweep_req(struct mpcg_info *mpcginfo)
 
 	grp->sweep_req_pend_num--;
 	ctcmpc_send_sweep_resp(ch);
-	kfree(mpcginfo);
 	return;
 }
 
-- 
2.48.1


Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HkeXNFRK"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BE21715;
	Thu,  7 Dec 2023 12:24:16 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7J17Pj001079;
	Thu, 7 Dec 2023 20:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=WSu8+CooPg2Ovx5eQ7X0nUx4jDjHPKdceAqnwSTf7hs=;
 b=HkeXNFRKsX0mNWlWO8Xu/o4t0E++toU4XYVLKH6sbjhuS3JUEWi87M1AilCGJYY62ec6
 vF8A6roVIJTcG55h7UGmLS+2ivqJ79k5GPq7671q/At5MnegtQDrP31CLfaicnHXhrTj
 dl4+F9oOT+EW6cZxuibTKpU8HMk1p98SYdM52OB9jwxJgGEOpOwQvwzp36Mg2WKKT/zu
 wMDg7uAraEorsKzFZ8+cusLBHymI7ReaEzhN/zuluU/vTe+ihDXUEraVI9V0ruebUHF+
 tDZ3w2EvXMFtONjW2BTkpY+7VE8Yv6u3LSv2m62VI5QDxrWstaV9MebQZrGxN5iHGGMd Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uukmnhwej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 20:24:07 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7KHoE3009435;
	Thu, 7 Dec 2023 20:24:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uukmnhwdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 20:24:07 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7JWQ6J015423;
	Thu, 7 Dec 2023 20:24:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utavknh42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 20:24:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B7KO27443909826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Dec 2023 20:24:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF0CD20043;
	Thu,  7 Dec 2023 20:24:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4E5E20040;
	Thu,  7 Dec 2023 20:24:01 +0000 (GMT)
Received: from MBP-von-Wenjia.fritz.box.com (unknown [9.171.68.143])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Dec 2023 20:24:01 +0000 (GMT)
From: Wenjia Zhang <wenjia@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Nils Hoppmann <niho@linux.ibm.com>,
        Niklas Schnell <schnelle@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>
Subject: [PATCH net] MAINTAINERS: remove myself as maintainer of SMC
Date: Thu,  7 Dec 2023 21:23:58 +0100
Message-Id: <20231207202358.53502-1-wenjia@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 079KmwIGMNJwqicRGCh5T8PA9sDLYTiO
X-Proofpoint-ORIG-GUID: rerRKfLyGkEP9FuAtAHeGLQp1YcUEJfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_17,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 mlxlogscore=660 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070171

From: Karsten Graul <kgraul@linux.ibm.com>

I changed responsibilities some time ago, its time
to remove myself as maintainer of the SMC component.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6109201e8b4..ddb858576d8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19638,7 +19638,6 @@ S:	Maintained
 F:	drivers/misc/sgi-xp/
 
 SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
-M:	Karsten Graul <kgraul@linux.ibm.com>
 M:	Wenjia Zhang <wenjia@linux.ibm.com>
 M:	Jan Karcher <jaka@linux.ibm.com>
 R:	D. Wythe <alibuda@linux.alibaba.com>
-- 
2.40.1


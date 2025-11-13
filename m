Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD4B2749EA;
	Thu, 13 Nov 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044944; cv=none; b=sqlLImmvXiVZ6jSbYiagoDWDTcYFFEcF2jHaMINvEoh32xW1BJ0T3+yGm/roZjDYvzMSOC6YuOzcITNoUtEcW5+WZLlkKFKSgyAwmR7pMSQ2i4QvC49hqO5brl3uEJ4naA9xLVXw45/uXHxNtbNMzQbMW6Pj++i2s4Jmjx3IZr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044944; c=relaxed/simple;
	bh=huEkxV5+2fCFuRMPqTcXsVbZsXuaGYEsPT8Fk4OWYDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DVIiITyG6r+9T4G4G8Vc0+Axo41zpcyBhkYcARxsLdLfkIVRQdxLejC7+x7JKoGprxPenwGJP0/bDYxKBg6XYtbaOh3/IwtNMrKvXWKdOmsfzk34gIzjHtSzQ5LAo0pkQTPIr8wJ4Nn3k+zj4kUCNYC1igz5Cp5LcBYzbc/A2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YMqk1pCp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YMqk1pCp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD4vnFR015833;
	Thu, 13 Nov 2025 14:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uJbXU7tiKscuYtktNetaVjZzoghsuqPe/TRKHC+FI
	O4=; b=YMqk1pCpUV+vuCZilHAP7MniWdgjRULeH/zAYULASxYN/InFby5cEhL5H
	LojRoOq4i/r3IPutn948E1UZBJb3k0K5AdY2hsEP3iPwxZx2EeSlECiqqUQ0cFsg
	9E1k5ranhLpwA4N/Qt/R5znj+CDdsfXjOiUbmhcaQYVdm72iFJH57PAQzjlnbG8e
	BJhB91C6qouHVjy9kP7qOXfgIPsMy7/Dc+FdYXS2SMNQQMa2rqEgIGuFR9WtsWtX
	r66oa79mz+lw3tDf4kAGDGUAn4E8mkYQzsFAdqpSuvxx5+/YqlC15yyCQMb/WuTd
	s4wO6v7jDd2LsaYLD730OsyZFtguQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m8e325-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 14:42:14 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ADDoLCR030719;
	Thu, 13 Nov 2025 14:42:14 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m8e321-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 14:42:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADDETWe011738;
	Thu, 13 Nov 2025 14:42:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1nyrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 14:42:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADEg9X515335802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 14:42:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8859D20043;
	Thu, 13 Nov 2025 14:42:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BE3120040;
	Thu, 13 Nov 2025 14:42:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 14:42:09 +0000 (GMT)
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
Subject: [PATCH net-next 0/2] s390/qeth: Improve handling of OSA RCs 
Date: Thu, 13 Nov 2025 15:42:07 +0100
Message-ID: <20251113144209.2140061-1-aswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=6915ee46 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=nLSxGV6bqfbj5Y-N57cA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: TRAZSRtniD4UVBzKHou94EWdFYocBU_q
X-Proofpoint-ORIG-GUID: vmA2TdyNMesVf2ME0tLYuoZczLKx4Ye8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfXyxHpAwku/MKt
 UUy55u0RJ1pC+ABZ4s1GHZ/1rw3L9cOZ0dEAx1kI4zxJi5+mMgtB3jfVezTg7/Ske0YrEoqshe3
 uR3CUHhhHtEn8fILCV/1pON32nmD5rkq9XwiERSyc3Iga/kOqf3nrlC6/OQgDJYlWG4qUrmQwDy
 puP14uOUdYZeOyE57blAg5lS04mSQE413WcJ5wgJ15nM/Vtl3u/7vZAIs9IndoA1vcgyQd5b3RX
 KRPnOAbq7Gfx4nII7ICOHqjIqEgWVvWJCs+U5NJgtlFu1EWphKDYx8P6h7223Vv2hfkpCR9spLF
 Oz7UpwsCQnQZV82i7GdcTxn3pa/7bOPKuo4wtoiU/mjIZmuDN/azWgpOdM48Gl2OzdWi/RBJWif
 W4WKzeVVBdzUCv2uWNL5JjAx4MRCPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

This two patch series aims to improve how return codes from OSA Express
are handled in the qeth driver.

OSA defines a number of return codes whose meaning is determined by the
issuing command, ie. they are ambiguous. The first patch moves
definitions of all return codes including the ambiguous ones to a single
enum block to aid readability and maintainability.

The second patch implements a mechanism to interpret return codes based
on the issuing command to ensure accurate debug messages. While at it,
remove extern keyword and fix indentation for function declarations to
be in line with Linux kernel coding style.

Aswin Karuvally (2):
  s390/qeth: Move all OSA RCs to single enum
  s390/qeth: Handle ambiguous OSA RCs in s390dbf

 drivers/s390/net/qeth_core_main.c |   2 +-
 drivers/s390/net/qeth_core_mpc.c  | 247 ++++++++++++++++++++++++------
 drivers/s390/net/qeth_core_mpc.h  |  20 +--
 3 files changed, 210 insertions(+), 59 deletions(-)

-- 
2.48.1


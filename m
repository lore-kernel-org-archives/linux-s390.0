Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F14204F;
	Tue, 25 Jun 2024 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335535; cv=none; b=KHtHY8jm2yYbAD3vQWDJ6oPK7Yvn5YWZ0SXXA7N06KY45DoRYBnPMA1BTw14FeSa9Av+gAh8Vo7BqUd1IuJtdnhGC0Ky/NcoNKAgGYiiiv7CjPLeV2jZCoCD66SVHWKObIJDJIizt6npTUfIaIIcppigD+6I8hHnydDxBvT9Jcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335535; c=relaxed/simple;
	bh=L9blIzOiyOQMTpDtc0cM0yFaL51Q+QqOq8ROY7HPUZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Ik/VEb4KRpPYkLO7y9hNiOyS4L82CKM19riRjNIvop3vB/UYJlFJKHRnhX6kq9hLwZVR72Kool6pObEW8Gfs0ZXzg85nT68RfIIMpHASP/CZzRc4s6a1tGKXgYPzWTG1TgDoRJeoDZx5ly0X2Gw8c6uOMu1RE70I4LaEuNvF368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b0exYH2Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b0exYH2Q"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P8NwEE010135;
	Tue, 25 Jun 2024 16:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nDLEPQk26/RrYJbffeyNSm
	MC9qenZ25ho29a+rIJqt4=; b=b0exYH2QlSnReTMx9flEcz1lpe4/Nb/mt/4/C7
	zzEIn+Fc6rZdMw35az0Kb+0VEVaEEs9zDo4JPOjpNmJC6ombV/VsunKsCCTIUYL1
	wJxq0OUyKFX3KpBYjkHB+D+n7mBq6JiCTb7MuyyUFsWCQzt9vMJd1KsZil63uS+h
	cN4AdahkZQ5Vmr9E2zdhv1lI1STekJ5CNxPB6lZnJ/A36BYFSWK10gHMb/gdAqAl
	6YYIshrrUhp7w83Xygu3RCKoIncudVecu70gPlYGmyQJlycCjqylBJ9WG4T+I5b/
	a6b1MMN/1OS0YRW1d+sdymf3vjkEI7a8HUfS6sr3+kTVXgXQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqcef719-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 16:35:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45PGZgAV031103
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 16:35:42 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 09:35:42 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 25 Jun 2024 09:35:41 -0700
Subject: [PATCH v2] s390/lcs: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240625-md-s390-drivers-s390-net-v2-1-5a8a2b2f2ae3@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANzxemYC/42OTQ6CMBCFr2K6dkzLP668h2FR2kEmkaJTaDCEu
 1vwAi6/5L3vvVV4ZEIvrqdVMAbyNLoIyfkkTK/dA4FsZJHIJJOFymGw4NNagmUKyP4HDicoK13
 LouqUlJmI9RdjR8uhvjeRW+0RWtbO9LvwSW5eYNB+Qt7jPflp5M9xJKi99MdmUKCgLirTlmnel
 dLe3jMZcuZixkE027Z9ASE1DjnhAAAA
To: Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler
	<twinkler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _OpMxqKNziW39itj1NFnZOOpArTyIsFz
X-Proofpoint-ORIG-GUID: _OpMxqKNziW39itj1NFnZOOpArTyIsFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_11,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=946
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250122

With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/net/lcs.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Modified the description (both in the patch and in the file prolog) per
  feedback from Alexandra
- Link to v1: https://lore.kernel.org/r/20240615-md-s390-drivers-s390-net-v1-1-968cb735f70d@quicinc.com
---
 drivers/s390/net/lcs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 25d4e6376591..88db8378325a 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- *  Linux for S/390 Lan Channel Station Network Driver
+ *  Linux for S/390 LAN channel station device driver
  *
  *  Copyright IBM Corp. 1999, 2009
  *  Author(s): Original Code written by
@@ -2380,5 +2380,6 @@ module_init(lcs_init_module);
 module_exit(lcs_cleanup_module);
 
 MODULE_AUTHOR("Frank Pavlic <fpavlic@de.ibm.com>");
+MODULE_DESCRIPTION("S/390 LAN channel station device driver");
 MODULE_LICENSE("GPL");
 

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240615-md-s390-drivers-s390-net-78a9068f1004


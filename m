Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9032D8390;
	Tue, 25 Nov 2025 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061124; cv=none; b=qVsjNuLxJQf4mPsF83Anh3NGRWfQwqp1btK5a7H23hDn/i9j/vWfvsbnQg+pNB7nAFfgLjXHpzJFuNR0m76sdLjb24cHN/19hV9USzj4YK+yhzbBmWDfOrkgOLzkMhVS1Qe1kIHKQs+FRx8GgbSr6Kat3NEOkohkok9o7KJf6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061124; c=relaxed/simple;
	bh=Ai76bSkgAlu/UMyz0v5v1ss1ZrkllOwqTXFh5an/2DE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6vyo0gcsjpsnzk4T4iNGiuuSiOUhBhT44m3/pObFAI9Qlh6KgIWHcldXdFZcjMWbXwXtuoMuzsQXdSCKjCn2iJ7S30F1kyXrrpdBGiT1MeeHRQUD2FLPepruwlKo2fwtMV9t1pgTXH0UySIBMTewCHObT3EoTU2cy4dwon6o4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gJOBpPeY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gJOBpPeY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOJibsk021415;
	Tue, 25 Nov 2025 08:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uRdlDVAlpO+TLEQcPq9QlLbXuvmg2frNS7o517UZs
	fQ=; b=gJOBpPeYrNXHo0NaQFl1AcGVrE+Qsa2M2tMH/UY8u2rEQ5QQNc8UDsDKb
	DjbXrEnpQXI+ElE2BSIWz7dPMES9SzQ7a2bFA0ptIOvoWosel8asnE54sWs9ZtF0
	bB4rCWEgB0Y7yUnngt9hKY4w+EpzurxyZXhBaWxW9UYCfHCWWZgEStOh/0MlpdAX
	BnHO4wqE5ThMHAht9I3dwvBvOW8FtnHiD5iIeUfsi4CSZsBOkIynvcbiRav00hW1
	Tcj8X0CpL+ptkvQIMqU64Hi924/pgvZHMHsytsrxFsFue+J+1JtlrrVU8B2Eohts
	Rcd0kwDxBYDVyp1eHQvHHjSX0lMMg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kpv116-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 08:58:35 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AP8coPa028597;
	Tue, 25 Nov 2025 08:58:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kpv112-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 08:58:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP73RWX019010;
	Tue, 25 Nov 2025 08:58:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aksqjjea8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 08:58:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AP8wU0157344286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 08:58:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14B022004B;
	Tue, 25 Nov 2025 08:58:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03B2C20043;
	Tue, 25 Nov 2025 08:58:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Nov 2025 08:58:29 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id CDA69E096C; Tue, 25 Nov 2025 09:58:29 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] s390/net: list Aswin Karuvally as maintainer
Date: Tue, 25 Nov 2025 09:58:29 +0100
Message-ID: <20251125085829.3679506-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwMCBTYWx0ZWRfX2kOjkca2maz6
 W65b3Vkb4XKOISWY3c/BT17IREtufBQnh7e41D9d/5Jslt+X0whXvOH/Wh3fiIYFj0oYAEnEtob
 YooC3yLPr0O1vF0J+sAIHWmJJmleq6xik7NEihLAVbsR7DfLsVo8fCI9HEIP+yi27axovGElX8q
 RR+S8kxdwORRfU32yslvOsb4HTM8wNoqT0etLj9mWIzfBHBOlnWDjISNB2Q2yalPJx2OJMPFxBt
 NiZrr1K/AOEh9UOD+POI9EOzzexznNoc9SD1xGBAfTsy7XR7GXx9UFwZZKPIkr1c39jlBCDlLqH
 d9MV2cGu7K8VX69ESj32mxWihYIyu6OPQec0nt05JRaDIkLjSP7f6OL0SPK9s5rgQZqiybdvjlV
 IhRsxwdatRQomPILQ5f5du084XL9Qw==
X-Authority-Analysis: v=2.4 cv=fJM0HJae c=1 sm=1 tr=0 ts=69256fbb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=c18PVjXdg6hYHKaeyskA:9
X-Proofpoint-GUID: hswxEebVJGQwJg10HWdFyeEqqbKvpnTI
X-Proofpoint-ORIG-GUID: TqVcwEsQN_5NQfISoHLmonv4FrbzYof5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220000

Thank you Aswin for taking this responsibility.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Acked-by: Aswin Karuvally <aswin@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9a8d945632b..012861995939 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22672,7 +22672,7 @@ F:	arch/s390/mm
 
 S390 NETWORK DRIVERS
 M:	Alexandra Winter <wintera@linux.ibm.com>
-R:	Aswin Karuvally <aswin@linux.ibm.com>
+M:	Aswin Karuvally <aswin@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.48.1


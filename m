Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347661DE2CF;
	Tue, 17 Jun 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168252; cv=none; b=JY1lWvF+8Au+RVCWQMw00WX+dZDL5NoFUlef5yRodszntwdxsMgdyyL9THlYwGFTAE+eTZIOjN2t6cJgh/po/KzMs0XOqaLnjVpR1i21G0RVOympV5m8XSDLD4trM0KCk3OXEbKtatfrNr6HdiBnTSwSpgJyIR9Ug8Am6Luj3T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168252; c=relaxed/simple;
	bh=Z2pUNZV7ejqeMoUK9N+A8VOh/Mc3PC2hOjG0koOyeX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBakJvMQFLTckQXfMd9Ip659My3cugSfdmtTSZ8EWQPLxmbXnAiSFqEFIAJc9V06sSenXmgb+yuwUaUrU5Sdcn3Fe1OynFq9OvQwN5uX2jqgtMmaKCfJyU2Yz3Rc9p6FvM3nCDMXns8SJgp++OA4mPbhKIYYwQ0pYjY1yGPm/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S0BlEGlF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S0BlEGlF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HAn6v2013475;
	Tue, 17 Jun 2025 13:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=brzwTQBukgwH38K5nXiOxo3rws5TNPpiceRr0jglg
	CM=; b=S0BlEGlFdHCw2jKI07A7TnpNY60+vIpRCo5mQa2qwZxYf6IEm8+GblUwa
	YasRr8PJDc9OzvDtEqAPSRZOMHVNgQfNvz7Et23sGuUn62lJcXtMomC5Fa3yxj9o
	MfksI0F8A3hWzFtqVXxqV5SVnaAIg8Sc9sxmXuWgDGu20fqbFXpMXjzTsbN5qryN
	ut1gnol/P7yvipFXjKb+K6t2HwtwR2O4+bHP9g0mgxnUoc2LQuIsXwDFjrIum1Pr
	U/M7R526kmOcIQQTjhISrKezHgK2Fk1UZBtw4qlH9jSS6u1fXYo5IFc23rz0qM6+
	R+4UBuS4zJZsxfMBreHrxqO90uWaA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r20806-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 13:50:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55HBu4Yh027463;
	Tue, 17 Jun 2025 13:50:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479ksyuvu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 13:50:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55HDohM052232626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 13:50:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 679EB20040;
	Tue, 17 Jun 2025 13:50:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11C032004B;
	Tue, 17 Jun 2025 13:50:43 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Jun 2025 13:50:43 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/2] bugs/s390: Fix compile error with old gcc versions
Date: Tue, 17 Jun 2025 15:50:40 +0200
Message-ID: <20250617135042.1878068-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r9F1hEPrStcqjl0Wv6y7QvyjXIPIqyv5
X-Proofpoint-ORIG-GUID: r9F1hEPrStcqjl0Wv6y7QvyjXIPIqyv5
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=685172b8 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=6IFa9wvqVegA:10 a=mjnkfGu_it_hZ3drrnIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDEwNyBTYWx0ZWRfXzPi+Y4C4Gv6B jqk7qlrDqyqZyEZJWh/27zyzpIjnH7eJAi8DSui/bHsEvPPqvH6hTH8owYN5GIrAmVhgRnWUVwS jrxS8NDykGkfoFdGYz0MBTZbmEpU/AxxDH2BABF9I92y304fKXcPvoAi1JL4qaWDIeE0hADekFV
 hrDaCGGziomm3iwYMkD7Vai8rxs2ntCIFi+Xf89bEtf1upl3F9DoCR/lqNAUOLFOTVglBiZgjOL SdB0X8YK3GQWabng8JLnQdEgdjxpgDWVJ/HjWAUbVxtFtaF+grWAPqmeqdNj+M//LB0oA2McjtZ Mm+1h3abT3KoRTRA4TswM/rrEeFGsNxQacR+wJJGvQ+XUPnvzE1pqf1+9S9wqZCbiq9ckv+vn15
 4oqbm+63qcHeMwc3XrrIozAAQW6uvUfrCR5Utwa/9ogB6np8QsKkIDNp6V30El0c6HqNBNCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=825 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170107

As reported by Naresh and Anders old gcc variants cannot handle
strings as input operands for inline assemblies. Rewrite the s390
generic bug support very similar to arm64 and loongarch to fix this.

Also use the opportunity to drop the rather pointless s390 specific
WARN_ON() implementation.

Ingo, I think the two patches should also go via the core/bugs branch
of the tip repository.

Thanks,
Heiko

Heiko Carstens (2):
  bugs/s390: Remove private WARN_ON() implementation
  bugs/s390: Use inline assembly without input operands

 arch/s390/include/asm/bug.h | 94 ++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 53 deletions(-)

-- 
2.48.1


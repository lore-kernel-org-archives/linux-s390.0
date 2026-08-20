Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D63793CE
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241011; cv=none; b=AxYJZQ/Lk3Sl6focRXYEqh1/jNOTWECyC3Fe514J/QuTUtzgvs5PlDmQVfmSCaS5gh87d8lLqiPgOwceVGorzkYhzddUCwh7gpdTsBC8a7Bi7ljla2JmJAWfanoAYrjdhl9LOyOkyT7Bach/UWDBIyffGNEvAgNbnkrlh3i4L74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241011; c=relaxed/simple;
	bh=N2w9hBbdHSdHNBJuXf/PLoutU2rt/nztOB8UsGIgLIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjJkF9YjbLNCJkYDDdMuyNjd2wNzkkJ0Uv6UXK/FBy5glZJkk1qpl/Hzu7wKBhl0lkQVCaUaV72lYCXEkIHmiYmFBCtBubdc5QkuC7M1NHBUSFItDGuNieuFcZRU9iv+6onTSQqxTQxtIbS/23onOkSFSO2tVlEf2s/QCVUDZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HiUt88jN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HiUt88jN"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KEVfMa1618845
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pshriybAZbe8nxpx1La0yf4rYFsux+ZQXQQ5NGwMS
	/w=; b=HiUt88jNE1dTSGKrwK4rXmWrLmJvVkwlKFffNSB0n4UWt/khS9ic90nSl
	t4lTHG2hdNypVfb4PSIBFfOXN2wjXsxDLu63+ocU77iJCa6mAIVbuyI27fQEFq6k
	7N+aRPHAxw2cCIwDj/qyKMNwj6etzkAvciHJtwo6L3MJ7RXBh2GBve0+A8NsoWRo
	RzGBrO1LAi0ci93vW3Ijmbou8D3cgatUqSYWgo/AvgHaAZmtr0ruAhgOq3YWtmS9
	+3i9pyoe2LBYJnjqC37C8aeqgE5FiOB3Wmv6LaYq/xqOZLfQehUNGZBOgCnTjAGN
	RZArIrYly+BHKQENT+hiUir765lGg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2b84u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:50:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KFfHLr026993
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:50:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhfcbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:50:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KFo42r41419146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 15:50:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED0FC20043;
	Thu, 20 Aug 2026 15:50:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3B9320040;
	Thu, 20 Aug 2026 15:50:03 +0000 (GMT)
Received: from ibm.com (unknown [9.224.91.220])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 15:50:03 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>
Subject: [PATCH v2 0/1] s390/zcrypt: Validate length information in reply
Date: Thu, 20 Aug 2026 17:50:02 +0200
Message-ID: <20260820155003.945837-1-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a872230 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=3FdhuFNONZsipLxNYqAA:9
X-Proofpoint-GUID: Sf94reO3QPUtLxch_o5Mb0GCeUdAKYJ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDExNyBTYWx0ZWRfX5DvLeVRxjTRE
 T0B9oQLBqPOLG/zUwutbeulQm7UqKSGikJR550s8Z1IsVo/QAXAxSN3kRLIjszMaJoi71/+kZcf
 e5ViHRKkU08Y94aQ1AhhJfaFkpdOHAH8RxFhkF8kSkV6dOihh0P5f6ZrOz7IRCXGt1LAPDZ2NN2
 4oDSCquPOjRvJImjyDD3Ksyf5rfHL0Sf9Wh7kzn9qXlRUjI5Wlh+8mjX9bcJlTGBPFGJgvQEkgF
 6BB/epTkZudhmFi2MStH7YbSanOeQATBCFvEI+6ONEm02jN2sbx4NywdGXdUoDdydZOcerL61pq
 zayBsvRBMMUa92ekNduMk2PKb6ivanghHg2ABb3UYnCETP/Ew3gK1GwRJ85RDsQAxyLsNEnbZdJ
 kz9a9HvceAYSEj5ru47BW9Xp3O6mx5vFi8M2Em0XPhQTKmVGjInFuyJ+SFXqaatguC8VAijXEdJ
 hRb1hjV6rhpoHFchmyA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDExNyBTYWx0ZWRfX8ayHHQc5U2q5
 tutgY3TaTXsxf73359GQn9+R4XxtXhbrT0kzOBFXShlZD5BtvXUZWQs+SgMZDqErGV9Yk+CDtOp
 jDmdUD47sbgS6vrgqEhDQ+Yh6pIXSNA=
X-Proofpoint-ORIG-GUID: Sf94reO3QPUtLxch_o5Mb0GCeUdAKYJ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200117

This series contains adds validation of a length information in a
hardware reply, to prevent buffer over-read/over-write in case of a
broken/modified replies.

Changes since v1:
- fix subject line in cover-letter
- fix typo
- pick R-b

This series applies on-top of Linus' master branch.

Holger Dengler (1):
  s390/zcrypt: Validate length in reply before using it

 drivers/s390/crypto/zcrypt_ccamisc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)


base-commit: 59e6295fac26b8e85c1ea859cdd89fa1e47519d7
-- 
2.55.0


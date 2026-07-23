Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C292D42FCCC
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800500; cv=none; b=IiKSIjo3+kIN9yF020qHtOC8kWdgxP2QBYjIX2wfy7Yb/u7JzihfBk9q+f8EhjaY06s9qRYwCdBCm/3X3/w2CNzoGxvUhpEdUm1f5N5Ss9yx8n5uW3Z+tD4ns0sQLcbfTRfVJnzdaRqGTBcTzIGQTSbmKt/peWnDSn3l5tmt3/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800500; c=relaxed/simple;
	bh=Dyeiw5Lk1AlxmTHX3IaqTiBS+n7g/RgcotLZ8MTnb5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lI1osxGzNz8Mk8MhgJaNU9mCmRK9wD1m2JrmccmWv8ZoC17fiGjXx1bCu74+tyC9pYwh0cn/Al4CN3GZyEG865wMY57QVc4jL4tNkrTih3XR+40KZIMuBqq9aF8QsDKVO0ZGALBo4KtNm63F0RiBGD25+QAsGSPX1yPUleZQBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QkZd/2ot; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QkZd/2ot"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9BtHD701585
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WsjrM0PJCthZqBR29U6+Sw4MIUJsIn/jx0cF+OvyZ
	Bo=; b=QkZd/2ot8SvaJV3nT6qSD+5xUBaXrO2My+L2aKYrM18BlrQ/Y9LTxoJBP
	4XgFwRJj6+Dk9jAjYd/ss1NR/F5ePMPEgqoGr5CbqSB4T6T89mfa7kBsxnWF1zph
	hyD72881coC+zyFRRlM3GqG9QOC7Ibazg29Wy+O2Va0gaiKbM32Mvulu5Pqddtck
	ePj9BMheuyZ7q1NhuMV36T3WBcPfMBW9abt09WcB8jcZevWs1eJrZG7X1Ma+vWXQ
	Dt3WCwacYORGxldbCS6j3V/aix1RNvviPuho3BLAzHL131aHKw3QZChLAjxRlhXa
	4s6/cT7rxkdXPnPrv4AaEMStkq3aw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77apv9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N9ncnG014806
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqbr01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N9srcs42729932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 09:54:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17B4D200F5;
	Thu, 23 Jul 2026 09:54:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0618200F4;
	Thu, 23 Jul 2026 09:54:52 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.142.235])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 09:54:52 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v3 0/2] Fixes related to domain access and verification
Date: Thu, 23 Jul 2026 11:54:51 +0200
Message-ID: <20260723095453.127322-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4NO3yhRwkHLqpX--IsZiiZ55GUHX-mAQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5NiBTYWx0ZWRfX2XcKP5x3tp6+
 rT+JFOFmkvsOjVJ8cKm1qmWKbL7xBSuyH8RM2+DMgr2dsTavU5R3QW0gMNi7LFEr6ogEKYGt/4X
 5fPzs1YQyR0CtzgTl9jz/pQ+O/KY3CM=
X-Proofpoint-GUID: 4NO3yhRwkHLqpX--IsZiiZ55GUHX-mAQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5NiBTYWx0ZWRfX57fETmGGvwmm
 azOpvMEr+yKWxWDQnyKFtJr00PA971m4/ufSfq20Ri194inzWGU19mF2wUAA9XSg08UVrcKIchF
 3LMwFYm6eNG+pulvpoDMBkA5iQwV0cdh6rQrSaqf4Ex5xjVoqXKse3EmHV8Sy85GkjR2Fs5hpIv
 vlV3Xmdo8hUinsiS9sVrCKZ8bu/tn37J3vhFmYufB1PHzqS/Mfw9S6pmpR6uY9PQi5xZ12hhkXS
 qqO4U3drkV+N4s+5lNaPUsCzOmOBtFFO/8fdxiSG5CiCnhae3WnTo1iemEPrKg1V9qZPbkniSOQ
 YrsIsJxV7pCugApXUUoTHmFRJJMvHPRG00RjWtWa/uFcQuA7OcoYrscFYpcyLzv6Apg9ZYRsdRN
 hUNVwVYi9DQHH4sCkGA4ozl0n6vgp9zHgO6r5CELqHOxwerq3Ass1LtcRBZGzkJqh33ZKT/6kuz
 Ge1CqpHoxU+Nt+6nNLQ==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a61e4f1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=-XbRBucOWa8m9vkr4cQA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230096

This is now a combination of the two patch series
"Fix wrong domain value verification with EP11 cards" and
"Close speculative mem read possibility" as there is some
code dependency between the patches.

Changelog for "Fix wrong domain value verification with EP11 cards"

v1: initial version
v2: Resend without any code changes, just Finn's reviewed by added.

Changelog for "Close speculative mem read possibility"

v1: initial version
v2: Resend without any code changes, just Finn's reviewed by added.

Changelog for v3 and further:

v3: Resent without any changes, just this time as a 2-patches series.

Harald Freudenberger (2):
  s390/zcrypt: Fix wrong domain value verification with EP11 CPRBs
  s390/zcrypt: Close speculative mem read possibility

 drivers/s390/crypto/zcrypt_api.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--
2.43.0


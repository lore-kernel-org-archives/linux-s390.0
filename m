Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D883655C7
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823046; cv=none; b=dMEmbK/SXvCr4oD4shs7QlOLMrE4HcMBXztgp53P0V2p8iYQmwJARzLAYD4U53xa/QmfIMzQm+yDUmyo4tKAN0DV6iTW9li67I6rrHNrWM7JY/XFu7YyoId/uqLcriC3ffIMXajVHo6pJWYmhuexdBx2ooFAMedf0gGop08GnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823046; c=relaxed/simple;
	bh=rR7nYD7l1R6QypyGcC9upx9y3XuMvsDbpATmqOAewPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h8a4a6JWO1b3GSn7Jkv+wYV3CTA9j67iD7DedHPMg5demUWfJTtx+eF8FIDiWF222tz0ah8XeFJqew7e8eRfQa9UVALmFdKGxqEInX8v8wuCneMztMYks9IhVUSrU0JNOQp2oRRaOwRMRupRBLOEgGoUf5gQSeLKTFRCRH1BBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IugLtafj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IugLtafj"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBgaI3106137
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vDAp8p5ULRnyvslm+ezYKLsnUsvRHq6RurbGPM1m9
	Xk=; b=IugLtafjBYDdV5f5U/csrUnJL88FXpJqwk22dNZvvyNOQb6fHAOth9Eqq
	IKixzvZ8+xwK9pyalCt6EWppsjWQRkpqDPjtByCdjduQzOcILrlwMETs8wDTyCrM
	m15V79D89V6J83zx48jSaZKJJ1/azEedWHTWaN1g6uDs6g9cBy1B8xaitDQ+238n
	952wy11dDYZi7gigWMCz0Alh9vtUxHWZYWf2CZ1QylXHZBAOizi03k516Do1ffCI
	SkCYpso+keQ4KlfL4ApdkMbljEab3w5eA3VXlZBRjHJEfRDAvVhxw1sUz9GUDddP
	nb8tPuEHRXrl3VZdlaCUOCCZGyk8g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7918fjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:10:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NG4fcg013820
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:10:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqd4kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:10:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NGAbD248955820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 16:10:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A09E20198;
	Thu, 23 Jul 2026 16:10:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 522E120197;
	Thu, 23 Jul 2026 16:10:37 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.142.235])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 16:10:37 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v1 0/1] Improve code in zcrypt msg type 6 handling
Date: Thu, 23 Jul 2026 18:10:36 +0200
Message-ID: <20260723161037.133395-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aLIiyhWgggZpV5L2nIYIJM1ke3GHO0C6
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a623d02 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=lBdAcpDw1wAZ-li3s1EA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE1NSBTYWx0ZWRfX3zjDwR5Mq5+X
 8Wi7Bj90BDdUSVcZ7KP3TThofGnhrbgGV4WuNxy29RKTgncq4JWti16D+pXd3cWAtexSd3kXjze
 500LnNIvgy7wHJnjcX3lQdxXK/5idDc=
X-Proofpoint-GUID: aLIiyhWgggZpV5L2nIYIJM1ke3GHO0C6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE1NSBTYWx0ZWRfX6PtwAkGdcYzv
 w6KkwH/DhNxKXXcxgs2bfI1gBANz32B6Xl04XFrZeC/9k2xXiEj684YltXUKnqLg7sm+M7xxMS0
 a9ypBzgSyls1ZYvMpjDBs3B0z+s3hJHStd8qHvN8JhyFJZ2nHf5CfeP/sW0mxWi6gHVu3mXobEk
 OCZpKhpCi1EIOE4TSbGY0iLWwsH/QXuU1yBAmPDRYWLF27ZcC1WqBXCujM+csTH/YOIyGjL7plG
 LLNK4TTjNMkpzRhpwbrgIlN+W0QTUHj8LpHNlZwA0n0P+t10Qroe+qFJyZ9WWkfQW5Ru9ey07TT
 +tt+4CV2GqkZo/q1yP2PckuN1onT3Fqmfs7QVvqZAJYfTdEPKkexygxt7CNoakFvEOxIJ8MQIBe
 /VKxUVwJet/iHeAnTO3ne0suu2NiSepCB9NlMpgDbtmAFF0bcC7xs/Zwje88Q0SuWe6uGtQ80JK
 o8+OFGohxJJV55OD1bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230155

Changelog:

v1: initial version, one patch dealing with overflow checks around
    the use of the CEIL4 macro in zcrypt_msgtype6.c

Harald Freudenberger (1):
  s390/zcrypt: Improve length check and overflow detection at zcrypt msg
    type 6

 drivers/s390/crypto/zcrypt_msgtype6.c | 84 ++++++++++++++-------------
 1 file changed, 45 insertions(+), 39 deletions(-)

--
2.43.0


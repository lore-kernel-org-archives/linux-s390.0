Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB203546FE
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730594; cv=none; b=sblBg1IvAAa6K1jZ7okS7rvFQ0/sBcky3rVWlgHHLu1QnfnrfTpocva9vOXN2a/qjEHzGnYS0Znv0tHxgUKBJIxQDG4U6agtg7F0dtae2dtlH53oLgRGToXW5no+ZpAUA83egMMEfp0I32bL2vx7XvuErpFDMxcPVUTXXAyK2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730594; c=relaxed/simple;
	bh=h7vnZbJzpe5r+VrJHTG3B3lUShTOws0UyaWhKdVqX9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JpqiOTEIips6qc0p5jreHX9huty0NUeB60DLND0iE9YBK8sJG1b4cqiLJTg0zhMpZQIY2ZNApZoVzj5NtRawpoT8CjvtveIKFdolZocOPyHZzIeijnT0ycDlwFKdxLw+oUS5YJS0/O96OOaZnZPIU1yoR1wblqDks2nPJ2iJWz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pZJi/gMU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pZJi/gMU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDfq83095181
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=duinTIDWf5+IKdikS6y7rWgtcRWdPwJT/TXBQgbtE
	zQ=; b=pZJi/gMUii/p4CDg0vcFZGDPVnDQmJ2pCj2LMJVAkqAahc5KevFeXYZcC
	LfMhw3w8HBroYSdRztf8+17xy3SvHS2SSj1tvi132yG2Nk3+mJN9JjF0+GLxlS2Z
	dRJSLt0GRpNK2It9/kV97WSReLgNVvDq9srtKpoHBAlG9D9lTdWKoZSvt5MGRxa7
	ahsXvfWJ/lNpX74HW7CP+qsPdSPjvuxFZZbwFaW302IB7dGfdL6wNqUzTLnnVKth
	qyKJ6nIJcJv705gOVbpY3CaI3oY6W/5vi1C6kEhxhYKeTCj7ErCn45QriDuHyiPJ
	QAokUAM83NMI/i6LIyNe/2L+sv26A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7aha68h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:29:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MEJaVD024013
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:29:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyfe2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:29:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66METkCW51577228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 14:29:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A19992004E;
	Wed, 22 Jul 2026 14:29:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 851CD20043;
	Wed, 22 Jul 2026 14:29:46 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.200.113])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 14:29:46 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v5 0/1] Rework pkey ioctl functions error paths
Date: Wed, 22 Jul 2026 16:29:46 +0200
Message-ID: <20260722142947.109588-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gl878dm0p2LUaHVpjdkPWCsXfGSQgOJc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzOSBTYWx0ZWRfX9nmwMU2pseDb
 xGtQNAJBx9IYmwjB6zOBJafEpWKkgEwDQEvfXSoNZ8Vc9XQR9nSW8v0DGhS5LDJDQSz359uHkR2
 a7I2IGHSLGuQ0J3k9E5SD2XZZ7Cfsy0abQORmgvd/w54qgAKv4y6cz5nL8xGVsDJH4PkdReoFQl
 K6WhfKZorEq1YvLQdRqEpV1lMyRO5s3WW/rrXnNsrYUFfqNoq6rV0xIDXNLQo1SCx/59Sr5r+Lm
 2yuyXHxN6gGb4iKG+yiFAPiI1UmEi0W80sEIlwUGAi2WInnXTVM9zFiVZIAx9e8MSA9r3GER6nD
 vnFSnsn+vc6NNluApOCIrPmx3u5ZE4r2+67x12h6ziII53v1uXUUI7wJLMLR7HNm4J7SNTRpZyV
 PZ111mc7GPKQdXBiFJR78X2eR5XlYIJqpTxOHti3uA/xr81E3c0tDLQwpHx+fHuE7Y/COtJXZho
 GtiXyDFMyH0fgC/Pw/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzOSBTYWx0ZWRfX4/3ycX/tM13d
 tX/Sp75/R24snpIJRRE1o+rAP5WK8QbdEQcdTdQG0+8KBeOI/TGuKhohDMe8V7F3qMhsivXDLvv
 vK0AKNMmZHPoZ1LRnzcTQ1NrdQda14A=
X-Proofpoint-GUID: gl878dm0p2LUaHVpjdkPWCsXfGSQgOJc
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a60d3df cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=yKOuWFisgHkgl6CRz08A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220139

Slight rework for all the pkey ioctl functions, especially related to
the error paths with regard to free memory. This patch removes all
this duplicated code and introduces one code block at the end of the
functions which is jumped into via goto out or executed on regular
exit.

Changelog:
v1 - first version
v2 - just a rebase of the v1 patch as the original patch did not apply
     any more.
v3 - Fix paths where a error ptr returned from a helper function may
     be used as input for kfree(). Fixed typo pathes -> paths
v4 - Added yet another slight rework covering the possible use of an
     uninitialized variable in an error path.
v5 - Resend without any code changes, just Finn's reviewed by added.

Harald Freudenberger (1):
  s390/pkey: Rework ioctl functions error paths

 drivers/s390/crypto/pkey_api.c | 288 ++++++++++++++++++---------------
 1 file changed, 157 insertions(+), 131 deletions(-)

--
2.43.0


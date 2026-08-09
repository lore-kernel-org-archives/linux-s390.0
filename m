Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7AE395AD2;
	Sun,  9 Aug 2026 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786274700; cv=none; b=EN/y/Op9h+GH5Gb1owY10zgFHoHJMALMJXTrQ5kqRewgi4lM5bgMS3dD6iAgPMCAHI8qCXGYTN+dTgjF0OYlsqPqCT2/3J2tjlE1+F11KPPWosi0U6XXK/f6hr7H7s130o8elNXvhY7C5Eud1eUCCNnbwdmhDP2Po38VG+VcY0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786274700; c=relaxed/simple;
	bh=z9Jp+XNZA/E/SHiRkNqx2TNfuPhxxykioIKeCF7dHgg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CaGF8N4X86Z8zTm+IQ5o/7hOi3AzLxLbDszSgp85vKG4bDEaxjAe2SPSW3fUXhkRqJ2fVahOWJZSGHid4+rynycvDh/NYtA4PsuhasO0XR2mf4Lx8imQwbrLtuq+dKIMZUJXsjfZN6Y3G3H7SC1NGQ9Re2hgteeIBlgQeE6cDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gcSa/csA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gcSa/csA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67991c0o2574318;
	Sun, 9 Aug 2026 11:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=//6hki4PQOtmJYf99mlpfiaXOOCRA4PhZF5EBpPYddY=; b=gcSa/csA
	NQKKEc/QFE8KDOAlTNdaS+WhZNVUY14bDD+HnE50YTWjiLKYDBhqSOtNOUkWuURA
	9uM8rnGIKQ5avxRqiL1xG7I+XO+UJA0kmOYjnqmyZaG/ca7YqFEpLRx/ojYKtY30
	npXkIdLK+MdgJ8mQsJfreC5E96dmUCjVthExHwjHkvK4EKgmwkWal5Ym/J58Qz2m
	vW7C9l+o3BCPl/mD7wLlv+5G9ghLCqiJjJKsAc7FswOeCv5Le39TC3e+lyqkIrbd
	VxhByTsi6fOJcfca/xNvPO7JGx6+pyCK8ontXQtI+GbyTDEkDApNhB54TODwrDMp
	cKLL3DuPh6Sy9g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9c22h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 11:24:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 679BBKdp027234;
	Sun, 9 Aug 2026 11:24:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g10p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 11:24:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679BOqGr51642684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 11:24:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22E0320043;
	Sun,  9 Aug 2026 11:24:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC23F20040;
	Sun,  9 Aug 2026 11:24:51 +0000 (GMT)
Received: from localhost (unknown [9.111.52.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  9 Aug 2026 11:24:51 +0000 (GMT)
Date: Sun, 9 Aug 2026 13:24:50 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.2-rc7
Message-ID: <ttji2de@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA5OCBTYWx0ZWRfX06T//WkrhTNh
 ncbHQqaiLo4cYIIdIqN1ZhLZkVoGtryH7btqy3lK5312+8DE2zReyGOI9XnxjcDaicgfWnf1bII
 1o2BXovae+0D/OcPfMExE3IGoWBhWlK0h4rkxVryMv3YJGiwPi/l3TDvcqmbaF6cSFmXoF9o2CY
 5f6aL5WbhLGsqbfMTTZfVZMfdR2HGxbav85o3PIkBm/UtQmSn+qYGGz6DhCDqnoqbFkbxisCQ/G
 HDlKOqGQ5E8BfsZ37wn1Mv8M0WVansUvfvixvte8mGjhCwaP/z/EGwCsjwHMPdd7FO8rX78/y23
 mmWL8mdyumdIDUwKrBhGMEW74Kqke0vFvcWpmIJ3g4DFBxJbJWdfYk024wEz1uQLZtF6HftHnsA
 O8mZbTfMYaBTSRho4XrH93Q2luKqbWELWCuL02DBqtG+Z+lnN/rO3mQlvmQ/8liPEwVjooWEqTw
 J6Ae2Gy5K3nEnRESNGQ==
X-Proofpoint-ORIG-GUID: _DVpEHBUHx7dGYWDAjmoVK_PEK-FB87U
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA5OCBTYWx0ZWRfX2w5xzQWCMlb4
 DSP+PAOerqjhLXMSsoZiqqOW9WpS5uc3Qm1QJwH4K2oXY6BFlPkUtrmmm1Fcizst8CK8LdOL7QI
 mJ7PJlfHUyanVb5WXIBRx9lxew5W2Oo=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a786388 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=qZIf2KWm-9LE-mVuogAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _DVpEHBUHx7dGYWDAjmoVK_PEK-FB87U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090098

Hello Linus,

please pull s390 fixes for 7.2-rc7.

Thank you,
Vasily

The following changes since commit 01476391aecef36a3b789ee844357b22fbc90665:

  s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey() (2026-07-31 13:31:20 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-7

for you to fetch changes up to eb363254472493e3458156fc11fd56dca92f4333:

  s390/zcrypt: Pad trailing CCA or EP11 message with zeros (2026-08-05 15:12:22 +0200)

----------------------------------------------------------------
s390 updates for 7.2-rc7

- Fix potential uninitialized memory reads and buffer overflows from
  malformed zcrypt CCA and EP11 requests by properly validating lengths
  and payloads

- Fix possible out of bounds accesses in zcrypt EP11 domain handling by
  replacing fixed payload layout assumptions with parsing ASN.1 fields
  with bounds checks

- Fix zcrypt CCA and EP11 request and reply buffer allocations missing
  required 4-byte padding, and scrub the full allocation on release

- Fix zcrypt CCA and EP11 messages leaking up to 3 uninitialized bytes
  of memory by zeroing trailing alignment padding

----------------------------------------------------------------
Harald Freudenberger (5):
      s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
      s390/zcrypt: Improve CCA CPRB length and overflow checks
      s390/zcrypt: Improve EP11 CPRB length and overflow checks
      s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
      s390/zcrypt: Pad trailing CCA or EP11 message with zeros

 drivers/s390/crypto/zcrypt_ccamisc.c  |  20 +-
 drivers/s390/crypto/zcrypt_ep11misc.c |  16 +-
 drivers/s390/crypto/zcrypt_msgtype6.c | 364 +++++++++++++++++++++++-----------
 3 files changed, 277 insertions(+), 123 deletions(-)

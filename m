Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A33101F2;
	Tue, 16 Sep 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030492; cv=none; b=s59/a7GDz4zVbwVvD2u30DcU4IUGibU9dL1De1dJfAnt/wL+L7jUJWKLOjyW77eElUb7ceBUg1JRfpM84JSKYaZbLLAiL6SgSHQ96KeE1XcgU2w1NOJp/a+5WeiOjmyF4Zs0OEzsC7Rh9MUKdrHOKvfkX7kM0JdrokEV4YckhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030492; c=relaxed/simple;
	bh=hyuKb6rkQURLOfxtkeFWXUDdUhfYigc2HSrSLSq7jaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VS/E8YFf0VKOq5v55PyGCAbj/a3JQB025+oKVhcp6unJKld63Kjm5DZCNNVfzchaxNUzD1dwJaFJrConao7ouTqgXgyN9DQenADUYtF5oUa9eBkdEk+CnXFm8Ap8lIzFEHrqt5u/+e0FDZbz/n/Zg1iL/uf1J9sYtUMUbPFltFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gWzSaSOK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gWzSaSOK"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G7GL1v020054;
	Tue, 16 Sep 2025 13:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZJqOdMzCpzPDq3m56tecE9bqsioz+tE7IPA7wHqNm
	VU=; b=gWzSaSOKWiMC0SCFLSCHjAuOY8Fgn9qYS7w5sxp7gCX2NID6vLuSdL6DK
	IfKbIgn+cQzFYZyzc+l97TO5UNklgrUv3zKwWo7A1YU2MaGIRVHRNil/nN54hmRG
	yPbSkLrk8ratI10PnUqgDpSYgNKI1wuvKAyVtABz9mvvg8ecgBL3r7CVEuwEXQwY
	glapCwljmaSOLYVgi7GRXvRL3XNA5/9uV7IsUFAZkR96/ENpgsvyTpV1LilwK3EG
	xux7Lfo/iLrG9Gg2DvQYCHvfMhfruhiRI1vKeV3cs6PaSQqthP56TAani0WzNaHj
	u4KnoPeeu8uSGxZzX7kGvCWr0h/Yg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496gat7w7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:08 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58GDm85x025065;
	Tue, 16 Sep 2025 13:48:08 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496gat7w79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58GBEVJd018637;
	Tue, 16 Sep 2025 13:48:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mbw07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58GDm3M115597912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 13:48:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 883022004E;
	Tue, 16 Sep 2025 13:48:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D36920040;
	Tue, 16 Sep 2025 13:48:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Sep 2025 13:48:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <kees@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 0/4] s390: Fix and optimize __flogr() inline assembly
Date: Tue, 16 Sep 2025 15:47:59 +0200
Message-ID: <20250916134803.874580-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BKWzrEQG c=1 sm=1 tr=0 ts=68c96a98 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=JPAbe6LxEtc0jUXev0wA:9
X-Proofpoint-GUID: gYCdbgO0aHIEEAPfUaXuqFkUGh-iXkB4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfXz3Z7A178VOHN
 ep1Sov813ega64aFgMe6IYhhgTtsp5Xdx2UyPeZ86kBNLwMA05PMkIrra72jq8hCgP78WzuHNRY
 62tMwaigk9nij1s0UWxDmqBpTbL77ApNjGbephBMffJf7OIJS6sEjEqvAWKGixUxXr2Qo9U15A0
 H5A/oNbr427M8PshyUY61Qv9WYfcigbzWDYFt0S6n0mStXU19Ek/19qmpwo7Oy4QHzUhd3G9K93
 xXlLQiISRPoe8IYvzdSolswC2fqrS591/QpRoysFCI/5m4Vy1Rzvf9xB8NjI0QdFVza6MRY+48c
 MMOQ9HTOT6s8HARH6ox8xXDbrrJL4PZWovfB/lEZiAUGF8ExNAfW5TKowNsJfGDJgRnliWW+ZwF
 oL2Bynjw
X-Proofpoint-ORIG-GUID: yY1hrQJ8tkwJV8Fs2X0KtHI9herUS2_T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

v2:

- Split patches differently, so that the first patch is the actual
  fix, which addresses the reported warning / error. The subsequent
  patches are optimizations

v1:

https://lore.kernel.org/all/20250910151216.646600-1-hca@linux.ibm.com/

A recent optimization of the s390 specific ffs() and ffs64()
implementations leads to a new compiler warning. Instead of reverting the
optimization address this with the rather new assume attribute, which
generates even better code, if supported by compilers.

Since the assume attribute may be useful for others as well, add the
__assume macro to compiler attributes, so it is kernel wide available,
instead of adding an s390 specific optimization.

Heiko Carstens (4):
  s390/bitops: Limit return value range of __flogr()
  compiler_types: Add __assume macro
  s390/bitops: Use __assume() for __flogr() inline assembly return value
  s390/bitops: Cleanup __flogr()

 arch/s390/include/asm/bitops.h | 21 ++++++++++++++-------
 include/linux/compiler_types.h | 23 +++++++++++++++++++++++
 init/Kconfig                   | 10 ++++++++++
 3 files changed, 47 insertions(+), 7 deletions(-)

-- 
2.48.1


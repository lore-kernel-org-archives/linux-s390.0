Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD6481FBF
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031595; cv=none; b=rtoViLw3yF2hSjG+clyvKoUJdt6RrFLx78i7811DHel29jzVAxEGH926pYfMPsO+RipJcujflvvhFD3VlvDvr834QNvCAkFEL7+SVma+0ciGEvGwDVQ3sW+pC1zejkg1IgjoEVX3rQebR74nqHfNmtfPxmDVS/BsJioAXh8/G5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031595; c=relaxed/simple;
	bh=AqOERWPoO0Dcc16qbopJ9+N0aScg7HbKggAA2iAgxIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXzJTSRNTd1dqKR2bSBYwJAciRq7JeQqBH+CnB5El6xlDFVF8ZXRgRgXSbIT23X5hKaLf9TQ/dCU29uPNcIzgyObhpO4FxPWzDxTyZSDJd7yO8dGU0WWOqyLemUJqPFRJhV8xx+GPHIilmJ145Is+oYuHss+2VR0fBswCPZxAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HOMy5HD7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HOMy5HD7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EnIuE2939856
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 15:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=otDVP6dIw0KjRRc5vKQkTY5Hv9K56gdpVUAAlSxX+
	Rg=; b=HOMy5HD7pAinDwiasLBSCLgAoD8mmaY4a8VmAfXOHcs/UM9775JlKVXty
	EmYcrl4e9xTOHPFLE+U6zWnyexoc9MZlFUmvYyLQypJEu8q2ssjCT2vyl+12eHx8
	exyy6R4aEBmei1dJAnew5MlvNPX4PIpUVXESOIgMs7ZcT8K6urEYMVx88ajGIe2d
	uq2U7isCztocgdBOVNPy44oln5vswF42mrOcB2T7r+DriQ9cqF6YkjazPJf57WIp
	fLZIvwepfjvoB2A9DQDWhMjYXyhe6XoIViU/8nHcmnQmbmy+3WdICQSXeA8HctJs
	/cjaPYRkYV+rgbLG8BIW2izpyIRVw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a493ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 15:53:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FfLC8024540
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 15:53:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhkrc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 15:53:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676Fr3CV47972748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 15:53:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC1B620049;
	Thu,  6 Aug 2026 15:53:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 880F520040;
	Thu,  6 Aug 2026 15:53:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 15:53:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 0/2] s390/char: Enable CONTEXT_ANALYSIS
Date: Thu,  6 Aug 2026 17:53:01 +0200
Message-ID: <20260806155303.2675932-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a74ade4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=FQ6yebTjqvXztJ0Dm88A:9 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: auq4hZtzPuoTTMzua7qFcIEIPHwSgi7T
X-Proofpoint-GUID: auq4hZtzPuoTTMzua7qFcIEIPHwSgi7T
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfXx0+pYWIey8c5
 spMtGHkXop1pTrlC0HPWhO5aUzy2LvNsaqbU08QmsWZBMrbspBZsXjzqrRN1UuB7R/jKFMzjJ8n
 AVIBrnCx7jFHPy+Ahes9Y4zhoaqaNHU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfX0qCmsrBYdaHI
 hQv+GhRJOo1HpwwFl5Y1L/bPz8JPfvBeUINWzFLki2qxqGjlLlb8RMr0DnO7Nb/p+y3H+nSla8J
 TRHjHQ6aRI0NKw4W4HeZPxLM4exJwq1QcGQ1lBOV3Qws943xqqb04c8o6h8iX5/EMkz4c5ZJw93
 0ROTBH/QS5MrxhKfEmGLCxDd9mc1dYGbNX8smGWih+Ec4hR0yrvMVPyLgitrPZeMIo2x2fy6Sxc
 tatyxhz9pa2IOdqEyZ4fEVDPVjjO2DoXTCp3yPYT4Wknvv9osmUfpszUpztsI0WXAWpzClIocID
 dERzt/TvHJ7eUN1M6aGW3G17OSYVuqbzLmlpx8waCffylSrNaLS00kVQz5VAd4Y1/hNnDEdvIcx
 CfyIQzH6lxHE0gYjLVieOTnuFC/7Aalt22h6+QkL3XbvYutfTk89AVm7KzShR3wvXRqPBw8ECGy
 +0vL/gOB8Gv0zMlCi8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060122

Enable CONTEXT_ANALYSYS for s390/char drivers.

Static code checking for acquiring and releasing locks used to be done
with sparse. That was removed with [1] and replaced with a clang based
approach [2]. The new approach requires that each subsystem needs to be
explicitly enabled for checking.

Do that for drivers/s390/char. Add a __must_hold() attribute to
raw3215_make_room() to address the only valid warning.
Then enable CONTEXT_ANALYSIS.

Thanks,
Heiko

[1] 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse support")
[2] 3269701cb256 ("compiler-context-analysis: Add infrastructure for Context Analysis with Clang")

Heiko Carstens (2):
  s390/con3215: Add __must_hold() attribute to raw3215_make_room()
  s390/char: Enable CONTEXT_ANALYSIS

 drivers/s390/char/Makefile  | 2 ++
 drivers/s390/char/con3215.c | 1 +
 2 files changed, 3 insertions(+)

-- 
2.53.0


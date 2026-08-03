Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11645380FC1;
	Mon,  3 Aug 2026 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751651; cv=none; b=DFzNjdoT0SAOSeIBxBSZw2/eplVmzZ87iFEsKzjSJvFgBXAMeEu5YC8rprsaJc0pcfos3+7srl3sl/8rE/1IYIhUN0TXFzj+bTlXYUVctZX15eCA2qYgJFvwW9RbUFpcA9ppPa6d6mizTdu1G36nDGj38e3kmsD8PYNTs8/aIfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751651; c=relaxed/simple;
	bh=VPXgM3d16jMYvJwab03LDWbObrdgpJfHcmVXRZ2n3UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XCKDG9hcKpKB1ICA7VBSgVdj7KFda0uAIN99WlGEDcI8BNwhpsLnTgm+hD2uEYIKyf7iWZzOcpvouAAftSXC2QBGQvSfp1i3hGIIy8Sqol/cLCRm8LbWaprrQ7dZEn/Qri0++xRKoqs9QJGg2AxF5ZB3JpijArReXiv4wo4H8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s1jwmg65; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s1jwmg65"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Lll2u243753;
	Mon, 3 Aug 2026 10:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TtxEqYa6PiWk78uvz0J8l7icYv4UhA4Fbtnp4d5Gy
	3I=; b=s1jwmg652Tb8/MUXK3TWGwORx+KoOYZftgYTtqgqMP6n2lB+JDRwbIBiX
	cLZ4qfA6xefBn2edJ/24cbpv0CYMoRzy7HwatYmm6E0SeYewsuSninBlLYyGuD5J
	rYi7dkfPky2f8XnnKoYnJidv+PeSBueayqSbEb4dCJcywvqVdUKl9VMOhlEWWphk
	0Ev+YCqRNi5elKS3ya0ceDhMesLcc/YlS7CUC8KYd19bSBCiQtuzr57wwaOhgyPf
	R1HtIGbenFvzdyt70CLhN+H46CzSRmHbMIM2Hng/YYY9Qjtxgo8zdOvPuuMxVc8c
	QAYLjt6PD8+hl8S00Rc7w/N+GecMw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4r4dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 10:07:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6739uKeL012816;
	Mon, 3 Aug 2026 10:07:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtycm09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 10:07:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673A7OlO41681246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 10:07:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFBBE2006A;
	Mon,  3 Aug 2026 10:07:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFDB720067;
	Mon,  3 Aug 2026 10:07:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 10:07:23 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] s390/pci: Enable CONTEXT_ANALYSIS
Date: Mon,  3 Aug 2026 12:07:20 +0200
Message-ID: <20260803100723.2343688-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4NyBTYWx0ZWRfXz/P9upW8rDNg
 Nbgu6y2gCp3c0N82b0VVIt/bx3j8ddxZ68llKXGqxd7skTxQFGKKeXS6JhEbfg1zRQqsViNQbXy
 sXXGyeo22eSPI+UAZ8N2sJptU3Gy6j8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4NyBTYWx0ZWRfX8gyDKOKn6uFf
 MVSVFc67e9YWY5LtWpqaT2SskAqGRYG09X6uIzaGq3dE458yHG2k+eRxNWaJQRvjX8HTRgbntwn
 fi5DJ66Amaj59wyn1n4GWyjdbHOKU43Ki/xIvf/mddE87MIv5U7dzrffOoGgXzW4ylTNgLvMSuo
 jJSL5F6TTMugy3yUEmVEZoww7J/FrjeR+XGm/j2OByc7JKWAWY9cjQ8uFdQYxRnhv3k++qTE03H
 n5Rld5vIw7E7rjOcdCqHwMMJEgTdg0pr8hyuROXmoOX0tLHsSlJ2F50Ww6uYPytHZzqdfsM21Rx
 AQ0n3GEhJOchyyiU02coRpqYbibfrQWxB1EYzIetiPiBj2uEIqgAlKY5B555hAblnW9zPNkhnKP
 22wbXSVbdrHPcFNY6CxQBUYxVhfCCM1RfN0eo6zaLPeP125G/f8IOfpqFGRjj7XVgVzzCJUmWOJ
 9NBU42XX+5rQ4oLf4Nw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a706861 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=jW6YlCM5X9v_IRLvDUIA:9
X-Proofpoint-ORIG-GUID: dl21ZeWOVdpAX8ov3L44u6IU6lGGrgRH
X-Proofpoint-GUID: dl21ZeWOVdpAX8ov3L44u6IU6lGGrgRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030087

Enable CONTEXT_ANALYSYS for s390's pci code.

Static code checking for acquiring and releasing locks used to be done
with sparse. That was removed with [1] and replaced with a clang based
approach [2]. The new approach requires that each subsystem needs to be
explicitly enabled for checking.

Do that for s390's pci code. In order to avoid false positives the code
has to be slightly reworked, since conditionally acquiring and releasing
locks does not work with the checker (besides that this is sub optimal
coding style).

[1] 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse support")
[2] 3269701cb256 ("compiler-context-analysis: Add infrastructure for Context Analysis with Clang")

Notes:

- More patches for other s390 specific subsystems will follow

- "Pre-existing issues" reported by AI will not be addressed in the
  context of this series

Heiko Carstens (3):
  s390/pci: Rework __zpci_event_error() to remove conditional locking
  s390/pci: Rework__zpci_event_availability() to remove conditional locking
  s390/pci: Enable CONTEXT_ANALYSIS

 arch/s390/pci/Makefile    |   2 +
 arch/s390/pci/pci_event.c | 146 +++++++++++++++++++-------------------
 2 files changed, 75 insertions(+), 73 deletions(-)

-- 
2.53.0


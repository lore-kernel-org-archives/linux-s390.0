Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B72F39C2;
	Fri,  2 Oct 2026 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954466; cv=none; b=QR5ne7YMOX8EnkKlnQvE1M4etFxJS7XV1LEgMlOOgQ1CCRt6/5CzYTmHQPj4d1vR3n5CTrzrjopZXFyYuecGgxmMttQmqDX5vMawXSDdrvC9lwph9DUUIsSTv1QwB7XsyuyDNlYmkKf3SwjhxJtdp9BsG2M3J093t7uDnZU1k4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954466; c=relaxed/simple;
	bh=3fw+8DcujUAciexXxNVHY//R+Pw068CPn4JUUzFHsC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aW7NCbiwtQC8+4iB4/Nw8r98YhbmI1q7yaXBRJh6P5XkxHlN2AHYkJjq7P/NGWrYI03TlIoDVCXVK8JksHbNUBIIyEz1AuVz1nO8XwYaZXPt02AnoOh3dvtbDzUCUlv3vLXfx+oDNC2XKqJKiTB1vq3AOiarTOP1DHFfaW0pKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C/S/U0Qb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C/S/U0Qb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692DZgcj673266;
	Fri, 2 Oct 2026 15:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=amrBudHCFLdV52P3zqeMXDn18uY182Ky/p0iE+8cc
	1U=; b=C/S/U0QbWgD+2B1KYtBeCtX/a2ffNIxohkJZjkOtAG181iKbqgQ0fIYeg
	6OBKz1KciMh8SSLeBvLAjoe/ivVi/j8pyzvvLyT/LKVfVCZfepW7rhyc5Fm+DNjk
	m80cqID98wO4UJoK+VJj98zbKQJAT9eKBufWoLagiUQLolCHokOxgaalEH9v2wGa
	z3UgRv3KRqrILMIibqWBvPxViLBVyRDw67EhwUoukgvlAyKh9dEuJ50H37xkm9oZ
	yVjBvUGgKj+1u4bRBawK7zBcJLpP23uMTxaWSU0Jq6jjj6rsRhDvi5Gcphrm7Lhu
	iFfVK3fjUBFKzdFw1c6HKubmwPidw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5t3r1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 15:21:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692DWVd52562920;
	Fri, 2 Oct 2026 15:21:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcska9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 15:21:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692FKua737749132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 15:20:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33FD620043;
	Fri,  2 Oct 2026 15:20:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D26F20040;
	Fri,  2 Oct 2026 15:20:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 15:20:56 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/2] s390: Improve handling for stack register corruption
Date: Fri,  2 Oct 2026 17:20:53 +0200
Message-ID: <20261002152055.3305184-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MCBTYWx0ZWRfX/3QVg+2Ww8Kb
 TG1c+dUcdk7vIjwr76J0NE4kJdFb9uvOlYkwLxsRBsDPzO+VCZBJh8bBRsWcVw0Da6rDuYlyCCV
 BnOso1igsu6ELnKr60VeDc1hXxk+9rc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MCBTYWx0ZWRfX2lJ219fggHmF
 LBzCUS7bM8kzlte+dpK9T9iU93wrka6jMlEhpceoGy8noBsx6QOADBcDXeHJp8Yriv9xu6/rhDN
 gtQBH/oqe75TCcD+EMkfoKO5BkJCpauLG7n1vVgbGT7oeHN4OQdgeSgzVD22MpY0piGMK3+MvzV
 /kxSgAWoucImkcBTqZqCZ4QIssHClMeHAn5sXLdh6QPH1GaJoYknHG2t/0df4/UHriDysgSUr+z
 0uBio8m1PR6UQopWso6U+Z3OMaMcZEAEqdKB2cxr4OL2MRmiSG6/Lo8RlZEs8q5Koxd9PFv5kkg
 8PRWOT313k5IZvs8CmxvaSvW+Nf+aLR4OQhOHMl2nCOjamw1wQoKbrdPgd1hfH7dlvDV9Y3ij2M
 nbmq5+ADcGFyd+KOggFSQTnXYqWk6BKtjoq4/41oqvD+iN+lLeyUm+tRQr9TTJQnLR+f0v/2oEA
 wJEiAHWgFcTtszFbdAg==
X-Proofpoint-GUID: ARlOYH-0JPwJ41ceWszPSyhfJZsCuKGp
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abfcbdd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=AI1S0lelkytbrRr2WCgA:9
X-Proofpoint-ORIG-GUID: ARlOYH-0JPwJ41ceWszPSyhfJZsCuKGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020060

Two small improvements:

- Copy last breaking event address to correct pt_regs location

- Save lowcore on invalid kernel stack to have more accurate data for
  crash dump analysis

Thanks,
Heiko

Heiko Carstens (2):
  s390/entry: Last breaking event vs invalid kernel stack
  s390/entry: Save lowcore on invalid kernel stack

 arch/s390/kernel/entry.S | 17 ++++++++++++++++-
 arch/s390/kernel/entry.h |  4 ++++
 arch/s390/kernel/traps.c |  6 ++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

-- 
2.53.0


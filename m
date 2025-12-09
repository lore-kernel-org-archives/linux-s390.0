Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2C322B72;
	Tue,  9 Dec 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282638; cv=none; b=WhjjiDrYiLjcPod3DRJ8mQBOPMYLtd5YMrHFlxXM2T8TATiaEh0QvmXleECT5kbnEskocdwTjXq1BRId2vHsIXsPCKfYz5uqlHgqdkSUZ2WHngEUB6NpdGl7XJsMbM8NKfaAxTk9YRwSRuHu3TGCKkdVomVStAECW/AY8N4Qgzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282638; c=relaxed/simple;
	bh=8vf+9tA9PFIOMDQ8pMkQAlyC+Ju4tjOHl7frkqQ16jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ErOg06BP9fwposN7xoTfSwTlqEhCcWewEylpOkAf8bB1B5oPMUTlkS5nn9G629JdVrhS67WC49bZYmuXaAEXHV/4VqIBS9KhaFMiXHDnEyhT1DbRMipVscFwIhC/6mbqrPZrVCPUEtgTpK1CehNtPu/ExwI36r+4Yz4vNK/2urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q6EvGVuh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q6EvGVuh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9Bg3BJ005499;
	Tue, 9 Dec 2025 12:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=SA0Qa1DaRPEJaeC025W7Gt2eOjCr
	BgcWQxQfpV2w8HQ=; b=Q6EvGVuhUTG93iyO4iDoZ+r6y8sife7j5qLmH6TMWRPw
	i88/PCaPP25Xv4rZfPpi6+MKAQU9q10X58l+92Pqc+PLD94mtVDWclygahCfUA8s
	v6+DvmtcnEYASdZrZSE+5RVyLxMnV5gnC9Wp/UcEcpgYckjYoKRkvv25p2Hf/hVh
	QKDIArttVgNKrgyKA3KtBZ946GiYrNMtZhMAh04RV0o3vYq+GTWXVSEYXXKMF0WG
	seaIrNadKvktcyx4nkPF4bWS4iMdHWAoRHWCk+YZguCCFeShjpnsx0LZOtLC2uJ3
	NOMnTzl1ySjVTKpzHDmXReInW0mE2ds1pcN67YyUNw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvmdnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9CBlqU002409;
	Tue, 9 Dec 2025 12:17:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jak9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B9CH16p53084598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 12:17:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 905DB2004E;
	Tue,  9 Dec 2025 12:17:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 625562004B;
	Tue,  9 Dec 2025 12:17:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Dec 2025 12:17:01 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jens Remus <jremus@linux.ibm.com>,
        Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/9] s390: Exception based WARN() / WARN_ONCE()
Date: Tue,  9 Dec 2025 13:16:52 +0100
Message-ID: <20251209121701.1856271-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lj21VNTuavT62uxo2pBroJHTsBgKrgks
X-Proofpoint-ORIG-GUID: Lj21VNTuavT62uxo2pBroJHTsBgKrgks
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=69381344 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=SWMNsmP5DZmT8m6ampYA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX5kyAn0+hkyN5
 jrjKQmeQwij1exRZx6mbGRYOGhb3otGajSW6D3dF7KLcBrEeBfcCw7P4s5/vUWB4u9jzu/gZixO
 Bz0DviJ+SzlN2Zgi7GyjVf22k4kgEhuIPlLLt0LgRRXrIEArNfImUQyjEGeKeoITpyon5eukd2z
 y54Oea15FuHsLCxNcXttoQxd3jrAYzZZknV6lAVUNUpfh+ucb4X2Jbyoyb3H4RPZO+2We+rykkE
 P4EO3BEwa76LwclFZkLXkr2dTnuEmGFfVvXKMq8A253WLrJjGY+Ucwkl0ki4oPlpl788114qYka
 a3Elq/lKQbiXfF7AKb2/1dgAo8S9qT0SmuQY26qQUTmVXzpkOF/p6jWqd1dP7pPU9qFp71msJ8I
 jABqfUfPU0XOHS4jndl0uoyGDDvtyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000

Use the generic infrastructure introduced by Peter Zijlstra [1] to implement
an exception based WARN() and WARN_ONCE() similar to x86.

Due to some compiler oddities on s390 this requires to raise the minimum gcc
version to 9. Maybe there are ways to avoid this, but I failed to find a
working solution. Details are in the patch descriptions.

Just posting this now to also get some compile bot testing, since I'm afraid
there might be some compiler version / config option around where even this
new approach breaks.

Peter, since you were wondering: your generic infrastructure pieces work very
nice. Looking at the x86 and s390 implementation: it might be possible to make
things even more generic since both __WARN_printf(), and WARN_ONCE() are
identical; it looks like only __WARN_print_arg() needs to be provided.

Arnd, just adding you so you know that there may be an architecture
which requires gcc-9 instead of gcc-8 in the near future.

Series is based on
git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features

...and not yet meant to be included anywhere.

Thanks,
Heiko

[1] https://lore.kernel.org/all/20251110114633.202485143@infradead.org/

Heiko Carstens (9):
  kbuild: Require gcc-9 for s390
  s390/bug: Convert to inline assembly with input operands
  s390/bug: Use BUG_FORMAT for DEBUG_BUGVERBOSE_DETAILED
  s390/bug: Introduce and use monitor code macro
  s390/traps: Copy monitor code to pt_regs
  s390/bug: Implement __WARN_printf()
  s390/bug: Implement WARN_ONCE()
  s390/bug: Skip __WARN_trap() in call traces
  s390/bug: Prevent tail-call optimization

 arch/s390/include/asm/bug.h    | 141 ++++++++++++++++++++++++---------
 arch/s390/include/asm/ptrace.h |   5 +-
 arch/s390/kernel/entry.S       |   7 ++
 arch/s390/kernel/traps.c       |  42 +++++++++-
 scripts/min-tool-version.sh    |   2 +
 5 files changed, 156 insertions(+), 41 deletions(-)

base-commit: 70075e3d0ca0b72cc983d03f7cd9796e43492980
-- 
2.51.0

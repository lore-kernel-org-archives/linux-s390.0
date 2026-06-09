Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23EB3F39F9
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001231; cv=none; b=m3nU8KesAH1KIEtNw67ta1bB/7Ud3vO9vUDFje4ju1vDAHIUanm3C7eMfJ/+jFbiGakI5JMPwQRIrxYkaa9Qtoel+1mMmGWqF5ezVpgOLSuB1OrqOQ/VqhdMISp2vBduK9FaA/g5TA4nBw56v3nDh7TYpdyBdfAfu37JQCmJTXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001231; c=relaxed/simple;
	bh=U6ONtV4udkTrHrIIxb60dnqlDibxz6BZZSa5sVkqYwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjTPnXNQWhGR7kAZOcsS1e8W/BKFohx/20dkoSnLFwSCg2AJi960n/L7XXjUoMdkFH1huySiQdsGU3BlxAwWRnb3Iz3Qc4L5+Tjv0W8B/HqTTDWLOYsRgNTozihMej76AYWRjTtrVHaBhjHccBdKlU+x0g6FGCBlP+jmc/yNPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bZhIvFlv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bZhIvFlv"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658K1FFv3088318
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GFx3OJPG1EVJHcGzflxIIifN15VgzojLj3kpJozwK
	pA=; b=bZhIvFlvY7+lU5K3/Gk48xef7MrySO3R0PrUIFw2ukXNmoyTE8oGK10mt
	GruwMcQBWlksjxxNSFWOJHMWQ37a2QRN7XWoE8K/xPJX7UGS9k+ZnZRv168NchHT
	0ylHTUiaEZSzL7LMZtBxSg8PDs4dmtmGo1gGZ4w9bY2bhaTDJSLIKnY6L+YZZXyM
	Sant6ZWJdDIRxKtWwlWOfywBzZlFsx+Ef5qYhVmWSbKw5AWUskKxDHOrOW74tHj9
	8r+xdjmTGwaGN2J/G1SIepmgx7gwtWYY0fxnG1lD0VdVey/RfPdBfcuSFd5KaqNm
	3zKSi0DRuxiHxN/VOH8+r2ORkVZkg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhup2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659AJbPk003702
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy99n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659AXiSo47841728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 10:33:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AFF920043;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B9B220040;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v3 0/9] s390/string: Convert various functions to C
Date: Tue,  9 Jun 2026 12:33:34 +0200
Message-ID: <20260609103343.107325-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5NCBTYWx0ZWRfX/XUJlRk3ho4S
 OiCODc8UceMP1vhvqcjl47HJUAvhcDC10GNoR/eBV+Wgi5eevLwA/AqZ4SsFO9gPYP+SLeQnPjj
 9aD81TrudpJ/Ymyl1VHlcwHSzFyU81y5EQx39eyOMNz648vzs9TBrSWyLWzArz3yu1wsuqKdI/8
 sU9hElKyLUFysSFyYXFiIV3G0hLmmEiNFNpdmCyxdMEpOcLjevPoUxBWgKFfm57EM/7JfviEQ/H
 k0P/TRPE1hz2xDvou9Alvypt082hhbFpkBdXEK41Gq3R/qlEnTZmMKuFyDyX/K02DIBeJdn90yc
 f7HoF2NiU1yf6IUVuTKzjwcAtzrzGtXApWFmzjzAzIwXLZ1k81CmrlLT2WlGxgQo++HZNDUTtkE
 13gto3jWsNPi6MR0RxUJWxA+zILXmqoLRhsn+kg+K3dcCjuq988tIWkWuNY5rmmQZZNHyR4/hBQ
 125y4qo8oi6kxctaeFg==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a27ec0c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8
 a=Edh_RgK51w-PSKYyiAAA:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 7puR1PNxJP8-aVG34A-_XmmCws2bVpFV
X-Proofpoint-GUID: 7puR1PNxJP8-aVG34A-_XmmCws2bVpFV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090094

v3:
 - Add additional patch which adds -ffreestanding compile option to
   string.o [Sashiko [3]]

v2:
Address various Shashiko findings [2]:

- Off by one comparison bug, which leads to slow path for memmove()
- Incorrect ifdef around __memset()
- Incorrect commit description for memmove() conversion
- Missing noinstr for tishift functions
- Missing header guard for tishift header file

v1:
While working on something else I stumbled again across the various mem*()
helper functions, which were implemented in assembler to avoid recursive
calls [1], when using the compiler's builtin functions.

Convert the functions back to C using inline assemblies, which makes them
hopefully a bit more readable and maintainable. Also improve the memmove()
implementation by using the mvcrl instruction for the backward copy case.

Thanks,
Heiko

[1] commit 535c611ddd3e ("s390/string: provide asm lib functions for memcpy and memcmp")
[2] https://sashiko.dev/#/patchset/20260607162937.2927356-1-hca%40linux.ibm.com
[3] https://sashiko.dev/#/patchset/20260608053754.571282-1-hca%40linux.ibm.com

Heiko Carstens (9):
  s390/purgatory: Enforce z10 minimum architecture level
  s390: Add .noinstr.text to boot and purgatory linker scripts
  s390/string: Add -ffreestanding compile option to string.o
  s390/string: Convert memmove() to C
  s390/string: Convert memset() to C
  s390/string: Convert memcpy() to C
  s390/string: Convert memset(16|32|64)() to C
  s390/memmove: Optimize backward copy case
  s390/tishift: Convert __ashlti3(), __ashrti3(), __lshrti3() to C

 arch/s390/boot/Makefile                |   7 +-
 arch/s390/boot/mem.S                   |   2 -
 arch/s390/boot/string.c                |   6 +-
 arch/s390/boot/vmlinux.lds.S           |   1 +
 arch/s390/include/asm/asm-prototypes.h |   4 -
 arch/s390/lib/Makefile                 |   6 +-
 arch/s390/lib/mem.S                    | 192 ----------------------
 arch/s390/lib/string.c                 | 210 +++++++++++++++++++++++++
 arch/s390/lib/tishift.S                |  63 --------
 arch/s390/lib/tishift.c                |  64 ++++++++
 arch/s390/lib/tishift.h                |   9 ++
 arch/s390/purgatory/Makefile           |   9 +-
 arch/s390/purgatory/purgatory.lds.S    |   1 +
 13 files changed, 301 insertions(+), 273 deletions(-)
 delete mode 100644 arch/s390/boot/mem.S
 delete mode 100644 arch/s390/lib/mem.S
 delete mode 100644 arch/s390/lib/tishift.S
 create mode 100644 arch/s390/lib/tishift.c
 create mode 100644 arch/s390/lib/tishift.h

-- 
2.53.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D82322B69;
	Tue,  9 Dec 2025 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282636; cv=none; b=TEW8r4HEvQRb+c0ze32ckG+3bS/5Fped6WCYkRLfus5NThfyXeXPcU8/6C0DitkNZ19F14PGaGDdgxWGEpq0iqZzoQJOegSI9rdmmsOmwY+qPmmkXEC2esRTosERnF8xnDPM+54sUHcFCGJpYOkjXwlh5lmyb6Cg0y6Y9PuAUPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282636; c=relaxed/simple;
	bh=d2L6w3v2cTFbHTO7k3Nn/r8rw1Ef6rrvSAOp7t6GWDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kz9p7OI/dQJP2oEZmkXK/6s7akpqlWVHwYmTrn0r1Z6upKvfmyaRNBQyovKUBC1FIprxF2LFMQZqMciPz8wS4bL9RbNOTt9y7i7BKjaUoxKdTwPCIqbPFPueDvhJGD9WzxQgDRoesQE7bLtyEkKjEl8uyb+mHGVOO1QPmnUmm0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IPIkGcGz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IPIkGcGz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B93GnKl023046;
	Tue, 9 Dec 2025 12:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mILDbajNj862vQBLT
	IK8ZvtTVVxawvtKU+q8Ju17tAg=; b=IPIkGcGzdldxnFWrC2rHBj0cd2yxn/2ZS
	BXOaDLnfX5i6WzEg2JWRDvd3duK0XJl4UkFIwKB36Kt5XIM4X+7mH0SNvm0SntlE
	z7aoDskgH4BkSno2e0hZ5+PiyMYuvLm2iefLEyDfvPgpzlgmeaV8hbqq5ijFn6jZ
	xJcFjXn6DafwnjgKFrE1AwSmze4KG6C7suJ4/4Ul4lYQq+mUFmkR9MIkqN/1a08r
	qCUaTCjl7UQEsr0FMYZFnnj6vkKbNeC+yFYrCcQgwZrBSjDd4LKcRAjZcP9iYHep
	MdbfOuYTNnVPX9XZwLtW4W16RY1moUcBTjCkIo2grfRBEGaP5Rh3g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53c442-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9Aag50030254;
	Tue, 9 Dec 2025 12:17:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4avxts2xjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B9CH1jN51511754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 12:17:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAA8620043;
	Tue,  9 Dec 2025 12:17:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94FEC2004F;
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
Subject: [PATCH 1/9] kbuild: Require gcc-9 for s390
Date: Tue,  9 Dec 2025 13:16:53 +0100
Message-ID: <20251209121701.1856271-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209121701.1856271-1-hca@linux.ibm.com>
References: <20251209121701.1856271-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfXwcaxYXPyPApc
 gGHNb+ZaNvu5GnlHZSRWJjqhAHrUuQ4h4aNiU9PsdN0FQcBmN9jFGPaOSSLrA8aY7YhEIZVZWI+
 zOTeVtu8byepM4kPPppcprNuYocVGqVtJh5KJBA1BkBJRHoRMdjSLag6u6E4o4cwj4z40lq0J5S
 pQ2BQDxvkZ1W64JzXrqAMngR10TJwXHuzhNlhp3i5mycFbjcMMws0kErUOPUfygYT0Y9/O+JGkQ
 sjzXUNv25e6mJACg6b7XXkZqkipqhyjpdsvVNWUG4wVbpC3863c9p1kZMQcyI8IOa5i1Z2fCaK1
 yP96zpRVXI62iNnph6cO5di4GYkmS5fjUOtQJQqBWTigk44BSJPmb2IQTQvUHBUZ4agHTa5jfzs
 Ed3j/5SC8f0vcig4O/wZo+6SuaDD3A==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=69381342 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=TbMndkmT-6wVJWDlugAA:9
X-Proofpoint-ORIG-GUID: UW3ngKb1Qw9RbMlqlnABqvUqEtwoCqB_
X-Proofpoint-GUID: UW3ngKb1Qw9RbMlqlnABqvUqEtwoCqB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

Upcoming changes to s390 specific inline assemblies require the usage of
strings as immediate input operands. This works only with gcc-9 and newer
compilers. With gcc-8 this leads to a compile error:

void bar(void) { asm volatile("" :: "i" ("foo")); }

Results in:

In function 'bar':
 warning: asm operand 0 probably doesn't match constraints
  asm volatile("" :: "i" ("foo"));
  ^~~
 error: impossible constraint in 'asm'

Bump the minimal gcc version from gcc-8 to gcc-9 for s390 to solve this
problem.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 scripts/min-tool-version.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 99b5575c1ef7..1cacd389f29b 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -19,6 +19,8 @@ binutils)
 gcc)
 	if [ "$ARCH" = parisc64 ]; then
 		echo 12.0.0
+	elif [ "$ARCH" = s390 ]; then
+		echo 9.1.0
 	else
 		echo 8.1.0
 	fi
-- 
2.51.0


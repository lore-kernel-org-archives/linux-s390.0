Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E012582;
	Wed, 13 Nov 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512429; cv=none; b=g6EUK2VeJzSiQ2efLAhRQZDTD+vsKjZvORyTtdl9vyj6jmGx/kVIJ3OPXBHOVJ41N/m7piG0W970Tft0L9YtilAevlgeUE6oTncrgjBa11unypnvokNh50rRRrpa5is/586ap7avJwGjoeLLPUrWo/qPb6G6nczKDVCDUCmZGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512429; c=relaxed/simple;
	bh=+wX6xsRfvGOGnmxGwsu16KEHsk5gDt40PhT7M1NaflM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=to0PSel+12Df4EwBnUygkC9uVYumacstM7nF9w04rCq6AF47o5i8gwYsTswNzMoEuETZxGc2+Zm1yEt/t0VwalK8KpfR7Q5SXUYI5CfyWE+M88Wm8qLIbWn8FCxbXXKH/4YabVA2mpG03Rlbi4se7X9mNVlJr2yLNrFYTwhYv4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lstaTiAC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lstaTiAC"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADEetpE022028;
	Wed, 13 Nov 2024 15:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hfzH9a8cVGnegLZnk
	cfqLIYfgVsdbIvqgz2fIhQhfpQ=; b=lstaTiACOf/HJG7ABwbbNkiKrshi65ySl
	9Ve8yXtfoEL+uHsrYKmGHaeYWQN13qZNyqeCoIrQZE1i1+YbOs1JTd3u8BMzXcqz
	+6nIASGOvqe5lkJ5m8GEKcUFtmQWx5lZBw8XKPoeZlE4Q9dJGRKbMD2ehLc37M2f
	0f4bBBYuGxftsyp7azepzMHZ+4xLKZUzEfuAHTC5eGKG/LzZuYi9xSbePzD4W7Wr
	O2vdx7D24S7z7BhBG2l6iokMEEsfd2PYu8z16A1u+URLPcxTyBVNAhMaUiACyZS3
	qBsnKWpdYBNtxWIAlgSsJpJgMlq3RxdX/pKLPRD0ZTCD3mst/Yphw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vx3208gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:40:19 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ADFeJBH003132;
	Wed, 13 Nov 2024 15:40:19 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vx3208gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:40:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADFYVcn007379;
	Wed, 13 Nov 2024 15:40:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tm9jeb2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:40:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ADFeE9u57999766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 15:40:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEFCA2004D;
	Wed, 13 Nov 2024 15:40:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 500B72004B;
	Wed, 13 Nov 2024 15:40:14 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Nov 2024 15:40:14 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 1/2] scripts/min-tool-version.sh: Raise minimum clang version to 19.1.0 for s390
Date: Wed, 13 Nov 2024 16:40:12 +0100
Message-ID: <20241113154013.961113-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113154013.961113-1-hca@linux.ibm.com>
References: <20241113154013.961113-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yHm55OPMTycFrIfuuIZJwJRz75a-rsFK
X-Proofpoint-GUID: 5I56uXFyd4HLzSLoiBb5izrm2O93h5sx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=815
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130131

Raise minimum clang version to 19.1.0 for s390 so that various inline
assembly format flags can be used. The missing format flags were
implemented with llvm-project commit 9c75a981554d ("[SystemZ] Implement A,
O and R inline assembly format flags (#80685)").

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 scripts/min-tool-version.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 91c91201212c..2dc674a74624 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -25,7 +25,7 @@ gcc)
 	;;
 llvm)
 	if [ "$SRCARCH" = s390 ]; then
-		echo 15.0.0
+		echo 19.1.0
 	elif [ "$SRCARCH" = loongarch ]; then
 		echo 18.0.0
 	else
-- 
2.45.2


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0174C2582;
	Wed, 13 Nov 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512424; cv=none; b=Bp+dBeYuVrBRT9TDdcprT4inUfCAUh+xdAMlQoBjwksaI9vif+HPXiI5y9t/ikHQtPYX7W3+i2ZLbRe6G599dd3dkloHx+jvCywVemdklQj8SUeBYH4I8TLnTwjBxvgrTLWFXbTil9pLBxq7QzjPoOd5WS5kx/ScsM9jRqrB444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512424; c=relaxed/simple;
	bh=lmbcpRZZjaAoP1qWtDaq6UZUfjAfOLrSFWSE0HRrK1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sLQrIhVnXYeMLeKtELhLv4S6SDE6UCj2g243v+d3XVYppFP9RbDgfbD5CReS6h0w2XVi7/M99PPb3AMpjVucYFoBQD2V2H1HGygcBB3NmX/jHU0qBtHkQdEVFYi73SpMszNsdCryBZj4MCxmcEoik3H729etyFdCZQdhKf677EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F0Evi/HB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F0Evi/HB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD79wqu025025;
	Wed, 13 Nov 2024 15:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0o5ujX6jknUuWaqA4ZnO9qS1aUgKkue+Qjr5BF4Cj
	Mo=; b=F0Evi/HBq14O0kL18iW1pLgerdkyLC3aJJGyer/ETqQV13nf9XEA/zSAg
	FQ3O81TstlPKEtt5ZYmLB1lVswvfRv0c2UQHojO21pY/dTEtILqrZEh7opTmhqsV
	dUhnGma9KIhSxtTdRlKqdkUxaJXj2lxBQztXYlbZSAvfywlMesUv2W5I3KceoqIY
	XE1pqzcccS4jtudUyMWE//vi+5spnIYa5zwKMoR9FniEMOSu6W5aZ722l3yp3Sej
	PuPjIMzxVIjWw8ewa6FrVHuvkY9lm4hSYVCNHKD3ukz5HhDssr3GPka35OZI54df
	BUGoo+0tDKsBuibUhnJg3b4zdHxlA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vqfuj5d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:40:20 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ADFeJmD012233;
	Wed, 13 Nov 2024 15:40:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vqfuj5d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:40:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDtahD017511;
	Wed, 13 Nov 2024 15:40:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tk2mxf8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:40:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ADFeEtC57999764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 15:40:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4061520043;
	Wed, 13 Nov 2024 15:40:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C32062004D;
	Wed, 13 Nov 2024 15:40:13 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Nov 2024 15:40:13 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 0/2] s390: Raise minimum clang version to 19.1.0
Date: Wed, 13 Nov 2024 16:40:11 +0100
Message-ID: <20241113154013.961113-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RSngnhPvDsG0JKq9rQE-GjZS1PDA-M5H
X-Proofpoint-GUID: I2baA1dTYsOPJOOICvY3Opy1ii3GkN8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=422 adultscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130131

In order to get rid of special inline assemblies for old clang versions,
raise the minimum clang version to 19.1.0 for s390.

This allows to make use of various inline assembly format flags for which
support has been added with llvm-project commit 9c75a981554d ("[SystemZ]
Implement A, O and R inline assembly format flags (#80685)").

Heiko Carstens (2):
  scripts/min-tool-version.sh: Raise minimum clang version to 19.1.0 for s390
  s390/fpu: Remove inline assembly variants for old clang versions

 arch/s390/include/asm/fpu-insn.h | 124 -------------------------------
 scripts/min-tool-version.sh      |   2 +-
 2 files changed, 1 insertion(+), 125 deletions(-)

-- 
2.45.2


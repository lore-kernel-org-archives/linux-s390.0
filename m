Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F628136B;
	Wed,  7 May 2025 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622096; cv=none; b=jV2U+i7eboxL8bK0ksTVW/Ctjnhr/1EmoX93gvD2b2FbH98pDOb7X5GJb2lMC/B9XgtFuS/k8Qeiz9tS2a1mxH5Y2HLnYnjqwnXwIRZfqC5oOwWo+m68S4Ef9FAbPXjQjZbcNIkBjTtk0VTvigWQFY1kSBDnpW1bYBQrPv1WNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622096; c=relaxed/simple;
	bh=GCsE80ARZWHPnDXsrOwvca/8zaXprzOlGBiWhv0oI0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K09DlV9MHN8dLIuLWgSX2+C1fjtPl+IiERsW/CZ/ZYmKgOvCdePcr+oGuUF0oiYm0aSEoQ/loEn8XXYLqNzjWs65XUb2PFyRGziaLpX+Jlb9Me6mktuFZmcE0/kFJy5c66HgN80IrD3T+3N2RwKIFL4sMr+ZwKq6flMsQqKWVvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rNbcqNXR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rNbcqNXR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547A4FjN012177;
	Wed, 7 May 2025 12:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0bF/6bqbsMkdjnuADJ5ycDEUAyKEb1tjELJNpbapA
	fU=; b=rNbcqNXRDQ2HpA147RYxWjnVKWiUi4ukpgohuGUhLQq2XYswvulA2qczH
	GQri6IRSJ8s9cPPrxTMCb0UbJNbFLRXi8nHpnodtmACRm8MnrVYqJCztgD6j4S3k
	KhrK5oBI0oo2K2SpxiJ1EFJVoQjdMyFJrZ5f33m8Xf5090ommFv2c6IpHpkaHXMm
	e5QaxEPXZitNY4+x+ZabWioHq7ASotQZoBeJFkhPUk3cjtYQMJNdzqMCDHwRs7lj
	LrYVjikzQFQ8qjTZrLt+GxPreRuxAbL3leo2lX//N04hVMZ5bWBZTJGK59n1XYsh
	v4GFvbmwlihlkspUqZ9O5va4jWb4w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46g5ejrquv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 12:48:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 547ChJjD002761;
	Wed, 7 May 2025 12:48:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46g5ejrqus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 12:48:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 547B08MH013765;
	Wed, 7 May 2025 12:48:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e062ga98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 12:48:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 547Cm3ER55378276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 12:48:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A03CC2004E;
	Wed,  7 May 2025 12:48:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CCF620043;
	Wed,  7 May 2025 12:48:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 May 2025 12:48:03 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 370F5E0610; Wed, 07 May 2025 14:48:03 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v5 0/1] kasan: Avoid sleepable page allocation from atomic context
Date: Wed,  7 May 2025 14:48:02 +0200
Message-ID: <cover.1746604607.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SvuQ6OO0 c=1 sm=1 tr=0 ts=681b5687 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=dt9VzEwgFbYA:10 a=RptFD5b0m2ehXSuSLUwA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: ls0CSTEdIVroqRAPQ4MRaJy_bGIyuZkh
X-Proofpoint-ORIG-GUID: w76n1Ot5A2NfAgFq8dUBreGB-wgkHpPu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDExOSBTYWx0ZWRfX8fftuVRzpHmz C9OXZDcMi45ugFCLH5H7G6/lJZsCvwZDupHonClR8qSdrvG0sBJbqM0F/OrcCod5exx+Q8Md9Lw 5kSuOTzLLR/ulJfXkDqEhOMoDr6oJy4QlL3eQ67PM2fPPu7Ry0JSXH0e9gtBPkKknCfnchdYQyT
 sNEaur/fRmK0VjRgQ49JYDrZyPS2Hl+ImVWP5YKGeI0khECPbvOpSE6LZy/NWpygtwUSSdwSsTI ce35Cf76owiXIFPhrfZcfJAHPNDYfvI8dNyiBM92S62IqXWp9cgFOKo1TrLmAEsxQVcOSiTHHHr klmf5Rt4SwNECdv/XL6bF7tcpiJ7kZuFrOKOHJLsmfmlxl4rTqn4u3UMzMFrdYvFws4TyHwZuRK
 1jEI5U9u9Dh5OCQrtWcuCNp2T4b9khOaBlbBrfGI1KyVQl8Ry6PGob7dTc5u0B7vVqqLXEXy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_04,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=555 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070119

Hi All,

Chages since v4:
- unused pages leak is avoided

Chages since v3:
- pfn_to_virt() changed to page_to_virt() due to compile error

Chages since v2:
- page allocation moved out of the atomic context

Chages since v1:
- Fixes: and -stable tags added to the patch description

Thanks!

Alexander Gordeev (1):
  kasan: Avoid sleepable page allocation from atomic context

 mm/kasan/shadow.c | 77 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 14 deletions(-)

-- 
2.45.2


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57801E883A;
	Fri, 18 Oct 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242926; cv=none; b=PqscaHSW7n5uspig1f02SF6MLQBf72JtdpSaOfzrGtVX2aeMh55z+rwnofpuAE0GEX4NDX55FCJB0AHD+4TjAOWzlfci7ota9r8qwY3VEOAzPRFTm+S4OBu9ofMS62KFV4LjptYtg3kmZZviJO75ATFEylSApOzU1HXhcMesFOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242926; c=relaxed/simple;
	bh=6VjdweAduNF1ESXGsaNKKtekqqDk3b+hcyDOhmmzvC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abNR6TQYQtVfBIGgLkgaaPQInN97flV3PbzYYUBBXVn/stMIBIvGdPIQLZOWB9asG9mSsKs0cIk3r848x0d2GxUBIghNjnZ//8zNOWtv668Ambp8ruqjg2RcyZOuBooKUF22PCdML4rTI9wnlCNBeyy9p/b7pWU//OIIe3oxHUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jy4xJM7j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jy4xJM7j"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I5Zm87012502;
	Fri, 18 Oct 2024 09:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sNovEUv36A8MIgNerkyD3B79QI7kmat5ST8ijWggF
	BE=; b=Jy4xJM7jU+6h4AR76YkltOR+heHc0M72leaoA0KSEgZHtw7Oc/QnMVGLW
	HWOAwYGQS//Jeqz16M4emX5GQE/kX/Un0JIGHYws9fCUzvQxw6x3AjCQk9sBb70H
	6gH9I9LtY4soC7mtZZmzsgTZUehFvadAm9Gwi09ALU2THVSv6ZOt3ljdNS5/l4PL
	CaTRj9sTYUqZYXjTEuvGnw9i/8iu4L5VYGkvNeKgHtjoTp2Q0ZkcA7jcyC+ZB8jt
	F9GLBhgFFBNVjgUBK5Hx9AV9SD3oOIeua6LLIKFptPCC/0hZqxEQlvail7GjLPHs
	Ztb0a34TSUaH8IYV9BTxfyyq25RMA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42bhnf91ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:15:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9EY0c005215;
	Fri, 18 Oct 2024 09:15:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285njk9cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:15:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49I9FHSr13369672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 09:15:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA98B2004B;
	Fri, 18 Oct 2024 09:15:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAD2C2004D;
	Fri, 18 Oct 2024 09:15:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 09:15:16 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v4 0/6] s390/uv: Retrieve Secrets Ultravisor Call support
Date: Fri, 18 Oct 2024 11:15:10 +0200
Message-ID: <20241018091516.2167885-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yo_-rWmBlJjcDeJdxjbQ8ro-nuK_IKFn
X-Proofpoint-ORIG-GUID: Yo_-rWmBlJjcDeJdxjbQ8ro-nuK_IKFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=365
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180056

A new secret type (group) allows SE-guests to retrieve the secret value
from the UV secret store. All retrieved secrets (but plaintext) are
retrieved as a PCMKO-wrapped key so that they will never appear in
plaintext in the secure guest. Supported key/secret types are:
AES, AES-XTS, HMAC, and EC. Add support for an in-kernel API and an UAPI
to retrieve a previously added secret. If the Hardware supports it,
adding secrets works with the same infrastructure that is used by
associate secrets introduced with AP-pass-through support.

With this addition List Secret UVCs can report more-data now and may
expect a starting index different to zero. This requires the addition of
LIST_SECRET_EXT IOCTL that works the same as the non_EXT variant but
additionally accepts an index (u16) as input.

Since v3:
	* converted an accidental kernel-doc-comment to a normal
	  comment.
	* improved list_ext documentation

Since v2:
	* Simplify conditionals
	* Fix documentation issues
	* Simplify list_secrets()
	* Add r-b from Christoph

Since v1:
	* Add various r-b's
	* Fix nits and minor issues

Steffen Eiden (6):
  s390/boot/uv.c: Use a constant for more-data rc
  s390/uv: Retrieve UV secrets support
  s390/uvdevice: Add Retrieve Secret IOCTL
  s390/uvdevice: Increase indent in IOCTL definitions
  s390/uvdevice: Add List Secrets Ext IOCTL
  s390/uv: Retrieve UV secrets sysfs support

 arch/s390/boot/uv.c                   |   7 +-
 arch/s390/include/asm/uv.h            | 146 +++++++++++++++++++++++-
 arch/s390/include/uapi/asm/uvdevice.h |  36 +++---
 arch/s390/kernel/uv.c                 | 153 ++++++++++++++++++++++++-
 drivers/s390/char/uvdevice.c          | 156 +++++++++++++++++++++-----
 5 files changed, 444 insertions(+), 54 deletions(-)

-- 
2.45.2


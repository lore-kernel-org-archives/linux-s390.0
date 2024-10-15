Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727CF189BB2;
	Tue, 15 Oct 2024 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991747; cv=none; b=KioYM5iREIfeJTSbXRMTLdKP6XBfhJmr96njQUHsV1i1G3Xyit+ZjJ0cRqmnpggbg7x9CXhi9n/E+EVlqYvubhdI0tCjc/MOKYn2GScl/vZ/g9R5UC3mWZ5j82QUWgd64gISqXlkvdnn+W4idx7WJI99kXLoaom9ctX6JBeCEtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991747; c=relaxed/simple;
	bh=fCcpbi/DMaiE9UkEgjGd/UHx8Y29H+4O5aEibvVOsio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOZEXZc4vjZG4lVLFEsiqyrAt1jVLuXq13gzW8WVpt4PZmWdPsBOS+0JFlZZeIpBPmTXzhQZL4yqMrXev2aksP8Fg3LGx1LlchgMWn8RdtWLMehrLH5CKWyxpJMSxc2XEYjiJLfFrlrV1BA9Z9kMyLLAEjX0rFEcWnQg46P+K1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UY3KbJJl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UY3KbJJl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAO3H6004314;
	Tue, 15 Oct 2024 11:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RhwuawkRavgSoXL5Aj4QSrR4egpta7JnevFXoUhiO
	8Y=; b=UY3KbJJlNuygd+i0jmd1d6vE749CmSk4z8gvkhC5CVxtfKS4uXlJkDRbo
	E+nqyfdoHStxUXST5tHvIMbGYXYEETWTXvqDQ7MiCbbKXgAThjXSX55lDK/Mu13W
	3/QBVdquzmHY0vSA1K/uaUEDGAlsGuTiJo6ajJq83uqAYfExrqH5qimtuvHXOCx8
	dYeA/3V5msVTXH/X5StFnIV9R0wlh5yqMRBBteP94/2/90iI2HssVDFfEZIxu9u6
	cvgeVNJll9TbmrmuS2ax2AjUdDPx4D79Nng3RY2tz1MiZxAIAbbgxaoBrd7zItaA
	czPWo9YWmRFd76SfDqQ+eNRRIJ5JA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429pkyg9h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:29:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAYtsu006674;
	Tue, 15 Oct 2024 11:29:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283eruq59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:29:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FBT0sg48628014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 11:29:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF26120043;
	Tue, 15 Oct 2024 11:28:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C866520040;
	Tue, 15 Oct 2024 11:28:59 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 11:28:59 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v3 0/6] s390/uv: Retrieve Secrets Ultravisor Call support
Date: Tue, 15 Oct 2024 13:28:53 +0200
Message-ID: <20241015112859.3069210-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WNb7Gix-m0yrwepuIlHN3QN5e-5mm2I0
X-Proofpoint-GUID: WNb7Gix-m0yrwepuIlHN3QN5e-5mm2I0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=358 mlxscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150078

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
	* rename BIT_UVC_CMD_RETR_SECRETS to BIT_UVC_CMD_RETR_SECRET
	* Streamline list_secrets()
	* Fix documentation styling issues
	* Simplify conditional in find_secret()
	* Add r-b from Christoph

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
 drivers/s390/char/uvdevice.c          | 154 +++++++++++++++++++++-----
 5 files changed, 442 insertions(+), 54 deletions(-)

-- 
2.43.0


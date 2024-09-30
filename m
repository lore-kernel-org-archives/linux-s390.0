Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07931917F1;
	Mon, 30 Sep 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702360; cv=none; b=PzZ13Fhv8cxP9LcBUBMt5CJM4KvIL/TOGiSSCS5sh0nqtnVQxtALgIsMJWn5QdcCclokUmxJZPQG3SvpsQSsxl4JFC0uruchMthAq9PYiB2lUmIPpgvzxPbSr9syIVFxbQOdw5G5NlawIOEuwZyDXFzUIOLsAAeziKGp9jMPnms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702360; c=relaxed/simple;
	bh=LpUIPWLOnT9jGfbz/mI6mohuakmfmqF6V8TNyZ+PUaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0BVRsLQFZdvNZ8r3tCtfDSSpAtYkf0KdGEO35ux2SYCKh0nJI/HItcLZL4eW2r57j9zt4DVi7nAKvaMzn5DLcrbvmez1JG9k5sdUDHkh8h8RRMBEOs7YnEhEwSgSdv0ztikKdYeeoVr1Lb/MSQLI4UsrRzSM6HclbAQFFdz5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XMY10wVK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XMY10wVK"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U3OMMF014459;
	Mon, 30 Sep 2024 13:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=RN2lWMaR/vU/WVNwFmMxL1VIwI
	n6mYAHKcvy3yGhnUY=; b=XMY10wVKaADBTCAdGrzOd1zY+VwjDBWQyM7+kh1AzH
	oqhAGtPXmuF7yEBSQH43PxJBJW045OCkZQRvELY7Gikd9Ito/mwCDpTqH/1V1dwV
	osFZ8DTIF1ia7RyzEuadediquAKaV9HP090RiQtPyraKiDdOIDqoDTaImZIHSIjS
	3dcxPdBnX3AqmJon4CLPEdEposU+0cvS3NGJ1ROzPxNEKQwlCPecjuY89BpZI8jh
	GbKYhESme/gJyuxnRRN14IIOUEuztbqqVee4YXajrFzSoLRT0MFJdtnJAYCL3qt+
	7Z2RsiC+Hbf2CeuAdlsu3QGXywVATi02ma//SlYeh6Sw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x87khr23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:19:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UACsYc020419;
	Mon, 30 Sep 2024 13:19:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xv4rxvsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:19:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UDJAGi29360882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 13:19:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 493F620049;
	Mon, 30 Sep 2024 13:19:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D08F2004D;
	Mon, 30 Sep 2024 13:19:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 13:19:09 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 0/6]  s390/uv: Retrieve Secrets Ultravisor Call support
Date: Mon, 30 Sep 2024 15:19:03 +0200
Message-ID: <20240930131909.2079965-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AINgD3vbAb1goHmWLypr0uxM8-lGrygw
X-Proofpoint-ORIG-GUID: AINgD3vbAb1goHmWLypr0uxM8-lGrygw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 spamscore=1
 priorityscore=1501 mlxscore=1 mlxlogscore=207 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300095

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

Steffen Eiden (6):
  s390/boot/uv.c: Use a constant for more-data rc
  s390/uv: Retrieve UV secrets support
  s390/uvdevice: Add Retrieve Secret IOCTL
  s390/uvdevice: Increase indent in IOCTL definitions
  s390/uvdevice: Add List Secrets Ext IOCTL
  s390/uv: Retrieve UV secrets sysfs support

 arch/s390/boot/uv.c                   |   7 +-
 arch/s390/include/asm/uv.h            | 140 +++++++++++++++++++++++-
 arch/s390/include/uapi/asm/uvdevice.h |  34 +++---
 arch/s390/kernel/uv.c                 | 148 ++++++++++++++++++++++++-
 drivers/s390/char/uvdevice.c          | 152 +++++++++++++++++++++-----
 5 files changed, 435 insertions(+), 46 deletions(-)

-- 
2.43.0


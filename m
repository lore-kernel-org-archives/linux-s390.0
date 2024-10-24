Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820A84037;
	Thu, 24 Oct 2024 06:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729751206; cv=none; b=cLCiwN27FFYOl8UTOelYMzsrY4S/zbSBw78IlAUPQVDenXLf2LRcCaXr0a+FnYCPecNnTKDLezOfv84BbT6oBRg+EG42E64u+6jVv2XedBLp10ifbKDd4otap7NzNDt6bkOnrMpnZSaFw0ji8PLMVjk4fi7HI8w/VspOYaMp/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729751206; c=relaxed/simple;
	bh=nFBY75P+Vby8zbPYa03I9ghY9JMgly/ZA0t8inrS+iM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XefI3viVrldVz6XeAED9PPItTMVGZ3+xtscch9AlnvQT6pfxVPUs5N0vitm6I2Y7NSX42PJuvBAOWB0vU+FvggtfHLQz8ufz3O0CNEwIJtSol/zBmeXkseTST5vZdDDOCo5kADkCRHYBMu40Ynjfd9580ftTRtp4LNn1fjv0eMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BwWo9Bj4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BwWo9Bj4"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O0fIXX014640;
	Thu, 24 Oct 2024 06:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=h+lkJheNxL0hp4Wxbr2WKJx75D5DL2RRTvtN8/f1+
	ds=; b=BwWo9Bj4DtCp8aZdfvEswcuSbWzuumVDFFnk/a7DLAgOOd3diuwSXKkbR
	P0/E1OjA+7nA90iykhjsAwtD+CcezJUJgIey7sDw+2AmgKyIIL4koSqk1KnLKoD+
	csTHHWSWgR7zvILgcNlnsxHXI/Q5g/YxuGPdC44ipoKZ/jkD3fTbd/BCrD+/ENM3
	puF8Mxt/BMgMwyWDces+Iq/oQjzFqZ6V1k0Y40v8/g4rDo5Yrj3UxTlloVF/PxoM
	HAcWcv3BiGyzmzLfpvCygyEP9aq7YtL6DOXTnQ1OOmfhalP8IcRJCfAMXmbe9pNp
	heEGBCiXe2YzDtqPzxbnK4IzCw54w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fbw411eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 06:26:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49O2iO3i012614;
	Thu, 24 Oct 2024 06:26:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emhfeyw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 06:26:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49O6QdQe33686130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 06:26:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9FB62004B;
	Thu, 24 Oct 2024 06:26:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAD7820043;
	Thu, 24 Oct 2024 06:26:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Oct 2024 06:26:38 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v5 0/6] s390/uv: Retrieve Secrets Ultravisor Call support
Date: Thu, 24 Oct 2024 08:26:32 +0200
Message-ID: <20241024062638.1465970-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LVtzs02vwyNPQE_IKW18BfKBMuiE7R-B
X-Proofpoint-GUID: LVtzs02vwyNPQE_IKW18BfKBMuiE7R-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 malwarescore=0
 mlxlogscore=395 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240042

A new secret type (group) allows SE-guests to retrieve the secret value
from the UV secret store. All retrieved secrets (but plaintext) are
retrieved as a PCMKO-wrapped key so that they will never appear in
plaintext in the secure guest. Supported key/secret types are:
AES, AES-XTS, HMAC, and EC. Add support for an in-kernel API and an UAPI
to retrieve a previously added secret. If the hardware supports it,
adding secrets works with the same infrastructure that is used by
associate secrets introduced with AP-pass-through support.

With this addition List Secret UVCs can report more-data now and may
expect a starting index different to zero. This requires the addition of
LIST_SECRET_EXT IOCTL that works the same as the non_EXT variant but
additionally accepts an index (u16) as input.

Sinve v4:
	* add r-b by Christoph
	* use struct uv_secret_list for uv_list_secret()
	* pack all new uvcb related structs

Since v3:
	* converted an accidental kernel-doc-comment to a normal
	  comment.

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
 arch/s390/include/asm/uv.h            | 147 +++++++++++++++++++++++-
 arch/s390/include/uapi/asm/uvdevice.h |  36 +++---
 arch/s390/kernel/uv.c                 | 153 ++++++++++++++++++++++++-
 drivers/s390/char/uvdevice.c          | 156 +++++++++++++++++++++-----
 5 files changed, 445 insertions(+), 54 deletions(-)

-- 
2.45.2


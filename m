Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD7C1D0DD9;
	Wed,  2 Oct 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885141; cv=none; b=q/YpuRgprG+JlDh0Kgys2wpG6ZVuJgEct7CqRe0lkVAWjJ6KGnMnQ+AoLBXfbqEWOBwtpd1rGRN7U2UCw+g1qv2ue0km4PHtPLRxmR/GYZJvJZbut2Pj22ax0w66fCj/S7u430O3SIz1QqOBysvVnYdrmnoeSue8whJlISC8SaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885141; c=relaxed/simple;
	bh=qwBeiKmrWZavTSopIky3W0gY+tBJhz86HgBgUOzovZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9dlVlLuinCzv/5IATEGDQ8bFycGHrksD/6OIUNSD5Mi6ufIQKksFFzL2ViyyclePjeRSSqra2RRse7Q62/+/IFOmxhMf2pNn4eMSF7J76sR7GH13ZJ9ewGyoZaDE/4EjNpG38QJSYvT0a/KWFSRtIhCk91+C31Yaqk6eOLUbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sc6za7fl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sc6za7fl"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492FlxCN029150;
	Wed, 2 Oct 2024 16:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=/W8EpT17ERHcsyvJzkJhbLWMJt
	BbdbQgdsoMQ+OblZw=; b=Sc6za7flo8xmJ2ylg1BZPqS6AIX52+Xypw47osPuoI
	KpJVfzZlzQJCBZ27ZlIWDRirPZSceqYw25h7FH5T6fCUX3Auj2itvwyg69KVG/Ld
	E12VcDJFPgE4PpGUB+DJmQo6Tutf6nYhBwWf5t8umaChIq+Kfljt+giuva8scKyK
	vAReR24yY167+vK0lgPYGLkAVKdnnbMUfJnfWtA9Me/uHLl/Hrn5l0h6y5q1x49F
	VXVgYuqfkYtE+/S8T8I/mxDgRfgul2N5mAo9/gsgsp1znUXueLfYXaVzuvcM3L0S
	G67xbVEtVVvUBVoNXkQE24RbwgMvafu8IEJVXGIkEfwg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42194n833f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:05:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492Fn24k008050;
	Wed, 2 Oct 2024 16:05:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgy3byp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:05:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 492G5XF659638076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 16:05:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78ED920043;
	Wed,  2 Oct 2024 16:05:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28CBA20040;
	Wed,  2 Oct 2024 16:05:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Oct 2024 16:05:33 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2 0/6] s390/uv: Retrieve Secrets Ultravisor Call support
Date: Wed,  2 Oct 2024 18:05:26 +0200
Message-ID: <20241002160532.2425734-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vv_VHoxvFpAwbw_PVb5tQfOWlwWKAvhi
X-Proofpoint-GUID: vv_VHoxvFpAwbw_PVb5tQfOWlwWKAvhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxlogscore=284 priorityscore=1501 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410020114

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

since v1:
	* added various r-b's
	* fixed nits and minor issues

Steffen Eiden (6):
  s390/boot/uv.c: Use a constant for more-data rc
  s390/uv: Retrieve UV secrets support
  s390/uvdevice: Add Retrieve Secret IOCTL
  s390/uvdevice: Increase indent in IOCTL definitions
  s390/uvdevice: Add List Secrets Ext IOCTL
  s390/uv: Retrieve UV secrets sysfs support

 arch/s390/boot/uv.c                   |   7 +-
 arch/s390/include/asm/uv.h            | 142 +++++++++++++++++++++++-
 arch/s390/include/uapi/asm/uvdevice.h |  34 +++---
 arch/s390/kernel/uv.c                 | 151 ++++++++++++++++++++++++-
 drivers/s390/char/uvdevice.c          | 152 +++++++++++++++++++++-----
 5 files changed, 438 insertions(+), 48 deletions(-)

-- 
2.43.0


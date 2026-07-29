Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA31C84A0
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317784; cv=none; b=LpfDTMGM1lRPH4d2iT60ngg/w9rKedvV66pjj+h7J+xDSCO7atvAMhYgwl4HzY5RRBf4OZFlm7Jb+crtCTV26EBliaCRo4HQtj9iQoYHgaLCUOZX+9ezlkCGCMbThVoFWGqLXb6kDA8I4mQ/eQOJqytI+QKV0aqScBM/wwN0Dx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317784; c=relaxed/simple;
	bh=csCIH0dUkazl2cG9+wgLA7QvnjufGJSMjys9Rl572ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRrn/JyUcWMh7IsTSY8fz1x49h2AgfDutN0mx1qSR2+HyOGRKNCo2C2TnY6ISHiUQ8M4KvbtIagcdg56bOqyQ7IJJCT1wnNCa6MZjHdUP//nymbcBuCHN1Y16Xb4uLjC1aHHgYE6rzYRev3xg93K1Mk7Yfl9sUjmgjnAhJimsUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lUVo8ndO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lUVo8ndO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7mMeD3507680
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ugBCW+tZ+KnzNP0vANbLrYtMJ3/ML497Kgfcg2dVx
	NI=; b=lUVo8ndOK1DQr+mw9ZHSXvp2RHYs5jo4atgE56op+13Doa1YeuihGtkFu
	HhPP0Xn5w4R1Zm8Q0h5ePjjeMXqIBIj8KHYL4G7icGsAKI+OVip4aCRft9Eq2i6l
	aecY8tnAVApnBTHi3KVwxxTFpxIi3ZnR0EIrrwbZn0lqlHZ82FBE27wyCF6osIGc
	Kacru4VdPwuN+ApeNNFsSOYZYpLSFttR4fx/Dbyk1rQw34hxFuTPe3njWGZF06mG
	7w0V7wt2xr2X6TXh5G5PzIVqiDwzt0YBe/3au0gEt1mxjZR1/euMNZaW5GXhGi8C
	3Z7qWCAXb7WRJIOlk5XB2cR8Fm+lA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj96f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T9QFmY032209
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgdw3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T9aHxg31129888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 09:36:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49B8220043;
	Wed, 29 Jul 2026 09:36:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED26420040;
	Wed, 29 Jul 2026 09:36:16 +0000 (GMT)
Received: from ibm.com (unknown [9.111.67.171])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 09:36:16 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: freude@linux.ibm.com
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, ifranzki@linux.ibm.com
Subject: [PATCH v1 0/2] s390/zcrypt: Validate length in CCA key requests
Date: Wed, 29 Jul 2026 11:36:14 +0200
Message-ID: <20260729093616.4184642-1-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA3NiBTYWx0ZWRfXzfHYxusXddXI
 jUBqzl5/7AMVKhEnA9oPwDLGFyfa5/lm9YOx7OP8boSmJ3fP9e+iOYgOkhy30zVkrjlxu7ZZEBF
 QJH1OyKgqu/kijwuDc4Qg7Q/fuP2d1E=
X-Proofpoint-GUID: P18pUFchKKQvoZDoTfnZBKQM5ISNdjb1
X-Proofpoint-ORIG-GUID: P18pUFchKKQvoZDoTfnZBKQM5ISNdjb1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA3NiBTYWx0ZWRfX35IBGRvnma4s
 O5ZBVr0BWzJesGN7dh4zq8/kwQqE/4+Cm4w5i1HJnKWqgYvNm5zOfGIyTQ26NChH69uSk8ig12e
 Id6oJEW33akXwBxrOF7eExBeycA0QZ3eegRbFNwqnwcqReV5tTI9IFoiFAcl3lrUhkDledZqwYo
 tqNR4BakAbilRnzlmAbpThjZ9719Hyr2xZIPdG9vEjo2VqnLWTb9E8GwgLfQGckBgKkmEiPDDZ/
 cIRV0NXfUCpBeL/X5MD5v+pGehLVqFbfRQE6CfjomvZ0v4yo4kATY8JZmmOaqCcOqNMrlpruz09
 wntdqU6kC2Y+MYTyNNsk/qXB3jLXxTbbrjrPDE/WBHhD8BO7TpJju5hgbf96AebYamJ8IUByayO
 j9kEjPXy3M/whgC+gIb9JzyyFGLOlY5FS8mxPTbvx1yrDbTQYGOeM6m+eKLzVCOVEnvSrFNW/ky
 VQZNOo1M8FWiFUGhcrg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a69c995 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=eZL2FeTKUk823_XBMisA:9 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290076

The series contains two missing length field validations for requests
with CCA AES cipher keys and CCA ECC private keys. In both cases, the
length information is used to copy the payload to the request block
without checking the available space. Malformed requests can so cause
out-of-band writes on the heap.

This series applies on top of Linus' master branch.

Holger Dengler (2):
  s390/zcrypt: Validate length for CCA AES cipher key requests
  s390/zcrypt: Validate length for CCA ECC private key requests

 drivers/s390/crypto/zcrypt_ccamisc.c | 6 ++++++
 1 file changed, 6 insertions(+)


base-commit: fc02acf6ac0ccde0c805c2daa9148683cdd01ba8
-- 
2.55.0


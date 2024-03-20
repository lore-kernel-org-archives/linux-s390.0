Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E76BFDB
	for <linux-s390@vger.kernel.org>; Wed, 20 Mar 2024 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975628; cv=none; b=QcvuhIpng0zZTlZVod2C/whvYd69KqvRTLRVR3hE5dDAoBceG2khzQjHOS/RdQ+zc3n6ovHVhimOO3NGRIJAbSu0tjv0aCps2F9mdhZ6w++bGYoEgopwlugOZt3LZXs/LzVdXpXPce3K8fPPLMqdRYz+H1JdqQscoDX5WdMs/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975628; c=relaxed/simple;
	bh=hy6Vkp/ydKZ9zp2U1A6lQgXD/kNh8u5vu9Gk0MZbGRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQkVc6LeLWNCgguEz0Hzie3QZBaup4lYWMdWoOYDHJJUoxQUF135QipQL4mrPrrLZZXoqbQzEzpe28mm2o7llmsR7HE/PWqoBXcFW3mDm89bbC5Yoa4WvanAqbmYbYUrmAFytiQtkYH11hFho5Hr24G6jPPCpKyBDLyg9i4M5Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jk3h8JPD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jk3h8JPD"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KMNrgm021219;
	Wed, 20 Mar 2024 23:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=4TJYg0dTor3+yKTjOC4JBe+DsvBh04JlJLsYBAYvyOg=;
 b=Jk3h8JPDtg6LLEGSoAF/5RTk1LvHI4Lxndq0/mXi1fhCo6Te9NOMOFgdQ/sLDGxM6yEm
 1D1cN18lRIu6dbrWauD549yo3xtXtZcdy64pHebWa4UpJV/oyOzJ0OJy/74OyQS0hecx
 xHEznlkkeiv86WZUAi7f24iTb9ynZY4+EiUWrBDoAB13VP0m0gRsp7KPvbFsAPckt9lS
 5fLy1FJ/vXvvmK+Kqv/Ab60qoW9/gg+kty5p02uvNHs5JYeEOHfS9pa4fqhm/akTBcUe
 NS6a819+ZP0b7M/eTr2DUslYQFe5UGJ+gHm3MpNFhSyonb+qdP77fcPY7GqSnKQj/NR3 uA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0644rbs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 23:00:22 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KLZtV2019924;
	Wed, 20 Mar 2024 23:00:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwqyks1s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 23:00:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KN0Fik38076708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 23:00:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48FA020043;
	Wed, 20 Mar 2024 23:00:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0B7520040;
	Wed, 20 Mar 2024 23:00:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.8.38])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 23:00:14 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] s390/preempt: mark all functions __always_inline
Date: Wed, 20 Mar 2024 23:47:47 +0100
Message-ID: <20240320230007.4782-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EWUkJVbtfzYIYmPsJpKDiNmaqNq1blNZ
X-Proofpoint-ORIG-GUID: EWUkJVbtfzYIYmPsJpKDiNmaqNq1blNZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=691
 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200183

Hi,

This series marks all functions in asm/atomic_ops.h, asm/atomic.h and
asm/preempt.h __always_inline, and is based on the discussion with Mark
[1]. It's one of the changes required to unbreak the work-in-progress
KMSAN support on s390x after commit 5ec8e8ea8b77 ("mm/sparsemem: fix
race in accessing memory_section->usage"). But it also makes sense on
its own, and may prevent issues with the other sanitizers in the
future.

bloat-o-meter says:

  add/remove: 4/5 grow/shrink: 58/186 up/down: 4408/-6368 (-1960)
  [...]
  Total: Before=29725530, After=29723570, chg -0.01%

Even though there are changes in the code generation, they are
insignificant.

[1] https://lore.kernel.org/lkml/ZfhI0F-vXMMw1GzC@FVFF77S0Q05N/

Best regards,
Ilya

Ilya Leoshkevich (2):
  s390/atomic: mark all functions __always_inline
  s390/preempt: mark all functions __always_inline

 arch/s390/include/asm/atomic.h     | 44 +++++++++++++++---------------
 arch/s390/include/asm/atomic_ops.h | 22 +++++++--------
 arch/s390/include/asm/preempt.h    | 36 ++++++++++++------------
 3 files changed, 51 insertions(+), 51 deletions(-)

-- 
2.44.0


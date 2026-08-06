Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D22BE056;
	Thu,  6 Aug 2026 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020770; cv=none; b=i02ZWviIsCpBhgVL2Nnr1afjcSY8dTuuHmFWtWXf/1yg6I+OdkRl2nqlGfa7O9SM2NIu87Fvwg86va72YVPfU7ocBWSJ4mj6nYfFRKrjuqSXizY4DBQsfFUWAcZz1yC69Zng7slZr/Qnjdm/J8OmtMjAZBmNWTi+QqW+zDCK4ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020770; c=relaxed/simple;
	bh=CtjnuCeIYXta82XIwCO4KGqoUEdk5e6L+MFxoe/grbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJKDtnnbt4WDXfiNgdP1r10xsmL2jGwPsTq68/z2ewaVFOaYUlKBZTqJiEwpp5Afqiu1ayHnXPuQP5cNCqCNVBEHMVoRlVWALRy2R9lAhi3pM824s8ZmX/OCf7ST5X0CYH54rbL6/7/CSxtvceLvM4//oqM8tPQcbrHkuLQB1SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qyze0idw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qyze0idw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Nle7A1066093;
	Thu, 6 Aug 2026 12:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8dF2H4Qq9CUzZEaxWgnE5XrpOGOuUcwqzmTNCeF8d
	ls=; b=qyze0idw87UXUayzvDKRI+WrAA6Pyq+l8zMwlKKpk4vak8EYCIysxLnVq
	Y+vkhy+xdanFZOAYX41u2qxjDTuE4BiReI0NZ7VvzSn3GVyBqjVo5POk07hNMAyb
	H59neDeXT/aYLwE0Vl3r1IC4Fuo2q3AXKOBvz7uQuV9/rzrpW+3gq4QPZxlP2WlA
	CpKbzKUpvUAMNH2wJKtC3fUzju8H5QhK9fdYHolrz/VsvDsUJ97q8wlAs3Jz/6Gh
	OKxzB2iufo4dLuCe+P/b28qtFisx0m5yiMgnKJgOvlEKDOBX4xh4cZ92RpBZN64K
	aY2B7DKTr4hAnMrRJ2Gfj0TM9zMqw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a487es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 12:52:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676CpBN9028811;
	Thu, 6 Aug 2026 12:52:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgk04h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 12:52:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676CqiI732244384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 12:52:44 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5202D58057;
	Thu,  6 Aug 2026 12:52:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E96858059;
	Thu,  6 Aug 2026 12:52:42 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 12:52:42 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 0/1] address one of sashiko pre-existing issues
Date: Thu,  6 Aug 2026 14:52:40 +0200
Message-ID: <20260806125241.210170-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a74839f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=J3Qewhdv2Gq3w6V-qCwA:9
X-Proofpoint-ORIG-GUID: rWFsUBk4jlbImeu58p3_dIWzxCxzCfEP
X-Proofpoint-GUID: rWFsUBk4jlbImeu58p3_dIWzxCxzCfEP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX+jZ+OjGX2vgO
 xk1lZSPsUOsPGKvPCUu8K1fe1uCdSp7PRB7kjIyJezKkMlWIvf5E5brDZoNxmZcN3OF0nZH4eGs
 1QTvn2YzSyaPHFVC2h6oqj1sBSPDxwY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX1lIIp3tp8SWy
 0KmO5woEN/9WBP3K0itIX6iQZ3YNiZIvd5qPPi1S58XO5S6iq2NzH80I1uUZMr1qdJK9kijVfu5
 uyUt9e52ivAP9BxelOQ2GvCfhWT6+1T+kf6qFkI97Sr0bx18g/goSGrtIOlnXAody6A5kBKOqwE
 LlUYSBYNtjjoLxpqCABUNbyaubfmWZbM3pHwoWjqdfikARiRYJO8xVruFuNBnNaGIP9pax9g17T
 ZUPOyWMOCqfi4OyvF++s4+cZQQ4r3EP0yqGHOq+ET8QBtAVUm36NcySvu4IqV2Gx8CU+ZhUKxhu
 iduVYJ3Z+Oh5lhjQCLDCfDIOqQ5NUvqXcKpcEzR9FBcKR0DWLIC8Ufb5kZvJrkGwgu649pITLvF
 a/s1s7t2+W+VCD31th0TVzoYBtJfA8M5S9ZovBGDLF4fUv4puKuv+rBJbj93poPLtrWC0+c0F6P
 i2O5yn6z3zUfC9lgdCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060101


Heiko, Vasily, Alexander,

this touches s390 nmi code. Please review the change.
Shall we move  MCCK_CODE_NO_GUEST into nmi.h and use
that for masking in s390_backup_mcck_info as well? 


If you are ok with this, 
shall we take this via the kvm tree?



Christian Borntraeger (1):
  KVM: s390: Fix memory corruption by not reinjecting CK machine checks

 arch/s390/include/asm/nmi.h |  1 +
 arch/s390/kernel/nmi.c      |  4 ++--
 arch/s390/kvm/interrupt.c   | 24 ++++++++----------------
 3 files changed, 11 insertions(+), 18 deletions(-)

-- 
2.53.0


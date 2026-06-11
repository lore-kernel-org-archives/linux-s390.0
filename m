Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6CD2DCBE3;
	Thu, 11 Jun 2026 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187783; cv=none; b=ie4ObtRHmUaksdxUt4XRQmACPMjvlQuHmBoolx1ZHNSuGXsaEY7tB29Wzc9ivwbTQyz3cAV/J1G2CljOiT3Qkv1Wppa8OVn0vHpJ5NJ2bkJLntUlXIWo/cx2Mr1Y3VGWRzJWfk4GYwvD82znII4YCpIaLr7CAn14UAGd3y3zw/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187783; c=relaxed/simple;
	bh=tX/92/tU4cFpVcEqtp/jLPvhIPgb44+MQAXza0iNHW8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BhL8emKpUyeX0n0JCeO33stdJaGFa1wyxnX0I02miVb3CBE/roqB8z2i6qIIOS+GjoKmCuMHmIpf9qzRaq2vrmbVozovZbXUIDxnBFPLUG3msvbXLzsIZDQ7iWCzYP270TbSf0jbeFh4AvVAvYTr4BOIyN0xPGDsAI0LKhEFVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YLGFEYQ6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YLGFEYQ6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BCLuap722324;
	Thu, 11 Jun 2026 14:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=K6BLSpzmC1KdDD7E4BPhh1BxT1XHUsi34R0+4pJ+7xk=; b=YLGFEYQ6
	MVJkoronwdmO7RTohTMmxyuSP9STXIssTEq+2CtJ5NbzhGOx0NEl4zF74aV5YAFE
	NGVpBewFLdtKluBzxJ55Cqd4x5BmTVOChX+8JLePpONQYHgx+KR/VPCr1VXAn77U
	sTLAPjbke21xLMWDGdtSBLp0PXWsBnp+G2YftrrQT+skMCGbIv5ilqjBO34OozQo
	XvhFKjKvQCRhbBDTxeHY5WB3hNJZzTbujqjWTTFw2m9mBQMg5+bh2HaGdlpttbwZ
	/vOqVGL5xkbFbnWNp7j7VD4Eh2iJsqiyBI7BVkwvXldVJTTmDqGX8WYjIKnvbsGA
	NXazzY2iKpFdog==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8dc4xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 14:23:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BEJadm020634;
	Thu, 11 Jun 2026 14:22:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09kh1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 14:22:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BEMtvi44499432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 14:22:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BB9820049;
	Thu, 11 Jun 2026 14:22:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72E8C20040;
	Thu, 11 Jun 2026 14:22:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Jun 2026 14:22:55 +0000 (GMT)
Date: Thu, 11 Jun 2026 16:22:54 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for final 7.1
Message-ID: <20260611142254.3501080A79-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0MiBTYWx0ZWRfX4SGXcwLPvjHf
 7EUgNBbUCFQN6/CXb5qWorj0lCpocMqYM6oX8LD6e5UEZVByRy55POvGDur/NIjEpLWaZtAGiO9
 19uTAvKHNMHM+Qo09FnxI/3rGNZd0CA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0MiBTYWx0ZWRfX+m/oYGH5ANjd
 F3pA6PEnMV4h+h+SjFLkt/zV/qs7PH0Csb7s9pYyQY3kKZtexfPqgh1gN0hO1G9AJpJsrIE9/RO
 XTBkhpgvZ056OZLbCxn2XHEYklNBosYZHEfpsiPqoQN6YXIvAzUX+IBXLEiJlyxCyH2oOROifN4
 i/41hfM53tC5vpF/9u2aSARjlVMazYs+mBrTejEvcGzYWCrvljEClo/JBosgKMmRqcrRG8R7xLm
 uq2SFSFxVbJYQGQIHsRwh1rZ+Eacr+w4tkiiYrQ9pq2s/jhe7lQkuC7T9fyo0ZUw4SaDoJi8jBg
 K7jj8ACYlTwMePEax1A91G4/+jzVr0ZNtzp1YmztTX4n7p0Nlo9TtkHLU7wEkPqkPaQlBpyIbO0
 yOaqK60KwANYBSqet9a0pws0K/09dn9RBY6iaJkPNpfRSKLdjsLT0KCZUjU3JFEzYo9KyZc/ROy
 bLmzKVYk7DZFupnwc+Q==
X-Proofpoint-ORIG-GUID: ltwuWWmGr9KfraIPjzsdIJqnWEW-VPEV
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2ac4c4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=GBxfbr-ptimD81uaDc0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ltwuWWmGr9KfraIPjzsdIJqnWEW-VPEV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110142

Hi Linus,

please pull s390 updates for final 7.1.

Thanks,
Alexander Gordeev

The following changes since commit 7c6535c37dbc03c1c35926b7420d66fb122b513a:

  s390: Implement _THIS_IP_ using inline asm (2026-05-30 11:33:32 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-5

for you to fetch changes up to 1f57f68c4dd101e5e8ffc9ffa6428f45bcdd776a:

  s390: Remove GENERIC_LOCKBREAK Kconfig option (2026-06-08 18:59:07 +0200)

----------------------------------------------------------------
s390 fixes for final 7.1

- s390 selects GENERIC_LOCKBREAK when PREEMPT is enabled to tackle
  an old compile error that no longer exists. Since recently PREEMPT
  is always enabled, which causes massive performance regressions.
  Remove GENERIC_LOCKBREAK from s390 Kconfig to fix the degradation.

----------------------------------------------------------------
Heiko Carstens (1):
      s390: Remove GENERIC_LOCKBREAK Kconfig option

 arch/s390/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ecbcbb781e40..9921a3772bf7 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -29,9 +29,6 @@ config GENERIC_BUG
 config GENERIC_BUG_RELATIVE_POINTERS
 	def_bool y
 
-config GENERIC_LOCKBREAK
-	def_bool y if PREEMPTION
-
 config AUDIT_ARCH
 	def_bool y
 

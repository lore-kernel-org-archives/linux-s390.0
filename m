Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24390285CA2;
	Thu, 11 Jun 2026 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190087; cv=none; b=RvplwyZEkp6+ZXKVm8+2rsV+atwYqnZR9TsuKlOvNZFc2/h9E7/uj6UeSXl/SRGbSGmUbi/IsVqfzbD2jYtZAviMJPc8B2igF8zZziRt16n60nxEdlCTvMTjSnrELEZIFdX/XhFJMKcTV+I7KKcCLwvUOOsTGUQGO1PagAQIzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190087; c=relaxed/simple;
	bh=rkcZzd+5gogBbHPFv8IfsAQ+03RLDEF+rpgYCkjlgkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1N9UYnRhYjZ8mmjTBY0R0Xy7YTvwIeXeCKxDAogiwFRf0+hJU4rnWup/3fsMT7czxlFAa/nLQ4MCiDOKZNe+hJKFa50/aYB4Yaehod0FyD+0gIdP2jTPjiu+0rvMHJLIPS97vdeLSz2n9vFthSCE8Rjw1UUWYMhrSpl7uoQaXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Are37pBy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Are37pBy"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BCPD8a4146525;
	Thu, 11 Jun 2026 15:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TrrAs1Fa4fTN85ivIg9qTZHVTAHE5ObbpOUHwoJ1d
	rU=; b=Are37pByELTfY72f+lyxcEbttr3EGFoVqIukqwyOxMRbbp3M+a5rzu71q
	CysMRWwhT44nP72TAwlJs+MDYIUF+HHkkf61c7Uioz7Pa9kufuSXr7aX2IpOAxQg
	MU//YvaQfAbtbv11SvDxH+0shKPyD9egbspy/9NQO+8GFwXvAd1GX/oS6kIRpu+u
	UwUL4B7WSwwG/jCij9e/QuvN3ixOa7eBOGGi6qpab5tBPlQ17iQxwdMRqOk3JGP2
	kKvIj+GzLxkTKcQjtmMy1i6caIlj6xNOO2iyXiwMgvyUWXHUjNb+kpJHek/m+z/X
	H1BCs5dpnFUWKsiLbDGKRMTKrDYEg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c4d5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:01:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BEncLL016672;
	Thu, 11 Jun 2026 15:01:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09unkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:01:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BF1GO748628026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 15:01:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDE3E20043;
	Thu, 11 Jun 2026 15:01:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A49CF20040;
	Thu, 11 Jun 2026 15:01:16 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 15:01:16 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 0/5] KVM: s390: A few more misc gmap fixes.
Date: Thu, 11 Jun 2026 17:01:11 +0200
Message-ID: <20260611150116.218162-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NyBTYWx0ZWRfXw+yTZgAgHvwl
 OaB+iv8QhBBiE7KauiEOkkV6RWcnu/Xd6VAwW8q6jWZQwIblqqdCv2S71U7L2MckpxT31gaBswG
 gbHcmhnCivpC2lfTa1y4CmiuFQ90SzA=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2acdc3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=OaEHRyIRue6tST0iOIwA:9
X-Proofpoint-GUID: gAPC5BqK0-v5et1c2D9ow75OLVBR8ak8
X-Proofpoint-ORIG-GUID: gAPC5BqK0-v5et1c2D9ow75OLVBR8ak8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NyBTYWx0ZWRfX6rkxW1f6FDdE
 cOZ0rRJIHlS8qVJVYhA06LykUU6vAheixtEwvd8x8NO4vCHZ/0S+PtJ471BWcdlZtGeqtolI467
 5+MgXs86VO4wyPGTyD6Kx/3mklDgJqSRY24L7YBj/l9o/VHmDwGTb4Bo+EJ9gDefy5iR4qu5ViG
 gncvEg0sLx0oA5KFtyKXQRKcI20qV9Ixo5aGpnS8EPA82BgY2Ps3VM98zYllZLzvl91Ew+M605S
 V0VXWqptbwj66mUhJOKP+SocRhaJpGoIcPgngRsk76QqV+qLjJVTbpBE3sNuNq3N2C9Zm/hsX5X
 MuzZN2eevt/lfZxwkn5kcZch3jMTyMnYVSgeww+4sWcC6R3J4gbEWS1Ke7HyxE81Rv/mpdraWoF
 nXQG99wPMeAqW+Sg6W4VxfY5BDQOD/JrPZeSIzQeYNYxsSsLPIE4+Zs3225elsyi3JwwOqOEe7H
 400b2o0cySpkOh2wAEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110147

Ciao Paolo,

as agreed, here is the pull request with even more gmap fixes.
As they are not urgent, they can go in the normal merge window.


The following changes since commit 9716c086c8e8b141d35aa61f2e96a2e83de212a7:

  Merge tag 'pm-7.1-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2026-06-10 11:53:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-7.1-4

for you to fetch changes up to abeb7eb57f1671d9185ddf11236c784f07bdb928:

  KVM: s390: vsie: Use mmu cache to allocate rmap (2026-06-11 13:50:09 +0200)

----------------------------------------------------------------
KVM: s390: A few more misc gmap fixes.

----------------------------------------------------------------
Claudio Imbrenda (5):
      KVM: s390: Silence potential warnings in _gmap_crstep_xchg_atomic()
      KVM: s390: Fix unlikely race in try_get_locked_pte()
      KVM: s390: vsie: Fix allocation of struct vsie_rmap
      KVM: s390: vsie: Add missing radix_tree_preload() in _gaccess_shadow_fault()
      KVM: s390: vsie: Use mmu cache to allocate rmap

 arch/s390/kvm/dat.c         |  2 +-
 arch/s390/kvm/gaccess.c     | 73 ++++++++++++++++++++++++++-------------------
 arch/s390/kvm/gmap.c        |  7 +++--
 arch/s390/kvm/gmap.h        | 14 +++++++--
 arch/s390/mm/gmap_helpers.c |  6 ++--
 5 files changed, 63 insertions(+), 39 deletions(-)

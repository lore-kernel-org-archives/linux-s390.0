Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4EF3ACEF6;
	Thu, 28 May 2026 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968859; cv=none; b=qDG2V3QBKmQjptZKGK3lA2keSW36utaguoqJyjENMXNVElIWr412YJYzKYt9vMP81wF+gtjBG4ynI4FCv9pj/UVdB75vLQcTjuQ+gNtKox3A3Q7QB8e5vYcKV7edeyxDbTjjJn1q7MVCc4mo2r1+xfc+A00J46bDSd9cZQ5UKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968859; c=relaxed/simple;
	bh=CoQaffJkzuFoI8JmTQ3+VqaxSBR7ugJRQKB+dhlJCPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZylDzzIJoYEZaoYZk6olsz6/okNOGs7H3jWcg8BT6SvwhnVPgZN8ETwVCPmp7m5CGaJw/g8+4DWugF8NNZRoXulaTlz2WYshAjLq0ny0a6fSs3lQE2qQpeJ+TMGxz8bXwkk1DZvDrGPdgJC8NrGB/g+1zG7y5fgszOrH3bjb530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iNowLqNK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iNowLqNK"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RL6dRK3426749;
	Thu, 28 May 2026 11:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FN0GLVxPetl41QnFQlO5InM+Hp5ASthC/kY9EQd08
	Ws=; b=iNowLqNKplk4x5N7TOKIVspFD6kb8nFJiFBPA2P9Ay6aa1/HL+AdHNl5W
	JI8L6LF8/imjCx1TaKrOsSiICu1oeTFUWbGgxLhYU0ipZHYSq8yCI55Cof0sKw85
	pNClQB1LOfioOXVw+e73WAIjonLmQfZLvo6CwErE+nxhvIkTx29XCt1pE5v8wEn7
	Rt/wgt7G0ymUuL5lTHZPLTuRtbIsGXVsB7tI1vrEkvOQnbgK1ZiiWNRBBKZIDv94
	izRMyQzTnVCk1YJjT42bCeUHZxtSRlEyxkqG0chiGDez0IXqS4l515WSi/F87KJ2
	eVgNXLnQaNGvwlTz1TWgDIYzNwJCg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884jsyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SBd6An028891;
	Thu, 28 May 2026 11:47:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbqw8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SBlSmK43581884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 11:47:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52BBD20043;
	Thu, 28 May 2026 11:47:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1777220040;
	Thu, 28 May 2026 11:47:28 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 11:47:28 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 0/7] KVM: s390: More gmap and vsie fixes
Date: Thu, 28 May 2026 13:47:20 +0200
Message-ID: <20260528114727.142178-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a182b57 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=RDX2kTa0qNrNx1cvdRQA:9
X-Proofpoint-ORIG-GUID: eBKcLURmMYv-dZa7i5UR5JxZ8b8ioJpd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDExNyBTYWx0ZWRfX2cdSl1vzD0Lx
 V6xfIisv/oh9ergRFXWYrGs5B1w1HSEBxysK4LdCs78qr64UXktTEAnFjvxlcPlD/XWebLhc00I
 Hw6pP58Xo4Dm5+yY3jopJLI6cutQJE0hoBnlDM/qhKJmC95UOiuDEa3CqCEa+q4ZlFBpuvwTcZL
 x/7zZ7ExHQusRxPMYu5f0Z3gFrA0trfzz465oX2+kJLTOS0EhFbjTN9ktkraj98yz2yLgQTjANS
 xXlwwdCAXFTlLa+fCoWbbJEjqbgRm7KFv3c7LTMDZmJsogIwb5M4yClXHB090d4di+PTIBe9nKA
 qFHu/fopMTMRB41PwxI0+kCgRa2mEmVkL6nfj8/YFdaYR6isu+OxhaUcAIUWNpv0oi55aS0Op67
 LVFJzz/qBlcafnRiEw9JYLRmXyjoFUFhsahBePpxVmkGdEMoyg/PUqWINXtGbBdVBTRo/OemfXr
 4TWiLm5PmniG2ObXFmA==
X-Proofpoint-GUID: eBKcLURmMYv-dZa7i5UR5JxZ8b8ioJpd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280117

Another batch of fixups for gmap and vsie. Some minor fixes, some
not-so-minor fixes that could have caused guest corruption under
particular circumstances.


Claudio Imbrenda (7):
  KVM: s390: Fix _gmap_crstep_xchg_atomic()
  KVM: s390: Fix guest / virtual address confusion in _essa_clear_cbrl()
  KVM: s390: vsie: Fix rmap handling in _do_shadow_crste()
  KVM: s390: Fix fault-in code
  KVM: s390: Avoid potentially sleeping while atomic when zapping pages
  KVM: s390: Lock pte when making page secure
  KVM: s390: Prevent memslots outside the ASCE range

 arch/s390/include/asm/gmap_helpers.h |   1 +
 arch/s390/kvm/faultin.c              |  13 ++--
 arch/s390/kvm/gaccess.c              |  11 +--
 arch/s390/kvm/gmap.h                 |   2 +-
 arch/s390/kvm/kvm-s390.c             |  24 +++++-
 arch/s390/kvm/priv.c                 |   8 +-
 arch/s390/kvm/pv.c                   |  15 +++-
 arch/s390/mm/gmap_helpers.c          | 111 ++++++++++++++++-----------
 8 files changed, 121 insertions(+), 64 deletions(-)

-- 
2.54.0


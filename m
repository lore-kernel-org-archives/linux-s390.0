Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0713988F8;
	Fri,  6 Mar 2026 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813820; cv=none; b=MlTiC2ShWAH5s1cXFlFliSm/mlNT/og3ds7pum3UXw3Udiqtf1wJv+tz3FUxJ8C3SYGNlkEaT0edzcXy+W/zyAq1qMHN4lsfHhjE+v5Uu8CgmV0LuiYBx8dILihqRBtTlqUqUiHSKQ1jvvnNggZt3edfIyvbYLd4FKwR79dsb9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813820; c=relaxed/simple;
	bh=LqHiKzVxxoqqn7v3293A4kMcfSnynK9HEicj1GYcb2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qD/24VDp6Vh2St6nQjQf9AGW+YQer1RWwk973YvTx7H2bqjnAferkuJpBbadr9245aPdlD3hzh9jG33cWscYKA5lSKHcBkD048c1lbOyq2zrEjKYzLuMbskJQ8OBmClJHrD7+dhCB09OW79u0pN2ZSB7Hxc0EjjPlgezcGF97U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MWKA3yLd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MWKA3yLd"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6263HxfH1457437;
	Fri, 6 Mar 2026 16:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+G8YAzU9aZ4wHaSHLLYbGlbpJK697IOJOmxNBpIK2
	i4=; b=MWKA3yLdHbUL0Z+CCDv1QCB4T3rbF9uIaHW3wDIXi9GwyeLJa05dtLG6m
	D/XWX4VadkaCcjr/VFcgC8BYJgVFTHrnCQlGWBKZpsp+bZqdPe8HWCKGu5XZOee/
	XyFoSiCGUncOrzAp3PC0iteD+QCIkssWQNsSdimkARZF1Qk5IWtnyiNGm3+ZVTIT
	94FB+vyrdv/teO72Enezf+CKOBVfh8MWVL+q6Rfcfu3diZC4HhDEv2pUxFRXdDMM
	rkOIkl/wHCwEHtAJAMDveQUgLSIQQfyJDfsVg0b37VpbE4eEwtdoK53mlWdfVzBS
	0zPzdC+XfyW8voVjdHKjDs3cFI/7w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrjhg6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 16:16:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626ETQ4X010327;
	Fri, 6 Mar 2026 16:16:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6kgfvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 16:16:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626GGXVv22086118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 16:16:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B7692004B;
	Fri,  6 Mar 2026 16:16:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CEB620040;
	Fri,  6 Mar 2026 16:16:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  6 Mar 2026 16:16:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 13D53E077D; Fri, 06 Mar 2026 17:16:33 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: mm/pgtable: Support for page table check on s390
Date: Fri,  6 Mar 2026 17:16:29 +0100
Message-ID: <cover.1772812343.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69aafde6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=WsTHFn69kSnc_5uNAH0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1MyBTYWx0ZWRfXz7XFdJ/VpJJm
 opiQLgcTw3l/dib7koF+ZwarAMZuXE76kXtrZUVa+Pf/c9GCVeg9EO4Lg/eT2AsuLtH/MHzpsGh
 9kSejWQNGueM4b6u4kPv0D21crlPSIPKL5/yszro+QzKd1Phh9jjRo5phDJRgQcebwFNLQfDxPN
 G0gjKxm2EOEiLlM/ZIcyKO2hLIafG7r17rRi10wih2qg3TAseSQ1K2kK6wnmZHsBCjpbBLu9SM1
 d1vpGY257ZVm/u3Hl1Uat779TQCm5c9Yo4KDanQS7qVkunnOtc+iUGEc93EaxQomCr/WB5dVcpd
 x4J8LI2eJpWyMiFuAeJggXqy4xo9so8AcepmuGK6fKgFj2v0X89F+316Ujonxr3Ft4Uf4P90L37
 w+gfcnnveoypMrWN2lj6kx0JLYL67mnB192pj30rqSi3N7I8S+RZUpvEGvZLl7T6PNbl3VZ8YJ9
 MKs7N0dUuyHTDkmBitw==
X-Proofpoint-GUID: WWK__Q3nr7cGNKzcN7KeoYhaVB95iFrP
X-Proofpoint-ORIG-GUID: WWK__Q3nr7cGNKzcN7KeoYhaVB95iFrP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060153

Hi All,

In v7.0-rc1 page table check support for PPC was added, which
conflicted with this series v1. Thus the only change in v2 is
PPC headers update, which still is NOP for non-s390.

I only did compile test for PPC.

Thanks!

Alexander Gordeev (2):
  s390/pgtable: Use set_pmd_bit() to invalidate PMD entry
  s390: Enable page table check for debug_defconfig

Tobias Huschle (2):
  mm/page_table_check: Pass mm_struct to pxx_user_accessible_page()
  s390/pgtable: Add s390 support for page table check

 arch/arm64/include/asm/pgtable.h             |  6 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h | 10 ++--
 arch/powerpc/include/asm/nohash/pgtable.h    |  2 +-
 arch/powerpc/include/asm/pgtable.h           |  4 +-
 arch/riscv/include/asm/pgtable.h             |  6 +-
 arch/s390/Kconfig                            |  1 +
 arch/s390/configs/debug_defconfig            |  2 +
 arch/s390/include/asm/pgtable.h              | 60 +++++++++++++++++---
 arch/x86/include/asm/pgtable.h               |  6 +-
 mm/page_table_check.c                        | 15 ++---
 11 files changed, 80 insertions(+), 34 deletions(-)

--=20
2.51.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E425F219301;
	Mon, 23 Feb 2026 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847609; cv=none; b=c9P/sc4dUPZ65Y6iexKDD12nrfqTKUM+OJDb7SsH9Q6Op+maANv8nRYVx82tD6gNK7/JHh5sdIp1Poma5xZIpoE4ScRhLyadfL7M/aaO5bimwt4K+4RWimB16VK7pCuuG8f2nRXminby5cbo4z7ORAIyHAv0Vsj7z/eszTEDiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847609; c=relaxed/simple;
	bh=s6itEbyHzQdwRjAVPcE0aoYx7xKUeCjLjJT9sSUXOF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JK65Lkj0RdkIiIlkSZaWI8y/0s1F6NvUd/M3Ryf7DcsV5mjDfTon2eveHxc0nR0trwWePSXfDULvhzJjEYtxh6d5FWBO7jBzWcChIRmihWoo9GxjoEHNvcDBLpyUaTuXDqYRv7IV2vmBYx5ZGLKZYIw5teUoJVV1RMgcqxaKW+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fLux+JNP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fLux+JNP"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MNFM642713432;
	Mon, 23 Feb 2026 11:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VGeQemTVLA6CfGFEfwMKWDbtyAhZnxofgecnLX4C0
	5E=; b=fLux+JNPrdMkDG7Z3qL5+oKlx39ZvYxtJ3avfWRwJsuVC5EGNOhSGXv3u
	jbLR03UIckEncl1pd02dMS9RLqrzHTJyhvzX/1PpHVRVzGyuH6tslAQtlUf7kAG2
	czFw/aV6lEWGUvfEBXlKXVSfUFsZQcSO8qKeYX0SXpBtETSa1F+MN36HPFw5IQwS
	MKB0rsLwG/JW91bg0MFil+ZwEzmqWi5Ujm5HFbCoEyXUzR6RBSHQXGBLU5sSND+D
	Nm1DsHimG71MnezeMUQ63l1H0cBiQBVID4hsRxjMRvJQ4kyRoPynhRw5tqTmkqkS
	ENCQi1nP8lHW0F3u+kKzEknL6JRwg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34bxhy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:53:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61NBVjIN003382;
	Mon, 23 Feb 2026 11:53:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8jmd7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:53:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NBrGos44826882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 11:53:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 890CD2004B;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6151120043;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 3E42FE0B5A; Mon, 23 Feb 2026 12:53:16 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: [PATCH 0/4] mm/pgtable: Support for page table check on s390
Date: Mon, 23 Feb 2026 12:53:12 +0100
Message-ID: <cover.1771845678.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5OSBTYWx0ZWRfX3bwiMJwv1jXe
 c4r0aVkh//XvZK3EBXuqKG9B0JraQiFOc8dQcg3L6hlHbNCSPBy354nHZYbOf3Z9UZlNVi+mRux
 EeyDGkJUJBDyoK2GU1u5SyohvpgacRwgMGGKQXrxihP5qZl5F/DQuJZITynR4i1aGOv8LKibeSC
 RGxHizdZO14zQnTCKgUY1FBF3JutdD5rOSEHxXURU6zKflVN9dkdE/EozKdxlSGa0kRFjzX/24Y
 gMjuCTOZLLradKDnaisg7DvD5UIEq28QAz9KXPmGnX7Xd8oy7GBzzGTdP+VhA82rCLE6wjou7xH
 Pn921Qn8QacYVzhh+1/7F+ZvAp/qVub2x3Fl96dY16DPIf9Z59BA44ZAQWLeFBS46z37smUj8Ta
 XkNJr03kfjcFpQpwp0bZpqgJa3LePoO1YYZp/7JVKWBY2uDu6ffV8SZp7G3zh5eOU1l19MHnaqP
 oT1eC76P9C+aiIo/j6w==
X-Proofpoint-ORIG-GUID: CmD9jFH5k147Zt0zS8yAjMb88bgQYtmP
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699c3faf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=WJZKNU4qom20v2zI9iIA:9
X-Proofpoint-GUID: CmD9jFH5k147Zt0zS8yAjMb88bgQYtmP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230099

Hi All,

This series adds mm_struct parameter to pxx_user_accessible_page() hooks,
which is only used on s390 and does not affect other archs.

I reordered pxx_user_accessible_page() parameters to be consistent with
the traditional order and removed unnecessary brackets in patch #1 - the
only patch that touches the generic code and other archs.

Thanks!

Alexander Gordeev (2):
  s390/pgtable: Use set_pmd_bit() to invalidate PMD entry
  s390: Enable page table check for debug_defconfig

Tobias Huschle (2):
  mm/page_table_check: Pass mm_struct to pxx_user_accessible_page()
  s390/pgtable: Add s390 support for page table check

 arch/arm64/include/asm/pgtable.h  |  6 ++--
 arch/riscv/include/asm/pgtable.h  |  6 ++--
 arch/s390/Kconfig                 |  1 +
 arch/s390/configs/debug_defconfig |  2 ++
 arch/s390/include/asm/pgtable.h   | 60 +++++++++++++++++++++++++++----
 arch/x86/include/asm/pgtable.h    |  6 ++--
 mm/page_table_check.c             | 15 ++++----
 7 files changed, 71 insertions(+), 25 deletions(-)

--=20
2.51.0


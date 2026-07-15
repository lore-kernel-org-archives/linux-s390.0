Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA352EEE92;
	Wed, 15 Jul 2026 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122760; cv=none; b=GAuuuydwwKzsYPgQYvBclUKXn4OrvlDubfx63KLyA97Uq5HZA8e9RlmZ+/UHyufw8I1SrRxzji0h0zBgnJLjIyQQC/eC2wDoAL9Uj7y0HAjdVXlz2nwwEiXW0TNshiilc3Q+mgtKoeRwWd15QW60vInRDILhUZ/V7d0M716Yvqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122760; c=relaxed/simple;
	bh=OUqD93AVxAS5s25z2wS16K9wr9Apea0uFZvSiOCP3Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inhkzx6OcBwz7sx7Q3auDZWaLaLf1z9a3w47pvKZ9OqU+u7cwl0Jb+DGEIQvyS9c0Tsg/y4YBfrC+cGYcc3ICmgvtLdgtLulLR9wLgsW93NbPhb++YZrZtIUeFkWDEePXdVZb11jBiGajlbKJ0j34O8j6EifHMMbhlxbS5dMtR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TvllfLtj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TvllfLtj"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBgRK9053270;
	Wed, 15 Jul 2026 13:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=HBmZYX3QF3QRHaTvbCMYUyZZFUmopLrD1Mltq//fS
	CE=; b=TvllfLtjyV+JhCT6daq0Xop4ffEMoXxNWBA5xvbYmtfsduhfoceJVwutX
	WYAFfDdZ7/t2zoaitf0oKLbnA2jx2wT6dxS8JXMEqa/dXPAsRz6ESrUceS5CbX4f
	vGI5J6fd0mF4gDZ/eok4UdG92IXaIyyola3f+N4y9kg7fId+m+GWVbRMI15FNey3
	FqCXock4duyvb6ZNM2J3aI7Dh3k51wvLav3k2m74beH7eEE+6ADS6lrghTYW6lDE
	qeyDkKsoK2Rqt2VvsV3Kqi1QnoaZeC2c0z7KCqVRvqGZ+a0wlP2JpO28E5HiTiJM
	ZLyskj1HuIPRfFz052tgqBT7c0zYA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbu7jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:39:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FDYla6015014;
	Wed, 15 Jul 2026 13:39:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgg1cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:39:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FDd1GJ25100922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 13:39:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 482CB20043;
	Wed, 15 Jul 2026 13:39:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20FCD20040;
	Wed, 15 Jul 2026 13:39:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 15 Jul 2026 13:39:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 071D9161122; Wed, 15 Jul 2026 15:39:01 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] s390: keep syscall number / return value in separate pt_regs members
Date: Wed, 15 Jul 2026 15:38:28 +0200
Message-ID: <20260715133830.2619853-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a578d7a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=yE0iEfProg0caIylHQIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEzMSBTYWx0ZWRfXzBLiQ/nyOnMp
 nf0XnyhhuIgMSU6RjLqrZfA6sgG7rCAmaEZOqRbidSB5GiWkRQILtNJiC4gZdxIMYHRnTVc4cpc
 w4btYyag0T+PalAYvtJara2xMaDGsgKCgdALii/SvNX948mL/Sidh+LzONWGiQq00QJch2x8g7X
 no8kKwstL8q7XtGjotaQ8LA+MhtKiUfRXeBUwLOd0JSHjwH7rfMLuq0HrAi+SFGHRqqo1mCTAdh
 KZYUx8LbRY9TNsrHa6kfNbrthJ9Eo9dpCsHzt2llkhkitlFpfJzBhVtaz42wgqqF7kmuoC7dHcK
 ACfYB/WXQCYqckuA8EO/pzJ/oVW3jaSDIlmoHlBX5WDhI9DQ+EtXtyDauZigirQ5dEfz+Wfebiv
 nns9dFlgpyUbHEyX8BDFlLQCnfdurmz5Nk8Wvvgib5Un4dX/E/jUKoIOTDveqfsGf/rZ63IHzFy
 vtDASy8GkSysiAAG/Ug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEzMSBTYWx0ZWRfX0J1VvZKABZgi
 5RJimMNA0Wc7yQl0A2aRDTLw6z9YWUeyTJYx+SPBV9GJT+9lm1JuRxKdk48Azztvs12lMSDG5c5
 THlx/TLmd8ZPgeO6RBG/bqTOnv4+vQ8=
X-Proofpoint-GUID: Ol3v1ypv2XF2xjOYZdwyb_mxmQ7E7N81
X-Proofpoint-ORIG-GUID: Ol3v1ypv2XF2xjOYZdwyb_mxmQ7E7N81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150131

After a recent discussion on the ML about syscall semantics wrt. pre-init=
ializing
the return value to -ENOSYS and the special handling s390 has, I made two=
 patches to
clean that up. See the commit messages for more details.

The second patch is just a cleanup and could be dropped if not wanted.

Sven Schnelle (2):
  s390/syscall: Keep syscall return in extra ptregs member
  s390/syscall: Keep syscall number in extra ptregs member

 arch/s390/include/asm/ptrace.h  |  9 ++++++---
 arch/s390/include/asm/syscall.h | 13 +++++++------
 arch/s390/kernel/ptrace.c       |  2 +-
 arch/s390/kernel/signal.c       | 12 +++++-------
 arch/s390/kernel/syscall.c      | 26 +++++++-------------------
 5 files changed, 26 insertions(+), 36 deletions(-)

--=20
2.53.0


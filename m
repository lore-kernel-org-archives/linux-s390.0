Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5343876CF;
	Tue, 16 Jun 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628680; cv=none; b=MZdeIZ2QPLjjg3ziIKm28av3W979mAD6ylQoFYu60hAEQRusJvlQGOvSd0wxZJz1jySIQZUGcdX9q2KOhvSsCmbyaVYq8U9aqfvYo6oXtsm+GGT3Ahxk7BwBmE/Ihed7fNFcl/vOKqAhGqmaKXhmtEvjtOfexN8pJC7acRs1Xeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628680; c=relaxed/simple;
	bh=Oz4BHzYKiO2SmP/Lh4tmsQBU4MpMhLny+lTAtOOjCBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lofYZVGJ6x0X4ugFk7BHhrHKuyA/tQRcFcRQ88OgsKVaLTm+yybMKNXSEDty55z6tzi6iEPDNQeI5nlbtBUqX9y5Xwz/d+OWoR6La0L8D9DBjMh5pFle+q70TwUOAsBNpsLCbpsHLfZJz1gGYGVwHuc5ZWfrBUXYBGkWi0hbiKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pww2zCgI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pww2zCgI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GFmZM81859106;
	Tue, 16 Jun 2026 16:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=17VzLdYmQnXYqLmoYcDZFBNqEB/eMIc0r6egb6mD+
	TY=; b=pww2zCgIYH619hLZNjSmQv/ASu9kdD2xBlBqbNaNoO5zCRzsbHXWA+5pz
	/f33QSZ5mRom6G9GW4dQRct9V03sl3jweniVd6gx/vvPGonIM6L6CofrY4Ugd6Bv
	P/XCr+HNyqBU+Ef103aXPQ7Cs/uhWDQnWwVDXSfkpMjX4t4Xnux8Ad2p/u4sxvnn
	18T9o9NJRQfzHC/HE52qbCCFLT7okcKM0WjlEI8EumbL1QBR2ZK2liYoFUbDZ8eJ
	DetPS7mVfSkXVFpS3jACC2bdd/TVve/c9DzKNesBWX6sXpCXprKKQAixnLQ0Gd71
	RNR1nroJpF7sC3OwnrvIBOy88bslA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0pe8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 16:51:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GGnZWq009770;
	Tue, 16 Jun 2026 16:51:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhq4k23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 16:51:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GGpCBk48759160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 16:51:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9F612004B;
	Tue, 16 Jun 2026 16:51:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF6DF20043;
	Tue, 16 Jun 2026 16:51:10 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.66.4])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 16:51:10 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v3 0/4] KVM: s390: Fixes for gmap and _PAGE_UNUSED
Date: Tue, 16 Jun 2026 18:51:06 +0200
Message-ID: <20260616165110.360921-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7jx-Fym7XK3lR6tqnAvm6iuNzd4aUoV_
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a317f04 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=PZNbbSIUsKFdpJ9CItsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE3MyBTYWx0ZWRfX4Ecjkbe0kfZt
 LbMK3kMO6aS4OcbidwqU8o1ID+r78assIGsvaCJ8v7Nfw94dStLesG8eC3B6uj/QFx6uSeHMejn
 G3XrQNIYa+Tn5kZWTUIB1bQyyR1yX7qdiTD4VrNUYlwiKg/ViCKa384r8YhitqLTx07nJhvcbPG
 A+pWsrb6MYpceD91dhR7Qn+xRwib1uiA8z0kEfOrEd7HehAPaNK5G6jd4eR5vD61Y/TDg4BLo32
 fwmxhJOUDUzsqne7/YNwZcJSqmMG6syDGz3hH2+TjwxZGQOrox237bBrc4o6tcbBvjEgEZpA3xR
 XPvuLX0EbgoLHcU5VGGPgNnP3UzkJj2mWWrK6ljjN44SX019cwiT5zpvPursga5FCWJFVhmIeU0
 mgK0OA9oLnagAcZOtuqi5q5dZO1kthYWYIKGNsUbF/XWL91D/+V1q/ZIQl3X48Rx3wNCy/F10Cw
 CrZBL59Qd7aiyifom3A==
X-Proofpoint-ORIG-GUID: 7jx-Fym7XK3lR6tqnAvm6iuNzd4aUoV_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE3MyBTYWx0ZWRfX7uQHT9XvUhG0
 ykjpWY4fLUt1X1+HRpCjF1rED2AMJ81U2cvWnZPy43EinqCfLPUjn+PFjCuYGHZ8V/No2fdFZtl
 kBNke/0Nmtv7GM4S85pMRyYG0IJGQus=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160173

Fix handling of _PAGE_UNUSED pte bit. The bit was lingering around
longer than it should have, causing issues. This is yet a different
approach from the previous version.

Also fix a few other small issues in gmap.

v2->v3:
* Fix _PAGE_UNUSED in yet a different way
* Fix a potential overflow in dat_peek_cmma()
* Some minor gmap fixes that are not actual bugs yet

v1->v2:
* Completely different approach, entirely new patch

Claudio Imbrenda (4):
  s390/mm: Fix handling of _PAGE_UNUSED pte bit
  KVM: s390: Fix dat_peek_cmma() overflow
  KVM: s390: Do not set special large pages dirty
  KVM: s390: Fix code typo in gmap_protect_asce_top_level()

 arch/s390/include/asm/pgtable.h | 4 ++--
 arch/s390/kvm/dat.c             | 2 +-
 arch/s390/kvm/gmap.c            | 4 ++--
 arch/s390/mm/gmap_helpers.c     | 3 ++-
 4 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.54.0


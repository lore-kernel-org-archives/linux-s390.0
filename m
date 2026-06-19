Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0365C39934D;
	Fri, 19 Jun 2026 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884340; cv=none; b=qBDuuQTb2A97DyrDGJTOpooe7AbAokKN4iVDwK8W4pC5e6yqxSuebyNmdros++5LSKdWDwgDw0p7oNihPaQk/mAygfWTCg6ePtcufHwQqP3aTPIiN/kCkJqWIrY3kho3YdIPjHytPGVf8NupGfQEB+iUHMWHneIiUzHVyTxBAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884340; c=relaxed/simple;
	bh=foJkRG4vkRZpigAdAM9BKfsFTchxWvWwH+I0FCrAQ+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRoD/xjmV1YrAORfrwgkfdrRSOrpsXqKmy0+0JJcRiFpPJNNuAEGsoYfcbe9f+3QcIrAw5gaQC9eyAVSOX6Jm0/sqrrVGBgu8tpxmLk5+lfbH0qDtnuP5gZE8Yb7S1PyvQj/EIigaNcaagAfC5nQ7w0oYP8UNeLiyso9JzS2yEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BcKgZELX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BcKgZELX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JDImE12293351;
	Fri, 19 Jun 2026 15:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hueKKIPgLu8lVGsmW
	ip9AppZpu+h5pBfqf+1Wmp4eSs=; b=BcKgZELXplQfVR1/0zphXE5GC5Jh4vmPZ
	s0gzZBlIjRqPn4+6/5cvW7veSDu0kNFTEnRWY0B8/RLLyoAVbAO+UDtzpUXEErT+
	ZA6Ck1ZPH7ZTu9B7+if9Wl6qnn/58RuaBCz8SjWM15U9gXFcAR7HTdkIXRgWeJn7
	/yzjfTYTaDvRfFi2WRRUhMtzOWh64VV/lT0YqeYNMaotZuVOEdwBhuU7zXocQXie
	ECO61LPZsmNDiNEz4usMMXxihRHuEU87Jo2v/dy/19wIA96PpDVN6dI7WSP/2imr
	9d74c7fSYfrQQs82MAgwUiOl2mMRnwUGKljSiGqXzodI/jKMztZrQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxe7k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 15:52:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JFna7Z007760;
	Fri, 19 Jun 2026 15:52:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1729h3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 15:52:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JFpxdv53477808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 15:51:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF26F2004D;
	Fri, 19 Jun 2026 15:51:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A704020040;
	Fri, 19 Jun 2026 15:51:58 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.54.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 15:51:58 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v4 3/7] KVM: s390: Do not set special large pages dirty
Date: Fri, 19 Jun 2026 17:51:50 +0200
Message-ID: <20260619155154.307572-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619155154.307572-1-imbrenda@linux.ibm.com>
References: <20260619155154.307572-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NSXJKK8nnivKqi_6iovAQwly1LzeS07m
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a3565a4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=NX4vPgGMuaxhIts7GPsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE1MCBTYWx0ZWRfX2Ze3t44nGVNf
 Y+GbjTsqZG47P0qw3k+EnqFFvU5fRx9Eqn9Vd3lKonltKcwqYtLJ1ib4g9fSfJ23MhFU4T1DV0b
 EtDfz60oWuEbyGwL8d5Ak3JuwzL6Q9c=
X-Proofpoint-ORIG-GUID: NSXJKK8nnivKqi_6iovAQwly1LzeS07m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE1MCBTYWx0ZWRfX3Ik/I+HqrMwo
 lereUu/mzuNjRpaUYPWwXqFgV2l2ZtXahVgYyGoF5gm7HkZCZzt3Un1+Yv8dJ8B8biljhrDr+tT
 n0CVm0Dq1OH5wt0zm63big/7u0CLRI8kPYqESReIY+iFQnD24eTsEjQjCJGeuxZaOFGtuKRLs+C
 p0FQRAn+r8AUAbkOypa/zjoRy4lxOgczyGrhflDyKIzSF2F8uUwqk5USLbzSglmbKTWH9pH9bZg
 FIVGMMXTbMxG407bDQ+NGzi4sBMzcg9wWAm7ctclduw3jPbTUt2qnZVuu0ERWgPiO2PikW29IgI
 2cdAbU3MUn9pn0J2fMUTOvgBTpmpYDfsdMXVRMvzNQgRHHCg76eqY7an07kjYTayNAkQGrhFQWi
 ozmtFx/bTOsdVC44M801Y4AvPu3Xy02zwVcODV9wdH2gYnwjD2tP/6wJW4ELxIc9Aeg1wxfzDul
 ibsVrhulTOarGhI55pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190150

Special pages / folios should not be set dirty. This also applies to
large pages.

Add a missing check in gmap_clear_young_crste() to prevent setting the
large page dirty if it is a special page.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
---
 arch/s390/kvm/gmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 52d55ddea8d4..3192f610f696 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -327,7 +327,7 @@ static long gmap_clear_young_crste(union crste *crstep, gfn_t gfn, gfn_t end, st
 		new.h.i = 1;
 		new.s.fc1.y = 0;
 		new.s.fc1.prefix_notif = 0;
-		if (new.s.fc1.d || !new.h.p)
+		if ((new.s.fc1.d || !new.h.p) && !new.s.fc1.s)
 			folio_set_dirty(phys_to_folio(crste_origin_large(crste)));
 		new.s.fc1.d = 0;
 		new.h.p = 1;
-- 
2.54.0


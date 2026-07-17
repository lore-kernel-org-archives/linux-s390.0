Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D266F3ACA7A;
	Fri, 17 Jul 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295160; cv=none; b=RrwoletBOJPecQoGmeJRFA7fbbkPU/39kuyzVdmYUoeTRBxXC/KrgXTbiLPTKxi+CnnM0t8iQp0h18vd0Udlug2nOVC1V5ZrukYB0feuIwsp4tjkiZsCLxowTRjsV0ma/iC/F6MyWZ6uOwkgn5hFIX+rGrcysD2kF+kPED4I8v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295160; c=relaxed/simple;
	bh=xl2b7xjTgYCfnmSRBg9pyXjyycXu6t6QUP7TPvFnZdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOECLMWeOoNYQS4DN4KzIL8Bo5ddv4ASlILh+nulrYUHL87g5NrcsUb0G4GaoGS6TyPxQk//W7dNw+EYQIshwBw+jrO/wgOZUNaIXRngWQJWW1qiECes+i6ysKL1cnMPe/U9k8dVieqwxQ3LXUN6Rwfbm1pWOg7KaHvTxcK489M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MwS765PJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MwS765PJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCfi2b163738;
	Fri, 17 Jul 2026 13:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=or7YSIsxjyCve/ej8
	k0RxC0Gu9rUVwFjOTsLFx+KLRU=; b=MwS765PJeaXFxgAXNqMZOKh6zPDkErKlq
	Nu0mURW6LivfW4RH7Bz5kq9NRum1WSyyqKZhF66dlkK6Iy3vP0z/uhqNSpd7OXEO
	FZ5GaPSNblIofp3mkiY+5LsaBIreWFig+05Uf+1ULVwp6+IXBMIyRY1A/I5ImcCB
	UmWPl4oaT1BIDsn+XR75amnMcxK1Szp7ipPN9ejVrcJJschN1PUh2rhy3GgSwLNJ
	kOOJhYAx3ME+hRiGRVgJUQS0awz33KvfJE0hb/tVhKAzr+92MJBX3gpXfCRI7gIP
	jQAphL1ISCe+ypZqar7i8gIbN92UqiUFsM6jqI2HzAqSOYrbqHLCA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33q7br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:32:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HDJbh9003175;
	Fri, 17 Jul 2026 13:32:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhssrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:32:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66HDWMMR13959492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 13:32:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCCF120063;
	Fri, 17 Jul 2026 13:32:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B23B020043;
	Fri, 17 Jul 2026 13:32:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 17 Jul 2026 13:32:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 993F916274C; Fri, 17 Jul 2026 15:32:22 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>, Chris Li <sparse@chrisli.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
Subject: [RFC PATCH 1/4] mm: use proper PTE accessors in madvise() and mremap()
Date: Fri, 17 Jul 2026 15:32:19 +0200
Message-ID: <3c4d3c768ebf9cc7bbc7667e0e08bf5ad2fe8729.1784292223.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784292223.git.agordeev@linux.ibm.com>
References: <cover.1784292223.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzNCBTYWx0ZWRfX9kTvVNcz5Jmo
 Pl3Z3eyavgj3VadKxtd+RD+oh/mU1JqXDFG0N53D3VIBNBKOcvxeaVQLtkyE6V0rApGcYpSzYuJ
 G1xHo80wT776IJw0+74E42/G4EHswSg=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5a2eec cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=qew0nP0EAHuLvkb_oQEA:9
X-Proofpoint-GUID: iDaEB2JQJhBC3xsyEdq_VH2SQVaRtzO_
X-Proofpoint-ORIG-GUID: iDaEB2JQJhBC3xsyEdq_VH2SQVaRtzO_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzNCBTYWx0ZWRfXy0sIwPc2aB4/
 dq4yFvqPqzzSQA1rjXzofJrLQbIAgPtHG4loanaLFSFUtqJ9VyF1nap1yGs8FzJ/l40QRhFHA8v
 46EySlpFNmLJy0Wuzbd8As+LczdjMQMWmyMp46MIuO3awjuuQd0OGSI2uIptoLWnhWstDgHPece
 kniOX0XSUMx5gz6KAZ3XCqVmVBzt1LMCItkCDnnAnuHbWmMelJxsbuFS/fQ5sj72sxJa0x4jQvC
 WNqvlVaQVvaf+Pxjxe4I6nOpJdKmifrDoo8Um/AULY9PvMZe66HFViAx83WMmKXX7MDksAsHzU/
 6okHfXih2CaBXzDWHDRTAwo6L0QK1PyLsuT/Au1xE31YKHG7FQxBsEjuBPN/OzXAPuK68LhF8Ai
 Cc3xnVPm3brph2gAS6/LHUglbpcGQTqDb+0aEOwxdqrEp/YpESZKj+11hLSpts2VgSmKnLcmBEW
 cenaUk28fAsX+21YlmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170134

Follow the pattern established by commit c33c794828f2 ("mm:
ptep_get() conversion") and use proper accessors instead of
direct pointer dereferences.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/madvise.c | 2 +-
 mm/mremap.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 77552b03d318..7d369b1ff8e5 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1106,7 +1106,7 @@ static int guard_install_set_pte(unsigned long addr=
, unsigned long next,
 	unsigned long *nr_pages =3D (unsigned long *)walk->private;
=20
 	/* Simply install a PTE marker, this causes segfault on access. */
-	*ptep =3D make_pte_marker(PTE_MARKER_GUARD);
+	set_pte(ptep, make_pte_marker(PTE_MARKER_GUARD));
 	(*nr_pages)++;
=20
 	return 0;
diff --git a/mm/mremap.c b/mm/mremap.c
index e9c8b1d05832..fc3b90274a57 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -264,7 +264,7 @@ static int move_ptes(struct pagetable_move_control *p=
mc,
=20
 	for (; old_addr < old_end; old_ptep +=3D nr_ptes, old_addr +=3D nr_ptes=
 * PAGE_SIZE,
 		new_ptep +=3D nr_ptes, new_addr +=3D nr_ptes * PAGE_SIZE) {
-		VM_WARN_ON_ONCE(!pte_none(*new_ptep));
+		VM_WARN_ON_ONCE(!pte_none(ptep_get(new_ptep)));
=20
 		nr_ptes =3D 1;
 		max_nr_ptes =3D (old_end - old_addr) >> PAGE_SHIFT;
--=20
2.53.0


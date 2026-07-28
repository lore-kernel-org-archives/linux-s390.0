Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E21D5CFE;
	Tue, 28 Jul 2026 01:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202537; cv=none; b=i5oe9X528VT7dey71FKQLTbNdO8XGS6iTs9SxC8mgsI4ie4NbKfWfmdFTQk1koDmdI4HtJiT677+9qjtfVRKvYaBg0+IOsVFAsBH+6+xzImlXM6KAlm3kVtGThRvARwwIejHUB8Yxoke+5AgTfs3Wr8pmp8jFPn8SZ9KRMb1Cro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202537; c=relaxed/simple;
	bh=iJqMOa10ZHrhvb5nSu7rxQ3Se2E9ff/HXCKt+Y7CNVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lk+B4QzITdEcUc6ASBUz6hgMKXA/wXzaed0lGxvwiyx/OLkSoxi4jpIYdaLRwM6NDf4tboWoZCS5siSVutWS5eOu2LvxXZHEAKwPxUeVU6+5WMWVo6HftJeSTKTtjCWtZWcEoFjrH4IgDyLE49qX08LCaWQg704zuTBzsTo17VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kUSZqVYW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kUSZqVYW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0m9ie3789922;
	Tue, 28 Jul 2026 01:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SeqaWBpG42+d5FxDTHgXz7cPXBmoowDPDhGdPZKId
	SE=; b=kUSZqVYWJArjwIv98ofgO8uDxsXlIEAGGEKGrn+CDj05YkOjPmp5rh66A
	a4qHj1Hhf0ek///yUaTxdPpoMk/MXPqy4mKKwo047sF+rHOiPkrRjKy7NqBMDpRo
	40VKN8HdoCpITtPT9UC6mk4+IHNtrAxXt2AQfqV8fWIxRpn/r57ekCLRuK9DDtNI
	6tmO+b1nEclTVhiwqeyhUpBJapNVKlG6StEhai/VHF+VW5gqpqsEtthF8jDtcLGC
	ckpX6q1+yJVF3Up3Gf8ZJkWrGUeQe0ayfEzav66mjstEKc8z+kjT37Pi/27nSa7i
	b5l2Gr0w9to+mOqWdQG5X+NplnW1A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwctdep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 01:35:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S1QfQC001127;
	Tue, 28 Jul 2026 01:35:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xyg31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 01:35:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S1ZU0o20054678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 01:35:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEEB1200BC;
	Tue, 28 Jul 2026 01:35:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E04220043;
	Tue, 28 Jul 2026 01:35:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 01:35:20 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 71E7C162736; Tue, 28 Jul 2026 03:35:10 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v8 00/10] s390/vfio_ccw fixes
Date: Tue, 28 Jul 2026 03:34:59 +0200
Message-ID: <20260728013509.1551753-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bk1yRE9BshckA363jhNHaZvboqH6a_BV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAwOSBTYWx0ZWRfX3N+QSCzYfQYQ
 QYkKgLcanN2qN1GEtURJANp/UrAP0jH2OP854HZpfuK81d9OFEXXDvpeVFm0kzm1PcmOB7PixYw
 JeMqRBgU9fHEH9ATTmjAh6nFrrdZZng=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a680767 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=cxIOQTdqLOtmHPkP-5YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAwOSBTYWx0ZWRfX8oscQyL0m1Nx
 rI1t8Ia54J9RoxWU5PCV2qTgHyJJrKFHo0lU/9chJY+quOYRBiK2orHTUI9AM2m/GjQCFp6wvyS
 xS8vxJ89v23mP41oXv8Kfyd50klCi3PZxU9jQ+yFaGeWuqpOo8F6MRIQdQkht3TVVpCyvDASw55
 PJrn9pUre5629h2mdG6Sjuj4fGVlbKRxF8DUzSbqUuBzxxLC7bZkcsHUVtA0EWCRPGJhEj7GAwj
 i7eOGz839sz2PygVMWTJcNxRpfxvkUpTX/xYimRCdHEs9ywp7MfGWRKGuqQ1QxyqiLF6T5LYUXx
 Qe8IwlZgdcfbcYQOhLC8r8cxcI8X1j/3N6/g6P/YygDxvR6hSLs6UhExKez0pSSxhn+Q/HgALRw
 qIVk1n4o9q9h3VgijZhsZ8JWnl88cljq+W9z2ayXcnyDTvgOkML9oAtFwbSv2yb1UhspyQMTfFv
 NY1whHdGydXtYPK/gHQ==
X-Proofpoint-GUID: bk1yRE9BshckA363jhNHaZvboqH6a_BV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280009

This series addresses some pre-existing issues found in the
s390 vfio_ccw (DASD passthrough) driver.

Patches 1-6 are identical to v6/v7.
Patches 7-10 are a continued attempt to improve access to private->cp,
as the results from v7 showed minor problems compared to previous iterati=
ons.

v1: https://lore.kernel.org/r/20260714232208.1683788-1-farman@linux.ibm.c=
om/
v2: https://lore.kernel.org/r/20260720201931.976660-1-farman@linux.ibm.co=
m/
v3: https://lore.kernel.org/r/20260723174751.1180334-1-farman@linux.ibm.c=
om/
v4: https://lore.kernel.org/r/20260725152705.3958100-1-farman@linux.ibm.c=
om/
v5: https://lore.kernel.org/r/20260726040129.2946151-1-farman@linux.ibm.c=
om/
v6: https://lore.kernel.org/r/20260726172153.1818056-1-farman@linux.ibm.c=
om/
v7: https://lore.kernel.org/r/20260727192230.2715207-1-farman@linux.ibm.c=
om/
v7->v8:
 - [FA] Applied r-b to patch 10 (thank you!)
 - [MR] Cleanup commit message on patch 8 (leftover from an earlier versi=
on)
 - [MR/sashiko] Move cancel_work_sync() calls prior to the crw list clean=
up in
   vfio_ccw_mdev_release_dev (really only crw_work needs to be moved, but=
 to
   keep it tidy..)
 - [MR] Call flush_work(notoper_work) in vfio_ccw_mdev_close_dev,
   to ensure a queued cp is released if pending, rather than arbitrarily
   cancelled and orphaned. Remove the cleanup from _release_dev, because
   any open device will take a trip through _close_dev first to be cleane=
d
   up, and any closed device will not be able to queue any CP's without
   first being opened

Eric Farman (10):
  s390/vfio_ccw: free all memory if cp_init() fails
  s390/vfio_ccw: limit the number of channel program segments
  s390/vfio_ccw: fix out of bounds check on CCW array
  s390/vfio_ccw: ensure first IDAW remains constant
  s390/vfio_ccw: calculate idal length based on idaw type
  s390/vfio_ccw: ensure index for read/write regions are within range
  s390/vfio_ccw: cancel existing workqueues
  s390/vfio_ccw: move cp cleanup out of not operational
  s390/vfio_ccw: selectively expand io_mutex
  s390/vfio_ccw: implement a crw lock

 drivers/s390/cio/vfio_ccw_async.c   | 16 +++++++
 drivers/s390/cio/vfio_ccw_chp.c     | 31 ++++++++++--
 drivers/s390/cio/vfio_ccw_cp.c      | 74 +++++++++++++++++++++--------
 drivers/s390/cio/vfio_ccw_cp.h      | 10 ++++
 drivers/s390/cio/vfio_ccw_drv.c     | 21 +++++++-
 drivers/s390/cio/vfio_ccw_fsm.c     |  8 +++-
 drivers/s390/cio/vfio_ccw_ops.c     | 30 ++++++++++--
 drivers/s390/cio/vfio_ccw_private.h | 10 +++-
 8 files changed, 167 insertions(+), 33 deletions(-)

--=20
2.53.0


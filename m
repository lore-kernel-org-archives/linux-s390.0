Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E071E3EDE7F;
	Tue, 12 May 2026 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608384; cv=none; b=nCmWoSrS38otn49ViR6GVCm9oaNga1IT7l0PwYt5Vq15fsv6ujbJwbIDPX4HDynSqqTxj/UKbgZB7tL2TyhC7jOq/1dX3GRHtFhNPsgojY/tI4TRDmBGeRG4ncnSdwhNmCgv2mSMLbVUhPDaiBJBfi8JIN4Ih6TXLT+ujAlwYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608384; c=relaxed/simple;
	bh=P1S68uoG1L2jha7zOykeGOgGW9jhB2ScbvCJoDmwLZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lTxzxwxUfy6p9gPYbYFoh8VT3pg36nipyH/99cN3lEubqcicQJDK2j06vO9rANBCQ8EZ/lgiRfMig595DLtnW5udrZFOVTN+/Du4oX95qhKYYrim3UvVR58VzzDF1p23/kBlvUIZzTNRw5D4Pn7Dff7PzuzFWLJT3JEp25j/0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RSpSKyP+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RSpSKyP+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CBYKcn3186917;
	Tue, 12 May 2026 17:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7Kxgj5p4UlN7PDbFx1LZ/hqjQ/7GeMDnqmeVFNQFE
	fI=; b=RSpSKyP+f42Fh8CYgbegdEbgLPQFMoXBsqYuOtGknJ8BYeV5EiwT1jOqU
	UrfOa1WHXDXiDu7jGCsrpMls8nj8KJ1bHQqAr0IU7DF+QJwj7Cy/GYhPByOPnYNp
	tW1z00Ulb7HkiOrJWscMs/GvsssZwsQyhxStoRY0dZhesmsGhsQ98UiGNfaZdoi0
	TgkOPYk0G1gpDVM7cK860I/6dXX3C3f4dMF8vWZc5sQ7ClQ+FXgfWNJ1O8f/1VTe
	Yq8qUldtbXg4UmTP0zaXcbCZuWivt6GnPhWbBAlsqlhdx3XKue7WYSaB5a2vRp9I
	fnYfXVFo5JuEwGl/Xv939R0tkLB3A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5ccnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:52:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CHdUO1024342;
	Tue, 12 May 2026 17:52:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgm82q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:52:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CHqqqt37618092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 17:52:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EB7C20049;
	Tue, 12 May 2026 17:52:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB93C20040;
	Tue, 12 May 2026 17:52:51 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 17:52:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 0/5] KVM: s390: some vSIE and UCONTROL fixes
Date: Tue, 12 May 2026 19:52:46 +0200
Message-ID: <20260512175251.300882-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a0368fb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=PbAycVehSIM_YFug2WUA:9
X-Proofpoint-ORIG-GUID: ToR4E8mBIPtqCOwoJVjuUdABQ8GNdy00
X-Proofpoint-GUID: ToR4E8mBIPtqCOwoJVjuUdABQ8GNdy00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4MyBTYWx0ZWRfX9hztSERY10Gp
 ded9txLHh14DpMN95ZDhwIHWVoDeBfPDMqLfpDtpRiQc430co4+761IA5kyhlKgLG0nId68RNH5
 5iknphkE5tltWVsR/CbUd8gEM47e6xmvXKQNjyumQGtsdOgWVqz0r7mKISpTpWSvldMHdZE+C4H
 F51+Oo3LopJ4SiAE5n2YSa9nb0dUW2SjiwQnTDag9FZS1f3gcOnru/wVCxy+Uz/Acl7gTaRGv5g
 ufvfgQ51FpA6z3/erCvEiJg4AriWqaNMzelByTI2Erx7/lIHFyz7ys6DEki5zKm5LjaCTwtsVgy
 RtLSeg2QIzwxzmHItLx9iK0rhS2MHhXFSecHKvi+VzPDMMXy+vkCcCEyDp0OngDtgc2a6jYlzbs
 xMmCtqFMX0bz+2Jve6wUAoScd/i6HnxFkn+wTKIZPKund6vTRJnY9J255gHzCZ6vjQH0rR5+xBY
 9ueAb4MsBBtrZJm2MCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120183

Fix some memory issues and some hangs in vSIE.

This is still a fallout from the gmap rewrite.

v1->v2:
* Fix potential leak of struct kvm_s390_mmu_cache in gmap_set_limit()
* Refactor and improve the checks to determine whether an unshadowing
  is needed
* Set and propagate vsie_gmem properly
* Properly mask the address passed to gmap_insert_rmap() to prevent
  creating multiple redundant rmaps when shadowing
* Clear the pgste.zero flag when needed, to prevent pages from getting
  accidentally discarded

Claudio Imbrenda (5):
  KVM: s390: vsie: Fix memory leak when unshadowing
  KVM: s390: Fix leaking kvm_s390_mmu_cache in case of errors
  KVM: s390: vsie: Fix unshadowing logic
  KVM: s390: vsie: Fix redundant rmap entries
  KVM: s390: Properly reset zero bit in PGSTE

 arch/s390/kvm/dat.c     |  1 +
 arch/s390/kvm/dat.h     |  3 ++-
 arch/s390/kvm/gaccess.c |  1 +
 arch/s390/kvm/gmap.c    | 18 +++++++++++-------
 arch/s390/kvm/gmap.h    | 23 ++++++++++++++++++++---
 5 files changed, 35 insertions(+), 11 deletions(-)

-- 
2.54.0


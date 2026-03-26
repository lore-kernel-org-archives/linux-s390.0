Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CE02D7393;
	Thu, 26 Mar 2026 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531058; cv=none; b=sl6fO2Zpx4fxvWPhmp/uFP62PB1Sn0LxOG/CDsdaWdkb9YnmLxg+83snk3MVcY3AaIaLfKxAoUp5xDXgi4PUk3D7JEgbT4/uINQNPDTPk+OAflAUPX8SbcPSQvhYchGwotR+kJ6L4PUmn+OqZIDyBkIVVBrIds2gglu6sG32eEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531058; c=relaxed/simple;
	bh=fs3nVTK5aun+GvFeVZwLZQuiMnk+bVFzRmbfPy6E5Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUD/uCN3RI3Y8JKOluq8cXxL72mL06hZE3TfvCMvHqoO9kYr5BM3XMIWDXQpQcV9seKaS3ljwN56OIZ6XCwOHZZeOlbja1fpwmBviNV2oGZirFNHxjuvCWkE6V88RKVb/e3FJGnhKKby3CuNHbvNdHz3oFi0G2oPSFnGF5Jbpa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p7wGBF4d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p7wGBF4d"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q8vTTc3000322;
	Thu, 26 Mar 2026 13:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=foQKNkBOotXrlKl8G8iBOAZ82XOgNiAF1RrAbHupn
	RE=; b=p7wGBF4dhvJVNsRNguwUP00lMLhlzjIEUdkPQVZOfYcXLBd7R70pYCRdr
	ODPLf5rUjvDWlun2XdUBCoKWUk9B4m9XAF7I19NQIzYOacAgwWWAqVeUucWdSTDD
	kUcOAeB8Dt/jziZuZTDDvHjAsfeUYJ/H8U7OMR2GOYC95hUMqvLcZMje+u4RZMJN
	/1RzetxhLMBVa8CjdZU2uSQzSocvqWfURyAh7QYJyDi1P8v0Sx3Nd6evJ6efqWYK
	rhg/bQuiOYu6gkfhFgCzmReif4/rveBuvnZsLX6Qp+HQdur8rO7ouIhYc+J5TpqD
	Vf2lQ8lkNb9Nh1WHj9zqapkcIQePA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky0c9q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QD0lfv004399;
	Thu, 26 Mar 2026 13:17:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2atxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QDHLc849217818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 13:17:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54D9320043;
	Thu, 26 Mar 2026 13:17:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA5DF2004B;
	Thu, 26 Mar 2026 13:17:19 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.23.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 13:17:19 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v5 00/10] KVM: s390: More memory management fixes
Date: Thu, 26 Mar 2026 14:17:09 +0100
Message-ID: <20260326131719.98229-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA4OSBTYWx0ZWRfX14NpCxHQO67t
 VhAS0MirjlU34ZdTRbTyps4RvlWe3zOt04zIIL6PqFHnXNv5MhXj2yqUwlxPWUDLk6biTxjbT4k
 oEhojZYa2rNLfCKWCseV+nH8XpTsXnwhGQIl30JhBcUq0BjpLn0RboGAUTwKtmPot5CSNVATkBM
 VZ17VU04GBTVLqS7vK7rykBEnKX4OAaxehAuJAlB5TvgIPHdIzcAlkT1XlKCCC6TLJgGC5LyQAF
 dQjrc/H+Q9VZdTED+/ONYCqNB0nATjPa01w2AHWmeV5ra7UPhyYHtRNWSNhwMUfeaVkQaY7GZ8u
 Efrr8M4bXpGExncHdktiTgNQUDpZki0nalnqW76z/AWZaTbmRrcxkKZLhi3NchPE8HooTMFGyN1
 1e9KQeo5Werl4HEMzTv3pjgDzQrVZqzX1HmVbLsrE1GoK2xajKTHom5sLqRB1GF2KYAaKelmR8D
 CaGGCra3B2OoTa8pYHQ==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c531e6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=LsndMcL8X8R5DaPRJiIA:9
X-Proofpoint-ORIG-GUID: ZfVTIDJzG0USIbyYedbaTBvx25sXBbA5
X-Proofpoint-GUID: ZfVTIDJzG0USIbyYedbaTBvx25sXBbA5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260089

This series fixes some bugs that have been recently introduced with the
big gmap rewrite.

Most of the fixes are related to vSIE (nested guests), although some
are more general. The last patch fixes an issue introduced last year.

v4->v5
* Use gmap_crstep_xchg_atomic() in gmap_handle_minor_crste_fault()
  instead of dat_crstep_xchg_atomic()
* Check the special bit in the new pte and crste, instead of the old
  one in _gmap_crstep_xchg_atomic() and in _gmap_ptep_xchg()
* Fix handling of pgste spinlock
* Handle more unshadowing events in _do_shadow_pte() and in
  _do_shadow_crste()

v3->v4
* Reorder the patches a little
* Fix dat_set_pn_crste() to only update its parameter n in case of
  success
* Fix _do_shadow_pte() and _do_shadow_crste() to return -EOPNOTSUPP
  when a nested guest would try to write-map guest-read-only memory.
* Move all host page dirtying logic into _gmap_ptep_xchg() and 
  _gmap_crstep_xchg_atomic()
* Make sure gl is not used uninitialized in _gaccess_do_shadow()
* Introduce new s softbit for crstes, analogous to ptes, and use it to
  determine whether to set a page a dirty

v2->v3
* fix a typo in the code (missin negation in patch 2)
* fix pre-existing alignment issue in _gmap_crstep_xchg_atomic()
* fix nested guest memory shadowing
* properly handle another possible place in _do_shadow_crste() where an
  unshadowing event could be triggered
* fix _gaccess_do_shadow() to properly handle the case of real-address
  asces for the nested guest
* fix some typos

v1->v2
* propagate vsie notification bit when splitting a large page
* replace gmap_crstep_xchg() with gmap_crstep_xchg_atomic(); let the
  callers properly deal with races
* do not attempt to protect guest page table when the nested guest is
  running in a real address space
* fix return value of KVM_S390_VCPU_FAULT in case of error

Claudio Imbrenda (10):
  KVM: s390: vsie: Fix dat_split_ste()
  KVM: s390: Remove non-atomic dat_crstep_xchg()
  KVM: s390: vsie: Fix check for pre-existing shadow mapping
  KVM: s390: Fix gmap_link()
  KVM: s390: Correctly handle guest mappings without struct page
  KVM: s390: vsie: Fix nested guest memory shadowing
  KVM: s390: vsie: Fix refcount overflow for shadow gmaps
  KVM: s390: vsie: Fix unshadowing while shadowing
  KVM: s390: vsie: Fix guest page tables protection
  KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl

 arch/s390/kvm/dat.c      | 100 ++++--------------------
 arch/s390/kvm/dat.h      |  23 +++---
 arch/s390/kvm/gaccess.c  |  71 ++++++++++++-----
 arch/s390/kvm/gmap.c     | 160 ++++++++++++++++++++++++++++-----------
 arch/s390/kvm/gmap.h     |  33 +++++---
 arch/s390/kvm/kvm-s390.c |  18 ++++-
 arch/s390/kvm/vsie.c     |   4 +-
 7 files changed, 231 insertions(+), 178 deletions(-)

-- 
2.53.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214EB3E6DE2;
	Wed, 25 Mar 2026 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458802; cv=none; b=OXbWnel92/0uP10hBx8g+fxjDohl20e6qvwYcu3/cOvCR03mRzkaogtdkQKLOrn6uxxV4KAblR1FEOehDsnUGON1qcyagEmqmsg998K4lVFzZNvJZTHhexQmfcbpx9cLkBQV45Oe/9VN5CLP6wn/9pUTpdRquabFlUyeQpBh6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458802; c=relaxed/simple;
	bh=RWzVvC6Zt/YzQmVfKA/RywNGC6y021on3g7S/JR8M9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Na9FrztHZ6LUgJgiJ2xU9wy9hHM+PvxapOPIfY1054tsGz/q1ys4ZGVEDOMggDYgufi/fLBEUwwo9I6jaSRxYwdf6jHbBNYX9uzQAmTaN7+5XrJ5Kk3wVH1arehYaWhY74eCu0lnI7No/mwXs6KsqsBn7PQoihuzH2++ydfAelw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pzHl5058; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pzHl5058"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PBtJvE632924;
	Wed, 25 Mar 2026 17:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vAlgMzGziLbEDeZk0tempMQ/sozFw83wgzjmJLdwU
	+8=; b=pzHl5058VzbywJboIHTVOXMw19P9B0PNsg8Fz4dEkBFQ0rSO9Gk73nuxy
	SO1OsrwXWzy3NGs66WtYrn0UzIDg3gU+FEHxX24cV+IRGyF/fMEKT6HyOY+qeHIp
	Q7IhVIWLtcSF/Fm8j2Dn+Br32LaRRa1IV8ou3lzKrZ9ryB5gQrCepu7fJLD8BuHY
	2QoWYrJTBocb9veuEFCEPcAcwDPMQGTkLhSHMorgOQD2RzjPS4WIJEpYh+QeAq6w
	yycX/+LgUMNq9LtkOXqhzKaD0lznJQRCn0/1yqWWwfJPFVBCQA3UW5HRfx2eadqq
	9pvvmqlyLroSVROp4RgLW1ziGB+nQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumrs7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PEWdZP005969;
	Wed, 25 Mar 2026 17:13:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yqjwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PHDCNw25559334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:13:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 453B620043;
	Wed, 25 Mar 2026 17:13:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16DA220040;
	Wed, 25 Mar 2026 17:13:12 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 17:13:12 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v4 00/10] KVM: s390: More memory management fixes
Date: Wed, 25 Mar 2026 18:13:01 +0100
Message-ID: <20260325171311.182210-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xxjhzhwtC9yg__zSr6THSYsbsVhg9T6e
X-Proofpoint-ORIG-GUID: xxjhzhwtC9yg__zSr6THSYsbsVhg9T6e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyMSBTYWx0ZWRfX4zyR3jE3mx+o
 FmafC6vgPt6kgolgrnwokYN+MBbaNcNpFu/+3Gywpjm9LwS1Tz4upYfoD31iPx3ZQPU8nvXfRoU
 MqC4gXQbBZGPLf0smP4nUzAbz78tyXNpy12ONXVt+0JcP1GqCSZwS2x9zpmBkpixKAiK82eK3MS
 U6MQM8toA0lWualViBeG3x7O9ktQZvnJeHmlmBuJZQrI4UWwhNOTnwRlO3FztpwEsvLpniCQ/Vs
 idOJ09grKLHAjT7cVQouqk5nqyvTUj79+u56Xl/K/ftDqdynyqS8fzvViwnqr1/XTaBdIdUyiqT
 aMFw4YzpKzumhFhIbLZYwkehl6qaM56uHQORLDD1bMfoRHdXzlL6SLInjjYqnZZJ5fWt2YBRICa
 mbl8n3dAvwCj9rJXNhb0Un3EbKapPkCn12hQSLoB/zHJiAjWcjv19QaCctxpEYaOZP7qIDDatpT
 /ZS1fmxSknk7lynmdWQ==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c417ac cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=wIwQePqm5S5lDNREblkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250121

This series fixes some bugs that have been recently introduced with the
big gmap rewrite.

Most of the fixes are related to vSIE (nested guests), although some
are more general. The last patch fixes an issue introduced last year.

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

 arch/s390/kvm/dat.c      | 100 ++++---------------------
 arch/s390/kvm/dat.h      |  23 +++---
 arch/s390/kvm/gaccess.c  |  61 +++++++++++-----
 arch/s390/kvm/gmap.c     | 154 ++++++++++++++++++++++++++++-----------
 arch/s390/kvm/gmap.h     |  33 ++++++---
 arch/s390/kvm/kvm-s390.c |  18 ++++-
 arch/s390/kvm/vsie.c     |   4 +-
 7 files changed, 219 insertions(+), 174 deletions(-)

-- 
2.53.0


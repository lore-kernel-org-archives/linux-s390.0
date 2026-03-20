Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82B3CF056;
	Fri, 20 Mar 2026 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023351; cv=none; b=evb/TRaCsEkCvhESGpBsntHnPxXqF3NKKosmZv25JEkl43646G048d1uj8xRQmt24EmcH15QY6D/4lSaqZmmH1R/+Xlcfggd170OC1GuuSf2RCb0yl/0EFPfSUliM9D8Ej9OPL5ZP+cMaQM3dmtXxMPJSVTVtWPR2SKaWSDoaUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023351; c=relaxed/simple;
	bh=W1WMmTkHW5COV+zfoLJIORS0+JpjFe4fCIKj8uQ0XZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ek10UaL9GhLTwJxbuvH2wur2vm5pGmK7ybfi/hA2p6ypdgTkSe1Y1oyJ5HEltIdANPsRoQ9rGh+YZ+qF5UPi/jlEUUmanKUUkoqwrNIyxfGKAo55wppJBbHN3fJo/rll0ivtETXia7FvIAyP183id7thwEEIUoE71HCSs+2DzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nrLhhPZe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nrLhhPZe"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K3wQVB1267653;
	Fri, 20 Mar 2026 16:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6uSf8+qw3Gl4yi1kLR9NYSRErV+v+ASvVxYUKQVtX
	Tc=; b=nrLhhPZebWpqyUm7qD14XjH9Np75xnYRC/E06NTFhm+wQxC6JQ+EcH1+k
	wbWHHgueAXbd6PFDcVnmGaYiBGQkQAF6QCFTdYhV1Asb+ZTgrIpbqMT0Axi7m/PF
	JTEk+O0uahQKW+C5RG3/LU/xLa5Kw/Xpwm6JrUzFKPgoONaGXbNz0CNTLdSZiL7s
	YFqC007Q26Al0wFqGnepy0ZwCw3oglylM1CrR28cEIrThjO8r4cHeIDTNcj8d4yI
	bdNitG7beUkOBjXbtzCZPshhkA6ZNtYLIa4sWUz/xVdTn5xqS+srzPSPzmn8s+bT
	xWSUUFknZRuWToMDV2ajYVLCJuarQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybsmdaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KCaYcp015655;
	Fri, 20 Mar 2026 16:15:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nqupn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KGFgJ941288168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 16:15:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5911320043;
	Fri, 20 Mar 2026 16:15:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3164620040;
	Fri, 20 Mar 2026 16:15:42 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 16:15:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 0/8] KVM: s390: More memory management fixes
Date: Fri, 20 Mar 2026 17:15:34 +0100
Message-ID: <20260320161542.202913-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69bd72b3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=17roCnwcm3wU4lutgNwA:9
X-Proofpoint-ORIG-GUID: tqNDzESRHWXankGF_udz2EUJJ4EPnZsS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEzMCBTYWx0ZWRfX7xHZD532hHyO
 By5QuGMnLXekIjS0tiVShyPMIO8OSlJgzcb06KEkDodUhKqwDthQwxuFMdKf1NPum81wWW/3qGJ
 Y8MiA6Evp4Ay1CHMEDri2yS06pvI3GsIfnCvIkS+rLa9zCUCFzhku09W+6t6YVXkkLVD+ESKuPV
 eLfFIsyqHayl0yzt8c3HX91JnYmxMqkjd33pO11NZVW0boq7uAE3KzfHU4shrK5DGenswXHM7Oo
 5GEItOKaCKPOmwKKFPy9cMRAS//mK9mLgW9zba79w2BE9sAZQPWUAGlVMdpgtCv8D6QP8gRdq/q
 g2aASGusmmFXIh/cMhF4Korgn5yfNkcEucdylUaf59tA06Lu7QO8bC/uzpQ3xKAp25Kx13kKIaM
 XbHzLZqW1cF2Wham3GyEaSNE9J4Xhwt+1yJ++iCWRC4Ukp441NQlG/+7U3Z5ql2GyW6QXyORSlS
 UKKaIZb1YRwu7HcA8wA==
X-Proofpoint-GUID: tqNDzESRHWXankGF_udz2EUJJ4EPnZsS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200130

This series fixes some bugs that have been recently introduced with the
big gmap rewrite.

Most of the fixes are related to vSIE (nested guests), although some
are more general. The last patch fixes an issue introduced last year.

v1->v2
* propagate vsie notification bit when splitting a large page
* replace gmap_crstep_xchg() with gmap_crstep_xchg_atomic(); let the
  callers properly deal with races
* do not attempt to protect guest page table when the nested guest is
  running in a real address space
* fix return value of KVM_S390_VCPU_FAULT in case of error

Claudio Imbrenda (8):
  KVM: s390: vsie: Fix dat_split_ste()
  KVM: s390: Remove non-atomic dat_crstep_xchg()
  KVM: s390: vsie: Fix check for pre-existing shadow mapping
  KVM: s390: Fix gmap_link()
  KVM: s390: vsie: Fix refcount overflow for shadow gmaps
  KVM: s390: vsie: Fix unshadowing while shadowing
  KVM: s390: vsie: Fix guest page tables protection
  KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl

 arch/s390/kvm/dat.c      | 102 +++++----------------------
 arch/s390/kvm/dat.h      |  11 +--
 arch/s390/kvm/gaccess.c  |  43 ++++++-----
 arch/s390/kvm/gmap.c     | 149 +++++++++++++++++++++++++++++----------
 arch/s390/kvm/gmap.h     |  24 ++++---
 arch/s390/kvm/kvm-s390.c |  18 ++++-
 arch/s390/kvm/vsie.c     |   4 +-
 7 files changed, 189 insertions(+), 162 deletions(-)

-- 
2.53.0


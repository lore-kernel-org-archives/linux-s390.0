Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528795;
	b=N7yEKkRxd9719gYUk89JVmLu+CX+PkhRX58pu0QsO6zl8gUjWIO6MKWpmtJG93s9b8a7
	 53JqoapfU4dj0c57IUO3Mp83goRuDkGgP2UF0B1rEhPBwSPvqNag6Oo3F/6OvW5bnc3HB
	 85qVM6svvQyjI6zjo/al/cZvIoQ7Q8duRFzbk5Y9B164zJy6WIBJwbXGUfg3Dh0bAcIvs
	 dppL32Ntvqh5HiH++qAU5SM1IGDV1OsTd0v6GEyY/dKIRcNM4S+i1yLR2NIkIZu3y/vCA
	 a0BaE37SSvhv5gzx284+3ZV3BMCSbke6qJ6iwfYN15vUahmZ2BDdMRt61D6HWLPWqvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528795;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Di2fg3fLNhggCMnAo/uiHWH3ZPD+NGbFlhS6fzQuXMA=;
	b=Z0aVOmY4VcHGiIG8qugY3BS3mjc3IVZXps7OupweybV3cROqhazVfbWqMvkSihstIgWA
	 Y2gSKwnPN2Jna4xOk+GIhGBCjSFXs5gx/o1qNuNGbKJnG8JjdTzoaSmuAQ+eLxIAbMw7B
	 KCKNeAlz0nCjZHNFDxE9kt8yFBFAw5NWWmooH5AdO6IjxEQ+hdS6w4tv/YSBojzCqKnvb
	 1hjE1VxPmdwgvKeqd3r+zNrNBhIgH7MxN41u9bT+e93yjQn0bVj2FKSSwSdki7I6QE7hX
	 d12Stx4nLnEF39v1VIqTBuncwZmlZL1f1TZMDz9ifADMIACBksNWXHi1z4fnVaA3xtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eUk0kt1L;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03C606A334;
	Tue, 24 Nov 2026 13:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF03C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eUk0kt1L
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOB4l7r980122;
	Tue, 24 Nov 2026 13:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Di2fg3fLNhggCMnAo/uiHWH3ZPD+NGbFlhS6fzQuX
	MA=; b=eUk0kt1LLR/uqfmoUyyXAoIL/RhxoQtrqOgiM13svrJSpOAL9BoaZJz0U
	8+xz5Eaihx7ZR9HyZEGrvE3r1Y+anmnOc1Qr83hgTon0eBPT8Q8vDREOUe3oUBqp
	/IsTWoB/5/O75fKHhy77HiRHCRWRr69ZOSPRuyHrVkk+4VbnGTHHDMKZIKpnb1Uq
	YpQQN1LO5o7fczKT7s3NcF7UjRybNmOZIGk+5d1IzWEB19U5sPyfPs20K0/7YLig
	wqbT8u2nsy1ppNYIABl9iSwQB7vhqQEPO9JfuUyzItgVVCqqtex/1wnyVj5KUPQA
	01gdDYbyLwMQssB1rJF9t0hPJaPAA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4fdvc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 13:59:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOBrjLw595779;
	Tue, 24 Nov 2026 13:59:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5a410b4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 13:59:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AODxn5f10027402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 13:59:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBA722004E;
	Tue, 24 Nov 2026 13:59:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B80CA20043;
	Tue, 24 Nov 2026 13:59:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 13:59:48 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] s390/mm: Deduplicate machine_has_tlb_guest() usage
Date: Tue, 24 Nov 2026 14:59:43 +0100
Message-ID: <20261124135948.1295745-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1MyBTYWx0ZWRfX98sIne7v85Fs
 gDZyCmDwenUj1TAQe6gw13PAQljXhUyWQ9t+oCpnUk/DWufBapWjTQ2W978iuHmd88IsO0WbmzP
 Kzmw3zLCa+9PAGU4sdOL0089iaohq/o=
X-Proofpoint-GUID: PGSW6wl5qTSmtP1jv-yzAHgQWEvoSESK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1MyBTYWx0ZWRfX0S6FoLIYZRNH
 ZyfcezXaNDQvXbABsf68Hx488hz6A8Ig2RycQ7TefMp3cwL/SEap8wmFHLZui6BknCCD/P6KpMC
 vh6Fq4pZynk5uVmrj9ZtqTjnH/lwsSmi5+tArN4aw1Wts7qkMzWU2+U1PhChuWLDmDIDUZvw/Dy
 PDhPCgf16xiU8xtQ2VWAecTxycG4cPKWAtZDGCJvZeqMxYoh1GgIyRe4tqQLfQgcruEcZmoLS2M
 RAzkvtTco7g1/rndzuXFTjzDcKqvVGt3PoBbqr7zv3UJBVlbdkUHEQOauLPn3nNgH/aP1f2sUNC
 pO66taGZF1+7fPyuiWkQOHxf6K9zgFSBTo0O26gFi92099EpGEXABQacm+3/bNM/gXmTwoTqeVe
 wgd9ia7YzcW/qxUpTRfibISVu7mZcGwl9oxaiozdbH2fB6x5TZ53V6ouH1/1VgGXNV+6W7Ly8Ur
 cdtEL/CCkxVl+SUhDXA==
X-Proofpoint-ORIG-GUID: PGSW6wl5qTSmtP1jv-yzAHgQWEvoSESK
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b059859 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=MgucmpxK4gcV0cN4TWEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240053

While working on something different there was the need to add yet
another machine_has_tlb_guest() check. The machine_has_tlb_guest() check
pattern is duplicated all over the place. It seems to make sense to add
common helpers instead of duplicating the code again.

This also revealed that the gmap_asce member in mm_context_t is always
zero since Claudio's gmap rework. Removing it allows to simplify quite a
bit of code.

Code applies on top of linux-next 20261123.

Thanks,
Heiko

Heiko Carstens (5):
  s390/mm: Remove gmap_asce from mm_context_t
  s390/mm: Remove unused nodat parameter from ptep flush helpers
  s390/mm: Add ptep_ipte() helper
  s390/mm: Add pmdp_idte() helper
  s390/mm: Add pudp_idte() helper

 arch/s390/include/asm/mmu.h         |  1 -
 arch/s390/include/asm/mmu_context.h |  1 -
 arch/s390/include/asm/pgtable.h     | 31 ++++++++++
 arch/s390/include/asm/tlbflush.h    | 12 +---
 arch/s390/kvm/gmap/dat.c            |  5 +-
 arch/s390/mm/pgtable.c              | 94 ++++++-----------------------
 6 files changed, 53 insertions(+), 91 deletions(-)


base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
-- 
2.53.0


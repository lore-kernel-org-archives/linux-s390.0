Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893037;
	b=CB/NPLqLiLWhzw7nMyozCV015WUJA1GOO4QL/aSYR/3GhB0dilQyMMfGKnmkksiK+NbX
	 1aCKHx731iiNUcqqIY7eneiPWdROnUR7qVidBLGSa5fv/b9zraroYKJNBy3y3GcS9PcDF
	 O8GPcx6KQ4W7Y9+cBkUAXIPhC2ZuRJadKIlIuHlP1yz5VME2carp7QLIbU10kQS6wTYVP
	 BBILb8MH+3YWErzoEBGz52Vhg95Oiiwh3iUvMFcqdbGIU5G5m0bBvvKANxN0KGLFCA7Ci
	 Ht2bF68GFyOAWg61tC3J52V+unyO3RxhrJFcqrYFWLzL7xMosqZQztHRQGDSpHkIqqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893037;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1TcnEO7LTvNQQNz11i2QHryQueJ9+HvO79SeEDn/MYw=;
	b=oRP8ZDJyzEVLPreDg2Z1QTgfW1NxNgywVSnP2lFrCI491PGEEBqWwaTrP8Ip3B2DUgR8
	 MKlSntYXubSK0n8QRcMK2ejGeK5dfhkxXmz4hvjK7RpdULRBHNyNFlctcA83kwPPGqvKE
	 WSZAHYdzm6qs+zwn/xZzfaDhGNva4dtyplT0Oecyyxk2Sk88H9PWcZTksDoqaivXZuUdw
	 KUdUbbru4Eq9lxXoSs2DFez5nBZBbf8B5lq5imi3sjjZMuRg82IUZb0w6XgLY1RqS2967
	 WYmxBzhxeFh6qTQngCicwSonWMQaRHMoXznhGSe1cFs98EdXUmAMV8VCpBB9MRov9kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RASBOwmo;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881C1606A33D;
	Thu,  5 Nov 2026 15:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 881C1606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RASBOwmo
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EiHJi2627300;
	Thu, 5 Nov 2026 15:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1TcnEO7LTvNQQNz11i2QHryQueJ9+HvO79SeEDn/M
	Yw=; b=RASBOwmoxbaROGaKFMN1xJXqmWh3q5uT1EFqgfiN7AZhlikqP8cBJGU6v
	LzAu43gGgxHDNU3drD0fhuvha0LmlwQfggY/RC69y3BbFEojwKdchn963HT/7tcx
	18ce5Oz4joqFQ2nAtFLLafrqZuaGTXa1g/OxBKA5eEH4avf4IItDrEciHmQnAPkr
	4hbWCm1NI/nQmd1moOLtcbGWZjh5kE5JsFJuz0ZlaQLNxQtJ2CLzVS8VDybsLUcz
	8iMXc5A6F888Ps0RlEmkcbpyFjckg2yQOu+nr6Xcd7PBRVF/TmB+si1It2CoA1u8
	XeJnfAoxOH/00iRs5TjGq2kMjvPNQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rdju8b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 15:37:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EZ0ZG1746204;
	Thu, 5 Nov 2026 15:37:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9mjry9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 15:37:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5Fb6M126804960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 15:37:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11C6620043;
	Thu,  5 Nov 2026 15:37:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E53B020040;
	Thu,  5 Nov 2026 15:37:05 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 15:37:05 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v6 0/5] KVM: s390: Misc bugfixes for 7.4
Date: Thu,  5 Nov 2026 16:37:00 +0100
Message-ID: <20261105153705.208516-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
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
X-Proofpoint-GUID: eBMpuNxFF3Yfc47Bi5RE1A9LVw8ZZlCD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfXwlD+6koLXnnx
 hMvi8pEkbc5zrnPxgeDqoq3pgIGU2Owdn0NWUEHRdA0JqZdDDFCgAox4toYT1cnxHyAu+x2ehQl
 E9cX5y68TvtwYKQTnbajv7vKoh07WlJNkbwlMoJyal3fzrXjBr4ZAsphtkH6GSscVf5/ziF1wFm
 cSAkP4fNi1QisWqy3DKbuSrRLjYYzLoqAViu2HxgXsr6G/k9jL6WZ34EOUYzfp9y5eZvW10CFam
 ei0QZOG3mR+fRg4b1+qe0lPXwK5ndwnjlz1bmaPP/Y3u8/GooRsvCAe/+PncWmcUMNuVvN4DQFJ
 VptsPOkRbLIrdSKZ9wEklw8FOfWt6smq1rI0JJDjWh8M9+lVrIyb2mc/btZpx+tfNWd8GZJSLi2
 T6fwG+uQo+ms85mhMtnpEC/wB3gEAlZF6kABTsu3lKnYF9rDeJCeDKZEbry89rxNy6vBROpWXaZ
 sSiYF4KsXCJ4y+irsMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfXyN38lEJAaPQK
 h5seFrqgiCcMxjNv39UgiSMuq48modfJQgyvd9JDvSJLo9Yuls/3KDYrzIuE7FSOCcSK04VCZ4k
 boSNoIz2+shdeVZlYmoh91qrYbY6PgI=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6aeca2a8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=6_dDdnKulsZJQZLWuZAA:9
X-Proofpoint-ORIG-GUID: eBMpuNxFF3Yfc47Bi5RE1A9LVw8ZZlCD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050060

Misc bugfixes.

Some Fixes tags are approximate, since the bugs arise from slow changes
behind the scenes in the kernel, and not from an actual bug at the moment
of the introduction of the original code.

v5->v6:
* drop the last two patches, as they need more thought
* add comments in patch 1
* remove spurious kvm_vcpu_mapped() check
* pick up some acks and r-bs

v4->v5:
* fix check gmap_unmap_gfn_range_fast()
* refactor and rename the function to enable cmma, now have a lockless
  version called gmap_enable_cmm_already_locked() and a wrapper called
  gmap_enable_cmm() that performs the locking
* fix missing DAT_WALK_USES_SKEYS flag
* fix some comments

v3->v4:
* oops! some stuff removed in the previous iteration was actually needed
* improve patch descriptions
* fix idte_crste() clobber and table type (partially picked from v2)
* s/IPTE_GUEST_ASCE/IDTE_GUEST_ASCE/ when using idte_crste()
* improve comments in gmap_unmap_gfn_range()
* do not attempt unmapping prefixes if the unmap range is above 2G
* remove useless !hpa check in pin_blocks()
* fix cmma issue when using large pages that caused the whole guest
  memory to be allocated

v2->v3:
* remove all non-bugfix patches
* rebase onto master

v1->v2:
* add "memory" clobber to idte_crste()
* remove superflouos gpa parameter for unpin_scb()
* clear the zero bit in the PGSTE when unmapping, add missing barrier

Claudio Imbrenda (5):
  KVM: s390: Fix UCONTROL inconsistencies
  KVM: s390: Move some skey functions to headers
  KVM: s390: Fix idte_crste() clobber and table type
  KVM: s390: Improve unmapping of large ranges
  KVM: s390: vsie: Fix pinning using the wrong flag

 arch/s390/kvm/gmap/dat.c  |  26 ------
 arch/s390/kvm/gmap/dat.h  |  54 ++++++++++-
 arch/s390/kvm/gmap/gmap.c | 190 ++++++++++++++++++++++++++++++--------
 arch/s390/kvm/s390/vsie.c | 133 ++++++++++----------------
 4 files changed, 249 insertions(+), 154 deletions(-)

-- 
2.56.0


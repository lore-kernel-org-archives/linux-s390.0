Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213673;
	b=EtnzEinALEYQTMfrn8nEevL0+qBxU48hVW7nN7YJa3vYKDEHc7kgNUMKDWBq5VdyUfnz
	 9X+dWVf7yWK95EBL6G5LIZGG4URUuZ4Prxp5faxHUBYgusBSDhgeSr9IAhG4+j/H/4b4Z
	 lSzXH9T15juKZdR0odRXSlMnundLUnhcRVFgj6TFtByMyuLmnm+W0X4V/Pno2lmGlmhpW
	 2mUr5XvqBsMHFbhlLqkmJjfNrDyTn345QvWi/wsTYr28zWuXz6UiZV4CfI8tU8hmwDAdc
	 yuWbnNW6NxsvMo6Ft19rf9S24+g0RNPwtIW41FH8u0RdeekOus33gJyFzjNDtojhbtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213673;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=E8YzY2it3vt2uiGmjkSLao0CD6Lfl3hNbBp+MVBI1L8=;
	b=txY/qjlqyjo2wssI11ggdPhDlp6RQy6Bq7gSp1evI/PTXLKDut1PPIlHQ3SeT4K9FBNn
	 Pzy6OrLmwJpm4T+lyorhagbgLh+yrEI15hR6NFysU4OwkqzNsDQ+ylEHgYrD6q4mpaJKt
	 ix71poKW9cgMqRNTv0+2rTawYHpfy7AV281iL0FYJRRI+YIWIQ4ohqsHjrs07DfF8dwfO
	 AkD+kU/AEskxAGx4rlLKd12rywZYI/NJ9lcd6zDV6vMi6RZUnko3/IgJ3EZChem5SUOx/
	 TRP49xvKZco16fl00j5RNyePZafecZRiYM0sIaHD0sdwh4GpKNU3BRHyEM81rtceruw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mGL9f03Z;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EA2606A32C;
	Wed, 28 Oct 2026 18:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7EA2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mGL9f03Z
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIiFsW2045081;
	Wed, 28 Oct 2026 18:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=E8YzY2it3vt2uiGmjkSLao0CD6Lfl3hNbBp+MVBI1
	L8=; b=mGL9f03ZLdchi5Sg6NBJks+VjpOSwwSVKN9Tz135uJQrTW3WPA0ZuqCGT
	H/U0mzGMfnJaavi/hNeqbfDuxOh+Izn3K39wX1oZ/o7vQmtxEq0eJB/UMdq50tgg
	krdicwBlnIhhg4Zt8AHcuOBSjjjmyIRQeNg6jC7jcqKjvj63ijybB2FwgkY5T66e
	0h6c3v2qubZvqh9vzPt4GDO8uCWJUFYWPfdbgGxtixoTW7i+lXfGhyWL4qztolmV
	NdEgFouuW8H197MGKzLBeNnkibuYcHJHS87d+zaxS7wvTFQ8exl1SLrk2CkFLSwK
	sn+qWBfo8zCWc3wc/4x4cyFPHpKfQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavp0t2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 18:54:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIYnb52009674;
	Wed, 28 Oct 2026 18:54:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjvh1x0cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 18:54:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SIsMov51708184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 18:54:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71AE720043;
	Wed, 28 Oct 2026 18:54:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EA4E20040;
	Wed, 28 Oct 2026 18:54:22 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 18:54:22 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v4 0/7] KVM: s390: Misc bugfixes for 7.4
Date: Wed, 28 Oct 2026 19:54:15 +0100
Message-ID: <20261028185422.272146-1-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae244e5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=6_dDdnKulsZJQZLWuZAA:9
X-Proofpoint-GUID: prffUqBisDVo4u_o6mYK6KhwIDmD71gj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NCBTYWx0ZWRfXwBMLE/fLXoK+
 YY/yr0yTpevpWR3CzSyQ8NG+bHV/7eDuS6caMp6eCUTRXjLrg84QiK6cq06FJi31AbSoiKWshid
 i/3OXG2GfXfWOASwWQbn9Sp94D7tqhw=
X-Proofpoint-ORIG-GUID: prffUqBisDVo4u_o6mYK6KhwIDmD71gj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NCBTYWx0ZWRfX5Yq+EGIqAX5S
 JE7S9C8yiBliq/TP5GlrrUTDRjW3n6rXezyR8hJkDbJZv4JZ3Y7n1jEXEfElWxxnxbS1MRHBnlq
 dDzmKin85N0s0df9AEq7iY84mUEBSadYFiRX4aX/DF91QI4gzcMUlCHfnShirWOWHuMnWM8eC0Q
 mL5LJwXo2e3hi8OtmSeJAXUHPfnGz05PrUt++76EeyViHYP+MvkCdB94QpwCeuWA7bqOSVCAz+0
 KXcQVeKo12xd1aHzOZU5/Ck4RiqbU2FJLuut3ZDpyMDUejX3+dLolemLh8QtviJ5lCdE47UxNZK
 RZdfI3SZs8EiOE8O7AxqK1GpwENhwkav9PvxI2SWKpxsv1tGErmywyGBDHJjq62ee2BTxg5b5hJ
 5mufJ7zINM794V7z8vNRQiXuE0MhNOPDrBMYa0z03YLyM41H7NyHvdIZSy+N39WQAwATyrIkQz9
 uXA+B7dN2IAJkTADXMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280074

Misc bugfixes.

Some Fixes tags are approximate, since the bugs arise from slow changes
behind the scenes in the kernel, and not from an actual bug at the moment
of the introduction of the original code.

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

Claudio Imbrenda (7):
  KVM: s390: Fix UCONTROL inconsistencies
  KVM: s390: Move some skey functions to headers
  KVM: s390: Fix idte_crste() clobber and table type
  KVM: s390: Improve unmapping of large ranges
  KVM: s390: vsie: Fix pinning using the wrong flag
  KVM: s390: Introduce gmap_allocate_all_page_tables_best_effort()
  KVM: s390: Allocate page tables when CMMA is used

 arch/s390/kvm/gmap/dat.c  |  26 -----
 arch/s390/kvm/gmap/dat.h  |  48 +++++++-
 arch/s390/kvm/gmap/gmap.c | 227 +++++++++++++++++++++++++++++++-------
 arch/s390/kvm/gmap/gmap.h |   1 +
 arch/s390/kvm/s390/priv.c |   5 +-
 arch/s390/kvm/s390/s390.c |   5 +-
 arch/s390/kvm/s390/vsie.c | 135 ++++++++---------------
 7 files changed, 291 insertions(+), 156 deletions(-)

-- 
2.56.0


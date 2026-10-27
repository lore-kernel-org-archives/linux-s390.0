Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122369;
	b=3QfcOPf+L2k4g2wmsA4jrNYPRsC2iu2GxvKj0AM/cNJUVIFI8Q159/38HU/46VSpkrvn
	 9PEOSbhilO75cibzhEgOvlT5EwJgYuFYlUcIMQct9g63QfOQKjeJVR2bOXG0rOwWx4bPz
	 I0lhmOMFKVT5V+kltOdk0zphuSTKv6ebfS6DpyVUzC6HLDTo7a7AdEqz2CY9AsmSo1qaw
	 S/eJ592Q30PltgXSaI6KP83HTdRGycgNWvjCuLWTNpCaeNkIxUM8uUWvhP3CRYch8x1ji
	 GmctMGi7y0Y/hPAeUbT5vygwqE5jgYiXj6nnD+t3ypTzTwzDSOJvWnTadoEjR7Xpuug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122369;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HQkxzjcYdQS8zPbg7QdQRcussTBgmfHwon/+0uAZBxo=;
	b=OIxr3SscB2A1N81kPrCacFqwKzmdJSUNdxCAErrFmz5Lg6XWbLmWFotMslxQX60rNHuY
	 FuwlUWI3tm9/7gtVpJ9BFlc2YlsPlFveXhboUlItVGS8imvLtpkP9KW010Z4b0gCRq3wA
	 NqoO0wPPvVcCltYZYLCkb4vJ/Ect1iFM7NkxV8yZCSNj6aP5e5nRNFqfR6AJ06H/D3I/9
	 aCtWrazFc/wfsO5xoU2AP4atEs6YXw8paO19eFtH7v/zI4mrhBMZ4vVTiGqVD6835/x+i
	 IHe2ZlEPaa21BAJ9hlcSxVTVul5bWir2/5HcBPexp6x+a7h4UfeHGlmfSlI5hWQ4ZKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kV9lQynY;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2D606A32F;
	Tue, 27 Oct 2026 17:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1E2D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kV9lQynY
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RHERAm1951772;
	Tue, 27 Oct 2026 17:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=HQkxzjcYdQS8zPbg7QdQRcussTBgmfHwon/+0uAZB
	xo=; b=kV9lQynYbC5pppSZddNcKHcWMamddW/bfvgdTEb9KMXLGNBLmgpTjEujo
	j5fMuLp8RyQDAx1bMlCbo/HXku+ol3T81qwmXoqK/fybep5G2JDAQNjcVa63HFh/
	teYyG+DU+24z1ePaB70YU7A7eNPNtkXdu+TRrK1faKEs7God99W4rTj01jI0XG7J
	KXecWUtZZHxNUuDegdwk+TLkkR/ByWJdX9eUEUx89bPRiFG28yyE6ke8OmjjpYMG
	TrWIzb5mUu2ufA+OmkjXIy08WL3bnBNzNDO7GOw7Thcl5gyWx2YdXL5ziBMATg9Q
	c3vmkGeXLO13lDJZD80hZ3Bow6Hww==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3g0qr6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 17:32:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RH57CE328682;
	Tue, 27 Oct 2026 17:32:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjvh1s786-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 17:32:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69RHWddS48955886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 17:32:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 932FE2004B;
	Tue, 27 Oct 2026 17:32:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6711720043;
	Tue, 27 Oct 2026 17:32:39 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 17:32:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v3 0/4] KVM: s390: Misc bugfixes for 7.4
Date: Tue, 27 Oct 2026 18:32:35 +0100
Message-ID: <20261027173239.224849-1-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae0e03e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=GAKtPlNA0qdIb8t8ZpcA:9
X-Proofpoint-ORIG-GUID: kIVVVoKGSjsGZ6ljyajRbqPKEuTXGPUt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2OCBTYWx0ZWRfX50EAkDTLcYRF
 Uu7bjAXoCerOAgvVK1iohGyB4y4a8LUZFdrDqnqqzWyBCr3NxWYLlEsH0GpbuBj4nSpy8mUPL6x
 YtgPVsxxYfou/U4Xagw7nu7wki+HUcaX8raPp6IO7rlQFRQyho/oKM3OhTtVL6V6kSJTdaoppxW
 UcoENdE71N4ELlG9ZHhrhq0BmDhkuH68O6RRp6X1B3QtTXz32BBLrL3XhIgtt4oR6GDylC4KhaZ
 ijkVTAf04JcxuumE3KUGZyQHF8SYJmEOW+mAtMLaIWpROPBgesdD+oAYx8WrUxtV9E+xXGk7HGE
 CdnRhtxCNfgVAx2oOoZcuTRDtD+TfP0z/03/KgjUh511fSGO9+aTNmrHnpVuuCHNIZT8VjwLLm3
 1L8q+JurXcMdZcdy+/zb77J2tNBmo/VVJZNi5plaSxWOSY/ioLLE5jskpO0PgdG+CxrOrPaTGii
 MzP5V3j8qrj3EAxYvvg==
X-Proofpoint-GUID: kIVVVoKGSjsGZ6ljyajRbqPKEuTXGPUt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2OCBTYWx0ZWRfX4OASsnbhar6Y
 l2RFF3HlWL+konwB30jcmv1VBTgV4j1Rn4C0mXS5PmO1i5u3VF3wDD1Lj2ByKCcyV4vpR1ocHiY
 f3d15q9j03Yhb5nscl3UwliFblYYk58=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270068

Misc bugfixes.

Some Fixes tags are approximate, since the bugs arise from slow changes
behind the scenes in the kernel, and not from an actual bug at the moment
of the introduction of the original code.

v2->v3:
* remove all non-bugfix patches
* rebase onto master

v1->v2:
* add "memory" clobber to idte_crste()
* remove superflouos gpa parameter for unpin_scb()
* clear the zero bit in the PGSTE when unmapping, add missing barrier

The remaining issues raised by sashiko in v1 are false positives.

Claudio Imbrenda (4):
  KVM: s390: Fix UCONTROL inconsistencies
  KVM: s390: Move some skey functions to headers
  KVM: s390: Improve unmapping of large ranges
  KVM: s390: vsie: Fix pinning using the wrong flag

 arch/s390/kvm/gmap/dat.c  |  26 ------
 arch/s390/kvm/gmap/dat.h  |  42 ++++++++-
 arch/s390/kvm/gmap/gmap.c | 178 +++++++++++++++++++++++++++++---------
 arch/s390/kvm/s390/vsie.c | 137 +++++++++++------------------
 4 files changed, 230 insertions(+), 153 deletions(-)

-- 
2.56.0


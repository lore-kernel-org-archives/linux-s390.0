Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF146F4BC;
	Mon, 14 Sep 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403749; cv=none; b=hp/+R73FCHSJjWtObJZY0CTPd4lRf2WezxxcPRuWDieYkKnTpA9Cu/Z4aRADvoFSZREjIM8YCOq75WKJFPTyjNxF/hiNGev9RfbPcVmWcyiMeB6nnz7RmmLqniBK5cEP9DrsrhOf+DQb3BjYiuZqHeT48Hfs1j6cQr5rHOw5ua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403749; c=relaxed/simple;
	bh=FsrBZkxZUTTveNgjKASkkUC5M0AfPjHcXlNk/TvQH0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeSDJD549rZGhZoyQP5xHZPmO9MQzsybxyYSCqZpflGcz3c4raD0QfGxcIs1NFwtiOtrJRLdsn8t/GPn8SphIrVgxS7FgnHsVWOhtXHex0cUxU0pKJpttsKw+PXJC7HfHy6iMqewWg5Fy2A6c9oR6sJ25OteKgTB9yaKNBkMETU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lr7oqeV2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lr7oqeV2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EFwEpJ2516100;
	Mon, 14 Sep 2026 16:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9MxaMTP2fA+GkO6+QaRKgKFrIvyrX7
	Mj51Kt+04Xe1g=; b=lr7oqeV2XAA7XKb//fWHYMPne/AWZST0Lia9/NYyIwX6CK
	76XmCv9Z09NrcDbKUEP/5+yo/IGsxIMUiN0LyN6oK6TW8BCNNTR/1LJ7jgy9XdE2
	P0WDbZQQClOS1fQkpfq1zUqZanR8ZF2Gkv92poSNNDLe+5Dnr0R6cd9n1o578k25
	BqGSKIk08D8TTTwwgE1HZPKfb6N1YALfl2FJCiQBxT9ABNje1wany4139Mk/xHgw
	WTHxnEALCLnm+E/hGyFeOzXV5FvzEr725hzHWWLI0S+NP2VMyRoMypOe0esCH5vt
	YxwWQBF31YlXZ83vkCD22fnwfDpoP0gC/wpDXWog==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcutetd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 16:35:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68EGZUPE2352730;
	Mon, 14 Sep 2026 16:35:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnkry6scd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 16:35:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EGZfdi52953560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 16:35:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B589220043;
	Mon, 14 Sep 2026 16:35:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F4A120040;
	Mon, 14 Sep 2026 16:35:41 +0000 (GMT)
Received: from osiris (unknown [9.87.150.220])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Sep 2026 16:35:41 +0000 (GMT)
Date: Mon, 14 Sep 2026 18:35:40 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: fix typos in comments
Message-ID: <20260914163540.14910Ac8-hca@linux.ibm.com>
References: <20260907063856.27600-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907063856.27600-1-hemanth.selam@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIzNyBTYWx0ZWRfXwkAAPa4TzF5L
 IzSMjTTcW2vhZ39IY9RAnVcdloJ77kvOIeW7mEFiQy3gBTdDtc3CtNq3MLGzQeVW4WbpGeN1cn7
 a1mjFWGcOTEOt4VGYCZjc1rvFaq39zM=
X-Proofpoint-ORIG-GUID: 79Ife5TWJ5zVkId5j_SKZs9XlH_oIvmD
X-Proofpoint-GUID: payRPa5pUnLdMDyva5qcS4WOpsPQlPR0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIzNyBTYWx0ZWRfX5CE4jPRKF+7z
 VuCe0JjgSZs4g0QwxfaDRlo0b0ZZ9kzOOCivKF3CzqEjKE3YrNCz0AN5HcG6pJ/iK5gCoEcVNRq
 B5vf5acR0yZO89VuszEhBTDDMctLF+xDby7TCGKQMaHb7ezYRAJ7a11ojHXYaTuFY9LcW6TTMHj
 KVSLJfjnmulbm1T52ReMV5niaIkZaJvEvyY/skI38ZDIxz9EIGLrscW3qumNJWy8u3SCxv6a7RD
 3Uy9pUfsta2x3hIbyMAE3uCEjF6IMWwZXDZGKpxMuCEOnsrJAbBidqc9CqfdQ/Zr5Lm5gNsesoF
 s2lOMR4lDKn8gn9YyOtqW2MeOSbWHFizZwjM9GDSe2wIzbweG9SlE8rLH2576yMflu28qLSH25y
 xMS5Unk7rTy2aPfnOlpY2U9lgETdyCQlZg47L+8JVRMc+bY3if8SKrgLNb/0AXmC54pYKqZuLsy
 n2v04DDQn+eRLtt3Rmw==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aa82262 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=wbSmXUBKm7kmP3h1SjcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140237

On Mon, Sep 07, 2026 at 12:08:56PM +0530, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/s390/block/dasd_3990_erp.c | 6 +++---
>  drivers/s390/block/dasd_eckd.c     | 4 ++--
>  drivers/s390/char/raw3270.c        | 2 +-
>  drivers/s390/char/vmlogrdr.c       | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

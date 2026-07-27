Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA82EEE9F;
	Mon, 27 Jul 2026 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166668; cv=none; b=bnt41wnh87UCzTosbBzwRjs2K+GivooHmkJ65UbMhUy8CJLCS0uwdv+r1AOSnLd340QlV7rOM0uzmSjXQEoTKFxKXToRq1KUaMeUrY2pOvqStnMt3TiiN8Q3W2i1TR0wARrBGrCMyYV9Iz+X9iEjCCQUYB5A/UdvOccjppcvOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166668; c=relaxed/simple;
	bh=oG9hbQFiobXs6vZRXPMsY5Wnrk2rlHH/DhmPpHs9+OU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=t8zrxTsVF6acQlZnScBsaNckaL5Y2f9JRgm/z+qhWpfaqO7DXIfvCKqnmPhWZdHwyL/hd2zt6yQGdS1Bq0PKwhtLtgTWKsYncV+QswXUV18RwETKWkUZVpzrckKdSTcRHUD9CYPICoWvl6lbpP4j0CRAZIhwxVBquQEmw/IcjPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SkJAmHNa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SkJAmHNa"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmpVv512396;
	Mon, 27 Jul 2026 15:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0hmgcZ
	1X8sHCZ4WgFUqZ+PhQkCgzjGTyf45H3Kv61wc=; b=SkJAmHNaaFxhOjDEzFisKp
	FCt18MiM48G95aVJaNo5FfoRiElzb+Wz/HY6sTK71COYvecX1DcOw3wXZQRpZ6pp
	t+6UdWlKB3QCas11GGYb4D/NNBcGddVua8whDRXF83ZyxO+4Hfv72QSTkf3bABG+
	Qws05tJvmkRtXoS2/tXajYMvb8i7siHCVXMj5XwRovRUEbkPB0mUWrEZRgWzpcAt
	HqJkHMwn1hWbuT+vFqTW+fLqCcEHRA2YX8BV3vBLC2MOwjM89hQq2L4yEZH84w0X
	moIIM2+9Aw/cdEdl4+NLf3x5j+HLoAIGF2zUoASsNgYFy2Ve34/Zum7W3KVmKGpg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc8s89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:37:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RFQHu0012980;
	Mon, 27 Jul 2026 15:37:29 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq63um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:37:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RFbSBh59376028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:37:28 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0948658045;
	Mon, 27 Jul 2026 15:37:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 403EA58050;
	Mon, 27 Jul 2026 15:37:26 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:37:26 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 27 Jul 2026 17:37:25 +0200
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ
 <jchrist@linux.ibm.com>,
        Dominik Steenken <dost@de.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Maxim Khmelevskii <max@linux.ibm.com>,
        Jens
 Remus <jremus@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>, Kees
 Cook <kees@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, llvm@lists.linux.dev,
        bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] s390/bpf: Add kCFI support
In-Reply-To: <20260727140514.116501-6-hca@linux.ibm.com>
References: <20260727140514.116501-1-hca@linux.ibm.com>
 <20260727140514.116501-6-hca@linux.ibm.com>
Message-ID: <7d7dd4bbce96d929a35f2981b18d1c17@linux.ibm.com>
X-Sender: iii@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: VOM-TLWhT-aQEyahwhad-Xfoi1FXN-a_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX2aGn3nQajnmR
 uyPftbHN6+UhfQHO30eNw5ljIqpk+5mNBRllYeth/zk8n06ENTbhHCXAAW8dFFgC09DO8hdRF3c
 Rethq6EOemMLLR6ua4tfg9sUgZV1fQrqHUSZ+Fc0WLDqNwmDsEtonQwLS1+DsT0Kv7NL4MoXl8k
 Nmnr0RM4x4aTtX/Mlnz9zTSwsPXjXjYgf2FUAqLpM2M+SNkVm43zr205I3AVaIaWoFZ9Ihf8UAj
 4VI+qZybyskqXdLN5Tsb0f4GZS8J5VVQSsylMmlAk/iu0yychcovpv7aIqh64n30iI57KrZOyWw
 iHI4okJ1/Ju1UL4jG0LMBhZKXNQidWeK+kaVR9lPeCKlFtyZzM82+CGqTzSW0JweC3Jvf2XpaRE
 4r36vItvclLQL+SyWpIcu/n7c6nsYl+qGCot7n6FA+3VP/V6AvJh/kH+SHNrJNZkhJdUSJhC6+E
 nErZnLQT0YGTjC0JHuA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfXwXrJquqOSQFy
 RRVwusC+NLZssauQc1B2tOFPyi+vQiUfcqLgGSMnyyoQfWPK5TZsNlaF9Rgk69AzML+RHqUVdUp
 doTeNrrwpEGwdwy0lCpJcYlsLhULtw4=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a677b3a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=naD7qE6c7dX3dS7GAa8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: CtB37ye5DuxK6FeTjhg9t7ymbHLmOId_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270144

On 2026-07-27 16:05, Heiko Carstens wrote:
> This is the s390 variant of commit 710618c760c0 ("arm64/cfi,bpf: 
> Support
> kCFI + BPF on arm64").
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/cfi.h  |  7 +++++++
>  arch/s390/net/bpf_jit_comp.c | 28 ++++++++++++++++++++++++----
>  2 files changed, 31 insertions(+), 4 deletions(-)
>  create mode 100644 arch/s390/include/asm/cfi.h

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

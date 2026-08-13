Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6B39A7F2;
	Thu, 13 Aug 2026 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611467; cv=none; b=CwAf7rQFT0hw13VHzsg+hOx7sFyWnTb2rC0SMEsWA5RCzzckhqBMRb5Sj72hG7lg5s2v5kXLf1hlLspG8BU/2cE2c88HtGrI5fmnXyG2fItCPRLgAueuvC527fqbra1zzWHaWYPp85U1pcx8GDr3/U7H+r7DRY6opCfmCMTA0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611467; c=relaxed/simple;
	bh=CIwsQWHcV94xwo7SWkDkmZ2wUpuZBk90TTI8Mn3gN+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO3d4XQ57cKqmw2M1KIVubfA8QjlDkug+CK+N3MukcaehDyt5UDa5wC807LMOhJbSBUFR74ZArSDx05/VJnXs2jjFyhUr+AwL3T6Kdl5mvuVN7AWKd3uNypUqjSaN/EY07Bftzn250+4aawQZkDe/8WyqTBJ6fUgV/kqkBHb3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y62efBOl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y62efBOl"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D61nle1430627;
	Thu, 13 Aug 2026 08:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TsObQORjB9Cbf0sLJ47VKFfN0K6NnE
	k6WOgC2weYtzk=; b=Y62efBOlUXlX1lxZ6pksfiBWck4cqxzLDtI7c1u64uAlJs
	hTb4rFHkGUH97VhS+mwPnyuJp/3wwVWIQTxjbxPqMGQURnMlibmLlIsEuDBd3src
	T2f7LOSOKEOy56/uXEIKECkZEcYtb7cpYC2U6rw+bgIKapUzfw6s58U85MeTzxWn
	RgQk19qnzd74gs+z+ny/pTsxmAksrXTAv7V9LqpkoYVDcick91D59amYTV+Wx7ft
	E+ERYTQmpJwtrNt1GnFE65oiG5FVjXUZHXhAq9Jwo1uZAx8ZujSlHHZRyt1JPqbl
	WsV+V6B9irA1qqrXbPl3Fmmd1Najrd0EafZ7fkjA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp3645h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 08:57:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D8uOs7004647;
	Thu, 13 Aug 2026 08:57:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wadb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 08:57:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D8vY5a42598842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 08:57:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3699220043;
	Thu, 13 Aug 2026 08:57:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1EA520040;
	Thu, 13 Aug 2026 08:57:33 +0000 (GMT)
Received: from localhost (unknown [9.111.42.87])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Aug 2026 08:57:33 +0000 (GMT)
Date: Thu, 13 Aug 2026 10:57:32 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/percpu: Fix MVIY_PERCPU() with older binutils
Message-ID: <ttjpa7w@ub.hpns>
References: <20260812203036.3018-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812203036.3018-1-kmehltretter@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7d8703 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=Fbue1idrPtY0ZwZ-O10A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: f6_JhA1bCXhb_biS6xM_ptfDxJ1H-bpR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1OCBTYWx0ZWRfX1ZoOUbquEBPN
 9pYnb1CfHotkGhF63bk5OKNa5eyGxeatNLbHPWNmCmYCe/pQG6ihpzZz8pzIiBD1wOZ7+7+xtzq
 Losb/+5jwaShz6WKseXhm7DRJQbcvanVgGnpVZsvrPQ/z83p458lnuRdYJdIlpX4GHMdsa7pDKS
 FUhw4eEG/wf3aPUxDR799L1pgY9fcPfRtQ4Giy996uKUFyQciN0/NFWGVS2H35xhzRv4nTwbV7q
 l6Ic8WA/DxdFNP6UspPj7tL3LIsgNMwmTRLCA5aqEGPwNS+HikcNNpa6BNt5L+wLBJ1cZKP+waU
 SDQgDisR/+0rZvuVm6yHC32lP67pWzEX8Rn05fbTCvsx1v6tTutp9T3z0oz6bnVKnd9NnEr6hZl
 /5YkiEUOniFbn6Zh8k1Ltah5tHP1TGF+5c4QdR+1k6xddU1OeSYnvLcj4nzdozHQUa/tv500IZg
 gUyXfcXDfU3eifSScpg==
X-Proofpoint-ORIG-GUID: YFzbg_hCxrpJeExkPpt1nNuRJqB9Zcof
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1OCBTYWx0ZWRfX9haJu/KsaB0f
 60UIJrHL5NQT4nhx5bfuG/qqB5ZQF9ZBdqd2JknhG5e3oAZNsre9Tqjso90b2sElc7P1h0zP859
 UPLxUWBhgHoxyaNLnJlQju8nD8ATwIs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130058

On Wed, Aug 12, 2026 at 10:30:36PM +0200, Karl Mehltretter wrote:
> Commit a737737cdb9c ("s390/percpu: Infrastructure for more efficient
> this_cpu operations") introduced MVIY_PERCPU(), which stringifies
> arguments that are already C string literals. This generates an
> assembler macro invocation with whitespace-separated quoted arguments:
> 
>   GEN_MVIY "459712" "%r3"
> 
> GNU as versions prior to binutils 2.39 drop the separating whitespace
> between quoted macro arguments during input scrubbing. They
> consequently parse the invocation as a single argument and emit
> repeated warnings:
> 
>   Warning: missing closing `"'
> 
> The .ifc in GEN_MVIY never matches and GNU as exits successfully
> without emitting the mviy instruction. As a result, the interrupted
> per-CPU sequence is not marked in lowcore and the exception return
> path cannot repair the per-CPU address register after migration.
> 
> All MVIY_PERCPU() callers pass C string literals. Use them directly
> and separate the assembler macro arguments with an explicit comma. The
> resulting invocation is:
> 
>   GEN_MVIY 459712, %r3
> 
> This form is unambiguous for GNU as and LLVM's integrated assembler.
> This behavior was fixed in GNU as from binutils 2.39, but Linux
> supports binutils 2.30.
> 
> Fixes: a737737cdb9c ("s390/percpu: Infrastructure for more efficient this_cpu operations")
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  arch/s390/include/asm/percpu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thank you!

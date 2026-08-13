Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66514328B77;
	Thu, 13 Aug 2026 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606992; cv=none; b=crco+qlyWlH3n90yQ4feouNHCu/9GjKZbyy6v1g9twsGcPN6e60j0x3jyxlQrH4s9kWu6EsLOemsSfWp9lFN5BPMbG6Jdr1w8xoaeZqWzg4hHqrNlA9JTvYL4H0rkJVqBD0R21BPPFxw7xeCbMXWZbwFrq+m6Hz4yfyatnrWZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606992; c=relaxed/simple;
	bh=H2VOur4eW7u1mUXO0K9i5OKtFUZLf/1R5q8nynQW24A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fltn478fkR1UCSxXPfQ39AHsqeje4hR+OSjGvG9HR8txxt1Sr/Kk7xQwS2fBg4jXz76Ns6WE+N9AKk560iYPhnZwYm65OWCNob56mpnP/XjrIBCO5a/5GRsmTknJbBPX7lXBwkZp5JpIk/90OZVuBGt2WaqbXqaecnnt71bjpSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=obbEH7e3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="obbEH7e3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D61ZAG1476554;
	Thu, 13 Aug 2026 07:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=lfG7s1gijqJxxaH5EoJ3IESNWO+fb6
	M06bI3AEn2g9c=; b=obbEH7e3tkOMu3PmHxlnYXcsBJE2K8bQjsUMCWxbvkPgfH
	vCm72Mn7oqEeiaMuvVSQkbj754jskUwGXPAymPBwp3jRYefDyMR8dyYcOZIzoX2T
	L2SpImk27AnG+ee5hWVme2kdWWMW7ic5WhkOBIm/JhdB56XICIN/RC/9ZqMnAKwY
	eB9vou6ss4EJHr8C5TtxHk/z9vvhM3je/vaIJD7eOBDcRc0i8vRfAGTCHYkZ7c4J
	T5njWxonfOpQI4fUqpU4+6w9veJJDVpT/wqD6cQb+fiq/z8wg7d9KKDwcvrJyoEl
	Oj9gcHJa6BAEo55oys4NJzCCKLC1vNzeS57z18DQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9psra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 07:43:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D7fGKF004139;
	Thu, 13 Aug 2026 07:43:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk22su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 07:43:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D7h5Y338600988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 07:43:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26D8C20043;
	Thu, 13 Aug 2026 07:43:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05B5E20040;
	Thu, 13 Aug 2026 07:43:05 +0000 (GMT)
Received: from osiris (unknown [9.224.90.220])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Aug 2026 07:43:04 +0000 (GMT)
Date: Thu, 13 Aug 2026 09:43:03 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/percpu: Fix MVIY_PERCPU() with older binutils
Message-ID: <20260813074303.10751Af7-hca@linux.ibm.com>
References: <20260812203036.3018-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812203036.3018-1-kmehltretter@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: KAl2Jq-eZs0UDe4Kp6RPvEr-5ebHbi9O
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7d758e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Fbue1idrPtY0ZwZ-O10A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1MSBTYWx0ZWRfXz0+JiJDfsUIx
 Me5op4oZH1BIGY0VEsqpHkujZPlcnDUaYULh/ufk8+0TG4IxWAUlNEgGuDDfuVBw0Jx3foF49j6
 AiMeVWIEab0K5EGLfeZCM8yDib/5VrQOLEdeI++WANGzYC+Ep6oYmAnnXykdJD17S7RjFsaPLG6
 ikSPVun8ROwH7/uoUVnaubi0BR4eT29vRlFyzmnXJNmwDUvUDc2GUccPbcHqIQ4DF7w13Dv5+0j
 ECUwoDC7o1rTmjrh04uxT1F5gEaNNUXzUaR5kTiywPXgkyejC3+TSuSZ4/rdoT5DMiDWqy5NBeM
 3BFelpUFHYK+A7O2NMhjJlHdjh/Zq16dSrXLa5NUgoZRW6gi6lF2AkP9zHjkymAPxYbGzyTsSnp
 aXI7mq/aHgQfv/ycYq1UfyFIebCPwdPd4p76bFhEkgLaSLaxYFE1CRi3D7m70vAllaVTsf3DHBQ
 Mg7y5SfeU9aHTZ9tKpg==
X-Proofpoint-ORIG-GUID: 5eH5VEQIcQ2VYi2K0WlFy9xn0CZOrynw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1MSBTYWx0ZWRfXyY8xLWwO+iw+
 1cJg6n/CFoQGT+sPf93dvsnlQJF5qJpDpKBs52jcIEM7JMifHyy2oWNWdRozRbQlcZBk+Haltwx
 JE2MU/8NXjdeTf5vsXwlUI8G53mTXEo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130051

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

Thanks a lot. I'm about to change this code anyway. It seems it should better
error out instead of generating incorrect code (even if there is a warning).

Vasily, could you add

Cc: stable@vger.kernel.org

please?

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

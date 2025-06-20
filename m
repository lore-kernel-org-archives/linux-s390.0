Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF1225777;
	Fri, 20 Jun 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425351; cv=none; b=FxqZnj9oZCTcw7XsLyKBN8dJ9dQ5qdtIIT+q75YUJ2YsgsqQsVrosgaBpKiLwhzeWzJ/kATrYRYSIap/MOElE7yanmAC3tz4GuaVX38zQyhDvgiKq1EMEik8WqTJp1zSaYlNCgzDOrQWrModHOFKSJTOjOKZs0QhvtIxPWdp2CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425351; c=relaxed/simple;
	bh=aW+GqYzaLm2DD/de3PvcrfrFB1ZYq3xdgGteykCu9TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lsbu1rG23j/lGUquVqQ91nG2gSPy/+0tjwF0E3l553VbikY8VYTH6p5EWPVo8w7fJL1NZbbWdM8o4sfYVldU/wNKeq5RW/xTRR2urbzhy10UpYmE0zsq03lTaGwue/ZPj1Sk6aXj6pOD2BHOnhpHWrYcQfVCH4IV74AG8CxN8Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hVsaQkHW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hVsaQkHW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K7d5Jn029597;
	Fri, 20 Jun 2025 13:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1yTusrWN/VWlbIwipqSog6MShNyn1v
	Y7K7E2F/QqWig=; b=hVsaQkHWFJws5IPzCUsZYipmqqXFk8Ki4ZVwkWglq/p3VO
	NPuUjnQbXe5PSfZgaphIfWfmdKGY1HMwFnqLgmhm58oCptXCcAZD0hsfMRwexnYf
	d+3OZmuuUCIWDcQ1Eie6+0gvDHBV5XU0Aw495bXKEGgSHzLFMueZN6rWrdOD9K1v
	kmrkkHle4jm2b2zwsGTNkWVAvZShTUK6jKFARPr/qwg2MDnxHlkI3xMetCsFgu9R
	N1avvtfoEM8YeGTPRDgG5Dg9OEIETvyL85+5KI7X5Uu6BQNyUDGqR9sCsEYYRG4N
	vT5HVcWXKig6rGv/n57C2AdLM5EnlCuuN+lJ/maw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ku3w3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 13:15:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55KCg92l021612;
	Fri, 20 Jun 2025 13:15:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47cahwf429-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 13:15:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55KDFf1n46793128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 13:15:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18F7020043;
	Fri, 20 Jun 2025 13:15:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E1C820040;
	Fri, 20 Jun 2025 13:15:40 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.95.118])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Jun 2025 13:15:40 +0000 (GMT)
Date: Fri, 20 Jun 2025 15:15:39 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] bugs/s390: Use inline assembly without input operands
Message-ID: <aFVe+8Wfo45S2OAx@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250617135042.1878068-1-hca@linux.ibm.com>
 <20250617135042.1878068-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617135042.1878068-3-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GiIzSgwJYUB8TSPOJ6h0mMwZqKYV33F2
X-Proofpoint-ORIG-GUID: GiIzSgwJYUB8TSPOJ6h0mMwZqKYV33F2
X-Authority-Analysis: v=2.4 cv=KaDSsRYD c=1 sm=1 tr=0 ts=68555f02 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=tGxnN14yH6XwWoqrI1EA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA5MSBTYWx0ZWRfX5HKP5hMxFjE+ ZxmzfOcVnbtsBUctu5muLCqS/UZEQI/B74lAGAwpIVzbwoAfsOkA6nE+NdlOnQQ/oglFk7jZx/c 2d7relu6nk/HHjuwTPPZQoW3TiwLias3oODzb4CO53HvCRoXySVe39wSx8xJzRRjU3CKCxoNEmx
 V/0jLISKSkK8snZRGh3t0HLue+gdBioiB/48C1xUoHl1dwFMjH41wueWE8NmeDzw3UjGeKJkNP4 zbP3scDoiKTaZGf0eMLFA2Mo2iTIoRSUMj+mJpUOG3JGgvjISFH4qspComgFsYEGnbkpjXboYaX g0tZPUtUQTFKlH0ySp/YXWw1NXjzO8lqD87mlj1HgtWrLKqsxL2aCFvrOBGV8/AZkMyoHZ61uRx
 zHNR7tFBk4CFdzRNRt4v4EoXFH76Z6vtj2GmeOPVpR25vXNuqxntXWnvY67idXR5RLjFGS/j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_05,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=818 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200091

On Tue, Jun 17, 2025 at 03:50:42PM +0200, Heiko Carstens wrote:
> The recent change which adds DEBUG_BUGVERBOSE_DETAILED support for s390
> changed the __EMIT_BUG() inline assembly so it has a string as immediate
> input operand. Some older gcc variants cannot handle strings as immediate
> input operands for inline assemblies. Doing so may result in compile
> errors:
> 
> mm/mempool.c: In function 'remove_element':
> include/linux/compiler_types.h:497:20: warning: asm operand 0 probably
> doesn't match constraints
>  #define asm_inline asm __inline
>                     ^~~
> arch/s390/include/asm/bug.h:12:2: note: in expansion of macro 'asm_inline'
>   asm_inline volatile(     \
>   ^~~~~~~~~~
> arch/s390/include/asm/bug.h:43:2: note: in expansion of macro '__EMIT_BUG'
>   __EMIT_BUG("", 0);    \
>   ^~~~~~~~~~
> include/asm-generic/bug.h:77:57: note: in expansion of macro 'BUG'
>  #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
>                                                          ^~~
> mm/mempool.c:149:2: note: in expansion of macro 'BUG_ON'
>   BUG_ON(pool->curr_nr < 0);
>   ^~~~~~
> include/linux/compiler_types.h:497:20: error: impossible constraint in 'asm'
>  #define asm_inline asm __inline
>                     ^~~
> 
> Rewrite the s390 generic bug support very similar to arm64 and loongarch,
> and get rid of all input operands to fix this.
> 
> Fixes: 45c79ca947c9 ("bugs/s390: Use 'cond_str' in __EMIT_BUG()")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/r/CA+G9fYuu5r34=bndUYWNxe_yLgBaPGXmK9WP3WTtoXMs_2LX-Q@mail.gmail.com
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/bug.h | 81 +++++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 40 deletions(-)
...

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

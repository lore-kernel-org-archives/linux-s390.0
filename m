Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411922A1D5;
	Mon, 10 Mar 2025 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603769; cv=none; b=cqn6me4esTTL2virmsY5oDPMJ9szKdRgA8GqmAwcMFDl9VvywS/lWFqOyDkNm4BCL6K1/xH6dtTX5nA/X1TIwuxz6mfjlRk/E2BeLzYy/Na5+g9h92PyeEC4PPomC9pq9Xg8pg9bWMaby3uDFm2Nm1nWPlGiA7b89XDexxE3xvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603769; c=relaxed/simple;
	bh=7r91rKZtrskh6CmIPNf+XSih9a1OoxJ8ms07oy0GExk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byq7RDf2umCDJiWcsCjJFgjHNJ8kDjaXBbBiVYDZ8qXeiIGkPIlaUCvVgQBAYzgMM+7PKk37GOcQHOgK5waKEmWVbicRveOMASOlzs4YBeo8TRlS40uxwT9fz6wqNvRguRV+4MteYZsq0MaPA/1nr3dMNcagUmvVP9LFxZ/P52s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bjk6RAj1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bjk6RAj1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A3kNJe017869;
	Mon, 10 Mar 2025 10:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=sKO+75m207JysMjIXv7KSQYHDy7YlP
	HemyAx01aINeQ=; b=bjk6RAj1gYm/73g4miHHrITkpTZLeEM2xqwRejDgvimYNO
	quInQEMglqZRTqIeqYXoqd4YLN7cZICq3Y9sHf1hHZ92XBlhyp6vU5FNuwOMMWl+
	plTY1zZSZ6NbfBYroA0WcaGgXnvXzUW4RyCAVLHPwKV06TZ+8C9e9kfgJ/WTNivX
	Zi+WJHO/zxDf1S009q1+Mx2b9mPN8mYb4vBricZ3BQtTRm0AWO2/phww4hGz9OK6
	Oi1QWwxGdC0fBytqYYDKalMBIOWnhNMBVLioklJ+kN2aOAzvFatR1Eb+0PhyaPMo
	/WQycoDFXrQl2Sv4zjUukTLA6iJQNAAp8GSbpr5Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459rf91vn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 10:49:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52AA1IRC023851;
	Mon, 10 Mar 2025 10:49:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4590kypaf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 10:49:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52AAnCI457606518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 10:49:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B0672004F;
	Mon, 10 Mar 2025 10:49:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D94320040;
	Mon, 10 Mar 2025 10:49:12 +0000 (GMT)
Received: from osiris (unknown [9.171.17.80])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 10 Mar 2025 10:49:12 +0000 (GMT)
Date: Mon, 10 Mar 2025 11:49:10 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] s390/uapi: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 uapi headers
Message-ID: <20250310104910.27210B18-hca@linux.ibm.com>
References: <20250310102657.54557-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310102657.54557-1-thuth@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V0k3BxwPMkpJ1gdsMev1GNuAAgSEoDZj
X-Proofpoint-GUID: V0k3BxwPMkpJ1gdsMev1GNuAAgSEoDZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_04,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=643
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100083


On Mon, Mar 10, 2025 at 11:26:57AM +0100, Thomas Huth wrote:
> __ASSEMBLY__ is only defined by the Makefile of the kernel, so
> this is not really useful for uapi headers (unless the userspace
> Makefile defines it, too). Let's switch to __ASSEMBLER__ which
> gets set automatically by the compiler when compiling assembly
> code.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/s390/include/uapi/asm/ptrace.h | 5 +++--
>  arch/s390/include/uapi/asm/schid.h  | 4 ++--
>  arch/s390/include/uapi/asm/types.h  | 4 ++--
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
> index bb0826024bb95..ea202072f1ad5 100644
> --- a/arch/s390/include/uapi/asm/ptrace.h
> +++ b/arch/s390/include/uapi/asm/ptrace.h
> @@ -242,7 +242,8 @@
>  #define PTRACE_OLDSETOPTIONS		21
>  #define PTRACE_SYSEMU			31
>  #define PTRACE_SYSEMU_SINGLESTEP	32
> -#ifndef __ASSEMBLY__
> +
> +#ifndef __ASSEMBLER__
>  #include <linux/stddef.h>
>  #include <linux/types.h>

...

Did this cause any sorts of problems? I can see this pattern all over
the place, so why is this now a problem?

Also, wouldn't it be better to fix this with an sed statement in
scripts/headers_install.sh instead? Otherwise this is going to be a
never ending story since those things will be re-introduced all the
time.

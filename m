Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6C02C182;
	Thu, 13 Feb 2025 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451203; cv=none; b=CgKnXk7cS6xwBc9Sy3zEeZApcIk4eDTP3rPjm1LpueOAF7gKap871d3wraQy6olrdci8IZPmpIrz/Tv6Ebxbx6meFtCNdsKcx/quWKtYF/feaEe8oGIuoO+wRcRqcotV0H6kolkzprWRS0K1t1M+aokeRSbv1dlb+z9tnGOHQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451203; c=relaxed/simple;
	bh=eWWChd9+g97MF6wnnaelU20oPUkpPav1lgJJQci8f6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxuIHLqY6lIhYvV7vLHQISI4QIvGmTXvWPWLM1q1zKMvT9EpQuU52BEsO/Ah+0j9bEHcIv7kQiTb2dtu9eCGaO/irfvresUFaWxzTryKjWTProbu17DrIxsy4ZtJY8Z/mnca88IRBVtNXlAafqJIwlb64ZYc7VCuN8vovDucLeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mkv988nV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mkv988nV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DCmkYW012578;
	Thu, 13 Feb 2025 12:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=eWPNAIgOiUaqeYRzBZnoWTnufMu8O3
	aad3DcxE2TisE=; b=mkv988nVqKFI+Q6OrBWS2ipxPqBTWh94TEwCx5ur0CW5tE
	gFbmuMsKaNXIBWlbpy9XXzuqt8Q0SYtWLu5xw5dicWbmtK4cnhHK/N/mmO32y0Kt
	GpxgaLbUIE+WtPwE5YYqiBZ+byC9GxDxMuwNYQn050np1UxVh3j/D4JLRuKI7MKx
	qnE39AotUl1IWNJO8+Ftlv1OKxIIJ/IXGkgDbdH3t9eDuti41obAiU46MnGoLJHZ
	BBkoakKAE6C0M/vRvP7cbEBdY4a8uahULG/ptd//n6izD71nSjIDUuS/h4zdd0Kd
	0X3cjD9wjHovI3bb6RqoeEn9YfZJq2oiDEDhxYWA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44s7k0tsn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 12:53:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51DBlMZ1001051;
	Thu, 13 Feb 2025 12:53:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjkne8ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 12:53:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51DCr4JY22675828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 12:53:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2997620043;
	Thu, 13 Feb 2025 12:53:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F256620040;
	Thu, 13 Feb 2025 12:53:03 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Feb 2025 12:53:03 +0000 (GMT)
Date: Thu, 13 Feb 2025 13:53:02 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] arm64: scripts/sorttable: Implement sorting mcount_loc
 at boot for arm64
Message-ID: <20250213125302.12012-A-hca@linux.ibm.com>
References: <20250210142647.083ff456@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210142647.083ff456@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ric8tIwk28XGa8a184QYg1kdT_6Gbzhn
X-Proofpoint-GUID: ric8tIwk28XGa8a184QYg1kdT_6Gbzhn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=878
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130096

On Mon, Feb 10, 2025 at 02:26:47PM -0500, Steven Rostedt wrote:
> For the s390 folks. I cross compiled a s390 and looked at the mcount_loc
> section, and I have no idea how to implement this for that. I wrote a elf
> parser to dump sections based symbols:
> 
>   https://rostedt.org/code/dump_elf_sym.c
> 
> And ran it on the s390 vmlinux:
> 
>  $ ./dump_elf_sym vmlinux __start_mcount_loc __stop_mcount_loc
>  1801620: .. .. .. .. .. .. .. ..   00 00 00 00 00 11 70 20  ......... .....p 
>  1801630: 00 00 00 00 00 11 70 90   00 00 00 00 00 11 70 a0  ......p.. .....p.
>  1801640: 00 00 00 00 00 11 71 10   00 00 00 00 00 11 71 20  ......q.. .....q 
>  1801650: 00 00 00 00 00 11 71 90   00 00 00 00 01 7c 70 00  ......q.. ....|p.
>  1801660: 00 00 00 00 01 7c 70 20   00 00 00 00 01 7c 70 40  .....|p . ....|p@
>  1801670: 00 00 00 00 01 7c 70 60   00 00 00 00 01 7c 70 70  .....|p`. ....|pp
>  1801680: 00 00 00 00 01 7c 70 98   00 00 00 00 01 7c 70 c0  .....|p.. ....|p.
>  1801690: 00 00 00 00 01 7c 70 d0   00 00 00 00 01 7c 71 68  .....|p.. ....|qh
> [..]
> 
> It looks like addresses in that section...

Those are the addresses of the mcount locations. After looking at
sorttable.c it really looks like that for s390 we can simply select
HAVE_BUILDTIME_MCOUNT_SORT without any further changes.

I just tested it with different compiler options (fentry vs hotpatch),
including selecting FTRACE_SORT_STARTUP_TEST, and as expected everything
works.

I'm going to give it some more testing in our CI - but if nothing breaks a
patch which selects HAVE_BUILDTIME_MCOUNT_SORT for s390 will go upstream
with the next merge window.

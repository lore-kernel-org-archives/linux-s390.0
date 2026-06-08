Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B863D3CF5;
	Mon,  8 Jun 2026 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938351; cv=none; b=OuY12tqnljYhoLNNYQ9Dk7qy6uuBQ/rgNG+YpUVI987yen9bMf03XL0j2m9lXpqyjl5giGDGWlLQbOUmWbikVyt3DVBZjL0PihBO6m0FCEEMoBQ4fm9hmcuwt2x39Jt06I0zqsrfzGzdSMuTuzE4UGbjFvKmlDepNYgwr8dmjog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938351; c=relaxed/simple;
	bh=fHMkAqPbx3llu2uvRDBK6cQtwTSzaYaOaMMk+4uo0AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNBEFij82KlV7042VfLJTtoI7X/JxeAv83WcMn8+vPE2chgkNFtpZpApRK3Lxm3u3ADr8vdfAqXWWRpuCMte/S+NTfRbndJgF+aYoiHqXhqtz28+RKJNQ2spWd/qJtmrw3xraBw7F9tRv9DAd01VvqnpGE0VMMV8sNndyb/zHKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=epAnTVy9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="epAnTVy9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586dFpm1992204;
	Mon, 8 Jun 2026 17:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=eUCzFhuOmhKm27Eu6GG8hharLP+BP/
	A1JQ6K+nsJA/U=; b=epAnTVy9ypqJXAYIZ3mAtNTdbuCE4RIZBgS9P9k8qayqq0
	iQcuhkfKpm9E/2q5b24KRIyvU4tKT5tkOQAJIy3PPX5eg4bj4pE9UY3fOYxu5+2/
	HsurXcLeSNCOxgTyfw6nm9A/c2c1WUDlwnxNImq4YGnQAYke4veWmG6V3max7EuO
	AMEWVaGtst6drcWae36Dx1sDB5XFCvlexKHJhqMuHy8b5UUvw44b7KKVfAXOIumx
	1CJVTBA+KbVZxqdz8FDd4TMrgX0FcDgHKMQzBhBm76MiQfjAQuU1OJ1BCJohcHfM
	oACtW7TjbGPC6ooxx1Fl0S0djJ+tC5KR1onTucLQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sr8xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 17:05:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658H4dmK020808;
	Mon, 8 Jun 2026 17:05:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vxdkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 17:05:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658H5bSH45482328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 17:05:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33A8F2004B;
	Mon,  8 Jun 2026 17:05:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1304120043;
	Mon,  8 Jun 2026 17:05:37 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 17:05:37 +0000 (GMT)
Date: Mon, 8 Jun 2026 19:05:35 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: Remove GENERIC_LOCKBREAK Kconfig option
Message-ID: <1c7ef477-d57d-4fd8-a51a-05829095a2da-agordeev@linux.ibm.com>
References: <20260605153206.2397521-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605153206.2397521-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aypBiSwLYnvZncHzBvymg-xl1lC1ZA6P
X-Proofpoint-GUID: aypBiSwLYnvZncHzBvymg-xl1lC1ZA6P
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a26f665 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=DfNHnWVPAAAA:8 a=VnNF1IyMAAAA:8 a=8PwEbw_DHVNOmaeoEiAA:9 a=CjuIK1q_8ugA:10
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE1OCBTYWx0ZWRfXyobYzCfrmjMw
 RPavBgjm+FSEAN8XzuTkqYX2wsXinpjdUw/Zq23BJQeHX1njmLHJ3i6OH7Ri2W/cEFWdgv0rVdN
 LKFESY0lzsQbj89oKsxSo8LQPPjQVaWHt9gUjWHqcx3x2pggxyPE8zweBX52xBkp5+4bW0yQLrQ
 ug49C5R8qtIbj8li1XV80STGHkhmGzjLbIe6nCEIly88sGMGXdLsZwceuD/sllg/Hh1342wlNwW
 I9lv3cq0L6gLx/CXTQCG+vGiE1gwHBRvR1pGpOM+NZqqOY+Vgxfz0+BH1jxwAQwwhk25GQl0Yhd
 i7k6bOXkPht/743sQgC3kMSCTipGO+lWtJ7vvuvKBVMLOl3U1A5ziWMvDvHW8Pnh+/e/v48OYZe
 1fk4BkcPgAQ0rWTSUHbPofAG66nPvh46NSAXwe9cZoxn/6zeI/SvpMVsQF8on0SLnuUOTMbU16Y
 zWEUFZ/nmMbWA21ODfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080158

On Fri, Jun 05, 2026 at 05:32:06PM +0200, Heiko Carstens wrote:
> s390 selects GENERIC_LOCKBREAK if PREEMPT is enabled. Reason is a historic
> 18 years old commit [1] which fixed a compile error for PREEMPT enabled
> kernels. Back than only PREEMPT_NONE and PREEMPT_VOLUNTARY kernels were
> considered to be important for s390. PREEMPT should "just work".
> 
> However, since recently PREEMPT is always enabled [2], which also causes
> GENERIC_LOCKBREAK to be always enabled. For some workloads this leads to
> massive performance degradation; e.g. a simple kernel compile on machines
> with many CPUs may take up to four times longer.
> 
> To fix this just remove the GENERIC_LOCKBREAK from s390's Kconfig, since
> the compile error from 18 years ago does not exist anymore.
> 
> [1] commit b6b40c532a36 ("[S390] Define GENERIC_LOCKBREAK.")
> [2] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
> 
> Cc: stable@vger.kernel.org
> Reported-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index ecbcbb781e40..9921a3772bf7 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -29,9 +29,6 @@ config GENERIC_BUG
>  config GENERIC_BUG_RELATIVE_POINTERS
>  	def_bool y
>  
> -config GENERIC_LOCKBREAK
> -	def_bool y if PREEMPTION
> -
>  config AUDIT_ARCH
>  	def_bool y

Applied, thanks!

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898B54E73BB;
	Mon, 19 Oct 2026 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409322; cv=none; b=HbYpTpx88sd7DMXD1NX/IUh2L2NwcWxJRTPdollCZz42Kzf9+LLfSw3m1HDE/fuW3CGVueJjOHEqZR6+EcHH7hajTXsIxAX+7ltxOf7xvh5q/3ofCN4ACIOFYKtG5ja+9t2mpw/F+p+ERgo/7xik71oGnen9+iLdBeH2gOUn3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409322; c=relaxed/simple;
	bh=vb8sxH9BTNTA4vMtJCzE7CI0S7nJBjmENppg7JcrStU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJ8/prjPey4HPZxxXYK0/BEzuhRRZ4Eh8Bn4cRyufzBRG16Imodx8YnBjPsBXu4NPa78SmzgLNo23PLw+Pj4VfUhNrzsQfCSvXnvLSDOnEme7dvtPgIS31dmTIUYPs5c4cKAnZEjiUyC24ZRMXOegB0LMVBMP4tSvniJg6ovebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UtkQwGQu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UtkQwGQu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8iKho3337071;
	Mon, 19 Oct 2026 11:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Ct9F2Vq+xZA0cBNgGB+3rDkn/J/fbF
	zJCmiu/DkUXDU=; b=UtkQwGQuDnpaALL5tBLzyKIZCOqPmroDnTDCGueE/2+zd8
	1+DSpGRttvo7W72cLWvyfa5t7M0YVPO/s4qzngTjNh/A4ceufuQBh+1DXmR0b1Bm
	erU9tn0nhyXqqneIuEMAH852coZLlwHHh26TuhWGG7WUoy1mA/jVxB/c11AvlTCY
	NZG6xULoNIQbjNXR/gqEcIo79YaOhdfDQhgwpMxiihT+RfWvd1t39nYJH0aAE6fM
	by7pOkIQjsSKmZ+lc4RiZk6SrSZx5uAzJE4Qa78p6FsXREOh6vYbLSpDgD/I9ptL
	6HB4Zbl6d3lVYhBO2KIiZbJ4nuDeILtYT5oSGCCQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0r7ju71-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 11:28:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Yr4U3802397;
	Mon, 19 Oct 2026 11:28:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmbjwew3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 11:28:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69JBSKUl49938692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 11:28:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 650B62004E;
	Mon, 19 Oct 2026 11:28:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00ACF2004D;
	Mon, 19 Oct 2026 11:28:20 +0000 (GMT)
Received: from osiris (unknown [9.87.142.53])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 19 Oct 2026 11:28:19 +0000 (GMT)
Date: Mon, 19 Oct 2026 13:28:18 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/vdso: Implement __vdso_futex_robust_try_unlock()
Message-ID: <20261019112818.19766A80-hca@linux.ibm.com>
References: <20261019111233.3372751-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019111233.3372751-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NCBTYWx0ZWRfXwhy/J7CdBAUv
 QqdMNH8OFeAyBu91CWLXJXxQkeaf3E591CTtSHMzbngzTE8qP8g8BWTnDYyLVj2bU67zVDAgwjm
 40dsBr8DaTGRy2TqkeR9VutKanP2bhY=
X-Authority-Analysis: v=2.4 cv=PrUG/AM3 c=1 sm=1 tr=0 ts=6ad5feda cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=mlY_YlscS5G_Db_UT14A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NCBTYWx0ZWRfX+xOejoAShASm
 ooPm1ENgXpvRiZt4YT//COox4cNZXWl2u63VPQeqfr2hqa/PRqEIdP8kQgOLojDQmFPTeUEwU6O
 SKo+wPBVJoDN4p493m/3b2gvUU5bhPOH2AN2AbT5tknVqpMvnvA0CwlMQMGClShZWsrKTN25c5X
 Yqbr2+kfsrsvIV/OqFp2XYbD6P16+7tcEjLv3U1o8xKBrJ2sB2zr4tVZwFifO7hsfK8hJ7JjJit
 qLPeXhz+UeZy3CJpRbf4j2r77CIyqe//Y0FJ9E+0OUxXvh7B7FkSz3Ph3KriWf9oZmf3uB7S+rh
 HSnCZWYk0xQFnoMzjIWiFeUZw/5srLIuAb9v8hp+Yp/w/7q9nDO3ca1+9FkNpZzmA0OCB32jxif
 G3VFVXWbpfmm4f4iBqvE/86aqr15M+2K0hsjtHGlHAbEQwHnCQ0erVXYbfo7Xn34lhatW91j1DY
 VDzrBtAyaeAexz3/0kg==
X-Proofpoint-GUID: yZTvr8O5azsyfYJDVttJ_xRPvlNidjFw
X-Proofpoint-ORIG-GUID: yZTvr8O5azsyfYJDVttJ_xRPvlNidjFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190044

On Mon, Oct 19, 2026 at 01:12:33PM +0200, Heiko Carstens wrote:
> Provide the s390 backend for the FUTEX_ROBUST_UNLOCK fix that was
> introduced for x86 with commit a2274cc0091e ("x86/vdso: Implement
> __vdso_futex_robust_try_unlock()"). See that commit for details.
> 
> Note that the Fixes tag does not mean that the x86 commit is broken,
> it is only helpful for backporting purposes, so required prerequisite
> code is present if this commit is backported.
> 
> Cc: stable@vger.kernel.org # 7.2
> Fixes: a2274cc0091e ("x86/vdso: Implement __vdso_futex_robust_try_unlock()")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Thinking about this again: the entire paragraph about "fixing" and
stable is nonsense. This is only about enabling FUTEX_ROBUST_UNLOCK
for s390. But the comment below about the test case remains true:

> Notes:
>     This passes all robust_list selftests in
>     tools/testing/selftests/futex/functional, except those listed below.
>     
>     wake32, wake_bitset32, unlock_pi32 fail, which seems to be kind of
>     expected, since those selftests set FUTEX_ROBUST_LIST32, which doesn't seem
>     to make too much sense for a 64 bit kernel without COMPAT support, since
>     futex_robust_list_clear_pending() contains this:
>     
>             if (IS_ENABLED(CONFIG_64BIT) && size32bit)
>                     return compat_robust_list_clear_pending(pop);
>     
>     which means that compat_robust_list_clear_pending() is guaranteed to do
>     nothing except returning false for !COMPAT. Therefore this looks like a
>     test case bug to me, but I could be entirely wrong.

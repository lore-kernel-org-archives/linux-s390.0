Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8137B3F9
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745457; cv=none; b=Edkj0M5+QKdoj510mZBQkfs0IXedy8TF2INuTrHtiggOf6p05o9oWi204A2kJr1+RsR9xPcp88xLw0ClRbey9xvM26l0QQ6w2bpNHS2buIKZEyBWe+6MfNRtC4Xk1g76qQG5bLtXr3DxNhcLpN8sp8sb2r+cTsfzCjdRrDV6A7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745457; c=relaxed/simple;
	bh=BHkpttu0NAah9y5M6HfIENDPMBV02xyY2+gQDQfOq0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXnXlYjaLjKgT6Iz3GtmkRgn7hHiA8W62UT6vakoPae2It4EoL7MGOTkcOdZojAaXdwVvleS+aoEJ1lwpKFlVppZMMMlAtGb8HzubQV/K8JnHUzWWFxx03Q02gkfsRkxZVNLbeQelXyBsjRCQ8RB0J1bCeHe5KxY4XORi/sawYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nlxpkPSJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nlxpkPSJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVd5u217292
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 15:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=//TpUJVmMUIUuwRXtswVkzQK7o7img
	0nllU8iw0BjfE=; b=nlxpkPSJqmCf39VhTDDQ8hbbDIOMNU03Nlx8JP0Lk38EB2
	aX6wkEhg/o2hMl7GFcgkKKAYBOsf9wdDGwOBB2+KUTYr80jWSs20wIgg6/4/U1Fl
	Y8cfpu+CCB7e8WEKAkdI+tSVbuySNdYRJCxxTuXXEvvsXWE+IL1HpWkMv1/MyGIo
	cebW0ks6dfe4VMj/7idCTvg7cYFUhhWqdNfcEP547nifYCLB0v9xjNiR/KUKwCmD
	xo7FpcSKCOPZh1vFiNBE7fs3ztpYd/msG5Pt5A1XyDQPRhxd4pGfz/xg54Pf4Td9
	JQAfHsgNDbhApjPh/3hfiquLtuSD8DaxTlxR1BFg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5egdbc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 15:30:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDO1AP722844
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 15:30:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjqxwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 15:30:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IFUor451642670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:30:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69B3D20043;
	Fri, 18 Sep 2026 15:30:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F67520040;
	Fri, 18 Sep 2026 15:30:50 +0000 (GMT)
Received: from osiris (unknown [9.111.38.246])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 15:30:50 +0000 (GMT)
Date: Fri, 18 Sep 2026 17:30:48 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH v2] s390/debug: Do not register views for failed static
 debug areas
Message-ID: <20260918153048.20386Je7-hca@linux.ibm.com>
References: <20260918151351.3977090-1-zaslonko@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918151351.3977090-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXzNLNfZ0Va+6f
 FB6fz+vGyzwHY9bZpEU0ycF497+Eql2/XVUtREfZYhOyQXpLAdFJwXmaU70zvo/KtmPuQEmumLx
 xS+5R4QDzM3bmnNHr8E5TUG81D72Of7idu6XjMpbzwj9jgHotnw/TaqCyeyg/hlvyqULpon30gL
 GBXAwA4Bv7MyZWwckdk7XuuygW3xg/eAkbfWtW8glMdzgPDteUKyodcUXxGuasBwXSk8E1UcTsu
 B17sSAx88PlQHRaCdcTDSjgmyH+UHboUgM6jpZQWXUC6PqT0JuQuNhdtSqEXmRoBbuf8WvUaPrO
 1736T0qUgbhtBendqoReiqFWIkxxLDAV0PZbOGC3XB8xGhENeIhZuwcpNiTXr1bI9zSFRTzHwBz
 bNzlEXkTvFvOrH/ZMaFbW2kX0wjw1kzi7A0BlxbZeSw/VZFnGWZ1PzadRacFicwQBW6/Go4+plM
 nTKMr39yjfjklIfB0Ww==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aad592e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=bc5nBT5EFvquj0DzSMgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: nkxO5n_e8ywB2imwuWBR5U17pRkoJw1S
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX+XdkkPmz+LA8
 84B9U15ovNynxjy1/BTm3otsf/Xe4xGMRqx8s2/7MJIQbAF5Ji0MMhhd7gnOInmz2IFnbh1oVpb
 gw6vyvoU4UCdBItsEKcIcgiDx4NVhZc=
X-Proofpoint-GUID: nkxO5n_e8ywB2imwuWBR5U17pRkoJw1S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180214

On Fri, Sep 18, 2026 at 05:13:51PM +0200, Mikhail Zaslonko wrote:
> __REGISTER_STATIC_DEBUG_INFO() calls debug_register_view()
> unconditionally, even when debug_register_static() has failed. In that
> case _debug_register() was never reached and id->debugfs_root_entry is
> still NULL, so debugfs_create_file() places the view file in the debugfs
> root directory. For sclp_err this leaves a /sys/kernel/debug/hex_ascii
> file with nothing to indicate which debug log it belongs to.
> 
> debug_register_static() is not exported and the macro is its only
> caller, so let it return an error code and skip the view registration
> when it fails. No debugfs files are created for such an area then.
> 
> Reproduce by booting with s390dbf=sclp_err::100000000. The sclp_err
> registration fails, no s390dbf/sclp_err/ directory is created, and a
> hex_ascii file appears in the debugfs root instead.
> 
> Fixes: d72541f94512 ("s390/debug: add early tracing support")
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> ---
> v2:
> - Resend as regular patch, no functional changes since RFC
> 
>  arch/s390/include/asm/debug.h |  8 ++++++--
>  arch/s390/kernel/debug.c      | 12 +++++++++---
>  2 files changed, 15 insertions(+), 5 deletions(-)

Applied, thanks!

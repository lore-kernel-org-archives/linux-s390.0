Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BFF30AACF;
	Mon, 22 Dec 2025 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401074; cv=none; b=RVDA11jreW+aYDry3Z5ajU91Lo8moa7EqGm8gmHE4sRxrizwQf3E1WsqtbhvpsUps5+BPh8tyYPliTJP9mIS59Ndi2jUvk5ajQJYiPlBIgvBBaikcAsEKUjw8BRE0JKU0sbYzaQbEsggzeWGQyUsFV2x5dXmktbD96vvCn5dn5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401074; c=relaxed/simple;
	bh=qNM+KWz0mYFHKjkoDjsaNFW5IFvecxY8gTHSTwShpyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqSPshIR+gM105dMMUHIm8lLqQBTS9TLxCjvg1go8QNbTTZZKYddI7jX+Zales4vrNr4jRSLAbdTHzAbnOo8ZxdCgvRA1dySYdAXv2Vu5K6UeGicSIFRiPafObYUVdqNxKtFlji6BFGFbdUiFbdjW7uVM6ZgnY05rmDfSq1Wgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bssZAyT5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bssZAyT5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM6ntxe015092;
	Mon, 22 Dec 2025 10:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=n5tRBbw+vMzK3jJsD2KImFfm9Ig6ZA
	0qLw2TisqBlUU=; b=bssZAyT5FyFLY1UfZFcJ2WWPXJKqhCbIaZKwz+aVNWwDmz
	S+4x1E4afcThzSftB1UFK2cl0A9GOESTBvXvCWJ53oLeWJdBVbN9CvDfvO0gmKda
	jiy8ivAG0qNdrrblF8X7i9NMMAnx5FTk6fJdVANVesP/e89UTWNdMia7ACbWng/o
	VKYCm7j/0TKKXzZZGlhg+DXMpbZpiomgrDIkhfyenrh3fk9NXlXmnCT5NxZYivT0
	2C4VAasfJr9Qt2lvSmMV3NTQ4k9bUTdcIMkul9bHZFp6R+Q5tH2QQJMYdTzTrZ18
	2DfCls8VthdvuswIbI3mZQWuJczTIAR23uKGlCJw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh47k2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 10:57:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMAfa5e027014;
	Mon, 22 Dec 2025 10:57:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b6r932q46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 10:57:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BMAvSc130802340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 10:57:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEBB020040;
	Mon, 22 Dec 2025 10:57:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56FED2004B;
	Mon, 22 Dec 2025 10:57:28 +0000 (GMT)
Received: from osiris (unknown [9.111.59.181])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 22 Dec 2025 10:57:28 +0000 (GMT)
Date: Mon, 22 Dec 2025 11:57:26 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/cmm: Use max to simplify cmm_timer_fn
Message-ID: <20251222105726.16440Adf-hca@linux.ibm.com>
References: <20251222103917.635026-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222103917.635026-2-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bulBxUai c=1 sm=1 tr=0 ts=6949241d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=qEcfGbZqEg3S2triV5MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: RNtUgmYrgIsr-r1Lj9lDEciiG0EIVso8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA5OCBTYWx0ZWRfXwEOqgWy82ISo
 QLIpYECy1/HHuLJMlubWSRcBfFQp//fmqs77TyD+jyT+pfPMGjaSRGOifcQSI35QBwjMf2OUbbt
 LoycTQduJqEQRFpOQt4BcYmtK+8N1McbNbSRLSM4oWFds3wjWqnLnE0GZUNVmz4Wa88c4qo4wuy
 ab7JG81EA4uUuNnIg0OEnL/eg+MN2rX41rSs3oaRNF9E/2WKEo9PPXMNc7zXGrp0NoK15kPfkXz
 4K6unINFftjLoUAmAcr15fg7winffF9erRQztpBoql3Gmdn0PRLETBZdqgfoUNKRIGDrCxsoYRs
 vEyA3fbi+9s8cK/5ZEyu0OfFG0x2Y2bgP6Mnl30UgGHDSrcWsdbNBqAZFWpyyrEtzfe0R6vYIbh
 v1ouxoOjUX63m6dsaBKO830hr/uESLDR5e75dZ4wAJh4Xgff+3hxlvpVTF0PauwQ/nO1d5qoPrE
 Jkfivl8hpLXduguLlxw==
X-Proofpoint-GUID: RNtUgmYrgIsr-r1Lj9lDEciiG0EIVso8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512220098

Thorsten,

On Mon, Dec 22, 2025 at 11:39:17AM +0100, Thorsten Blum wrote:
> Use max() to replace the open-coded version and simplify cmm_timer_fn().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/s390/mm/cmm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

...

>  	nr = cmm_timed_pages_target - cmm_timeout_pages;
> -	if (nr < 0)
> -		cmm_timed_pages_target = 0;
> -	else
> -		cmm_timed_pages_target = nr;
> +	cmm_timed_pages_target = max(0, nr);

Just in case it wasn't clear in the past: trivial patches like this won't be
taken. You already managed to send buggy patches which look trivial, and I'm
not willing to spend time to look for subtle bugs such trivial patches might
introduce.

In other words: you may stop sending such patches which address s390 code.

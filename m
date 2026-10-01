Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E343DB320;
	Thu,  1 Oct 2026 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842926; cv=none; b=HXPeiU0OvntasqKK0y3QkmNzG/U2Z3la0eB1RPbBAKPU7/ZqW4N5ORJSRCovewzINu216WLApYMVhSqCKDerOJ4O87jcPhHlWWwuqCuWYLurzDlbH3DC0n/uyKPF+tIQwaktRPxcR0hZko8iTUrQX5xzHlV9yJ5ip4KLOeej6A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842926; c=relaxed/simple;
	bh=UJ8re4iGPcfDjFz1mMptS/C9g0/pxZv/1VNyAFy5Sbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raN2afPkfOs35BA3yQPG9FM1jwlYxxesdOimOB2hk3K7/vE9lgRwHO1j/0+71zDTlbAgmFRghaZPwhkgBfZwMeU0dGMqlhLrBmYo0fjg8FzlixkYoWZ8faRmpO6lgXjFolkF0VtqiAUShfSrb898ODXtgIytpr7FNpLYakQMYes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sg429Kis; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sg429Kis"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175cCV3446282;
	Thu, 1 Oct 2026 08:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Ra21bCnm37PIfxPIVfOfDlU9+VHD7+
	UVFquqYg8I9II=; b=Sg429KisClpP2FIAkW1SeEW17LWTZrbV914wW+Ml7aBzlF
	jCrnGyioF8AmhORd3CPMqsR3EpSrP+QfI599ab/dW6TAOAITIRqFAELoU0nmYTZK
	RCmANT3qZ2LKQO/QTaAgCPT3fL3SDkDVgsmVgpAM0/mFnI+9jwcLo8YEdS6VBoMC
	z+dM3EwIat3/RDjxXh9JB5BigmLYnnJI6Td96Bmydb6Xb81HHABF5Nd87NKv7ksH
	HTptiEVJBRD6Y63PiFqoSl3RWQ5vu9TURW9p4h4DmUdDxgtfB/JObLeY9Hh7/iAg
	qQuF9Wt2WDDoiBbtM1qlace1S0ySBcriEEx58XaQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrj1s8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 08:21:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172sZh3460477;
	Thu, 1 Oct 2026 08:21:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4peg24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 08:21:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6918Ljki48234964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 08:21:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A081A2004D;
	Thu,  1 Oct 2026 08:21:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 447D82004B;
	Thu,  1 Oct 2026 08:21:45 +0000 (GMT)
Received: from osiris (unknown [9.111.57.16])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Oct 2026 08:21:45 +0000 (GMT)
Date: Thu, 1 Oct 2026 10:21:43 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v7 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <20261001082143.23106A21-hca@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <d7fd78377a7278108ef501cf76571e80caef5968.1786956464.git.agordeev@linux.ibm.com>
 <20260824104048.11040Cdc-hca@linux.ibm.com>
 <b66a61a4-a532-44ba-a1c6-26f02193fb05-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b66a61a4-a532-44ba-a1c6-26f02193fb05-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzMiBTYWx0ZWRfXzqdwM24uMq2d
 JFtOpooszbMFxsw8JIiv/lb88Q8ZUMkXZN4Vd/76af98XN4QSgjvBDoSBU/EQtkJWj8kWXbh3UF
 HWSaRHHsAgtVnfC5Ryx3p6xOyg1XRz8r7yN4cLSESP0aZPLKh9N0Psyvp38PrFOhiCW0tJmsuKK
 4lIlozRlo3tJFavbWuQ4x6cU6ucKjhrHYUp38sWOX+5f02jC6akQLqumjkSvZqBELU4xwO6hl+6
 9I+2Fx7QKhL/HZU7L+090RpmJzQG7zqs0MNMwJ3A/kjsqkw7NzC+v9FXPog9HQvoRA16BVfLQ20
 Lx0xgSQSL1Ro8fqXSnFc+KGwSjiefWQfQu95sTMPwWDN6nOR0HTpdhk3MxlHtX1tzpO7fArbwAU
 VIzfnayZVydUo9cyXXlxBHseT0drn9JUtq6p3MiB31Ni5MS5o+4v6JfBZuyDh0P9lFo78/ydqve
 qv4R8Hhx7p7DZ6h+MfA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abe181e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=zTqDmhcANAg0LMT_mQAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: A2oZF3D5kEhAE0y9bRNvcasuaL_wKoHn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzMiBTYWx0ZWRfX6n5FtlHwUqqn
 n9L2GMagK4riLG6QdXDHuZZIakMcw14hVARbLVq9IRwVf5VdjqUFgvZkKki2DZ2IZxDrrcuqLEH
 19QgJWzAekawIDSf81LNJIEUbjCFADs=
X-Proofpoint-GUID: WsWF8puhUxSntuyNQ3eIKEBsgGvSOCre
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010032

On Thu, Oct 01, 2026 at 10:00:55AM +0200, Alexander Gordeev wrote:
> On Mon, Aug 24, 2026 at 12:40:48PM +0200, Heiko Carstens wrote:
> > > +static __always_inline bool is_lazy_mmu_active(void)
> > > +{
> > > +	if (__is_defined(__DECOMPRESSOR))
> > > +		return false;
> > > +	if (!get_lowcore()->lazy_mmu_count)
> > > +		return false;
> > 
> > I guess there is opportunity to generate better code here using an
> > alternative and using a flag output constraint too.
> 
> It is only CY and LT instructions that make sense for me.
> Here is what I came up with:

...

> As result instead of gcc code:
> 
> 	lghi	%r8,0
> 	lt	%r1,1032(%r8)
> 	je	...
> 
> We get more or less the same:
> 
> 	lhi	%r1,0
> 	cy	%r1,1032
> 	jne	...
> 
> The only benefit is [zero] "d" (0) could sometimes avoid LHI if a
> zeroed register is already around. But also the KASAN coverage is
> not generated.
> 
> Does it make sense to go ahead whith the alternative?

Not really. But why is lazy_mmu_count 32 bit? Do you expect a nesting
level of 2^32? :) If you would reduce that to one byte you could use
tmy or cliy.

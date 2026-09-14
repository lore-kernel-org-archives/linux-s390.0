Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C19F3D1CC5;
	Mon, 14 Sep 2026 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408805; cv=none; b=MI0c3/qNlKYBUk1JGLCtK3ws8pegvKOAQTNDeNpdk/fiBF5gkkU4gmLyYkLLvrlC+QQGSC0iMt7j8JPcXQuk7xOvvYFsSaci35A5Jvd58JjPmhFXdgetkmaoI+1KjOtIoh1tuilbLvq2NXszv5YrizAlleWGzadYhDq240KyTtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408805; c=relaxed/simple;
	bh=OTiu5947C9fA3Y7NrlQcDhXpl9PL87QMkeiajEFAspw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0BJbOiN1FcQprn1PA+pNUyIZMnY45iqvY+So9eyt0eV6yfr0yqt9Esb8nxD61QqePF7juDhpINg4q39d72rq4ofHF6GlBdaanNsYcGv6huVawRIqIW0Gc6gp9Xr/EtDivvWtfISReRNRkWVGMgYHNeAMJNopf0wVCih3UHBF+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CQFL0ieY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CQFL0ieY"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EFvoxw2495162;
	Mon, 14 Sep 2026 17:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=n6XWvEkjUJhke/eXYBmSDyCZt3sChR
	VssS0jrboyjOE=; b=CQFL0ieYaPas4IYdV09CQtevlNKjrDVFKrgYocAup/KyrO
	KXLBYiDsue7gh1DvI/djTq7k6OB0oOFEHmBH8LXl8WzmsdqFqds7uuD/vmQC26MP
	sNe7OaM8xaxkgvhMYPK6zYfEjVHI/MOVH2zdsy4i0OwOPLnxy0rnWrgVTqHrQOQ5
	t0wzfOP+lOQGH2dB+acDHIltiAHWlDvMZ0iKGEyT3cwqv1F7UqU38U0qTEgfsO/y
	DUczkLh/G6azIqmtJHe+i5MzHXjb/hoLoZgMOa1UkAJ54AQ+p6mWPl0fUX/np2aG
	Kw9T7/a/TwhlTEKYMIyogrHnlXe9lSrYIoO1vdlw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4u46g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 17:59:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68EGVNK82359957;
	Mon, 14 Sep 2026 17:59:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnh2pykx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 17:59:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EHxsXj50659592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 17:59:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 278ED20043;
	Mon, 14 Sep 2026 17:59:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B817420040;
	Mon, 14 Sep 2026 17:59:53 +0000 (GMT)
Received: from osiris (unknown [9.87.150.220])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Sep 2026 17:59:53 +0000 (GMT)
Date: Mon, 14 Sep 2026 19:59:52 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 06/13] s390/cmf: Use kmalloc() for the CMB area
Message-ID: <20260914175952.14910Fc6-hca@linux.ibm.com>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-6-e931086fdde1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-s390-cio-ready-v2-6-e931086fdde1@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iVRITbDW7x6rY8UOuc8lzGASFfpPHKxm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI0OCBTYWx0ZWRfX/jZQYnZDbspo
 eLajtSQuqN9l0P5gCRh/QYG+6NNOuVHNNhWcfApZ8JRauj6x4zbcS1VY8XIapyH2h6wAZV6+KIJ
 QZiLrt26q8/G/CsYkXX0vlPXiuiBqn4=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa8361f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=w3GGswcpYwqc3GNkgiYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: iVRITbDW7x6rY8UOuc8lzGASFfpPHKxm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI0OCBTYWx0ZWRfXwret4GbqXc8u
 3ZDt6AjnA37okgOmgPCEI6KAKhAXtude1C8F0ksDzCP32Hh0Jx4cpLaLXyD0SiyEtZRc9DGo9xx
 J+r0m4wIdtZdU/LCRe8GBktgpoSju0CCH1+qOCxOskrOKMLh71r96gNjw1ibURKfEaPqo8egtZV
 8Xr6y2f5gLKJkNRyRTjfmyTyg8PIwnDBDERTZUZ3qQMmf8XR0BbbKTXDiNYZcFv/q6Bf4W0Vxue
 LejoyLKTfAu5zXUvKUwD/7XjzCaREtVsQBaov2DwTqQOWItmFn1yS00ike1VZVeFV+O0bsBLN9s
 L6wbcfy3CJUzY+qPoMzb3JfTx+VsgyVYWBhnKU8y2L1Yp8auH9Tlb6jLGhEZNkepxoiTzx429fj
 bJKEHPRyjRPRL+hv7A2cqcjA4D89mHaElKGt9Wmg8/n/TJVZGDBlbaX8h8kFmWYE50Evn0gTz0F
 s5/yXqW9BoTmKZdP2jA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140248

On Thu, Sep 10, 2026 at 02:00:08PM +0300, Mike Rapoport (Microsoft) wrote:
> alloc_cmb() allocates the channel measurement block area shared by
> devices using the basic channel measurement format.
...
> The measurement block origin must be 32-byte aligned. Each CMB is
> 32 bytes, so kmalloc() provides the required alignment without rounding
> the allocation to a power-of-two number of pages. Reject an empty area
> before allocating it.
> 
> Replace use of __get_free_pages() with kmalloc() and free_pages() with
> kfree().
...
>  		spin_unlock(&cmb_area.lock);
> -		mem = (void *)__get_free_pages(GFP_KERNEL, get_order(size));
> +		mem = kmalloc(size, GFP_KERNEL);
>  		spin_lock(&cmb_area.lock);
>  
>  		if (cmb_area.mem) {
>  			/* ok, another thread was faster */
> -			free_pages((unsigned long)mem, get_order(size));
> +			kfree(mem);
>  		} else if (!mem) {
>  			/* no luck */
>  			ret = -ENOMEM;

This is the only patch which made me raise an eyebrow, since the allocated
area is smaller. But it looks all good according to the architecture.
Since the allocation changed anyway, it might also make sense to switch to
kzalloc() and get rid of the subsequent memset() (not in the context of the
above diff).
But... I doubt it is worth it to send yet another version just for this.

The whole series looks good to me. Vineeth, Peter, any thoughts?

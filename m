Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7956329B8E0;
	Wed, 29 Oct 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743592; cv=none; b=QDG+cKr3rLKzbQ/pvuB2BzIZUBpNGo9elflH/b5sHvvWNPg+vkdekosWCM1jl0PjLaicQ6wuHCn/svtY2uXka9Z2WQ2S6RB0pAOOeMu4srtjIIVuP8RrcIW1eny5UitgmZ29+YxVGNYpOE2sPukp7HUE18WQjAcqzmbWOFLdRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743592; c=relaxed/simple;
	bh=Jf+mWc84R2BTDc9CnRYCqLU7KSQTob9Q8S2oNMz67sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSEufPM2MjBIjeY+lXgXiCDCAPSxGbzxAvR96Dl5V9FQ3NQLvQ2ZKofZUK070AmdAnhU7RsL9LOYIBz53/PyD+n3Hoxfu7eVnyyDoSylU+OyHiOEAyY87XIpA80xAxSGjoVHcB4M+VKfFQ48eplgHhbflZpmMJJltIDrVX/+rWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fvB661jG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fvB661jG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TB6Piu019585;
	Wed, 29 Oct 2025 13:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=jO/iGRvRsHg5ISVAQ6IWHLfB756sIc
	VPi+oYAicJLPU=; b=fvB661jGOacNiZ7VyTmFhzruVMZZ5+etgtf9h5Wi/T3eA7
	vl2i9Roys0bqFhvjRrV3ZxXrEFrVX8Ien8KLnd9A8sjWN3lmYX/2eJQ03siCF5CA
	YukzKZ1MG/gaJEOUh9SovEWUiViJ8fUR8hsKmcTh72ffci2li7voQDjxHk19B6iK
	0xsuHlVTjRQVVDmnSpG3/khs25et9e9+5LJmqLykXWHF6cwFkn7H0avZf1J9/6n7
	Y9/iX9e5QxcV7QSHqPZ6wowxl6E6VrC6p7cNW9C3rLKi1I/IT4Kbxgk/6DTANPOx
	fRSRTccd89PWgq0RlPyl7mbQinYL1/vjlebKWTYA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agk87c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 13:13:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59TA1tT4018789;
	Wed, 29 Oct 2025 13:13:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xwbdcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 13:13:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59TDD1SS44040658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 13:13:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2261220043;
	Wed, 29 Oct 2025 13:13:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEF1C20040;
	Wed, 29 Oct 2025 13:13:00 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Oct 2025 13:13:00 +0000 (GMT)
Date: Wed, 29 Oct 2025 14:12:59 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/nmi: Annotate s390_handle_damage with __noreturn
Message-ID: <20251029131259.8393E76-hca@linux.ibm.com>
References: <20251027084728.1362-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027084728.1362-1-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K+gv3iWI c=1 sm=1 tr=0 ts=690212e3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OeaGBy565VZJS7LA750A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: fk9OheHiaOxf0pdguQa3X6fGw_D_mTMB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX2/0lI6zmALJa
 DIiVkASN2/NDPQpJSwWpYW9/8Q2cRftNWEP2f7s7lwZX6pFMWBAM+u1vMrWfZ/0yLMEF5Br6xj1
 JOHuYUnUvPBOQlz3ANbKpyS0xrPHZBByePUcy6AZrJLzg6lK3MieCMTNK8hefXiT2dQYxfZVxKV
 m9KFvVwqpCtgkH0Ji8xbTZwZMItxgcDZU5YqTABHThg9+SAgjSgYJp1UrrKEFv9pMsPx4/xydb/
 UvjTTal5dIwjrcPTUJ2X6RkamlCc17juasBNT9uvze6jVwXLuHCAY1o/tB2WQIAZZoBDBdCoW8C
 FmE1KJ+2DmmkrfAj4wDjNHh7UHy5GghTy3PlbqQ3wyBOF2qllYqnBW1eXRmNvur1JMZW1LOLsBu
 Vy66fG1Cwdzvy0p7H65AtIY/XQxOiw==
X-Proofpoint-GUID: fk9OheHiaOxf0pdguQa3X6fGw_D_mTMB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

On Mon, Oct 27, 2025 at 09:47:25AM +0100, Thorsten Blum wrote:
> s390_handle_damage() ends by calling the non-returning function
> disabled_wait() and therefore also never returns. Annotate it with the
> __noreturn compiler attribute to improve compiler optimizations.
> 
> Remove the unreachable infinite while loop.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/s390/kernel/nmi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

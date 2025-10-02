Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCDA7263B;
	Thu,  2 Oct 2025 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391315; cv=none; b=TKi6bw/RKAvKTt+BnpMs+OnB61CsVx0HG5Z4RoH0HkIKwIOZ6Sr3rfboNE/XbSD4g8civT07ABK/z/RUxkai3bed3/JbfvliEuIs7N+2L3fgeXc/C8bP303+QLf1icH7aFQoqZBW4h1EjXhcwU6kjQGFDbxuBw4Mrzh6GzsCcSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391315; c=relaxed/simple;
	bh=PFOi0aMezM8lp/suG5ZJoNsGMyvv2Uy0VRaH4b1W9cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/Lzt6V9u7wWPAI5XMxYlT0SX8QB1/JV1iTocV6l9mbfz99pJxo6JzMNR0lXWfvUbTCGcze7xKx7RT9qHOYZxFvvQ5SYjDbq0iBOIJuKxXpokm26UC/8/bTfwkFv1O9S1BEOAipnra/N/zrbJXDrphBpaEHn88yprqdFfBw+DSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F5hgp6qR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F5hgp6qR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5925F3S4024216;
	Thu, 2 Oct 2025 07:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7zOP9DnHMuM+Tf27AvcsBmCepxoI7z
	Kka/0qM6um6Bc=; b=F5hgp6qRBanHR3Kwa9gZkTAWVYuRg9oamCdxobwMTsM4XX
	t7qyaNcQu9EsvSlyBmN/HQ39RBtqtR4gjoBfZeDe52ChkIcgSll+Cxst8zrNemjD
	m62TwsjkOFe+gJPk2CpLWetcXgFnzSuDJIO/TP4GXpLr3fAALe/TsQXAJBDnbVam
	+0Wt/fBds4sXiC9ZrVWg8h0IbmiN6q/ezxyuOEw0NgtzYiT+pUVX/kmhZKYHCop+
	Zyy+JFNJCkHNeGTlnFBUYg+T4PL0DWdBD4khL+f2HiX8FwD2HqBZhbm/pp7bENwX
	VHM9ccPkOPJnzo6RVLurK7XlXPmeiMxvda58kz0Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwu0gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 07:48:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59240PdG007285;
	Thu, 2 Oct 2025 07:48:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurk4x7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 07:48:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5927mOa333620706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Oct 2025 07:48:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CCCA2004B;
	Thu,  2 Oct 2025 07:48:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1C3F20043;
	Thu,  2 Oct 2025 07:48:23 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  2 Oct 2025 07:48:23 +0000 (GMT)
Date: Thu, 2 Oct 2025 09:48:21 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Josephine Pfeiffer <hi@josie.lol>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] s390/sysinfo: Replace sprintf with snprintf for buffer
 safety
Message-ID: <20251002074821.7570A92-hca@linux.ibm.com>
References: <20251001174104.192486-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001174104.192486-1-hi@josie.lol>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX/9qsu1i0DatH
 mTOD4yVHxRSvuLJ+MXGcMVC+QYE4wtt2jqfyUuoWXE23tAXwPYG2SKbm/3SjxNqHVzaiwK8iwe6
 2KDqL4mRDjP0zJrMnnSXIB1rCfj6AEfPfSFXRvNBjGPZzIOAm5+WIiWxKpklGoUhJr6/Qy25X0E
 mw3S0ACt9Hz2I6gbS6F1xzZ0SHFUUGWYrg8k9vci7HZCDtTUs25HdLziG/ZjuonM/lZp+Z14XsB
 48a1twBgYzsdu1CMIP2iVQYKujYsqzLMHHtPRf/aMAXxCtK4tQTl6mICYWs9qFVvfKw1tNyz5oQ
 uBDQ46ebXedHZmUSh7sBz9oWmxENUACk15Q4DoRT7IwySH811o0aV69EtCMbaBv5emgbSWddXkd
 AS9A/XtGLktlo0ZPLodhT4RtaNgKnw==
X-Proofpoint-ORIG-GUID: A4GCNJ5DWt8ZKUHCCLP9u55bjjMdbzoC
X-Proofpoint-GUID: A4GCNJ5DWt8ZKUHCCLP9u55bjjMdbzoC
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68de2e4d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=k3TDWKG8rbEpaGFVyfsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

On Wed, Oct 01, 2025 at 07:41:04PM +0200, Josephine Pfeiffer wrote:
> Replace sprintf() with snprintf() when formatting symlink target name
> to prevent potential buffer overflow. The link_to buffer is only 10
> bytes, and using snprintf() ensures proper bounds checking if the
> topology nesting limit value is unexpectedly large.
> 
> Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
> ---
>  arch/s390/kernel/sysinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
> index 1ea84e942bd4..33ca3e47a0e6 100644
> --- a/arch/s390/kernel/sysinfo.c
> +++ b/arch/s390/kernel/sysinfo.c
> @@ -526,7 +526,7 @@ static __init int stsi_init_debugfs(void)
>  	if (IS_ENABLED(CONFIG_SCHED_TOPOLOGY) && cpu_has_topology()) {
>  		char link_to[10];
>  
> -		sprintf(link_to, "15_1_%d", topology_mnest_limit());
> +		snprintf(link_to, sizeof(link_to), "15_1_%d", topology_mnest_limit());

[Adding Kees]

I don't think that patches like this will make the world a better
place. But you could try some macro magic and try to figure out if the
first parameter of sprintf() is an array, and if so change the call from
sprintf() to snprintf() transparently for all users. Some similar magic
that has been added to strscpy() with the optional third parameter.

No idea if that is possible at all, or if that would introduce some
breakage.

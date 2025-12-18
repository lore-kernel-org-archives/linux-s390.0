Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C1F2BEC45;
	Thu, 18 Dec 2025 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766044774; cv=none; b=Sd27Ym54S1hI95u9MQTIc22+gYeHdG0dy+0xoy8Jrt7HistoTSdLzyxodqzn/vihIxh7dfL/WmeeDzKFj0oNQ6JrB/mOXIPDoa97deIR4uLmmcXm1l5Ly4oZ6xPJVmkOqhF9Ds14baWhrS9VE4mZfy04RQlYsnBML6gKBJLtURY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766044774; c=relaxed/simple;
	bh=yfeYlxG4JS4gQipKNvPOn2ynkl1l4rFPm3FsCfiVnSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAIu45nM9coauqVQNWhLuZUPU0KDtMpEKCXDsI553JKFkSOSEqAsontKiznj+3HMgHsLeSgg+7xT3dJBWRsdwZxBQWs2+qN9WPXpC7IfUYsncS8Qm19HyXKLGWPVUgklyJHoBvgRZVwzyQRh+J95JGr5SSi8tGNxvR1os2lRt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=glTloH2t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="glTloH2t"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI5RHC4024778;
	Thu, 18 Dec 2025 07:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xUKC0o6I6fABncVZSZkGE0FET9ECTF
	croFa36Sy/pFA=; b=glTloH2ta0T/nWt9oMrJgvwie7+6SeUY8zoU38ZHPGiI2I
	+EmYjuz+SMDzZoCQqoh9GNuadprEhJ6qqZ4s1FnCFtCeGx5ce0DGom38TZTA65y5
	EJUZgQLTSbgozFyxu6ITfHnpOYMlcQDyOY7zGRn5SkVulUV8dxmM+rG9la83bGTB
	Cp7N0WxUX7qWl/LnZaW2Dt2LB5k0l6YdJMWubQ+4i6SLWYd+z9EmvuxuRRl6XCtL
	q05UB5GxOAdIGDBnGvUDv4RBSIg/bkA/4kspQCtwuDUScbNMxptXRksse86jNpg6
	tfIx0r8Iw7juWaT+nMAIgeWxDHjDXziSmowO58MA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytvhdwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 07:59:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI41gld014324;
	Thu, 18 Dec 2025 07:59:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpk6vp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 07:59:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BI7x5Bd47186346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 07:59:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4636C2005A;
	Thu, 18 Dec 2025 07:59:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A535F2004E;
	Thu, 18 Dec 2025 07:59:04 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.58.137])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Dec 2025 07:59:04 +0000 (GMT)
Date: Thu, 18 Dec 2025 08:59:03 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        joel granados <joel.granados@kernel.org>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/spinlock: Replace simple_strtoul with kstrtouint in
 spin_retry_setup
Message-ID: <35571508-723e-482c-a729-6ffccaae14e7-agordeev@linux.ibm.com>
References: <20251213123246.356155-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213123246.356155-2-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX+uRRcY0yEDI8
 57e0bBCUPvbA2u2lydptGgWTNo/2sqR4sKIZvEV7sW8rlsEegqJCeKFugWxYt6x8DohJU3oP9Om
 AnVnQlFWo6IoiDSWRMwd58FGAeXluNt25vc64l/c7+3jX4SMvclYFE+3qQ0SXiGHbDjvIKSUb5G
 c6OFnuQcYNpBp7b7q2JsOvx10/+CMphTgF3Vxo9XB4xeaeHZZZRC7jkes8FqFprzngiP1vcGX54
 hEsjlWei4Pa/WkUUEtJbVxgC1YIuZ3U6lT6eWCkYNdG+0EASjz0hyP4CtpySvX8IjDr37ZqUlRM
 +Fe3MEXyZgjQZ0KMSnYSVM0TTTFeGBUmUkDwJZVxltDtCGT4CXM2zUssIY/6xSxEx64X6169Cjw
 ZC8/q6H7parRzsuUoK3V0w6IHspRjQ==
X-Proofpoint-ORIG-GUID: ncJwEr-XcFIz6FZg3ZwwjjiNkWnsASoj
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=6943b44e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e1MRfLDUff24qKUScGgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ncJwEr-XcFIz6FZg3ZwwjjiNkWnsASoj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023

On Sat, Dec 13, 2025 at 01:32:44PM +0100, Thorsten Blum wrote:
> Replace simple_strtoul() with the recommended kstrtouint() for parsing
> the 'spin_retry=' boot parameter. Unlike simple_strtoul(), which returns
> an unsigned long, kstrtouint() converts the string directly to an
> unsigned integer.
> 
> Check the return value of kstrtouint() and reject invalid values. This
> adds error handling while preserving existing behavior for valid values,
> and removes use of the deprecated simple_strtoul() helper.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/s390/lib/spinlock.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
> index 10db1e56a811..b4ca53356b96 100644
> --- a/arch/s390/lib/spinlock.c
> +++ b/arch/s390/lib/spinlock.c
> @@ -34,8 +34,7 @@ early_initcall(spin_retry_init);
>   */
>  static int __init spin_retry_setup(char *str)
>  {
> -	spin_retry = simple_strtoul(str, &str, 0);
> -	return 1;
> +	return kstrtouint(str, 0, &spin_retry) == 0;

Why not to use kstrtouint() return value, like other parameters do?

>  }
>  __setup("spin_retry=", spin_retry_setup);
>  
> -- 
> Thorsten Blum <thorsten.blum@linux.dev>

Thanks!

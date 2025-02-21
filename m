Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B7F433DE;
	Fri, 21 Feb 2025 23:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740182153; cv=none; b=esbIaRpWaWHbtpymEeg4qgsTSjp8nW3azkwKI933CS3QRF11XBa5Rf9/Niav+C8B+0nA7Om2toH1nhPbZwe7ZKK9aMwb0dITWHdESN+cCB/dmBoddi6M8xaC/4RglvnpS1dyksfDHepwaEopsETaYlce9nMtXUPtyj5Zr2snspc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740182153; c=relaxed/simple;
	bh=2db/W3z8n0hWl/MKDovp0LrTr/t/l9Q9+WY0RSNMumo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9wuWzQXshgYWtQ64VkAfhVkLTiBXtQbr1q17fdleX1wSif4/HbjfMV+yNx/fNXsoFuVoSGrO7QkBX+0D9wgZL338kJJ8RJpBfH8OhS8C3Oug9ur00IXd1Dx11H5mjWMT8HGSGPk5fZzIwZu/E/i/Pq20UVBRMpH04Fy/5Z4gPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qEMMUVs2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qEMMUVs2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LIMnif002896;
	Fri, 21 Feb 2025 23:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=achMRzWnd/KuI8b0wuIGICjjIrYg4Y
	P7qUOZX+tlM/0=; b=qEMMUVs2ZVqyTriMS0xBDIeyOXSBM2lSPqCs+S3VnXkfEu
	2QwSgpQ85tThMe9ybizqpcoZjhugdvYvDzWXgroNnHWSdPjffPoj/1w50Z3tl4/k
	qQq3cEqqgBKanoju1j7k+uMDalTfQTj8g14h96cvDPdFEe8bbZeM/Ksg0zX7I1j2
	VZYiWCFBT8/65/s8zAJz78XZgY11UQ8ojEjurLvQMB4gYcifafv4cN1d4uRUkWha
	w9TXEh1w0OuIRdxbn3Z5deR8Ax2vnWj+DH42WMb56zH8tCl90Y9RbfTQ+Ygbbp2O
	mvnVeFmy5mk1gaGnuUcl5f0E+rZ0BPiYBGlZYEtg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xn6q4fjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 23:55:50 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51LNtnsf023036;
	Fri, 21 Feb 2025 23:55:49 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xn6q4fjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 23:55:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51LMUC9n027066;
	Fri, 21 Feb 2025 23:55:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w025jsd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 23:55:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51LNtjrN33096034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 23:55:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8278720043;
	Fri, 21 Feb 2025 23:55:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 016A020040;
	Fri, 21 Feb 2025 23:55:45 +0000 (GMT)
Received: from localhost (unknown [9.171.80.218])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Feb 2025 23:55:44 +0000 (GMT)
Date: Sat, 22 Feb 2025 00:55:43 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Simplify gap clamping in mmap_base() using
 clamp()
Message-ID: <your-ad-here.call-01740182143-ext-5271@work.hours>
References: <20250204162508.12335-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250204162508.12335-1-qasdev00@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 06BIERgAeYDJhI6AyOyeUl0Mk93vN8Ct
X-Proofpoint-ORIG-GUID: 6a4Wjbv3g57imsF_ZRWmcjewk8IQOYxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=889 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210161

On Tue, Feb 04, 2025 at 04:25:08PM +0000, Qasim Ijaz wrote:
> mmap_base() has logic to ensure that the variable "gap" stays within the 
> range defined by "gap_min" and "gap_max". Replace this with the clamp() 
> macro to shorten and simplify code.
> 
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
>  arch/s390/mm/mmap.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> index 76f376876e0d..a3d3e09a2828 100644
> --- a/arch/s390/mm/mmap.c
> +++ b/arch/s390/mm/mmap.c
> @@ -63,11 +63,7 @@ static inline unsigned long mmap_base(unsigned long rnd,
>  	 */
>  	gap_min = SZ_128M;
>  	gap_max = (STACK_TOP / 6) * 5;
> -
> -	if (gap < gap_min)
> -		gap = gap_min;
> -	else if (gap > gap_max)
> -		gap = gap_max;
> +	gap = clamp(gap, gap_min, gap_max);
>  
>  	return PAGE_ALIGN(STACK_TOP - gap - rnd);
>  }
> -- 

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>

Applied, with a fixup removing the gap_min and gap_max variables as
Alexander proposed and aligning with your patch for x86. Thank you!

https://lore.kernel.org/all/174014934373.10177.13398467994659612713.tip-bot2@tip-bot2/

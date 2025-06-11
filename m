Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B17B28F3;
	Wed, 11 Jun 2025 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668425; cv=none; b=Nz1Cu2VwA/dv8K+C4Wkz9TAa1heo/MhQgS1me6/uTc9egPUtsRJx9/L3QTn8X8yqvGIHgLUtNdMn+rw/36XRkr4Q4TmgXCi6TKsOd8/NZX97i1FupGYQeYR7isQ3lKrQrRsQHfLjSJy9KlZGkJmWFgL0AiqyLordnlJKuSHunL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668425; c=relaxed/simple;
	bh=e4nXt13i5DJIPk1NseWWOQoR2O53PShyRPkdaFFTdXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqurrxPEl4nPZFMei7SctQs1wx8OIG2KBAzqCY2V7SPhIQr+gHFh5Fcf0TF6kIliC2/Qs54xijQ7YlQEv8XYocb05cqOfTifbV21wTkjgwGZkRwt61NZNMeQJ43gOOmbir5KBGCLm3Bdro4l/pyROT7GwuMMUCBDg1igZyXzzr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sy277uNk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sy277uNk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BBfIUd017921;
	Wed, 11 Jun 2025 19:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YRY8Hlh8BcZs9QFLnCpLolrIQpgdj5
	O2DAHcOoiDzvs=; b=Sy277uNkdDGUsqfM2J2DWanmFWv6ogZX67lCU/JE/WiN1k
	4bSQsVDo6FVkiyrVXqB/3jxusE7olrsB94bYs6WaBo3mSxBjz/pxbtBl86J6YioM
	binI25I9UZlevgHlOqhj4SZBEsPRYTfQpNSCiYMraOlHtaz2sDZqC3voltTyHdyQ
	WhJtU8IEqeJ7SUL/onM+GXhlzalFrGRowqins52DBN6N2IMth4tSXFJpWKd5dW0n
	X/4Vg+ObLDr76TdfVSPxv1YyJB4Qsw+0ehx1zTme408wEFWoJzyuVMjOOA+RJ95m
	3QmJmpoqEgYquSWoPVa2XTLh4lIzTc+YR8kH97bw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgunhuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 19:00:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55BHJDeU015369;
	Wed, 11 Jun 2025 19:00:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rp92p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 19:00:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55BJ0Clq16974114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 19:00:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 625EA20043;
	Wed, 11 Jun 2025 19:00:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC7862004D;
	Wed, 11 Jun 2025 19:00:11 +0000 (GMT)
Received: from osiris (unknown [9.87.146.33])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Jun 2025 19:00:11 +0000 (GMT)
Date: Wed, 11 Jun 2025 21:00:10 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] s390/pkey: prevent overflow in size calculation for
 memdup_user()
Message-ID: <20250611190010.28440A1e-hca@linux.ibm.com>
References: <20250611172116.182343-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611172116.182343-1-pchelkin@ispras.ru>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pfr/hjhd c=1 sm=1 tr=0 ts=6849d241 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8 a=xjQjg--fAAAA:8 a=rhoCFuGJYNpbFOIXLfUA:9
 a=CjuIK1q_8ugA:10 a=QM_-zKB-Ew0MsOlNKMB5:22 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-GUID: rV9FXjPDhgR77xSagpfkWeoGD7AFt-kb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE1OCBTYWx0ZWRfX9YQKDWPOXtq1 I4BxPagEJaoTGD/XF6AnqaF4Z0j8Tk8oLZrgFBhrjv3nP6pW8pp3aD2gP7Ye0BpZgBhz2PA2v9u sGbYc6iiMTjLUxs+ZOSVBJuHqjhsIVQH/qLOcYSp0+2YGeWWkLwG66hIq+wRzM2rE826GwWaPfz
 mnigukUZp8kFdj2RE9hOilyGEhpx8XKS8+SIGdtTOQRO5ADY0bC4bSIyZTh8bHWj0RZegRZ9SU0 g2okX11IoecpRqXEycth7NbFxrVwHMzecSp5XpDKk1wJ8Y76T/WGS0MnWf9e60PtY1xAciCausa jE9xuAgkBekefPEKkGcA58tJCCnnrrWB0y8mIJ8XWE8yeJUFuvp3FHwQt4kKfBEurgGC5AayFU0
 DOd7XDdGVNcOHWQorPp6Msc6toNqbk149UArDjvr3XKUZkxBJIIdZ8arFMfEORrsw817V2D8
X-Proofpoint-ORIG-GUID: rV9FXjPDhgR77xSagpfkWeoGD7AFt-kb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1011 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=676
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110158

On Wed, Jun 11, 2025 at 08:21:15PM +0300, Fedor Pchelkin wrote:
> Number of apqn target list entries contained in 'nr_apqns' variable is
> determined by userspace via an ioctl call so the result of the product in
> calculation of size passed to memdup_user() may overflow.
> 
> In this case the actual size of the allocated area and the value
> describing it won't be in sync leading to various types of unpredictable
> behaviour later.
> 
> Return an error if an overflow is detected. Note that it is different
> from when nr_apqns is zero - that case is considered valid and should be
> handled in subsequent pkey_handler implementations.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: f2bbc96e7cfa ("s390/pkey: add CCA AES cipher key support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  drivers/s390/crypto/pkey_api.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> index cef60770f68b..a731fc9c62a7 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -83,10 +83,15 @@ static void *_copy_key_from_user(void __user *ukey, size_t keylen)
>  
>  static void *_copy_apqns_from_user(void __user *uapqns, size_t nr_apqns)
>  {
> +	size_t size;
> +
>  	if (!uapqns || nr_apqns == 0)
>  		return NULL;
>  
> -	return memdup_user(uapqns, nr_apqns * sizeof(struct pkey_apqn));
> +	if (check_mul_overflow(nr_apqns, sizeof(struct pkey_apqn), &size))
> +		return ERR_PTR(-EINVAL);
> +
> +	return memdup_user(uapqns, size);

Thanks! Is there any specific reason why this is open-coding
memdup_array_user()?

If not, please send a new version which does the simple conversion.

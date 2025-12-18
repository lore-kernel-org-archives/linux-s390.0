Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67302E62C4;
	Thu, 18 Dec 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766044693; cv=none; b=Ih0ooFEwV/ycsEhcogovINViuien+pp+kvR3ZJ/km0Y62Vk2PjLzjOIobIYFjG66KdXtJein6Xpd+qPX3hNyfD7t6C+lUOcgAIu6noI08WrAjKYUemz76tU1csFIBnFJ0lrwNJcvO6Qgc1UVTisYYvubI5iVSdshAtP+rQD09jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766044693; c=relaxed/simple;
	bh=RzENK0QR5M5OrQiye3LE2ajhrEEAHIPN/dpkEIuS7l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pu+340M4j3MzKA9GKVsxE9IXtkPnHN8/aO5Gk9xMfmM8w4aXrUL6AKRCKs0acRrFEWgXAEuc7qBDUNAeSR+QbQIY+SnhoUx2mSV+xT7ZakX8Vp+f7QUDFjawsTZBu3OIHDN3cr7ew0YXOdpRCy10JzhqkNSBQJXHaQmPCL4rznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mkM7m1vp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mkM7m1vp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHK0K73006760;
	Thu, 18 Dec 2025 07:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ytA04uomUIXLjxjbGbwRNj/l881DdU
	rByeDcEdzodqk=; b=mkM7m1vpSoeZ3/4Dz1ThIQEqVaH+sS3sEaEquDULLuLqmm
	0KhK78XtNQdvaOCTeiweccGmFeaV3zxOdxhx0MWiO/ya/CQ0B3NbR0Zzyf6k/4Z4
	rP7s/1q1SCmSP5Vb3iYh2A5DXyCbJaVuu3e58SIdrpSJ+U+5aRcqx1//o5rw+GRS
	fzN2lSWAJZabqHr52Y4L6ptw15ykg6+t3MCYduXum7y+1TOSmN1QyfLdW+Eeukt9
	Svg/vwNLjmFYvD6Vjij8A9l36hSMumComk+kyyKMmiUUFfu1zgsbzxLIa1u+mlyx
	SsoujsyAT17YjxFtE62hd5f4HTDBorSCx4OUhwyw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjq8smb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 07:57:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI71CJT002856;
	Thu, 18 Dec 2025 07:57:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kfnf4kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 07:57:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BI7vQW352625824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 07:57:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B05A92005A;
	Thu, 18 Dec 2025 07:57:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30DA32004F;
	Thu, 18 Dec 2025 07:57:26 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.58.137])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Dec 2025 07:57:26 +0000 (GMT)
Date: Thu, 18 Dec 2025 08:57:24 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/cmm: Account for NUL when calculating 'len' in
 cmm_timeout_handler
Message-ID: <4b00c8c6-e50b-454d-985d-0a5e2c3d77e9-agordeev@linux.ibm.com>
References: <20251215122214.381098-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215122214.381098-2-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwMSBTYWx0ZWRfXwU1+HrI2GdxI
 OccnyrZYStrew3BYx/j0t3ZAoHK8Fk6RLziR2nuKI02iCjV4vnQVPiWwjikwz/Ys3uFRjA5Me14
 RgftoKGq3kmH+hZLT2ctQXo3cZ8ftfh9jJaes11f3FLL5grIVH0CTeKfZvOKEdGMpzuuSlMCxOt
 8IvL29L/Tn5JRNtC5eTQvJaHS3eHR6RpOOLLsLGCsQUwV7zkWvEG14FR7nH2IKby/6n6yDTn0dW
 DTg3AYhvk7ek1yBRCzuevgJTt4Uhw46dgSC60bjdBE/eM4pfLgnzqUkrmY3c1EV7PgdCZa6dTFi
 mP5dI7JicDA2otmm/h14xPgDSSfUXixL11CP7tdcJSoXKi3efazI4avvqZiIWCry6VvsGr82ni8
 RjKmU9oAq0J3A28jJgGThZIFtNZYdQ==
X-Proofpoint-GUID: cQHkxZWxFXmVQTV187fA2LLsLy8eK7Nd
X-Proofpoint-ORIG-GUID: cQHkxZWxFXmVQTV187fA2LLsLy8eK7Nd
X-Authority-Analysis: v=2.4 cv=Kq5AGGWN c=1 sm=1 tr=0 ts=6943b3ec cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=2wvyHPyC685z5p9gvYMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130001

On Mon, Dec 15, 2025 at 01:22:14PM +0100, Thorsten Blum wrote:

Hi Thorsten,

> When the input length 'lenp' equals sizeof(buf), the current code copies
> all 64 bytes, but then immediately overwrites the last byte with a NUL
> terminator. Limit the number of bytes to copy to 'sizeof(buf) - 1' to
> reserve space for the NUL terminator.

I see you point, but can not see much of the benefit. Besides,
to me buf[len] = '\0' rings like a past-end-of-the-buffer access
(although it is not, it feels like that on a cursory look).

> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/s390/mm/cmm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
> index eb7ef63fab1e..06512bc178a5 100644
> --- a/arch/s390/mm/cmm.c
> +++ b/arch/s390/mm/cmm.c
> @@ -311,9 +311,9 @@ static int cmm_timeout_handler(const struct ctl_table *ctl, int write,
>  	}
>  
>  	if (write) {
> -		len = min(*lenp, sizeof(buf));
> +		len = min(*lenp, sizeof(buf) - 1);
>  		memcpy(buf, buffer, len);
> -		buf[len - 1] = '\0';
> +		buf[len] = '\0';
>  		cmm_skip_blanks(buf, &p);
>  		nr = simple_strtoul(p, &p, 0);
>  		cmm_skip_blanks(p, &p);
> -- 
> Thorsten Blum <thorsten.blum@linux.dev>

Thanks!

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A068187550
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743419012; cv=none; b=rLuaLDY6cJ9lb5TW8S3GmQX/Iaw9cieOQNKQ+P7/p6hVAiqAkgvqYRjQUHDITTSOty/9Rsm4atyjW//0r5YsBMXc382wBgnwsyFraLuRKE3NH6wZqFFMlhIZkbXcMdnp2vI63zvkgKL0jyIuobLazEIBnR1DnHii1WZCRG60BE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743419012; c=relaxed/simple;
	bh=7J/Giu1LaVr0JksaiEqLN1kaqdLiUFTzsWzvzPgaJdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mg+HkTEzOjvcee0QsT3G4i6jBo9cOHvNC/C5tpRCm3Vq4JPw8CLYxG7vcbWeUNcbLa+zRNdnwE9mgUyykH7kAj/AUh+0NDN450E9T1qCGAkSQYwvzSbmvUBP2lWeSG1fCfLNeM1fZ7IfCFJJSHjt91/qzBaWZrG4HlnmINZeFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K0l7YFzp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K0l7YFzp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52UMlUYH027382;
	Mon, 31 Mar 2025 11:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XiCxemC6Ftr9D50OubMjidM5gIGAbt
	JyXN1cuRd3BlA=; b=K0l7YFzpGavOaJdVWvrIAd5UbwG8f/32d4T9VJotkgWSgc
	NSfBOboQS/Ie1uK0ND17No+7WPRmtc5aTt6zrmQVZobSgLyvpFXTW6TmZSZ8t5GI
	AEvgCIpLoQ+8Q9WZzOFZiqkS1St1De6j3HqjWgrqwjkxOOfEH0wHkpzPS4vFe4Yl
	MM2Q+Wb4GyasQU66UoVi5rdAjgeXkp2pjKoJ792iNknxCjs/Ve1sAyLQrEEnEWve
	l0iowdBOt7sqEUWX120bYmCe4Wgwx48yragfRO5KY4n2zRrUeimP2FflZSIraYsJ
	NaRQsJ3JALaqzjR/p6q880gfGgOI2iuQNjV+gO4w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qd4q2qf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 11:03:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52V6WGEi005442;
	Mon, 31 Mar 2025 11:03:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pww256fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 11:03:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VB3N1B45547868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 11:03:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C758720043;
	Mon, 31 Mar 2025 11:03:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C02B20040;
	Mon, 31 Mar 2025 11:03:23 +0000 (GMT)
Received: from osiris (unknown [9.179.29.62])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 31 Mar 2025 11:03:23 +0000 (GMT)
Date: Mon, 31 Mar 2025 13:03:21 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v3 04/21] s390/ap/zcrypt: New xflag parameter
Message-ID: <20250331110321.25223E4c-hca@linux.ibm.com>
References: <20250327143941.45507-1-freude@linux.ibm.com>
 <20250327143941.45507-5-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327143941.45507-5-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nkLSjF3-yZlYPsVWF2xhUlHrSG0jEVu3
X-Proofpoint-ORIG-GUID: nkLSjF3-yZlYPsVWF2xhUlHrSG0jEVu3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=743
 malwarescore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310074

On Thu, Mar 27, 2025 at 03:39:24PM +0100, Harald Freudenberger wrote:
> Introduce a new flag parameter for the both cprb send functions
> zcrypt_send_cprb() and zcrypt_send_ep11_cprb(). This new
> xflags parameter ("execution flags") shall be used to provide
> execution hints and flags for this crypto request.
> 
> There are two flags implemented to be used with these functions:
> * ZCRYPT_XFLAG_USERSPACE - indicates to the lower layers that
>   all the ptrs address userspace. So when construction the ap msg
>   copy_from_user() is to be used. If this flag is NOT set, the ptrs
>   address kernel memory and thus memcpy() is to be used.
> * ZCRYPT_XFLAG_NOMEMALLOC - indicates that this task must not
>   allocate memory which may be allocated with io operations.
>   For the zcrypt layer this limits the number of EP11 targets
>   to 16 APQNs. But as this flag is passed down the stack, it
>   may induce further restrictions.

And this magic 16 APQNs is not a problem, because...?

> -static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
> +static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
>  				   struct zcrypt_track *tr,
>  				   struct ep11_urb *xcrb)
>  {
> +	bool userspace = xflags & ZCRYPT_XFLAG_USERSPACE;
>  	struct zcrypt_card *zc, *pref_zc;
>  	struct zcrypt_queue *zq, *pref_zq;
> -	struct ep11_target_dev *targets;
> +	struct ep11_target_dev targetbuf[16], *targets = NULL;

This "16" and the possible limitations that come this this should be
documented somewhere.

> +	if (targets && targets != targetbuf)
> +		kfree(targets);

Please no NULL checks for kfree:

	if (targets != targetbuf)
		kfree(targets);

> +/*
> + * xflags - to be used with zcrypt_send_cprb() and
> + * zcrypt_send_ep11_cprb() for the xflags parameter.
> + */
> +#define ZCRYPT_XFLAG_USERSPACE  0x0001  /* data ptrs address userspace */
> +#define ZCRYPT_XFLAG_NOMEMALLOC 0x0002  /* do not allocate fresh memory */

What is the definition of "fresh" memory?

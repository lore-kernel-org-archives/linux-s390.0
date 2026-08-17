Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7130C4B04B9;
	Mon, 17 Aug 2026 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952947; cv=none; b=Bar+oZtFbo87P9FA0Juv/ILgelTaeeImwdfguSupDDVzvyqR/faBSZ4RwfRQ5iGubHc+sO0DPapfcM6HA2Zgna1pmQRvbg1qgx9esy7tiRRX658ShDCC3uGDs6eEv3tAYUzE4sFmmdsqARXKWpI8EKBtADs2zlLfnSlGnslSRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952947; c=relaxed/simple;
	bh=wrV5KONiIS7Wbmp56BZbxRmC3zXjRpnOPu+iOpx/d+g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WZZfH8DzqD4pc6nZ3hBfCkKF6ZLWh5iS7G+sgEYBFP7qP9B0kZMDGTca593tYk3HGoOv63dKPky/s7Or2PfL0lo7+IYU2cIxtCiFPku+CCW9QuWhGYJ9gQGSrYc/pR3xt1eKHQ16yVrLvzPxFiFOnQH7Jee1TpwNM1TT20TvuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NwlZE4Cv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NwlZE4Cv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLWLDG3685920;
	Mon, 17 Aug 2026 07:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=zyzcDlF9l+prXp1Kqx+2YIwcViNm8H/RSPQHzZ67Bro=; b=NwlZE4CvGfq+
	LzcHjfSfcgTMBlyBFUAuu+yjRY5oS1wchqCHY/1EIhEN8GpksF/VawSh9VQ5iKkn
	tSAQgdAqpMum19j4kOy9e11uhj/Bo7PYM4Q7La2zQso6JGjh0Vhas2EJpno9jHlG
	x+ypTMnSjfWFLOS6Py5zP98NyxBB0XX7FfTMyETOYzyxnxEGNwdaUfX011riE2zZ
	2On9XBvTArA3tECKuU2fd3CzY6S1t16JNDiiQN9Wh90ZIXKa7Qf20+UXZnK6NB9+
	GBqzvywTaqyXDOgms0fhRD5A6SSrKgqP1K7hgRxYjcaS+ET41LSgQHDSGh4+iibI
	3kT2WysxxA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3h05v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 07:49:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H7fZfa009446;
	Mon, 17 Aug 2026 07:49:04 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejvxjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 07:49:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H7n3v629360674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 07:49:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 319B658061;
	Mon, 17 Aug 2026 07:49:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F74A58043;
	Mon, 17 Aug 2026 07:49:02 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 07:49:02 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 09:49:01 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.vom>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v4 3/3] s390/crypto: Fix use of mutex in atomic context
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260814124606.4B0F31F000E9@smtp.kernel.org>
References: <20260814123711.61145-1-freude@linux.ibm.com>
 <20260814123711.61145-4-freude@linux.ibm.com>
 <20260814124606.4B0F31F000E9@smtp.kernel.org>
Message-ID: <0c9e1e8fb696f01e65e0577f5bedb874@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gJZFB3LdexlGS-gH91mlVZED5WsdIeWY
X-Proofpoint-ORIG-GUID: gJZFB3LdexlGS-gH91mlVZED5WsdIeWY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1NSBTYWx0ZWRfX5y1LRlM9H5M+
 UdvEeOMcewNm1DAnsR7VE8/g9zKr6wn1CYrmXFhqe5sL7x1ITBi4irMuRjogOlppJ1By/WZwfJK
 bORorsHL1udTRK1LTzB4uPFyTuzhxrA=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a82bcf1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NQAhLJwWZoJv7Md_NhgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1NSBTYWx0ZWRfXzMm5VIck28RW
 ZuerxscC0nvfyj0CeEf2ChZsvlRitAcvrbJqCcJu2WbK+a86dUejMoxIOPX6RGsezWEZl22nLv4
 IO+Rp1Ojy/cNzpYWGgUs0LK52Zhadieso7Ftihy4cnNbZGq5yyX60gA9n7TbJw/Sn+AWelGaDll
 qdRqwSJx6452BJN7Kbuc78aitggfvsYwguWVvvlpPjKgoxdw76UHDflFOgU3+zrmuuiZjtqDhAO
 Sjooiah/Wu45csceqRCVMb8txySHgHEiG8HzFCLDlcKBhbgYX/2/C9CPthwY8x7qrH9LIoz47jK
 gfsK7l44UcVpxCSleyursS0OkttOZWlzp+DE4ELa8UB6gRiBCyC407JREIRkIvbff6gYPI2IQEw
 qzxuYLcr41ME815jGDA3MnB4jvBIdK22LjqO3MBvHlgTpHgauGOpWq+IQ1/J3aZRRAncBw3XVCB
 CzpoDaa0FXDVAyclRnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170055

On 2026-08-14 14:46, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch completely misses the exact same preexisting
> invalid mutex usage in atomic context in the Protected AES (PAES) CTR
> implementation (`paes_s390.c`).
> --
> 
> --- Patch [3]: [PATCH v4 3/3] s390/crypto: Fix use of mutex in atomic
> context ---
> commit 709721b3784d3a0026753ef3b28100620270373d
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/crypto: Fix use of mutex in atomic context
> 
> This commit replaces a mutex with a binary semaphore in the s390 AES 
> CTR
> implementation. This prevents unsafe locking when the crypto routines 
> are
> called from atomic or interrupt contexts.
> 
>> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
>> index 10561aa687c78..bd9815988c813 100644
>> --- a/arch/s390/crypto/aes_s390.c
>> +++ b/arch/s390/crypto/aes_s390.c
> [ ... ]
>> @@ -569,12 +569,13 @@ static int ctr_aes_crypt(struct skcipher_request 
>> *req)
>>  	u8 buf[AES_BLOCK_SIZE], *ctrptr;
>>  	struct skcipher_walk walk;
>>  	unsigned int n, nbytes;
>> -	int ret, locked;
>> +	bool locked;
>> +	int ret;
>> 
>>  	if (unlikely(!sctx->fc))
>>  		return fallback_skcipher_crypt(sctx, req, 0);
>> 
>> -	locked = mutex_trylock(&ctrblk_lock);
>> +	locked = down_trylock(&ctrblk_sem) == 0;
> 
> [Severity: High]
> This is a pre-existing issue, but it appears the exact same pattern 
> exists in
> the Protected AES (PAES) CTR implementation which wasn't updated here.
> 
> Looking at ctr_paes_do_crypt() in arch/s390/crypto/paes_s390.c:
> 
> 	locked = mutex_trylock(&ctrblk_lock);
> 
> Since the skcipher API can be invoked from atomic or interrupt contexts 
> (like
> network softirqs), does the PAES implementation also risk an atomic 
> context
> locking violation? Should arch/s390/crypto/paes_s390.c receive a 
> similar
> conversion to a binary semaphore?

This is addressed in another patch series for paes_s390.c

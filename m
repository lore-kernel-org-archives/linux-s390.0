Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690701AE877;
	Mon, 22 Jun 2026 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145111; cv=none; b=LwnXfNE1u/sVJaGkT+kcw2lykih8sFrmosBztH5CY7HZY5Is5GMtKywIRATTZS2AjBFJteplmZv7vX2UEK6W9UaIiIHoefALRDno6c+UHdf9XYtZ6xm9nEG9c4IZegQdnbozWtqqP+HnBC1T8E66rPfrl/aZG4zAQro/4jrvEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145111; c=relaxed/simple;
	bh=JN/4RegocwYG+/7yDoiTScVk/eNOWaFcP50rw+c9MQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/5v+j6EFNIACMzrdROecLNYPgA3Ak2UTJgA2Z3Y3Z5bfsiyrQkNlxPCPzWpSuK/OT2JZ66jxaUqWEGfolyDsJrrtxBPh7RPZdJvtYQBuRRb8mfSBVJHlxTYgYWgcAhAnmEDn3K6OxPXWOixBFaNVZsZcNR+UNYNaPRqaP+zZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fg0uR2W7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fg0uR2W7"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmTst3394274;
	Mon, 22 Jun 2026 16:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/pwGOH
	3uAvKTtS8zsofnIMrwpihmsABKX37N6TJyfOY=; b=Fg0uR2W77c9O+Nl9thLHfG
	a1yJSEzJzSg/FIcVKzlmWDejCyEJB7v0hFJYidnUeTToGi38DcW48BwT2b+bvELw
	ub61KE50Lt2WgfNLk70Xc0hu8C2tqslE8PZ4rEHPbEDLJ7H5PoxNB1yYMAigsiw1
	v++sJI4aqHbY1RaCHm47LAyRSdRdpwbHK55NlPjQe0DvI/pH5ShBXmz3UlLr2ewq
	qkQTr7pKEIhmr0J1ANxu+CbwHbC3EQOxTOaSdpjqpHLgZ9KN11JW5PDxJ5WPRsPu
	7RWKH1Bh11WGGh5Ss0ZQWH8a7A3OCDDs4CJB+xFjYj340nFqrd7bwocc4wIqnGSQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9ga83c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:18:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MG4cEb003150;
	Mon, 22 Jun 2026 16:18:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6ph6y5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:18:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MGIMG847907268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 16:18:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A650320043;
	Mon, 22 Jun 2026 16:18:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15EAA20040;
	Mon, 22 Jun 2026 16:18:22 +0000 (GMT)
Received: from [9.87.145.196] (unknown [9.87.145.196])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 16:18:21 +0000 (GMT)
Message-ID: <de145546-4a82-4b54-9e56-6976a3ad5d38@de.ibm.com>
Date: Mon, 22 Jun 2026 18:18:21 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] KVM: s390: Fix dat_peek_cmma() overflow
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, hca@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
 <20260622160739.202044-3-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260622160739.202044-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2y3nYnI_S6vGiEZsmIl3wqM5NsMzc2XU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE2MCBTYWx0ZWRfXxrP4UkzagjPS
 2FQ3awCZdthN7p1n/DauZwZSzQczX7NkiTtW6Zm+sU0yFZ8vOChK/q6CaZb0Tlduk6WAAKA2FlE
 1i9KcJLsmdxOWLNHLL0hH/qCIfrrYAA=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a396053 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=V7Lfsfyam54kdkz9vnAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE2MCBTYWx0ZWRfX5k0nMjeP71rM
 JNIcea/MYUYEJ53D29JULA03wElTHmWdF2wx8jLomnv3qO7/VxbsM2rYyIppegks1pTKenGKiQf
 Jd1JcPkWsM37wU9y879eNKDvZFMhNAgKDG1+ZDG/7AkRifCRAqMtxBZ2yU64bAHP7u8e4CmTxSR
 jFplu6eIYXWw+rEcsvi0SrRD+YtqOxcomIym528bhhD6xaXyhTCGBS8HN60kMW8ioj4ml75MxP3
 Y8dGDFRooNACM+f3DjnIkNDXTKScU3h7V3fYTUSWwiyxtcLs6RWQLwwFXtI4yy2jQRmsHkDdIj0
 ErM5ByZJzNbzAjF3x0GuDaaaqQL1MuQuQF0O7DjdU4xO9fFuYnTo9Bmk8qaPJlr24gH5HwsbMdE
 Sp3wuQpuayzeqJi5HB0Q8Dx6Xd2P7Wjl+5eywArdP2IDrQP/u9bGDGd19Ausl9r7AYMiZFYUpEs
 8u1zqbI5jNhPqW00VMw==
X-Proofpoint-ORIG-GUID: 2y3nYnI_S6vGiEZsmIl3wqM5NsMzc2XU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220160



Am 22.06.26 um 18:07 schrieb Claudio Imbrenda:
> If userspace passes a start address that is out of bounds,
> _dat_walk_gfn_range() will fail with -EFAULT, but state.end will not be
> touched and will stay 0. This will cause *count to underflow and report
> a very high number, and the function will end up erroneously reporting
> success.
> 
> Fix by only setting *count if the end address is not smaller than the
> starting address. This way invalid starting addresses will correctly
> return -EFAULT and *count will correctly indicate that no values have
> been returned.
> 
> Fixes: 7b368470e1a4 ("KVM: s390: KVM page table management functions: CMMA")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/dat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 4a41c0247ffa..cffac7782c4b 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -1209,7 +1209,7 @@ int dat_peek_cmma(gfn_t start, union asce asce, unsigned int *count, u8 *values)
>   	int rc;
>   
>   	rc = _dat_walk_gfn_range(start, start + *count, asce, &ops, DAT_WALK_DEFAULT, &state);
> -	*count = state.end - start;
> +	*count = state.end >= start ? state.end - start : 0;
>   	/* Return success if at least one value was saved, otherwise an error. */
>   	return (rc == -EFAULT && *count > 0) ? 0 : rc;
>   }


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0393F44FA;
	Fri, 24 Jul 2026 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913201; cv=none; b=ePGfyPhIUqi8C9vfYa2W3IpKcl5FTil8AouaNV6TZjj7zZNa36Kqo41JF2haVQQnx5mdLeb2j1HC+Ay+R76/pXbq5T2YR+LhlauiqzpcQLVB8siDulVtcW7YjgdM8z2TXtUmDIy7ZmEJ8eIVThTmSpzTvn2bafyS7+xWvH+jkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913201; c=relaxed/simple;
	bh=fNI69qFdGr9DZ1olyaceHCSgR6ziD6oEcp8LJw4MmMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PzOY44avyGTenRnI9CeLDeSXKiPcuqycNksYi5HFtD83nl4Gqd6uEAiWbX/4cKweyueQ+DQfEmUKErDB1aVDbr9+/Zy9Jwd3lHZseErH0Cvt5YmtYMgDEGA6PigfxgMoF0q0uk6Ez2ita2fn9hcILYGT1Hq/ZbH689AfaOp7mQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NG9nwrYh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NG9nwrYh"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OHBeMp2429150;
	Fri, 24 Jul 2026 17:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=84F2ln
	R3KE7fqyOlDzAHRJEsemkHbT4yC60qra56Ky8=; b=NG9nwrYhCuyGAqKjmm7VGR
	czL7RkCvOmtCwpOBxHmcvhuHmBmSwtVFxl73/74Svf//Dqq3xWTaHxz1FymZUfAs
	mXAdJXEarp99E3hEpHF5qh7LdcEzjgpnq14HGO+veBjBPLofdA2JI/gkvoJHiUqS
	hoxU7IJUZVJtxRxUxnfKisXsXuEq6sWHthJ2JgMIy4xPdBKEjkT5+n/nDCyTajcL
	EH6J3QGbNrx9Cny8cZO7V2zsBeSxb0ySGMu/Vb4o1MNrVS7RddcvL0Q6YZ2VCmVY
	MQ0ILamaFft/u5RbCup679gzng334iG3u/OpJMC8srpRJfiza94cJY7KK+ZGrsnQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h512vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 17:13:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OH518b007358;
	Fri, 24 Jul 2026 17:13:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk9v2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 17:13:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OHDG5M17498624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 17:13:16 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D0EE58052;
	Fri, 24 Jul 2026 17:13:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F71758045;
	Fri, 24 Jul 2026 17:13:15 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 17:13:15 +0000 (GMT)
Message-ID: <bc1ae5b4-84eb-480d-be54-19264bdf5aea@linux.ibm.com>
Date: Fri, 24 Jul 2026 13:13:14 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] s390/vfio_ccw: ensure first IDAW remains constant
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-5-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260723174751.1180334-5-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE1NSBTYWx0ZWRfX6+rr17PtpO/q
 MO2NqkYSWw1Y2ekZ44iQKV0ZbEU1U3oHx9bCRe1IKBn26IWllOlRggeiqZALwB/IXCNeI8zJBQU
 4VyuObvGVLa1/IePlTvJYLoXYKzzFxw=
X-Proofpoint-ORIG-GUID: Rn8U8E625vYrD7R7oeh4JQdOvaS6ZaP5
X-Proofpoint-GUID: Rn8U8E625vYrD7R7oeh4JQdOvaS6ZaP5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE1NSBTYWx0ZWRfX19e5epe/JRYc
 EBuSkqAYbTpqjTmA3iNGb+jyQZUpxciHV9e2YwTrxu32lbHCp9ml++k+tv/fQgjLX30CKc1RKyo
 c8cuXlGMNeowFXi7Nj1U/OV4StUUEpw7QRijMC6EFUHEqS9fHWDmyCU+OJExjGbYD1yAJ/Fwegk
 OtOWDqZ5/kk2ahJhxCVlBNfzTAbMShfckDiNPLr46TizsfaEAwNIsyUY7zWTG2tvUieb1nPQh6U
 W6faOzr0Cq/AzzFex7pXpOtewX+aeQEuocVVv651OF2MLW1RK+XBuPQPbUYaRIgncRaZirPdYV/
 HDigDEkG8o24ZJlqOAJgMXiOWTvDatZXTgEZQAlTnPsHHG48xmquiCXSF0p1NK+K+5wuTU9i2Z2
 0fgomlyQFunivbIPKLR6UP1clr7y8ToRVlD9ctlih8PKdcqknpp+2rElBwC5wi4NhRYduMmR5kZ
 jqsfg9uMpBBghx3+v/A==
X-Authority-Analysis: v=2.4 cv=du3rzVg4 c=1 sm=1 tr=0 ts=6a639d2f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ZRtANegDX4hjiLUYKcQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240155

On 7/23/26 1:47 PM, Eric Farman wrote:
> The first IDAW in a list does not need to be on a 2K/4K boundary
> like all others, and so is read separately to accurately calculate
> the size of the buffer needed to read the full IDAL.
> 
> Verify that the address found in the first IDAW is unchanged between
> reads, to ensure a consistent set of IDAWs being worked with.
> 
> Fixes: 01aa26c672c0 ("s390/cio: Combine direct and indirect CCW paths")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 15 +++++++++++++++
>  drivers/s390/cio/vfio_ccw_cp.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 258a99930c6a..06b6bc6142a0 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -533,6 +533,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, struct channel_program *cp, int
>  		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
>  	dma64_t *idaws;
>  	dma32_t *idaws_f1;
> +	u64 first_idaw;
>  	int idal_len = idaw_nr * sizeof(*idaws);
>  	int idaw_size = idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
>  	int idaw_mask = ~(idaw_size - 1);
> @@ -549,6 +550,17 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, struct channel_program *cp, int
>  			kfree(idaws);
>  			return ERR_PTR(ret);
>  		}
> +
> +		if (cp->orb.cmd.c64)
> +			first_idaw = dma64_to_u64(idaws[0]);
> +		else
> +			first_idaw = dma32_to_u32(idaws[0] >> 32);

Sashiko mentions this one, since first_idaw is a u64 would
first_idaw = dma64_to_u64(idaws[0]) >> 32;
work?

Then you are doing the >> 32 against a u64 just like what
is done in ccw_count_idaws() where we set guest_iova for
comparison below.

Other than this line, this patch LGTM.

> +
> +		/* Unexpected mismatch from earlier read */
> +		if (first_idaw != cp->guest_iova) {
> +			kfree(idaws);
> +			return ERR_PTR(-EINVAL);
> +		}
>  	} else {
>  		/* Fabricate an IDAL based off CCW data address */
>  		if (cp->orb.cmd.c64) {
> @@ -614,6 +626,9 @@ static int ccw_count_idaws(struct ccw1 *ccw,
>  		iova = dma32_to_u32(ccw->cda);
>  	}
>  
> +	/* Save the read address for later */
> +	cp->guest_iova = iova;
> +
>  	/* Format-1 IDAWs operate on 2K each */
>  	if (!cp->orb.cmd.c64)
>  		return idal_2k_nr_words((void *)iova, bytes);
> diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
> index dc91a317ef19..d547dbc969cc 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.h
> +++ b/drivers/s390/cio/vfio_ccw_cp.h
> @@ -43,6 +43,7 @@ struct channel_program {
>  	union orb orb;
>  	bool initialized;
>  	struct ccw1 *guest_cp;
> +	u64 guest_iova;
>  	int ccwchain_count;
>  };
>  


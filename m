Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C15371899
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237210; cv=none; b=mj9Xg7IiGPz3dIqxKGyQJczeAKwF37gicTpNE+zr/436ZdKKlXYWooXlHjOwrzaKFx5GWSH0F28pj2TUiFf2qm/U8i7GB4PaflKJr1IWQrFXEpzacBJ16SO43JJAbHYrnvdTfCmtTB+MXYq+VEWbG5+hGVw3VZqFyfWn/0Xbio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237210; c=relaxed/simple;
	bh=gXnYaeikRuQTHax6TZd0ZcIHnDpPPD1x+1ym4MJeXiw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nTTOqjUzD93w+IYYzo717BUAyFvwa+NgzsYt9eugAx73uW6jKW/NllkNNuDprU21ae+UdnbKg7SJGYQZvbcwMR5DQBZKUBCbSi9pH50R1SQXYYF2roLP/au8CWedehN/nW+RGxqjR21IF98d3kAVzzitHc8J15T4BPvCadihZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EZJztp0l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EZJztp0l"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KEVkie2632520
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=ZVI+KfQS8iD+6HpLyH8fEjdajgqzh0np0a9dNpo1iNU=; b=EZJztp0lDs/1
	gi7F4CwbQmB3Ftgmf61GLuprvdel032Y+cRt+8+owhAwyj1jGBtvkTqkpB3VfSWS
	q2p31oTOzZYs5wqRd6iF3uVRpa8EwAb80yaz/rdfnxTU8S9DoRneYm0H1ges07PB
	KqOI5OX0y1fuFkY1d3FvsCLtOHEL8k33YBhBPDS2Wj5XZ965gsd+cArTns9oJas7
	SkXkVHcfyABrajUL31ibY+yplUblCC5Ps9nBPdoTKEw93e9FYJuIWfVbkS4pXjwd
	nCKIr54TzOSgcjEqnBhImthjUgsSL5+BCcVi/2KE8LIyaBnb1QiOPGP/VUz5/vgf
	RFC5CkkMug==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4avrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:46:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEfQTH020645
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:46:47 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekf48h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:46:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KEkjUS5243402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 14:46:45 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A0D958055;
	Thu, 20 Aug 2026 14:46:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74E865804B;
	Thu, 20 Aug 2026 14:46:43 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 14:46:43 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 16:46:43 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ingo
 Franzki <ifranzki@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] s390/zcrypt: Validate length in reply before using
 it
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260820140439.892324-2-dengler@linux.ibm.com>
References: <20260820140439.892324-1-dengler@linux.ibm.com>
 <20260820140439.892324-2-dengler@linux.ibm.com>
Message-ID: <3cd23b72c689c0ba769b5bc091798c40@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfX7/TbeoBvmY6E
 F7ieXhGGfdbNByExWLl7Pc7vlFBUSJyOyxYzJ3GmvnHL3vL1S6Ktx7XOzwEvmVxqVkSE3lgmaBQ
 48+09R4s4N5/WUguFz6qzXyOug8sJnI=
X-Proofpoint-GUID: q2ebBO2xB22u5Wav5HP1JIgNOFErh_dz
X-Proofpoint-ORIG-GUID: q2ebBO2xB22u5Wav5HP1JIgNOFErh_dz
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a871358 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=n_ldoGegh-ZflxYri9cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfXyonAiNca+xjp
 SIZ7IHJ2QTagpwaTHoA8CPWwXDVln0llE5gsTM8uD6LcBW7il4p4OT6gB0AxMjgjCsC3LPDO9Bt
 ptx7Ce5AsFzAA9NKKcgFNduiL/mspsyt/f4zYoVnoeiM4Epracw2dgSKzZd03SNanWcMjaanCOg
 RXLhHaW5PCr60E+T33LHVWVWyxfKxor9RnF9i073/HDw6v+UjbsL5wuN+rIIj/SdqRpWyqoz5OR
 QMrm8e9JM8e0dww6Q7lmkKF+6xTbFER1B+qb1RqFOFAQmsXdpHi9arW/RWagrdfGYcc957huJYc
 7UmKu/k6VzwZxZYJ902HZBTPjIsHeCm+HPTi2IFYkvIQR4wF6hfzmUHMxOkO0mbhT+5d4FaeXBy
 6SiUHiRQwsqWul42j5xOoumoxtzu3HnOqD92z2ovI+++P94y7XcFHVIM8E2Dbb7xDm0Vn0SXA1F
 AQ/Ae+jwFouO9QL1+Vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200109

On 2026-08-20 16:04, Holger Dengler wrote:
> The length information in the reply is used to copy the key token to
> the target buffer. An invalid information in t->len of the reply may
> cause an over-read of the target buffer and also a over-write of the
> target buffer. To prevent that, check t->len before using it.
> 
> As the available space in destination and source buffer is always
> larger than the valid length value in the parameter block in the
> reply, compare t->len with this (already validated) length
> information. As a side effect, this check also prevents buffer
> over-read and over-write.
> 
> Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>  drivers/s390/crypto/zcrypt_ccamisc.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c
> b/drivers/s390/crypto/zcrypt_ccamisc.c
> index d4ce6352b5b2..54b8edd1dfc7 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> @@ -1158,8 +1158,21 @@ static int _ip_cprb_helper(u16 cardnr, u16 
> domain,
> 
>  	/* do not check the key here, it may be incomplete */
> 
> -	/* copy the vlsc key token back */
> +	/*
> +	 * Copy the vlsc key token back.
> +	 * The available space in the destination (key_token) and the source
> +	 * (t) buffer is always larger as the valid range of 
> prepparm->kb.len.
> +	 * Validate t->len ba comparing it with the length information in the

what is this funny "ba" in the previous sentence ?

> +	 * param block of the request (prepparm->kb.len)
> +	 * The value range of prepparm->kb.len has been checked above.
> +	 */
>  	t = (struct cipherkeytoken *)prepparm->kb.tlv1.key_token;
> +	if (t->len != prepparm->kb.len - 3 * sizeof(uint16_t)) {
> +		ZCRYPT_DBF_ERR("%s reply with invalid key_token length %u\n",
> +			       __func__, t->len);
> +		rc = -EIO;
> +		goto out;
> +	}
>  	memcpy(key_token, t, t->len);
>  	*key_token_size = t->len;

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>

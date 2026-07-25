Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595B37702E;
	Sat, 25 Jul 2026 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995781; cv=none; b=jx1lnp8MBYrdnetoNwY3B35h9EQAgKp+eXHnQcpaNl+RZcCKF6dB9AFkia4fLLuxb0UkjtGTV/LP6MdfwL5ZYusoFJBzxj1V0bd/b2XZk4kEJLNWpMGyChzVyCwJRpYmDpufATy+GLGXyJnDc7I4J2O5tKfDumkj8jHf3IT26Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995781; c=relaxed/simple;
	bh=3FkZrmA1B/GJ9CYCKoxS4UEJMleGgQxU3UJBd0Au430=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWj+9pnykQmP/Gamw6dinIWHHaKsBMIN7zQpgYw10AKepr652idwn+lcPtP7154kSamAlyE7jZVI7HUwD9ehoEbcYZrzgJQ/Lo0PDVH9n0IrXyac1ZDkNJf3e39mzEEpLv/n/lNuTsjLnLHANbyNDjVX17l2u8j2cladU4wSmII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hdzvPlPu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hdzvPlPu"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PDlZtL3116436;
	Sat, 25 Jul 2026 16:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b3AH+U
	1UAtZ8hVlYrmhdCdFIu/lYOKXYm31fipJX6qk=; b=hdzvPlPu6UGdzAOOIS1bCa
	GcJ2RwNJEksjtS6W+Dc9RQx+45XzGFQy8E8SAZVNo77KjBBImCFQH7IjXK0AbIWK
	T1d81TdTW5aRvifNoL3MxVVeX+INkgQRY/uttmHyjLLGf0laRfgIdAxqvnAHJqd4
	ex4rx11jeZTpWSQLj5owLzBhJmSfQTZx+bGiHp+7b365GNnecsw6a4HmNobNB6QP
	4uJWPHswoYOdywBBOjIz6Jdg07PxFhwdRCkTOWPdyhnit7hdZqBGvhzotnIHo5Am
	5/PIDuYtIKiF2Zn8uxU2ITFF8n6/ZFe7CA3+VEPeyebJZTb0aP4p16/sRaF1nFsw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc0ns9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 16:09:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PFuJL9000494;
	Sat, 25 Jul 2026 16:09:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn12hsgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 16:09:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PG9bup65601810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 16:09:37 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A55958058;
	Sat, 25 Jul 2026 16:09:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAEDC58057;
	Sat, 25 Jul 2026 16:09:36 +0000 (GMT)
Received: from [9.61.125.168] (unknown [9.61.125.168])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 16:09:36 +0000 (GMT)
Message-ID: <692723b7-9f9c-473b-8528-8cca63739532@linux.ibm.com>
Date: Sat, 25 Jul 2026 12:09:36 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] s390/vfio_ccw: fix out of bounds check on CCW
 array
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-4-farman@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260725152705.3958100-4-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9UUguJBIGwg4OUZMquB618f5C9R3OyYM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE0OSBTYWx0ZWRfX1J83YjCip+r1
 LvZlLjmEAx9+Fr2Srmtck3qgxFlyuELKEPIL7JfaL+TUBjImE08QJ36FJwitfkU/sXcYffrUFzY
 wFtsi3TdfNrSsSn8oVLch1sr+ulTTd5DsespOOWQ6dfIhun8r5R8EGQLebFGW7EraKBcNCyoVoD
 eU/piJ1AmF629nBtGGXd3pDWEas93oiPy3Wkklgw8bzzj7AaRvPGiR/nCboqCzhcr5OPjyhG3PW
 dlr5aHAYN+nGLW47/eHu9dAHqfGI5zHlkga4l53DNdAB5zg4DSCPC7FBgRZE7vaGBIil28OXghA
 UDL1sPV5PlvscBUGH/Jp98SvrnSTEf4UhiHk9OnXTpNC7NG14k0HPCoMYq00ldbYKF+UYxGcjbF
 SCIbUvG4iWRb46rXXxgyC2fSKI7Puy/RXjICyqwOYCc+1UMuMRyHs2fRgd1dpzG2yYVLZ9cn6CF
 LO1vRPYQOkFAW96pOZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE0OSBTYWx0ZWRfX+GjDBy4xfe+C
 bADajluhCfDXoiy/reHlZB7YsRxot1SQ29dKbHM8UXDyMlmhn08y1o4KNdoGTI4iurz7/qJRTk6
 Pp2T4YlTX9vrJShBmka5Wh5ZCgpAioo=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a64dfc3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=FdF3VCsun6y3n0bO8WkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9UUguJBIGwg4OUZMquB618f5C9R3OyYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250149

On 7/25/26 11:26 AM, Eric Farman wrote:
> The routine ccwchain_calc_length() counts the number of channel
> command words (CCWs) that are chained together in a single channel
> program, and rejects anything larger than CCWCHAIN_LEN_MAX (256) CCWs.
> 
> The loop itself is "do..while (count < 257)", and while the logic in
> is_cpa_within_range() correctly adjusts between the 0-index array of
> CCWs and the count of CCWs starting at 1, this means it would look
> at a possible 257th CCW before ending the loop and (correctly)
> returning an error.
> 
> Fix this by restructuring the loop to break as soon as 256 CCWs
> (thus indexes 0-255) are examined, without looking at memory
> outside the range.
> 
> Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 1c2890d139c6..af632f9d5453 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -377,11 +377,9 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
>  static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
>  {
>  	struct ccw1 *ccw = cp->guest_cp;
> -	int cnt = 0;
> -
> -	do {
> -		cnt++;
> +	int cnt;
>  
> +	for (cnt = 1; cnt <= CCWCHAIN_LEN_MAX; cnt++, ccw++) {
>  		/*
>  		 * We want to keep counting if the current CCW has the
>  		 * command-chaining flag enabled, or if it is a TIC CCW
> @@ -391,15 +389,10 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
>  		 * after the TIC, depending on the results of its operation.
>  		 */
>  		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
> -			break;
> -
> -		ccw++;
> -	} while (cnt < CCWCHAIN_LEN_MAX + 1);
> -
> -	if (cnt == CCWCHAIN_LEN_MAX + 1)
> -		cnt = -EINVAL;
> +			return cnt;
> +	}
>  
> -	return cnt;
> +	return -EINVAL;
>  }
>  
>  static int tic_target_chain_exists(struct ccw1 *tic, struct channel_program *cp)


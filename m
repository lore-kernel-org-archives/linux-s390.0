Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3B34388E;
	Fri, 24 Jul 2026 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911754; cv=none; b=iSow81n5pABR3GefgDutzQXPUjzzpyIYVMtVi+jPft8ZaIwSci2Zk+UdRutUV0qT5V8wbSnhVF+1TChOGU9Cw8JL4Hw4yS2wG3rTnzKTLSTIDuKYfCSm9jIcC/wYKgPvlgi6qUt4IEVii783oeFO0hTJszKETQQTfsGy72F42As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911754; c=relaxed/simple;
	bh=1UGAnJFLF7EN8foSpj24V4L8dSBOlVeYIVN/VKmKTh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLkgCe8TxDet5914c5KksDa6YCuqMF+dEygOg8vpZwTxKkgJUdRY2rB21DbLo5oDryHK1tDpM/c2Df6V2mdlX5/3q9D5N2V50EXPegEpDCtw0VxjoU8EG2nu5b7UU6mAkKVq/lLOYdhdyuZZr1L+FOutzEWBUYZ7muIXD979vnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PZGSIm4x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PZGSIm4x"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfdQ21973583;
	Fri, 24 Jul 2026 16:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C/cmAd
	GxZvTtalFereQsryrThdIi/K7671oYeDwhwRA=; b=PZGSIm4xDV7cWkzbuHXfos
	LJJjWXHJRHRMOqWKuVdmwFZRsOdB+g6TOgY13icod40LsNyOzb9n819jj+w1Uek9
	Zu7NEpA4fQd6IO9ca07fNUj2NNfpEBJ5tKQst9iPnzvYdxu3RKuTHsfmJwqCCj/w
	KquFhUEoDUlkJixPjDWVUL4eFcxa0l4QHQ9nRzkaSlqk6B7UUzSqkNUwG1Tr0ylX
	K8G3ZTreNfZB7IvrPf/zKiDq+Opx+jMB+mr5OZKDG7E9pyKTXWbkpSY6UflDJskN
	2gxqOvnZ8KSpGbfm7a5U3kTpFFFAFg5B7ls3aqhBXRUlLd/HXXkwzq3Q+LvzWWEA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h50yfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:49:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OGYbk3016284;
	Fri, 24 Jul 2026 16:49:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gsjw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:49:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OGnAqM24117978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 16:49:10 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 493F658054;
	Fri, 24 Jul 2026 16:49:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6694358045;
	Fri, 24 Jul 2026 16:49:09 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 16:49:09 +0000 (GMT)
Message-ID: <924a8e11-f042-46d3-a559-407dbdc76d99@linux.ibm.com>
Date: Fri, 24 Jul 2026 12:49:08 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] s390/vfio_ccw: fix out of bounds check on CCW
 array
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-4-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260723174751.1180334-4-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE1MCBTYWx0ZWRfX4A2gSO0EFvb1
 sp7a1dLf3knKsQYadAi8pGRsjGWysgR6yJcQCPEdBYuSXxUjq6igvezaLtcMqbW7Kng58DynYdQ
 pP0rPZhqccJMXpMFWk1doCoBX3rhaEk=
X-Proofpoint-ORIG-GUID: ZWiJZejKBwLvOhw8cnd0aTHhj0r_Dvv8
X-Proofpoint-GUID: ZWiJZejKBwLvOhw8cnd0aTHhj0r_Dvv8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE1MCBTYWx0ZWRfX+UOloMLrJaC5
 RpVKh1jUwvXVncKcgQfLXTrb3moBmz8G+Earyh7ZBCS270ETmtyWJEuInI5Xod1WiysdXc9uDe7
 g/G0rRlOoPt2G62o/3xLPQNkrEtW+DWB5dFf5IPA+XAt63eGWlfoshbDVTT8EdFieWUk6TE/tp3
 6sVQqbxNryDwTjHQfoOgTVL245QILd6PJ5B8NZIk7ajo8K+j+fcb4L3gKe+XB+JIkiHQrWSQ+9N
 GXlnrqS8IuKBOBbsA1Ta0Trz4hNEiDwWV4K042VRikZBmDxiqqd+BFP/O+nQuBNWDZZXnw79Q7+
 VSUOq8GkSkDs5vgJhjDkNuauasvWmtrcno/+HRzTEUPVv5Fq8bbps4/H+OqOuLeK0U9VZ0taghd
 6YkPPMKo0d8S6KD1TGGMpNuLioAfflBm0+Br4IxhoHgN3qRVW8dzdcznU/WWvp7OYOTQ59atmbG
 p78gcNPwOhY4xipKMYA==
X-Authority-Analysis: v=2.4 cv=du3rzVg4 c=1 sm=1 tr=0 ts=6a639788 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=FdF3VCsun6y3n0bO8WkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240150

On 7/23/26 1:47 PM, Eric Farman wrote:
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
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 

So, I think your approach is correct, but I tried for a bit to come up
with a more concise solution because the while(1) was bothering me.
The best I've managed to cook up is something like:

static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
{
	struct ccw1 *ccw = cp->guest_cp;
	int cnt;

	for (cnt = 1; cnt <= CCWCHAIN_LEN_MAX; cnt++, ccw++) {
		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
			return cnt;
	}

	return -EINVAL;
}

Assume CCWCHAIN_LEN_MAX=2
We enter with cnt=1, ccw=guest_cp[0], and 1 <=2 so we enter loop
either return 1 or loop, assume loop so we increment
now cnt=2, ccw=guest_cp[1], 2 <= 2 so we enter loop
either return 2 or loop, assume loop so we increment
now cnt=3, ccw=guest_cp[2]*, 3 <= 2 so we break out of loop and return -EINVAL

*So the only catch is that we will increment ccw past the end, but unlike the
original implementation we will break out of the loop before ever attempting to
use that ccw pointer at that point.

What do you think?

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 1c2890d139c6..258a99930c6a 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -393,11 +393,14 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
>  		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
>  			break;
>  
> -		ccw++;
> -	} while (cnt < CCWCHAIN_LEN_MAX + 1);
> +		/* Exit the loop when we reach the maximum */
> +		if (cnt >= CCWCHAIN_LEN_MAX) {
> +			cnt = -EINVAL;
> +			break;
> +		}
>  
> -	if (cnt == CCWCHAIN_LEN_MAX + 1)
> -		cnt = -EINVAL;
> +		ccw++;
> +	} while (1);
>  
>  	return cnt;
>  }


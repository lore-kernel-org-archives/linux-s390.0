Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE511C5D7D;
	Fri, 24 Jul 2026 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915640; cv=none; b=MewJ0+0Oz3+w5ztGHiL5LsMOjMt5Pd20jjgmEI7IctRpeb5zvZ+ZcpHDK3BbuBqf/a+P1BSRGfE2dkQAhB7BQbpcfkT9QGtycvRvuH32wDfoQ/4jG6Z0EJF5B0tPNmSedhHEUJfV2274smfUYtMR6Kvh+9ev4fK/2L3DRw9QEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915640; c=relaxed/simple;
	bh=8oaRis8UgQRGMMpH5zVLI9N8FyyPalp+/iV10iYEzy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+tfCac40TfIxRdUBiCM+j3ftfHFlQ+8HZKJbzXtp+demuexPb2brjOwxyiy05ygv+spFqTILfBkloLqnVhd/P3yvP5cJBF4v0w3C36gpq6qcTVaE9U+YpGgnCkA9FT3gpHCV+ni5OiibxChTfrSPx/SIvppmgZ/Q/MaOvV7GMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CEgrntMs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CEgrntMs"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OHBnLE2450787;
	Fri, 24 Jul 2026 17:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+c0rxx
	oG4q7orJ5qvjOr37YofShRkSUMF5bMuA7COXY=; b=CEgrntMsWWKQqA9ZMbPaS9
	IsZWMBgBQ6+hJlpGOdl5HcbNhrM8mEfIgg/QVxQyrssUVao+TQmEV1tLwgDkrvJb
	5k+dPEKGxNGiDhsbDrmvmtdd3/AjXAqkzy1R1axP885r0Y24bMty2Gl2YzAU+MbR
	11u1WzMN5WXFh5lbmdjj9RprA/RvCtdAYt08TGzqqkvJV5kbMh9Swzcx6xDemyGC
	IfPZFlKjCCCInLPwo7Uka0+fljv4e/WBKHM1uolfaaupbzYnQrUR5OKqDa9FzWtz
	Bq72Hztga9bTNr4WatAgotEEDXMmRVOS/gdM/U9Kk2bVHWYc2P171dTZnRxDf8IQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahn9b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 17:53:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OHnafn008972;
	Fri, 24 Jul 2026 17:53:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gstdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 17:53:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OHrtdc25625322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 17:53:55 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52DF55805B;
	Fri, 24 Jul 2026 17:53:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EA3458058;
	Fri, 24 Jul 2026 17:53:54 +0000 (GMT)
Received: from [9.61.19.212] (unknown [9.61.19.212])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 17:53:54 +0000 (GMT)
Message-ID: <7c38970e-99e3-4680-a8ce-28ab9a3a5232@linux.ibm.com>
Date: Fri, 24 Jul 2026 13:53:54 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] s390/vfio_ccw: fix out of bounds check on CCW
 array
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-4-farman@linux.ibm.com>
 <924a8e11-f042-46d3-a559-407dbdc76d99@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <924a8e11-f042-46d3-a559-407dbdc76d99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Eces0XPtWHrSPlxqTU1f8i1JV-bYtpjM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE1OSBTYWx0ZWRfX45N81XyEoe2g
 b4aCVsDy+h2HgTF8fZ+B/NQCkNJJYRCuRCB76mg2z2X4sh5imcxCjm9U2XQDq+XzDi5yySpsvmr
 Ue1O2ELiyu5RoV/iMW4kiq1wjhpI5FLDOFsTfzb084ddvZp0cWuEnGZxc0Blcntc6V1ceMIZknS
 0lVSEpnFdrnXMHR3swCFDwTHRcRHXCOPGegwjyPQAjE7caJJ09/byERkRGJfLD0ULfM1H4OIlDZ
 rSnY3KqswaQuDRQ7BiGzyIiVkWSferB68uhUmwPS8Si4SEif/h4MEUdFF5L8lcjThlfr/PVV0Mt
 BzqX5eqPpvB05WYBr6VoF/sbGOoakLdmQ62ybn1k8yT44FkWdl44g9OiRQFWSl/5t3gLTUXtMlG
 RBe8+yV3I5EXgaLkO5ZWrHe6NoSEWSWkgdMCdxtCDE6x9SgjeLccn+INspdjXPg9/63ZlxDKxGq
 10LVNik73IFwlKkONYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE1OSBTYWx0ZWRfX/BDwDZLakybl
 Dq41zuAZ+HIApg9yZG5FnRHprSbm9jbxPoUhX3Na/sVczRI2DbnYcWFUFqARaIzL1tY5KJIDTLc
 /516AWQLgDmrWiZGy9DeYAS89w/Ntjg=
X-Proofpoint-GUID: Eces0XPtWHrSPlxqTU1f8i1JV-bYtpjM
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a63a6b5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=cexSUo_GorlQsk_X9b8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240159



On 7/24/26 12:49 PM, Matthew Rosato wrote:
> On 7/23/26 1:47 PM, Eric Farman wrote:
>> The routine ccwchain_calc_length() counts the number of channel
>> command words (CCWs) that are chained together in a single channel
>> program, and rejects anything larger than CCWCHAIN_LEN_MAX (256) CCWs.
>>
>> The loop itself is "do..while (count < 257)", and while the logic in
>> is_cpa_within_range() correctly adjusts between the 0-index array of
>> CCWs and the count of CCWs starting at 1, this means it would look
>> at a possible 257th CCW before ending the loop and (correctly)
>> returning an error.
>>
>> Fix this by restructuring the loop to break as soon as 256 CCWs
>> (thus indexes 0-255) are examined, without looking at memory
>> outside the range.
>>
>> Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_cp.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
> 
> So, I think your approach is correct, but I tried for a bit to come up
> with a more concise solution because the while(1) was bothering me.

Ah, yes, it was bothering me too, but I guess I forgot about it.

> The best I've managed to cook up is something like:
> 
> static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
> {
> 	struct ccw1 *ccw = cp->guest_cp;
> 	int cnt;
> 
> 	for (cnt = 1; cnt <= CCWCHAIN_LEN_MAX; cnt++, ccw++) {
> 		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
> 			return cnt;
> 	}
> 
> 	return -EINVAL;
> }
> 

This seems reasonable, and is definitely nicer to read than what I had 
before (which contained artifacts of the old/busted setup). I'm running 
tests on this now, but will include in a v4.

> Assume CCWCHAIN_LEN_MAX=2
> We enter with cnt=1, ccw=guest_cp[0], and 1 <=2 so we enter loop
> either return 1 or loop, assume loop so we increment
> now cnt=2, ccw=guest_cp[1], 2 <= 2 so we enter loop
> either return 2 or loop, assume loop so we increment
> now cnt=3, ccw=guest_cp[2]*, 3 <= 2 so we break out of loop and return -EINVAL
> 
> *So the only catch is that we will increment ccw past the end, but unlike the
> original implementation we will break out of the loop before ever attempting to
> use that ccw pointer at that point.
> 
> What do you think?
> 
>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
>> index 1c2890d139c6..258a99930c6a 100644
>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
>> @@ -393,11 +393,14 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
>>   		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
>>   			break;
>>   
>> -		ccw++;
>> -	} while (cnt < CCWCHAIN_LEN_MAX + 1);
>> +		/* Exit the loop when we reach the maximum */
>> +		if (cnt >= CCWCHAIN_LEN_MAX) {
>> +			cnt = -EINVAL;
>> +			break;
>> +		}
>>   
>> -	if (cnt == CCWCHAIN_LEN_MAX + 1)
>> -		cnt = -EINVAL;
>> +		ccw++;
>> +	} while (1);
>>   
>>   	return cnt;
>>   }
> 


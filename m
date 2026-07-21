Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13921A262A;
	Tue, 21 Jul 2026 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784592116; cv=none; b=R1bGQg8QRa/fAbtM7L/JSMAiQZ5dA8YCzhyfojy56iiuiNVeJGhBnLO83W96hwF3Qk0a6hgVBPGoUT8JIJp+jyyzifwXxo3TnM0hdnSA8aj8RTb6FcO9ZEt5jKM8m0xo5JFTsDzx41sFW2+bAKSBOc90knNom1P4p1H0THuQOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784592116; c=relaxed/simple;
	bh=n7vkdzC0YSpubJsZVnKY4CiWNaOBHHO2qChBLYEvqqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FK57uv7siH7GeG8c951BgSicPbVZiwGzHHyrAf10KbAou92h7lKG/JRO2RxnqqDrGh/sxtOjBIwiiffINFnDQiru7bfYtRvpE3fwiX3AuKii9MoorNTQSI8x4kOYOiluiIANzi5kNKCMuZWOpaK1eF7Vhf6SE6GA8uLiuSkxV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yowkji8m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yowkji8m"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNDHVT1677282;
	Tue, 21 Jul 2026 00:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=60EkiR
	hdUz40wuv37dLOKsRbRz9If7jrddfmFHDnYXM=; b=Yowkji8mS00BR8rOHFvnwJ
	u/Dp13fOgRyZ9T1CAE872FXZh6cfwo6uPnu+uWC98Pz+zijBFuKyJxqW0ToduS2H
	tYwx8VFslO/kigIIfkJZ+f8NMvDxwWPKj/xckB5Qz94XTUccBGW9ajy9dj6+wEDQ
	+bqXZzfYhKwG9qL0GHjNuvn5WhZ0jGJ9H40usgCwcwM/zGZ6rKw8iDq42Jiw9Ox+
	6am1hix6i6u+5CthNjqy97nQ/W1OEJ2h6y1ldn3rWu87ox5bXWQV4UmszrRVxVDK
	WTnM4pfTNeIihrbptoQsOUXpFfPM/7T12i0L51Tg8CU51+K0NeuMpyaQ0Kd+bEuQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77aa0uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 00:01:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KNnYAx017807;
	Tue, 21 Jul 2026 00:01:44 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy7kup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 00:01:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L01h7t31851114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 00:01:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E0365805A;
	Tue, 21 Jul 2026 00:01:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 514E158064;
	Tue, 21 Jul 2026 00:01:42 +0000 (GMT)
Received: from [9.61.41.22] (unknown [9.61.41.22])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 00:01:42 +0000 (GMT)
Message-ID: <72f9931d-9e1f-441f-b1b2-247d183582cf@linux.ibm.com>
Date: Mon, 20 Jul 2026 20:01:41 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] s390/vfio_ccw: free all memory if cp_init() fails
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic
 <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260720201931.976660-1-farman@linux.ibm.com>
 <20260720201931.976660-2-farman@linux.ibm.com>
 <74b5de0b-b52f-40a8-8fca-9876bb12ac48@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <74b5de0b-b52f-40a8-8fca-9876bb12ac48@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _mKIDLFCgzwUCZDCnYQjWcT8wmo3mXmR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDI1NiBTYWx0ZWRfX3uVjyBGKabKb
 rbO9Q1CYe/hOzYv7MkXaz/0egpPkWC/Gs6NjdDQV5Lfsz6AySefw2VhphPl8VDzeq5ECwjYWhVF
 Vkwh4De7DcwAb7Jk3ihXbvkJYuotofM=
X-Proofpoint-GUID: _mKIDLFCgzwUCZDCnYQjWcT8wmo3mXmR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDI1NiBTYWx0ZWRfX8oXY8CndNAPq
 q8OMKpkGQWFQDTlZfI1KLPg6+eHn0a9FjzNnwNzDNHAso7YVK1dAeDGNyDnD0w44NS+a5JL1kpg
 XUx16YDN3659ribafSo1CcMNr6SqYURFqt0L6MjWExdtT4O+Gn9PW7TcwffI3EjCA6EACo85NL0
 olp98qBdzkr8Vn6S4QdJ9gd0JrOGypMT4SeGygQnMy7/ZzQF737lFFN1kE/V9r+2g3kUjbPXLoL
 qL9bT1pn4jgg1v8GqWwgMzsMwCdMyUn8bWISr0lgf4WlybBOzqV/rHxwKKFxNuhgBvVqOQzP3oM
 /TuO4l+qP8BcZaRVaQqg1UcxRL4FZkNRzX+PyNTNlRsSLjWTaZOYablrJJ6dPrSNBr2621acRnY
 RBCEjuXOKub2JPJOD0YV5C38hMmo4yBAFjfTUPbje4C9PXGKsuEPmlS745+iinGhaoWoqwdfFz8
 ZjBF1RXG5H886+a7enw==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5eb6e9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3pY_3P-V3KhXw8xrUiAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200256



On 7/20/26 5:48 PM, Farhan Ali wrote:
> 
> On 7/20/2026 1:19 PM, Eric Farman wrote:
>> The routine cp_free() is called to unpin/free any memory once an I/O
>> is completed successfully, or if cp_prefetch() fails. But if cp_init()
>> fails, and cp->initialized is not enabled, the same routine cannot be
>> used to free all the memory.
>>
>> An attempt to address this exists in ccwchain_handle_ccw(), where a
>> single call to ccwchain_free() is made for the currently-processed
>> CCW segment. But this will leak other segments (created as a result
>> of a Transfer in Channel) that had been allocated as part of the same
>> channel program.
>>
>> Address this by performing the cleanup outside of the recursive
>> ccwchain_handle_ccw()/ccwchain_loop_tic() logic.
>>
>> Fixes: 8b515be512a2 ("vfio-ccw: Fix memory leak and don't call cp_free 
>> in cp_init")
>> Cc: stable@vger.kernel.org
>> Cc: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_cp.c | 22 ++++++++++++++++++----
>>   1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/ 
>> vfio_ccw_cp.c
>> index 7561aa7d3e01..086d1b54bdb0 100644
>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
>> @@ -455,9 +455,6 @@ static int ccwchain_handle_ccw(dma32_t cda, struct 
>> channel_program *cp)
>>       /* Loop for tics on this new chain. */
>>       ret = ccwchain_loop_tic(chain, cp);
>> -    if (ret)
>> -        ccwchain_free(chain);
>> -
>>       return ret;
>>   }
>> @@ -486,6 +483,23 @@ static int ccwchain_loop_tic(struct ccwchain 
>> *chain, struct channel_program *cp)
>>       return 0;
>>   }
>> +static int ccwchain_build_ccws(dma32_t cda, struct channel_program *cp)
>> +{
>> +    struct ccwchain *chain, *temp;
>> +    int ret;
>> +
>> +    ret = ccwchain_handle_ccw(cda, cp);
>> +
>> +    if (ret) {
>> +        /* Cleanup if an error occurred */
>> +        list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, 
>> next) {
>> +            ccwchain_free(chain);
>> +        }
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   static int ccwchain_fetch_tic(struct ccw1 *ccw,
>>                     struct channel_program *cp)
>>   {
>> @@ -735,7 +749,7 @@ int cp_init(struct channel_program *cp, union orb 
>> *orb)
>>       memcpy(&cp->orb, orb, sizeof(*orb));
>>       /* Build a ccwchain for the first CCW segment */
>> -    ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
>> +    ret = ccwchain_build_ccws(orb->cmd.cpa, cp);
>>       if (!ret)
>>           cp->initialized = true;
> 
> The fix looks correct to me and I don't think Sashiko found any issues 
> with this patch (issues identified as pre-existing and i think something 
> this series is trying to fix).

Correct, the two pre-existing findings reported against this patch 
should be addressed by patches 2 and 3, respectively, in this series.

> 
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> 

Thank you!

> Thanks
> 
> Farhan
> 
> 
> 


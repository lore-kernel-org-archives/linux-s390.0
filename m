Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F385D3E3DA8;
	Thu, 23 Jul 2026 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839127; cv=none; b=WHJedsoxfi/1Ahzw8OY/DdIF9lexkmkcZ8aWbTpJboLgmW43Ip0eC+LbaITda345KcL1VzCHoAKY5oajRvR7Elz+Kh1etW5upcI/65D+yV/qP0/qrdrqPtR8d4kyfmqekMNTrfpWldZf8aEvXq7V4d5AhRDGR//7yG8IW59x4uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839127; c=relaxed/simple;
	bh=7x1RxcUYGYMxooIg+wbgy2njuIetHpx6HrgCGulu9NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLMQ4Td9dR5jPyH0+P64M7NZUJb4myp9nm7KICG0SZL5ZZt0P4scKzAijGllnLfBprW0GnReB4qynwuhA7lntlz6kLDHpx8q+s7jve5b7TGDiHqlSBIC/3Rv7ULDVkpRYIq0r2Qe4ycu/OoHOvE0Kjr4hpt//oh3ewKEpDquSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NGtHO8Zw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NGtHO8Zw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NKGwVV4027257;
	Thu, 23 Jul 2026 20:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=10IhiZ
	aYhaflu9tAgaF/Hd+lR4a7it3lRtisd98+9p8=; b=NGtHO8Zw2P98kRh4dJCNm9
	5H4POlXzBZTSwOrFxOwbGrO8HQqIlx98G+UetIily2BE3c4f5MinAJd32VU4ZtOJ
	DCFFoTNNQTKfQoiXo1M4jF2/j/MmRTeuuBtN0p0hCwXVNb6MSaX9ieWiUvX+oEYP
	OiiSxRi/TwwEPInkD+OZgMVDQwWDEJ1FxPlwMpIG+w/6OqdVl14jSm68zhuU0Nvk
	YhNX260WwN591wqCbZEAem3IJwVLwdrjOfYP7QENrHaXgEBZJMWp4C98Dw315CAC
	CV6cz5sEHn/Dxs8QLEUEC0IyuUyCnVTVxpZcQdUyJHUb17evQbv34pecuqHOpTsw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7919j7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 20:38:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NKYgkv019420;
	Thu, 23 Jul 2026 20:38:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk5yr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 20:38:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NKcdsE31523392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 20:38:39 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E44858052;
	Thu, 23 Jul 2026 20:38:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A30A5805A;
	Thu, 23 Jul 2026 20:38:38 +0000 (GMT)
Received: from [9.61.19.212] (unknown [9.61.19.212])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 20:38:38 +0000 (GMT)
Message-ID: <b21d6e76-27ba-4215-949d-30c8e77e5b3d@linux.ibm.com>
Date: Thu, 23 Jul 2026 16:38:32 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] s390/vfio_ccw: ensure first IDAW remains constant
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-5-farman@linux.ibm.com>
 <20260723182956.2AF2F1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260723182956.2AF2F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AEsL6SldSjgfdlckhQ142582E7_DMbFG
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a627bd1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=VfsGCoBMmi06R50DL2AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE5NiBTYWx0ZWRfX51532StjCvIJ
 4h/7AIqA0Zeqy1bmXjUhjsVRlEEsCmkHxZni9zuaOqN27Sj7QJ8juGgC18t0/Wa5/JdIN0SNwgQ
 j1lkaij8rLp5z743pvF6tCy+mIW8Dok=
X-Proofpoint-GUID: AEsL6SldSjgfdlckhQ142582E7_DMbFG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE5NiBTYWx0ZWRfX2lTLvUHZ1Ebw
 E/pXYhEF+AAh2z9on+VzZdWk+O/vTTbredeZITbv51q3Tj8aJU1iaE/NP8O83bvzNAjKnjr+2Wm
 KGD/5O9IHDwHGlrPrvNydOSGbzfS7E4j7stxhtcwnLOdKqcB+dgvGgQLtHoqsX9jyd5fwSnAK0f
 HjvtKGYOmNz2bqTljUUjHf32Skb7vgvCahZxH6U3kAXYFFVK9R26qlNHmp0F0PDCZYxECjyaMmW
 9qrj4GQwegrSPDOdoEvVOLP5u3nJyCdINBWUsnzu+rdG5vAaaE+g2lOVL4TQZAdhj8w9ZyOr/pI
 BObJ5YN1aB4msdpjbB979PKLspdSwEcun8eAkIHzjZwftYXe3BNFtrd9biu2PEWdDyFyxZTqSDt
 RUfdZ47aFkr7Xe8zMLHgGfXBm1qDjstIvYM9pZj6qftp4OAjxtwEm+S1+I6M47Y3wtiXtgyE2f/
 YSG+KWw57aBaeC3YMeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230196



On 7/23/26 2:29 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Low] Applying a bitwise shift directly to a restricted `__bitwise` type (`dma64_t`) and implicitly casting it strips type annotations, triggering sparse warnings.
> 
> Pre-existing issues:
> - [High] `get_guest_idal` reads too many bytes for Format-1 IDALs, potentially causing spurious failures for valid channel programs.
> --
> 
> --- Patch [4]: [PATCH v3 4/8] s390/vfio_ccw: ensure first IDAW remains constant ---
> commit e8a4291c688f39a3fdc915242b5bb6676e357ac5
> Author: Eric Farman <farman@linux.ibm.com>
> 
> s390/vfio_ccw: ensure first IDAW remains constant
> 
> This commit ensures the first IDAW in a list is read separately to accurately
> calculate the buffer size needed. It verifies that the address found in the
> first IDAW is unchanged between reads to maintain consistency.
> 
>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
>> index 258a99930c6a0..06b6bc6142a0f 100644
>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
>> @@ -533,6 +533,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, struct channel_program *cp, int
>>   		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
>>   	dma64_t *idaws;
>>   	dma32_t *idaws_f1;
>> +	u64 first_idaw;
>>   	int idal_len = idaw_nr * sizeof(*idaws);
> 
> [Severity: High]
> This is a pre-existing issue, but does get_guest_idal() read too many bytes
> for Format-1 IDALs here?
> 
> Because idal_len is calculated using sizeof(*idaws) which evaluates to 8
> bytes, instead of the actual 4 byte IDAW size for Format-1 IDALs,
> vfio_dma_rw() will attempt to read idaw_nr * 8 bytes.
> 
> If a guest VM submits an I/O request with a Format-1 IDAL that fits exactly
> at the end of a mapped page, this could cross the page boundary into an
> unmapped page and cause the DMA read to fail, spuriously rejecting a valid
> request.
> 
> [ ... ]
> 
>> @@ -549,6 +550,17 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, struct channel_program *cp, int
>>   			kfree(idaws);
>>   			return ERR_PTR(ret);
>>   		}
>> +
>> +		if (cp->orb.cmd.c64)
>> +			first_idaw = dma64_to_u64(idaws[0]);
>> +		else
>> +			first_idaw = dma32_to_u32(idaws[0] >> 32);
> 
> [Severity: Low]
> Does applying a bitwise shift directly to a restricted __bitwise type like
> dma64_t and passing it to dma32_to_u32() trigger sparse warnings?
> 
> Since idaws[0] is of type dma64_t (__bitwise u64) and dma32_to_u32() expects
> a dma32_t (__bitwise u32), this implicitly strips type annotations.
> 
> Should this be explicitly cast using (__force u64) before shifting to avoid
> violating sparse type rules?

Probably a better solution to this is:

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 06b6bc6142a0..08be6d5a99f3 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -551,10 +551,11 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, 
struct channel_program *cp, int
                         return ERR_PTR(ret);
                 }

+               idaws_f1 = (dma32_t *)idaws;
                 if (cp->orb.cmd.c64)
                         first_idaw = dma64_to_u64(idaws[0]);
                 else
-                       first_idaw = dma32_to_u32(idaws[0] >> 32);
+                       first_idaw = dma32_to_u32(idaws_f1[0]);

                 /* Unexpected mismatch from earlier read */
                 if (first_idaw != cp->guest_iova) {


> 
>> +
>> +		/* Unexpected mismatch from earlier read */
>> +		if (first_idaw != cp->guest_iova) {
>> +			kfree(idaws);
>> +			return ERR_PTR(-EINVAL);
>> +		}
>>   	} else {
>>   		/* Fabricate an IDAL based off CCW data address */
>>   		if (cp->orb.cmd.c64) {
> 


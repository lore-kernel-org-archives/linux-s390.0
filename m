Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CA131618C;
	Fri, 24 Jul 2026 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915487; cv=none; b=bp/gSoixW2mpF1/zmMUunlZ3YsVTmr59kwplbzlfBfZXzzDPPa2CQJ3u91aTLjKG0su8sV3faaj+irxksJuIs13vdurWDrg4EYY0PPJeFzTI8MjReajvy/tRsfKMmoA68FpfW+sDEPo2IEXCEsIKsZFeOZ5u96iHcGG+vJEO96w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915487; c=relaxed/simple;
	bh=nWnbTi8pvw8DLc79ebFvMEdjRzgQl2qSWxMboDg000s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3t2Y93Sw5tR61vR8JQ/P+pU+dwMEXC4jYQbU6Ol65SqTWzMYJKdsojO5tvuAfikhVdwF25WBYO9Pt/DZODL4ocSfCxjIXg+M52a8u06d23ddnNkb5q6HlE7IMoniQnPVJgDoINqtMQfrbHraBO+xswVJBy1tKBjM++HzsJsv/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gimToVP6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gimToVP6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OHBv7X2352942;
	Fri, 24 Jul 2026 17:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qpPWGO
	Ste8aUhnSh8xL3B8s1k3NcCGnPZ5/+NhtQx3I=; b=gimToVP6yvqg9Dh2i0DtnZ
	COYUeeVPnwaWzPzeSuugNTXiwfzaF77HDmpmFxEJW5qFO3q+giXWXcq+6uzEbIZX
	rpEHzwEf+EIJfG7HtW4xONRRVO0hr02Is7KUMQpb9vPY7Ily1NDxodtbqYrB0bOF
	EJvaz2nBRjLrhHWMhunqtW4xGR/8yUHvUhx15dgCjSIzR4QZgJPOB5Jv0DqJuMyw
	IUCtP2Oj1vhF3r4ujtYOjnZ7w4ZWyMecVHyZlHzBUrPirY2paLUhZl141/kotUFg
	0hMlJRI+1CHtOkdX4hdat6y2H1ZYt1j5CIHsSN0FnhKxw6dkARcojZwQjvUoEKfA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77knatu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 17:51:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OHniNs026353;
	Fri, 24 Jul 2026 17:51:24 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqj5w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 17:51:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OHpMG328639868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 17:51:22 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DBD258045;
	Fri, 24 Jul 2026 17:51:22 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BB3E58050;
	Fri, 24 Jul 2026 17:51:21 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 17:51:21 +0000 (GMT)
Message-ID: <c234577c-c27d-4460-8dd5-7d8b48e0094b@linux.ibm.com>
Date: Fri, 24 Jul 2026 13:51:21 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] s390/vfio_ccw: ensure first IDAW remains constant
To: Eric Farman <farman@linux.ibm.com>, sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-5-farman@linux.ibm.com>
 <20260723182956.2AF2F1F000E9@smtp.kernel.org>
 <b21d6e76-27ba-4215-949d-30c8e77e5b3d@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <b21d6e76-27ba-4215-949d-30c8e77e5b3d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a63a61c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=A5oUufH1SNi9yJRP6tIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE1OSBTYWx0ZWRfX4Cm8JiYjT6tI
 QX5Ed+H9l0WABJc3g1Tx64fuWyYgrmrHq5ueBGkzMMKUfKTcAqGfIq0ff+d85uydnaWT1V+PS8H
 v7/hiR91x8xGjtqMu/xZjaAyyko0FWzWLtlSKEktQKFrlkKTztY9R/pm2dl89U/oLBA/+Pfpm0X
 UJxM1+/Fo0PKqYv/qEP9OwXinw5S6HUFaiisrnE3wkC4jfTaH4aE+z/TgzogC6VDssIjQLwBo0+
 nyOj4iESfM8yLbxFDSozpssPRDSa1bs5rcIKCS9ifip8SS5DBgI2G21gBwWJgzi+irQ9mGf68t4
 z6ypdANOOLrc2yuW2/FjiGTpXSJEFmEc+thnpYU5ct2qgD5wCSlKbIcv4DfYefwNPddoHiiFqMM
 mMFxxu6mM2VSw25X+r/hjbMIHkpKXgmttm41DxlhnJkv/ykgpPD+dqOl2fjbZaj5eiHXZzYtUiJ
 ULo9/3+Vj+wYDre3A0w==
X-Proofpoint-ORIG-GUID: P0nSI3DxMi7Xn7rHw-jTPPjNinI28Uhu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE1OSBTYWx0ZWRfX/1wj220Wt915
 zTu/jtGTVRB8vSavWgeZSAMgNizOhTWrlE+gxrsjUyZmn1+BBdBDIy4AjqlxmpCm2U5loZ/rDnq
 eKwsGYOHLSOPmJvA/Q0awaT1W+sugEo=
X-Proofpoint-GUID: P0nSI3DxMi7Xn7rHw-jTPPjNinI28Uhu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240159

On 7/23/26 4:38 PM, Eric Farman wrote:
> 
> 
> On 7/23/26 2:29 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential
>> issue(s) to consider:
>>
>> New issues:
>> - [Low] Applying a bitwise shift directly to a restricted `__bitwise`
>> type (`dma64_t`) and implicitly casting it strips type annotations,
>> triggering sparse warnings.
>>
>> Pre-existing issues:
>> - [High] `get_guest_idal` reads too many bytes for Format-1 IDALs,
>> potentially causing spurious failures for valid channel programs.
>> -- 
>>
>> --- Patch [4]: [PATCH v3 4/8] s390/vfio_ccw: ensure first IDAW remains
>> constant ---
>> commit e8a4291c688f39a3fdc915242b5bb6676e357ac5
>> Author: Eric Farman <farman@linux.ibm.com>
>>
>> s390/vfio_ccw: ensure first IDAW remains constant
>>
>> This commit ensures the first IDAW in a list is read separately to
>> accurately
>> calculate the buffer size needed. It verifies that the address found
>> in the
>> first IDAW is unchanged between reads to maintain consistency.
>>
>>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/
>>> vfio_ccw_cp.c
>>> index 258a99930c6a0..06b6bc6142a0f 100644
>>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
>>> @@ -533,6 +533,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw,
>>> struct channel_program *cp, int
>>>           &container_of(cp, struct vfio_ccw_private, cp)->vdev;
>>>       dma64_t *idaws;
>>>       dma32_t *idaws_f1;
>>> +    u64 first_idaw;
>>>       int idal_len = idaw_nr * sizeof(*idaws);
>>
>> [Severity: High]
>> This is a pre-existing issue, but does get_guest_idal() read too many
>> bytes
>> for Format-1 IDALs here?
>>
>> Because idal_len is calculated using sizeof(*idaws) which evaluates to 8
>> bytes, instead of the actual 4 byte IDAW size for Format-1 IDALs,
>> vfio_dma_rw() will attempt to read idaw_nr * 8 bytes.
>>
>> If a guest VM submits an I/O request with a Format-1 IDAL that fits
>> exactly
>> at the end of a mapped page, this could cross the page boundary into an
>> unmapped page and cause the DMA read to fail, spuriously rejecting a
>> valid
>> request.
>>
>> [ ... ]
>>
>>> @@ -549,6 +550,17 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw,
>>> struct channel_program *cp, int
>>>               kfree(idaws);
>>>               return ERR_PTR(ret);
>>>           }
>>> +
>>> +        if (cp->orb.cmd.c64)
>>> +            first_idaw = dma64_to_u64(idaws[0]);
>>> +        else
>>> +            first_idaw = dma32_to_u32(idaws[0] >> 32);
>>
>> [Severity: Low]
>> Does applying a bitwise shift directly to a restricted __bitwise type
>> like
>> dma64_t and passing it to dma32_to_u32() trigger sparse warnings?
>>
>> Since idaws[0] is of type dma64_t (__bitwise u64) and dma32_to_u32()
>> expects
>> a dma32_t (__bitwise u32), this implicitly strips type annotations.
>>
>> Should this be explicitly cast using (__force u64) before shifting to
>> avoid
>> violating sparse type rules?
> 
> Probably a better solution to this is:

Oh, I missed this reply.  Yep, that makes sense.

So with the change below:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/
> vfio_ccw_cp.c
> index 06b6bc6142a0..08be6d5a99f3 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -551,10 +551,11 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw,
> struct channel_program *cp, int
>                         return ERR_PTR(ret);
>                 }
> 
> +               idaws_f1 = (dma32_t *)idaws;
>                 if (cp->orb.cmd.c64)
>                         first_idaw = dma64_to_u64(idaws[0]);
>                 else
> -                       first_idaw = dma32_to_u32(idaws[0] >> 32);
> +                       first_idaw = dma32_to_u32(idaws_f1[0]);
> 
>                 /* Unexpected mismatch from earlier read */
>                 if (first_idaw != cp->guest_iova) {
> 
> 
>>
>>> +
>>> +        /* Unexpected mismatch from earlier read */
>>> +        if (first_idaw != cp->guest_iova) {
>>> +            kfree(idaws);
>>> +            return ERR_PTR(-EINVAL);
>>> +        }
>>>       } else {
>>>           /* Fabricate an IDAL based off CCW data address */
>>>           if (cp->orb.cmd.c64) {
>>
> 


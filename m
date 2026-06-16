Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22523C063F;
	Tue, 16 Jun 2026 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621649; cv=none; b=gNRTtSHyQckFQKSARNgG82iTOkpeoDfu8r2IWlhy8B4pnNJWV0bu2aTkkJ6EaQREEq9MC0jyynLnaq2UUlsImKzsBp6uQV98baf/vKJZzEpUYY2F8BsD76TlK2zez7sZYQrglnk6/tZ6n9quSu9BL2msk//K9ZG95+C+vWJ5x0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621649; c=relaxed/simple;
	bh=+KcgMYMMD+KuHhREcBgmyUVl+Dnk/gARVOdMr6X+olI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAE4Gcznh4VkW0i8hXStFNLEfuxkaVIbkRebtUucwqZAQQSHxtsgijzu7VEcgsoxwOuTiHu79+g6IEZL9QTi1BnACKz4hQl3J+fKjDZk3yGdZUELy63DnnsOMhWMcvlC8ltmY6w3FQ/HB9Tm/lAfcS0FqltW0nLGMGcdmDhSfTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hFMeVlfr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hFMeVlfr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GEIeAH1673457;
	Tue, 16 Jun 2026 14:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DRdxeZ
	5SshvjWgEvhuzvZReA8eXY9OnUcM5NT73ix/0=; b=hFMeVlfrZIlTBjK9gQKMP+
	F+lJJpZ2xxZ/Cj8i8Po+0sDYNEem6/EbOpZYLFKISRmi0jYUsNxFn7sIJAFL6TVx
	9uG4urwzjj6cBxFESPLSiT71x26ZLH/4kPBY4N384jYKYgb1XirJwKUhU0vGPWDI
	kBC+CnoyhsGGaQFqknQi0aAcDXP2q3uVXEidMx82SG8YFdXBFthovYF7vSVKxO8l
	btYIVpRS+CSYHRUEa8oKeojftFr9lZgFhZL/YMxnxqMP1qfU7diD7k8E1JGOoHgw
	mHpySRxaK8X562AB9Rqsc0fGNfRvEsJH22c1YKRjD5rbsPH0cLR+GNSe1YYbt4bg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg5sh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 14:54:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GEncYN011261;
	Tue, 16 Jun 2026 14:54:03 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshww404w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 14:54:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GEs1M026280582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 14:54:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D27835805E;
	Tue, 16 Jun 2026 14:54:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CAC458054;
	Tue, 16 Jun 2026 14:53:59 +0000 (GMT)
Received: from [9.111.180.184] (unknown [9.111.180.184])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 14:53:59 +0000 (GMT)
Message-ID: <6356a2be-a49b-4ac4-b52e-dd84bd4ff7b5@linux.ibm.com>
Date: Tue, 16 Jun 2026 16:53:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: Also suppress -EINVAL on device
 detach
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
        William Bezenah <wbezenah@linux.ibm.com>, vneethv@linux.ibm.com
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, mjrosato@linux.ibm.com,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260612155407.199218-1-wbezenah@linux.ibm.com>
 <20260615002309.052e0614.pasic@linux.ibm.com> <875x3jn94r.fsf@redhat.com>
 <4d7fc371-4357-496f-9774-1f7a7c1a3091@linux.ibm.com>
 <20260615234246.0ec5d947.pasic@linux.ibm.com>
 <2e543ef5-1aa8-4ddc-a68a-103c7bdfe58d@linux.ibm.com>
 <8733ymn8vd.fsf@redhat.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <8733ymn8vd.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1MSBTYWx0ZWRfXwiuz08QPyjMJ
 uD65jRN4d48c+AmwN3IYvE7jMA/qD8sDMhPu3PIkEWnCH4Cb30myb4N0glqloNl55xE/zkbZbj6
 duvk/aon0yLzHioHPb/hRYKmVJyhKMY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1MSBTYWx0ZWRfX5c44wfQ927zr
 aeOwCyS5xzerauj/b2eMDvpMUzbW095fXaMdHTyG+21ffxddv/ayqdJVTm9+Sw9yQRk+inHfIOF
 IHG+lnR4Cp39UUZzaMs7r71fgC6TZnmMxEq1Ees//f3HBedxP+tVuHRkoZ6k8MdWk2MKwkD0LOD
 voXr8OpZiTkMJjwyLWztbFadMMU0aSe5ScC7iC73A67Aq9syS7Lvgeq1GgNGK1KJD+N1fG+8PrQ
 dYGHVBmiVQLDMjAYaSKwoiw8o0bJL7gb9gEFbeLxpMDz/o9+grkBFo8PR5DfunttEiHOchuiVLF
 2iOLXbXiz/pbDvakCssQHbEPoGYVlZTbPZOj0llpvAryqaZJ3Qn8dtz6i4Ina4P+xPEDBkhm/5J
 1vyyBlC1Ihs7hMAWPccCUrAuDvnsPVTA1Qi80tZvATj6CRrYQOhc+Rs6Srnw8ZVRwrWW7MjrHVf
 7ZIfJzlgGFzIqVbegcQ==
X-Proofpoint-GUID: wItAubSkpMPvEUNx-xdSOmOJyHuZd8Tn
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a31638b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=JxTIInlSnpDs0fHktd0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wItAubSkpMPvEUNx-xdSOmOJyHuZd8Tn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160151

On 16.06.2026 11:16, Cornelia Huck wrote:
> On Tue, Jun 16 2026, Peter Oberparleiter <oberpar@linux.ibm.com> wrote:
> 
>> On 15.06.2026 23:42, Halil Pasic wrote:
>>> On Mon, 15 Jun 2026 16:01:55 -0400
>>> William Bezenah <wbezenah@linux.ibm.com> wrote:
>>>
>>>> On 6/15/2026 10:58 AM, Cornelia Huck wrote:
>>>>> On Mon, Jun 15 2026, Halil Pasic <pasic@linux.ibm.com> wrote:
>>>>>  
>>>>>> On Fri, 12 Jun 2026 17:54:07 +0200
>>>>>> William Bezenah <wbezenah@linux.ibm.com> wrote:
>>>>>>  
>>>>>>> Since commit 8c58a229688c ("s390/cio: Do not unregister the
>>>>>>> subchannel based on DNV"), subchannel behavior following a device
>>>>>>> detach has been updated and results in -EINVAL being propagated
>>>>>>> rather than -ENODEV, originating from ccw_device_start_timeout_key()
>>>>>>> in cio/device_ops. In the end, the virtio driver has no ability to
>>>>>>> react to the difference between device and subchannel states here,
>>>>>>> and during detach, both -ENODEV and -EINVAL indicate the device
>>>>>>> cannot be used and should not be treated as errors requiring
>>>>>>> attention. Update error handling in virtio_ccw_del_vq() and
>>>>>>> virtio_ccw_drop_indicator() to suppress -EINVAL in addition to
>>>>>>> -ENODEV.  
>>>>>> Hi William!
>>>>>>
>>>>>> Are you saying that ccw_device_start() started returning -EINVAL
>>>>>> since 8c58a229688c ("s390/cio: Do not unregister the subchannel based on
>>>>>> DNV")? Or did I somehow read the paragraph wrong?
>>>>>>
>>>>>> The funcition ccw_device_start is documented to return:
>>>>>>  * Returns:                                                                     
>>>>>>  *  %0, if the operation was successful;                                        
>>>>>>  *  -%EBUSY, if the device is busy, or status pending;                          
>>>>>>  *  -%EACCES, if no path specified in @lpm is operational;                      
>>>>>>  *  -%ENODEV, if the device is not operational. 
>>>>>> and the commit message does not say a thing about introducing -EINVAL to
>>>>>> the mix.  
>>>>> The function may return -EINVAL for non-enabled subchannels
>>>>> (i.e. pmcw.ena == 0), maybe we get an all-zeroes schib with dnv == 0?
>>>>> I'd expect it not to be enabled in that case anyway.  
>>>>
>>>> Yep, that's at least how I've come to understand what changed. The
>>>> function ccw_device_start_timeout_key() has always returned -EINVAL
>>>> for non-enabled subchannels (pmcw.ena == 0), though it's not
>>>> documented in the header.
>>>
>>> Wasn't his -EINVAL actually introduced by commit:
>>> 823d494ac111 ("[S390] pm: ccw bus power management callbacks")?
>>
>> In the context of virtio-ccw added in 2012, an EINVAL return code
>> introduced in 2009 might be considered "always" :)
> 
> :)
> 
> I'm wondering whether we should still expect to hit the "ssch with
> ena==0" situation, given that pm support has been removed again in the
> meanwhile. (Well, other than in situations like this, where it is a
> follow-up to other problems.) IOW, can callers expect not to see
> -EINVAL, unless they are doing something really stupid?

As Halil also pointed out, this would be a programming error, either on
the side of the driver that starts I/O without setting the device
properly online, or in the common I/O layer (hopefully not, but you
never know). Having a dedicated return code to identify this situation
is definitely useful, and we'll also consider documenting it accordingly
in the function comment.

>>>> What changed with commit 8c58a229688c is that cio_update_schib() now
>>>> updates the schib even when DNV=0, rather than returning early as it
>>>> did previously. Somehow this update results in pmcw.ena == 0 in
>>>> ccw_device_start_timeout_key(). Previously, it saw pmcw.ena == 1 and
>>>> moved to the condition (cdev->private->state == DEV_STATE_NOT_OPER)
>>>> where it returned -ENODEV.
>>>
>>> Sounds fishy to me. As far as I understand the DNV takes precedence over
>>> all other pieces of PMCW.
>>
>> And you're right about that! The Principles of Operation states (p. 15-4
>> in SA22-7832-14 [1]) that the contents of all other fields in the PMCW
>> are unpredictable when DNV is 0, therefore 8c58a229688c is in error.
>>
>> I'll work with Vineeth to determine how to fix this issue, potentially
>> via manually clearing some relevant SCHIB fields instead of copying the
>> unpredictable results of the STSCH instruction.
> 
> Can't you zero the whole SCHIB, or do you still need some of the
> measurement block things for cleanup?

I faintly remember that there WAS a reason to use the remainder of the
SCHIB contents because of some unwanted effect that occurred if we
didn't, but I don't recall the details. We'll need to dig up the
associated bug report to understand it and determine if we can simply
clear all of the SCHIB, or need to keep some of the information intact.

>>>> So the commit didn't introduce -EINVAL as a new return value, rather,
>>>> it changed the subchannel lifecycle such that existing paths now
>>>> propagate -EINVAL rather than -ENODEV during the device detach
>>>> scenario.
>>>
>>> I'm not convinced returning -EINVAL in the given situation is the
>>> right thing to do. Peter, would you mind to chime in?
>>
>> I tend to agree that an attempt to start I/O for a subchannel that has
>> DNV 0 should result in ENODEV rather than EINVAL, though the latter is
>> still valid when a driver tries to start I/O on a subchannel that is not
>> enabled for I/O.
>>
>> We'll make sure to design the fix for 8c58a229688c in away that ENODEV
>> will be returned when DNV is 0. Assuming that this is the only situation
>> where virtio-ccw's ccw_io_helper() receives -EINVAL from
>> ccw_device_start__timeout_key() during detach, the subject patch should
>> no longer be necessary.
> 
> I agree, I'd not expect to get -EINVAL in ccw_io_helper().
Yeah, this was definitely an unexpected side effect of the DNV commit.


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E47935A384;
	Tue, 16 Jun 2026 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596773; cv=none; b=NkwdpfmYS0WOYqcAp48rAgQ0QRNB9SJYVoMqHemr/L7gxEpxbDLI+Iy8pSSCO02LXBAwRIM1dopybxBeu1fjBxjBKt89nvbPokxPcGzhX5KRv521N8dOm8GpvxJV2tv/8zCpzyhxGC4L5ivMHj/kYROMwhBdUAjDrR+v8CuXoJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596773; c=relaxed/simple;
	bh=WmOevG+MfehdwRgCvitcae6SLcc/cB6j0A/135Qmwt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+TfchdffX9hvcO8/dHL9LAB5phGGZBPpEqK3vIFP0HLKmDR2Ysa0RKODSf5g7UfnS7yVx8rOkXRw/5Y8kRxCD5WEIymHBcl0XhqZAVq6zETYQhpFNEY3JmJJPckms6GNQEcszWo2St6KLrljKHtNX5Zd32ICTIh35QuGhHdUVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=asgd4HER; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="asgd4HER"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G6IFKt563382;
	Tue, 16 Jun 2026 07:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=alQMTb
	DCljflyTyRM/budj//8mXRwpxXo+3VJLEqytc=; b=asgd4HERq+n/x/wcAEemfN
	XNkXldd/D3UVse6BubVaJD0QiYoYbmVo6+L3PJpoJu4fLimZ1ZrnQRgHzBVResEO
	Svt0OFFQPAiVYjX2tQoOOQTwffjhXsis4bYHt8W/IKp0TLc40psPVdMaraB4jSy2
	T2r8dBNAiR4GrgW1c7h5jNU10BX6cdS5Bxdn8qS+gJwC0kVerGpXDJ+evdQYb7IV
	mJErWsNFPJV0Difg7T0KV/r4BjplANu1K6Yuv1kJpEPFyyGrsFHadGYDkTpbSK+K
	rG/1zldVk+3C2ee8fEMdArSNCa+WJFlOeHy/kzQwmet8KfB8xuGRHfy464MpO+DA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h84kfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 07:59:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65G7naXp012272;
	Tue, 16 Jun 2026 07:59:27 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshww2eqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 07:59:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65G7xPrt19071546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 07:59:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A91958062;
	Tue, 16 Jun 2026 07:59:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7CCC58056;
	Tue, 16 Jun 2026 07:59:22 +0000 (GMT)
Received: from [9.111.180.184] (unknown [9.111.180.184])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 07:59:22 +0000 (GMT)
Message-ID: <2e543ef5-1aa8-4ddc-a68a-103c7bdfe58d@linux.ibm.com>
Date: Tue, 16 Jun 2026 09:58:38 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: Also suppress -EINVAL on device
 detach
To: Halil Pasic <pasic@linux.ibm.com>,
        William Bezenah <wbezenah@linux.ibm.com>, vneethv@linux.ibm.com
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org,
        farman@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        mjrosato@linux.ibm.com, virtualization@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260612155407.199218-1-wbezenah@linux.ibm.com>
 <20260615002309.052e0614.pasic@linux.ibm.com> <875x3jn94r.fsf@redhat.com>
 <4d7fc371-4357-496f-9774-1f7a7c1a3091@linux.ibm.com>
 <20260615234246.0ec5d947.pasic@linux.ibm.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260615234246.0ec5d947.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA3NyBTYWx0ZWRfX2snOj0WtUw3R
 GxgkBbWnQy0A6ruHO1csFCx9fSaPlwraM/hmYEfalKdza3VKJ2GCQfi1rOmFG23so5k/BmlXlLM
 +mRf4V838zsF5kfbi0HDXhevQF8FARg=
X-Proofpoint-ORIG-GUID: -yQ1AlMq28aMpEg9wiooiBufe9kYU99y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA3NyBTYWx0ZWRfXyRubUlMV737n
 i48fGpvoEAv06fmBwYnphNnVnPcbJsrrBH260UTQ7LnajtWvRVB+GBNQ6QRcDln8XUW01HMXoOx
 ayat7jb2B0kgm0piwInTc5N40jAtWYSglfPLFe18iI9HSgbG2APp2VrPlzKnFZ3sswnIY80MB1V
 /noQns8wkaYET6SbU5ldIo+iARFL5h2mN8T19TttOhrf0yljg0OR8R5Y+BbuIo4DwQbFMC9jlDq
 UlE1tNVWKv+Wuk87KgbRKj2AmEn7PmE8fK60KSBTZqi9MnabrBcXpBkS8+A8TLjg+p8fN+YN/k6
 k5z0MdkMpw2LrBYRoOIAx2m7lmb8KtbwS2xG0aTxZb76vt81v/tSf+lXrUO23Vf8KEfB8MVnS3W
 8N+XovLmXrWrJC39xyMCY9qm8qPpAyO3h5wRTF+IESsGozcw23wiruaQ6RaJmqCpv4kvN1T36e/
 g+xedzf/wed9Kyx9+kw==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a310260 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=_897DxvIdcy9fRa9VuYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -yQ1AlMq28aMpEg9wiooiBufe9kYU99y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160077

On 15.06.2026 23:42, Halil Pasic wrote:
> On Mon, 15 Jun 2026 16:01:55 -0400
> William Bezenah <wbezenah@linux.ibm.com> wrote:
> 
>> On 6/15/2026 10:58 AM, Cornelia Huck wrote:
>>> On Mon, Jun 15 2026, Halil Pasic <pasic@linux.ibm.com> wrote:
>>>  
>>>> On Fri, 12 Jun 2026 17:54:07 +0200
>>>> William Bezenah <wbezenah@linux.ibm.com> wrote:
>>>>  
>>>>> Since commit 8c58a229688c ("s390/cio: Do not unregister the
>>>>> subchannel based on DNV"), subchannel behavior following a device
>>>>> detach has been updated and results in -EINVAL being propagated
>>>>> rather than -ENODEV, originating from ccw_device_start_timeout_key()
>>>>> in cio/device_ops. In the end, the virtio driver has no ability to
>>>>> react to the difference between device and subchannel states here,
>>>>> and during detach, both -ENODEV and -EINVAL indicate the device
>>>>> cannot be used and should not be treated as errors requiring
>>>>> attention. Update error handling in virtio_ccw_del_vq() and
>>>>> virtio_ccw_drop_indicator() to suppress -EINVAL in addition to
>>>>> -ENODEV.  
>>>> Hi William!
>>>>
>>>> Are you saying that ccw_device_start() started returning -EINVAL
>>>> since 8c58a229688c ("s390/cio: Do not unregister the subchannel based on
>>>> DNV")? Or did I somehow read the paragraph wrong?
>>>>
>>>> The funcition ccw_device_start is documented to return:
>>>>  * Returns:                                                                     
>>>>  *  %0, if the operation was successful;                                        
>>>>  *  -%EBUSY, if the device is busy, or status pending;                          
>>>>  *  -%EACCES, if no path specified in @lpm is operational;                      
>>>>  *  -%ENODEV, if the device is not operational. 
>>>> and the commit message does not say a thing about introducing -EINVAL to
>>>> the mix.  
>>> The function may return -EINVAL for non-enabled subchannels
>>> (i.e. pmcw.ena == 0), maybe we get an all-zeroes schib with dnv == 0?
>>> I'd expect it not to be enabled in that case anyway.  
>>
>> Yep, that's at least how I've come to understand what changed. The
>> function ccw_device_start_timeout_key() has always returned -EINVAL
>> for non-enabled subchannels (pmcw.ena == 0), though it's not
>> documented in the header.
> 
> Wasn't his -EINVAL actually introduced by commit:
> 823d494ac111 ("[S390] pm: ccw bus power management callbacks")?

In the context of virtio-ccw added in 2012, an EINVAL return code
introduced in 2009 might be considered "always" :)

>> What changed with commit 8c58a229688c is that cio_update_schib() now
>> updates the schib even when DNV=0, rather than returning early as it
>> did previously. Somehow this update results in pmcw.ena == 0 in
>> ccw_device_start_timeout_key(). Previously, it saw pmcw.ena == 1 and
>> moved to the condition (cdev->private->state == DEV_STATE_NOT_OPER)
>> where it returned -ENODEV.
> 
> Sounds fishy to me. As far as I understand the DNV takes precedence over
> all other pieces of PMCW.

And you're right about that! The Principles of Operation states (p. 15-4
in SA22-7832-14 [1]) that the contents of all other fields in the PMCW
are unpredictable when DNV is 0, therefore 8c58a229688c is in error.

I'll work with Vineeth to determine how to fix this issue, potentially
via manually clearing some relevant SCHIB fields instead of copying the
unpredictable results of the STSCH instruction.

>> So the commit didn't introduce -EINVAL as a new return value, rather,
>> it changed the subchannel lifecycle such that existing paths now
>> propagate -EINVAL rather than -ENODEV during the device detach
>> scenario.
> 
> I'm not convinced returning -EINVAL in the given situation is the
> right thing to do. Peter, would you mind to chime in?

I tend to agree that an attempt to start I/O for a subchannel that has
DNV 0 should result in ENODEV rather than EINVAL, though the latter is
still valid when a driver tries to start I/O on a subchannel that is not
enabled for I/O.

We'll make sure to design the fix for 8c58a229688c in away that ENODEV
will be returned when DNV is 0. Assuming that this is the only situation
where virtio-ccw's ccw_io_helper() receives -EINVAL from
ccw_device_start__timeout_key() during detach, the subject patch should
no longer be necessary.


[1] https://www.ibm.com/docs/en/module_1678991624569/pdf/SA22-7832-14.pdf

-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D

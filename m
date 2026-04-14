Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190A9375F69;
	Tue, 14 Apr 2026 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776200801; cv=none; b=u3YJPfmbijyAoo9NA4KJf1YKFucG2dGNWHaBqAf+qem8GkNWk2/cMiFP87fQOLZzoWnqPfWDNhVLhiptgats9dLdyXVGAOWT0crn7s9+OVT0liYrai6DISfdcn1sBAql2uLO+prYrm7+ag2Ym+Es2yr3hvcRlqm9wU3vbEPqijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776200801; c=relaxed/simple;
	bh=0eqcVAJWSX/W0HjnY8IjzDHeLzD4g5oztWf/V5RI6UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFDC4b4S0QEX4mRD0kPwFh0s6jA2meWwroAfPJrYzhGvYQpFYeOJT1F3cytR+FATXbs1D3w21Gix2x1LRKftGbF8yy+MK9rDtxSJiBqdjCW6Hi2PWDaTpfkk1wZGqwPevC4oL7snqliWPJ/7pMVdRJvLgGcHaWfOlYWYQvtL++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nJDVft1G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nJDVft1G"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EEgwZ11734239;
	Tue, 14 Apr 2026 21:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xqostE
	CAIlXCSPHLFQl/SCSIqNIXiec7UAF0E3+iqu4=; b=nJDVft1GbpCrWiqQyiZRPv
	O9uwuFoWgUHdegCWQ5YKH0zofocmPrZL+i4QD/CgGwpRT6MTijR4Uo+XVnOsj0Sj
	mYhiJmaYUZ2taW1iXdJxPu50SToi4g8IVAID5YGhHD8autYylT+kC+8/CSB82VWn
	60JR0K9CpW7h+iDDKqY5HMYJTZ0gdK+RQgPCM80pZwDI4/Ien0FF8/kNUZjou1Wu
	48J6W9srtrj0b1ijtoAp1Qw75Dt9usYPZ8iIL3kM37VhbXwxyEfwMJuqQi9N+4VW
	iHY0xDJgD2kF/o2LHlgPD/jDlfaNaCPs3SCJGgat56JP0DHlfBuYgyvfGSCEUA5A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89m4ven-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 21:06:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63EHGKa0031099;
	Tue, 14 Apr 2026 21:06:33 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10ybmxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 21:06:33 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63EL6VM528246540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 21:06:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E128658063;
	Tue, 14 Apr 2026 21:06:31 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE02B5804B;
	Tue, 14 Apr 2026 21:06:30 +0000 (GMT)
Received: from [9.61.247.90] (unknown [9.61.247.90])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 21:06:30 +0000 (GMT)
Message-ID: <34f59b3b-dc28-4fd3-b2d6-d34bc4fd297c@linux.ibm.com>
Date: Tue, 14 Apr 2026 14:06:31 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 5/7] vfio-pci/zdev: Add a device feature for error
 information
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
        clg@redhat.com, kbusch@kernel.org, mjrosato@linux.ibm.com
References: <20260413210608.2912-1-alifm@linux.ibm.com>
 <20260413210608.2912-6-alifm@linux.ibm.com>
 <20260413165758.0f87312b@shazbot.org>
 <cd9d7977-8b36-428c-81f2-c14b66173763@linux.ibm.com>
 <20260414081238.23e2cecc@shazbot.org>
 <5f26af4c-9584-4c70-9702-0a3bcd0c4ad1@linux.ibm.com>
 <20260414114132.31481b48@shazbot.org>
 <9d68b944-bd65-495b-b69c-e0d6758f15ee@linux.ibm.com>
 <f20c8b1c6cd7fefbe3fbeea1055d41bea009b5ba.camel@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <f20c8b1c6cd7fefbe3fbeea1055d41bea009b5ba.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69deac59 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=1b2_H57lPKfI2HTGgoQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: j9kVDP58I3JX55hzCEeCHV7Nrb1Gc6Xc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE5NCBTYWx0ZWRfX9aTcOc8LhNJR
 ZasRoLujPS+rQWH+DE4zOdg7r/kGzVeAjWkTs3uuxPc/ImdVveE9vwvGhUZVY2R9PyjZhHi89PA
 oY6m+GsULGMKRxT1y8ZIYNzX7oy2azcFMOJnXL0vOM7OQBTM7SY6v6uyimPjq0J8cBJ+/JLa0Hx
 HwklhSLXYooaVjfjUPno3gToU21jfoddm3uOUdUkxEOfJf39gF6q1JH8lTF2IL7PNIfePSagajL
 mQ9eah5rRAVqNn6uM+R/OFXneYXFkkiB12vrhJx2XglijltdZH4eS1PGGUj0j8vwEBhlstk6s0k
 nvhIKSh9cpv8HM1ZqgoYpimtylw81gUyZxTMtZGGri0L18CBkS59juHJqd03Xxpy0Whrnphn94X
 e7fh1FjWxFIYWhmU21u7/qUbQyq7TyLcOc+SD7GtZGDunmPsqjeQ57F033x7C1tQFNuSvz1d8kt
 A3e26gz18/AoZLgcfQA==
X-Proofpoint-ORIG-GUID: j9kVDP58I3JX55hzCEeCHV7Nrb1Gc6Xc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140194


On 4/14/2026 12:43 PM, Niklas Schnelle wrote:
> On Tue, 2026-04-14 at 11:45 -0700, Farhan Ali wrote:
>> On 4/14/2026 10:41 AM, Alex Williamson wrote:
>>> On Tue, 14 Apr 2026 10:13:22 -0700
>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>> On 4/14/2026 7:12 AM, Alex Williamson wrote:
>>>>> On Mon, 13 Apr 2026 16:40:49 -0700
>>>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>>>> On 4/13/2026 3:57 PM, Alex Williamson wrote:
>>>>>>> On Mon, 13 Apr 2026 14:06:06 -0700
>>>>>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>>>>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>>>>>> index 5de618a3a5ee..2980ca39dd38 100644
>>>>>>>> --- a/include/uapi/linux/vfio.h
>>>>>>>> +++ b/include/uapi/linux/vfio.h
>>>>>>>> @@ -1534,6 +1534,26 @@ struct vfio_device_feature_dma_buf {
>>>>>>>>       */
>>>>>>>>      #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>>>>>>>>      
>>>>>>>> +/**
>>>>>>>> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
>>>>>>>> + * userspace for vfio-pci devices on s390x. On s390x, PCI error recovery
>>>>>>>> + * involves platform firmware and notification to operating system is done
>>>>>>>> + * by architecture specific mechanism. Exposing this information to
>>>>>>>> + * userspace allows it to take appropriate actions to handle an
>>>>>>>> + * error on the device. The pending_errors provide any additional errors
>>>>>>>> + * pending for the device, and userspace should read until zero. A value of
>>>>>>>> + * 0 for pending_errors and pec would indicate no pending errors that need
>>>>>>>> + * to be handled.
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +struct vfio_device_feature_zpci_err {
>>>>>>>> +	__u8 version;
>>>>>>>> +	__u8 pending_errors;
>>>>>>>> +	__u16 pec;
>>>>>>>> +};
>>>>>>> I assume .version is for compatibility, but we don't define a strategy
>>>>>>> for using it or specify what the version should be for this table.  It
>>>>>>> doesn't seem like there's actually an value-add to having it.
>>>>>> Its possible we may need to extend this structure in the future if we
>>>>>> want to report more information to userspace. I at least want the
>>>>>> flexibility to do so. We had some discussion around this [1] in an
>>>>>> earlier version. I was trying to follow similar versioning pattern we
>>>>>> had around vfio-pci/zdev structures.
>>>>> IMHO, the version field is a dead end towards achieving this,
>>>>> especially if we don't specify from the onset the expected version
>>>>> value or the compatibility semantics.  All that's going to happen is
>>>>> that some userspace will hard code that it understands version 1
>>>>> because that's what's currently reported and matches the struct defined
>>>>> here, and you can never ever report anything other than version 1
>>>>> without breaking that user.  At that point you need to come up with
>>>>> some other means for the user to opt-in to a new version, whether it's
>>>>> triggered by another feature (as we did with the PRECOPY_INFOv2 above
>>>>> this), or we reimplement the whole v2 feature.
>>>> My understanding was based on how we version some of the capability
>>>> structures for zdev (in include/uapi/linux/vfio_zdev.h). If we wanted to
>>>> provide more information to userspace in the future, what would be
>>>> preferred approach? Do we need to explicitly define a v2 feature? I am
>>>> open to suggestions on this.
>>>>
>>>> If we need to define v2 explicitly in the future, then yes I agree we
>>>> can simplify it to return only the PEC code (or an error code otherwise).
>>> Maybe I'm reading too much into it, but it sounds like you already have
>>> plans to expand this.
>>>
>>> The existing zdev structures seem to rely on the version field in the
>>> capability header and maybe you've gotten away with bumping the version
>>> without breaking userspace, but it's fragile.  AFAICT, the ioctls do not
>>> define a versioning strategy where vN+1 only adds fields to vN, so all
>>> it takes is one outspoken userspace tool that hard codes its
>>> compatibility to a specific version to become a problem for further
>>> updates.
>>>
>>> Likewise this feature doesn't define a versioning policy for userspace
>>> to follow.  I'm sure there are other examples within vfio that are
>>> problematic, but let's try not to create more.
>>>
>>> If you want to use a version, then also define what the version is and
>>> what the compatibility policy is for future versions.  A flags field is
>>> another option that we've used extensively in vfio.  The version field
>>> might be better for incremental expansion of the structure, while flags
>>> can address specific fields more directly, ex. a reserved field being
>>> redefined.  Thanks,
>>>
>>> Alex
>> Just wanted to understand and clarify if we can associate multiple
>> fields with a feature flag? I think in that case flags would be better
>> here and given its also something that is widely used in vfio. I am just
>> trying to figure out the best way we can extend this without a lot of
>> code churn in the future.
>>
>> I appreciate the feedback and discussion on this.
>>
>> Thanks
>>
>> Farhan
> Here is an idea. I think we even discussed this internally at some
> point. How about we just use the architected CCDF Error Event (i.e.
> basically struct zpci_ccdf_err with possible uAPI type adjustments) as
> the data user-space reads. The bit definitions of it are already part
> of the architecture and it has provisions for extensibility based on
> s390 architecture principles which have worked quite well for forward
> compatibility. If we additionally make it possible to query its length
> as kind of a version it could even grow. I think this would also work
> well with the idea of returning an error on read if there are no more
> error events and user-space reading again and again until it sees the
> error. I agree with Alex that this seems much easier to get right than
> a pending_errs count. As a bonus we can immediately expose all the
> error event information Linux currently uses. That said, I would opt to
> setting the struct fields by copying field by field explicitly and
> leaving reserved fields 0 such that we don't pass-through any bits a
> future platform may add without having a defined field in Linux.
> Thoughts?
>
> Thanks,
> Niklas

My concern with exposing the entire struct zpci_ccdf_err was it could be 
error prone trying to keep the struct and vfio uAPI struct in sync. Just 
thinking out loud, to query the length we would need a different vfio 
device feature bit? But if it makes for a better uAPI, I can make the 
change. Thanks

Farhan



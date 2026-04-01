Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5E43DA5B;
	Wed,  1 Apr 2026 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050755; cv=none; b=stgxkkK/ExHrRDsnrazNUHwf85+IaaAYiKfNbNeJt1k5zzSZi8gx3ZYF/RKKZn5hD41gAQv1CDVbKzrdyTYBAX0vAoZdnokplXSLKnzVEVEdJCSglXJut68rflqoM99iJOd77/KY43IpDIFq2BAxTIBvVCygWFf14MKwvteD3CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050755; c=relaxed/simple;
	bh=HPe2uhLe8egBYWk4y8Vso4BCVhCEjvs6VpRaWipin7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4pMjweeiV9Zn10EmG/qCb7SenAlme7YusMDy75JF3IZB08v3wsN9rTwjSukderkEExNz9KMcQhxAurykeJj8viBggZbPjptDp6fn4GNkAxhtBJvRaMJL0hJbA+TCw8sorks2BewHOCMf6mQhIXrKv4Ew/FNfDjzi3MHxcZsQnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZnV3mi4Y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZnV3mi4Y"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6316ioXG3351854;
	Wed, 1 Apr 2026 13:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Soc+N+
	/2CsWLepOHsjDxwGsKdem+97KixeUgZHc2nvI=; b=ZnV3mi4YodeXqHR5utLCAD
	f9+04/FDkpP2K0OJrLA1s8IEZEBYn5snBXqpdvcNtDsxEbVHB0Ky5K8vXdp8sL3A
	fGH/jIv8zOFllnZ7bAKqMuRa48GXVhLx+S0+viuGarbfrIxG6WSOg3G/JTAp+dUi
	8mkEUc1nln8JDX9NDRHVopfVqRuJa2AaAfzawHw9ZpBY/C2MuTofsr8+rAjHSHYi
	VS9vU6CfNBZYxMVpsTl8bgEA9XMv+DCqCWRGXJscdb++Yii2sJfCRAUOQ9j7as57
	jip2HDOQpis1AgO/9hGPsNQIlNcJGoLkREm6Uddc7CDTNUQONsQxcUw2JZUjSZog
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q38aew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 13:39:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631AwcRH005980;
	Wed, 1 Apr 2026 13:39:03 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy5u5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 13:39:03 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631Dd2oh44171596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 13:39:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3712D58062;
	Wed,  1 Apr 2026 13:39:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D16758054;
	Wed,  1 Apr 2026 13:39:00 +0000 (GMT)
Received: from [9.61.133.81] (unknown [9.61.133.81])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 13:39:00 +0000 (GMT)
Message-ID: <3f320ef3-c539-4671-8fbf-283ea9f48633@linux.ibm.com>
Date: Wed, 1 Apr 2026 09:38:59 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/23] s390/vfio-ap: Implement live guest migration of
 guests using AP devices
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, jjherne@linux.ibm.com, borntraeger@de.ibm.com,
        mjrosato@linux.ibm.com, pasic@linux.ibm.com, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
 <20260330102748.6423ff89@shazbot.org>
 <2949d622-fa65-4df1-af04-0665ed115ad4@linux.ibm.com>
 <20260331114009.43e41a3a@shazbot.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260331114009.43e41a3a@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _7B6u9MoJYdYORh8XIh_g7wAUHOYgZto
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cd1ff8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=GtCQs2gfn6UTnSsEokcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _7B6u9MoJYdYORh8XIh_g7wAUHOYgZto
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEyMyBTYWx0ZWRfXw+8K77EETdXu
 7JT/CNkQKbK/DSqB3OnhSS543rpO1oWPNXdKkaYqK9ixrKtiScD8ixbgkSDpQt8/c66sKf1F2Ll
 uPXPxI3HCNANQBJFBzfKJwbaY7zm+q8vdcLzTytmUtJU7ZduBpiAWcOvhyuxEa2LmvL5uCVNkkI
 IlEQXDta3Ar9a0eUb3KV4z3Yi6Eoe16Dl7N3K00LftLJvOzz0ueIx1aiQMlN/PXWZ2CjpDUrAuq
 HvQjZfpzaABvvT6fHAqP+8awfRnFGibg4PoEGl70zQSF9RpVKmezm02i7Uv0AyY/HVHX20kaD4S
 yO9aJ7aec/0nfoBknN0QhwLzo4yBJfOkDA7PZ2BMAt8eub0N2yqPYsxdS3+oCaPR0r+WYTEWUkt
 AAT79+MC32xYpi/LvRlv5u2/kVxtK1tRt5tLZy6smhaNDQyOZdVsaUqhNIDMuYiRJCmkM5rfMe6
 5DkJufEmp7XpxXTteBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010123



On 3/31/26 1:40 PM, Alex Williamson wrote:
> On Tue, 31 Mar 2026 08:07:06 -0400
> Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 3/30/26 12:27 PM, Alex Williamson wrote:
>>> On Wed, 25 Mar 2026 17:00:47 -0400
>>> Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>   
>>>> This patch series implements live guest migration of a guest to which AP
>>>> devices have been passed through. To better comprehend this design, one has
>>>> to understand that VFIO AP mediated device is not used to provide userspace
>>>> with direct access to a device as is the case with other devices that use
>>>> the VFIO framework to pass them through to a guest. The sole purpose of the
>>>> VFIO AP mediated device is to manage an AP configuration for a guest. An AP
>>>> configuration is comprised of the AP adapter IDs (APID), AP queue
>>>> indexes (APQI) and domain numbers of the control domains to which a guest
>>>> will be granted access. Once the VFIO AP mediated device is attached to a
>>>> guest, its AP configuration is set by the vfio_ap device driver. Once set,
>>>> all access to the AP devices is handled by the s390 Interpretive Execution
>>>> facility; in other words, the vfio_ap device driver plays no role in
>>>> providing direct access to the AP devices in the guest's AP configuration.
>>>>
>>>> The only role that the vfio_ap device driver plays in the migration
>>>> process is to verify that the AP configuration for the source guest is
>>>> compatible with the AP configuration of the destination guest.
>>>> Incompatibility will result in a live guest migration failure.
>>>> In order to be compatible, the following requirements must be met:
>>>>
>>>> 1. The destination guest will be started with the same QEMU command line
>>>>      as the source guest, so the mediated device supplying the AP
>>>>      configuration on both guests must have the same name (UUID).
>>> AFAIK, same UUID is not a requirement for out-of-tree mdev drivers
>>> supporting migration.  You're really concerned more with the
>>> configuration/composition of the mdev device, so requiring the same
>>> UUID seems a bit arbitrary.
> Combining replies:
>
> On Tue, 31 Mar 2026 07:17:08 -0400
> Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
>> As stated above, the destination guest will be started with the same
>> QEMU command line as the source guest. Within that command line
>> will be a '-device' parameter like the following:
>>
>> -device
>> '{"driver":"vfio-ap","id":"hostdev0","sysfsdev":"/sys/bus/mdev/devices/62177883-f1bb-47f0-914d-32a22e3a8804"}
>>
>> Note that sysfsdev is the path to the mdev named
>> 62177883-f1bb-47f0-914d-32a22e3a8804;
>> therefore, the mdev with that name must exist on the destination guest or
>> the migration will fail with the following error:
>>
>> error: device not found: mediated device
>> '62177883-f1bb-47f0-914d-32a22e3a8804' not found
> Then this is a requirement of your tooling, not a kernel requirement, not
> something the kernel should care about.  QEMU matches devices by their
> virtual bus path, not the sysfsdev or host attributes.  In the case of
> VF migration with vfio-pci variant drivers we cannot require that the
> source and target devices exist at the same bus address.  Ideally the
> pre-copy data from the source device to the target will include relevant
> configuration information to validate that the source and target are
> compatible, regardless of the uuid.

Maybe the problem here is stating that having the same UUID is a
requirement in the patch series description. I agree this is
not a kernel requirement; however, a live guest migration will not
succeed unless the destination host has a mediated device with
a UUID that matches that of the UUID of the mediated device used
to pass through s390 crypto devices to the source guest for the
reason I stated above. Would it help if I removed item #1 as a
requirement?

>
>>>> 2. The AP configuration assigned via the VFIO AP mediated device on both
>>>>      guests must be compatible. As such, each AP configuration must meet
>>>>      the following requirements:
>>>>
>>>>      * Both guests must have the same number of APQNs
>>>>
>>>>      * Each APQN assigned to the source guest must also be assigned to the
>>>>        destination guest
>>>>
>>>>      * Each APQN assigned to both guests must reference an AP queue with the
>>>>        same hardware capabilities
>>> Why isn't this sufficient vs also requiring the same UUID?
>> I explained why in my previous response.
> See above, userspace tooling requirements don't imply kernel
> requirement.

Got it.

> A userspace interface can still exist, I just don't find this path
> through the driver to the VM acceptable with this justification.
> Mechanisms already exist for the device to refuse a state transition or
> generate an error for a migration already in progress.  IMHO, it would
> be acceptable for the device to block a key change if the migration is
> already in progress.  If the key change cannot be represented in the
> migration data stream, then it's up to the orchestration of the
> migration to make sure they stay synchronized, but I don't see that
> the vfio uAPI needs to be involved.  Thanks,

As I stated in the cover letter description, all access to the AP 
devices is handled by the s390 Interpretive Execution facility, so 
without a complete redesign of the vfio_ap device driver, there is no 
way to know that a master key change is being requested. I do get your 
point, however, so I will figure out how best to handle this in 
userspace. Thanks for you review.
>
> Alex


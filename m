Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56963314B9D;
	Thu,  2 Apr 2026 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131435; cv=none; b=DivHbg/j3OPl0h/MPvIX6O7xlfjyfsSR7VrHi/nqYnLTUd65xFsZlRtyXhr4KoN3qBTusRsd7SvI20wTl+237VisFKovJfcQsdDPQC1uX1Gfnp/tPEBOqbdNRraWNZFvnrkbZ0sEGpInoKgJqfS/RpzfcHs8qmRZMklJ0TokRUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131435; c=relaxed/simple;
	bh=1HOfsq25FGmrNZA79MK/iU1oE4zUppSHMT6vyKEjass=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSIRv0DrZY5dIufSNzDB+cwedGcH5qveMBiycNKeaStqgsD4kucfsdmycgM9PZbBBSPVyNQbCEjjKQ9cY9KrW8FFqQdcyfFhndwN2Aksj0sL2GnWV8EOOz+O8f6N2bNqYPi04RzEg9S6uD+SenumcNySidMXMaBIr7veomopnfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o9UiCS7N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o9UiCS7N"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631L8LZ43183710;
	Thu, 2 Apr 2026 12:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=brz/Zf
	ac1TF7wvape+g9GV0/KMKxBlbw+QwpMf7qPbA=; b=o9UiCS7NDG2FEKoHWDuZhh
	9WHxDIw+s1Mk+0Y/amF22L0O4tkArEqGewB7fKV7ySfQtql5ELpYt3QWh0G6uuMZ
	nFX8x1sUR98Suy0knNGu3HoMyGJoothz3SKhwCD9g/5soCIK8Y5yckadLkwdW74c
	bYsW0LiOKlx4zXzI5sehAKXFAVuynLTDEGnuBsz0UM24ZxfgqRJWQLy0Cf/7/KCO
	m4vgmp2Hd6o5J03LTkM9hbhGCZwBTtKnaWJmJWMhou+WKeQ7MTZJo/qNrEp8+74W
	Ca9VmmriGVwALXQkGU94lEj9QtXaBOO9BQ+kFwchLiSYB7FUeEToD3HFftf+s3Kw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dguwnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 12:03:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6327Qwlq030955;
	Thu, 2 Apr 2026 12:03:41 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk1r06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 12:03:41 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632C3d4Q46399778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 12:03:39 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8B0A58075;
	Thu,  2 Apr 2026 12:03:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D259058051;
	Thu,  2 Apr 2026 12:03:37 +0000 (GMT)
Received: from [9.61.23.155] (unknown [9.61.23.155])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 12:03:37 +0000 (GMT)
Message-ID: <1571dfed-2c88-4b45-87b2-10c5a0d7774e@linux.ibm.com>
Date: Thu, 2 Apr 2026 08:03:37 -0400
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
 <3f320ef3-c539-4671-8fbf-283ea9f48633@linux.ibm.com>
 <20260401105743.6c88f13a@shazbot.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260401105743.6c88f13a@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEwNiBTYWx0ZWRfX8rbBibLha/AH
 HgWf9jHrjQ5aa5m4aKiC+NCcMy/mSamDrWt9dbU+JuZ/AdRpKEKq+H5+WMnShRlgkLltBsC0y9/
 3Iof4CkODfhclAePARY5AtMg+FRoqx3+UoB8qJWFcP3v0zD1vUAlRDQ1luy812EW3lRgTo1AEI2
 5AYW1rew4ZGnqIeQJJWVc5kAffmAEfpJ0zgQmOc4sihz5pTLwZu6Pfs8O0GCTQ60d+Oc5XpkCSF
 PpfYXuEhJPOp0BeG5nKj2YKALwMuw/Ug81fgDYKgZkqkPN74nPbuTRYHF1VrOl9bCo/8TbtJLtD
 1Dq1AX98EZeOX9D7paOWUrF9lHJ/fbZWqH7I8XQgEKPBrOvkUfs8XQQILC9a/bzsyYfBEb9zAOA
 SbRdO5JT/ua/pno/wTohr9yq6eqvI17JKJj2KN87/ij4GuFl5JSarnKsjlX6TpzHpJdBh2yYys5
 OwGnUAfd2oJwW626cbQ==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ce5b1e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=6y9mIIUkAAAA:8
 a=VnNF1IyMAAAA:8 a=tw0iCfVx5RxVUoNpJO4A:9 a=QEXdDO2ut3YA:10
 a=BT1tkpHCJze4Rb8jY6gx:22
X-Proofpoint-GUID: CCpO5csGqsk5LBDWZ1GGKvT0_YJ5SD5E
X-Proofpoint-ORIG-GUID: CCpO5csGqsk5LBDWZ1GGKvT0_YJ5SD5E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020106



On 4/1/26 12:57 PM, Alex Williamson wrote:
> On Wed, 1 Apr 2026 09:38:59 -0400
> Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 3/31/26 1:40 PM, Alex Williamson wrote:
>>> On Tue, 31 Mar 2026 08:07:06 -0400
>>> Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>   
>>>> On 3/30/26 12:27 PM, Alex Williamson wrote:
>>>>> On Wed, 25 Mar 2026 17:00:47 -0400
>>>>> Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>>>      
>>>>>> This patch series implements live guest migration of a guest to which AP
>>>>>> devices have been passed through. To better comprehend this design, one has
>>>>>> to understand that VFIO AP mediated device is not used to provide userspace
>>>>>> with direct access to a device as is the case with other devices that use
>>>>>> the VFIO framework to pass them through to a guest. The sole purpose of the
>>>>>> VFIO AP mediated device is to manage an AP configuration for a guest. An AP
>>>>>> configuration is comprised of the AP adapter IDs (APID), AP queue
>>>>>> indexes (APQI) and domain numbers of the control domains to which a guest
>>>>>> will be granted access. Once the VFIO AP mediated device is attached to a
>>>>>> guest, its AP configuration is set by the vfio_ap device driver. Once set,
>>>>>> all access to the AP devices is handled by the s390 Interpretive Execution
>>>>>> facility; in other words, the vfio_ap device driver plays no role in
>>>>>> providing direct access to the AP devices in the guest's AP configuration.
>>>>>>
>>>>>> The only role that the vfio_ap device driver plays in the migration
>>>>>> process is to verify that the AP configuration for the source guest is
>>>>>> compatible with the AP configuration of the destination guest.
>>>>>> Incompatibility will result in a live guest migration failure.
>>>>>> In order to be compatible, the following requirements must be met:
>>>>>>
>>>>>> 1. The destination guest will be started with the same QEMU command line
>>>>>>       as the source guest, so the mediated device supplying the AP
>>>>>>       configuration on both guests must have the same name (UUID).
>>>>> AFAIK, same UUID is not a requirement for out-of-tree mdev drivers
>>>>> supporting migration.  You're really concerned more with the
>>>>> configuration/composition of the mdev device, so requiring the same
>>>>> UUID seems a bit arbitrary.
>>> Combining replies:
>>>
>>> On Tue, 31 Mar 2026 07:17:08 -0400
>>> Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>> As stated above, the destination guest will be started with the same
>>>> QEMU command line as the source guest. Within that command line
>>>> will be a '-device' parameter like the following:
>>>>
>>>> -device
>>>> '{"driver":"vfio-ap","id":"hostdev0","sysfsdev":"/sys/bus/mdev/devices/62177883-f1bb-47f0-914d-32a22e3a8804"}
>>>>
>>>> Note that sysfsdev is the path to the mdev named
>>>> 62177883-f1bb-47f0-914d-32a22e3a8804;
>>>> therefore, the mdev with that name must exist on the destination guest or
>>>> the migration will fail with the following error:
>>>>
>>>> error: device not found: mediated device
>>>> '62177883-f1bb-47f0-914d-32a22e3a8804' not found
>>> Then this is a requirement of your tooling, not a kernel requirement, not
>>> something the kernel should care about.  QEMU matches devices by their
>>> virtual bus path, not the sysfsdev or host attributes.  In the case of
>>> VF migration with vfio-pci variant drivers we cannot require that the
>>> source and target devices exist at the same bus address.  Ideally the
>>> pre-copy data from the source device to the target will include relevant
>>> configuration information to validate that the source and target are
>>> compatible, regardless of the uuid.
>> Maybe the problem here is stating that having the same UUID is a
>> requirement in the patch series description. I agree this is
>> not a kernel requirement; however, a live guest migration will not
>> succeed unless the destination host has a mediated device with
>> a UUID that matches that of the UUID of the mediated device used
>> to pass through s390 crypto devices to the source guest for the
>> reason I stated above. Would it help if I removed item #1 as a
>> requirement?
> Yes, AIUI this is an artifact of your tooling.  The destination QEMU
> can be started with any arbitrary UUID and should accept an incoming
> migration, routing the migration to the correct device by the virtual
> path, independent of the UUID.

If by tooling you are referring to libvirt and/or quemu, then I agree;
this is an artifact of tooling. According to
https://www.linux-kvm.org/page/Migration#Requirements,
"the guest on the destination must be started the same way it was
started on the source". s390 guests are run under qemu, so the
qemu command line used to start the source guest will also be used
to start the destination guest. To pass through
AP devices to the guest, the mediated device that provides the guest's
AP configuration - i.e., the crypto devices to which the guest is granted
access - must be identified on the qemu command line. As stated
previously, the following qemu command line parameter is included
for this purpose:


-device '{"driver":"vfio-ap","id":"hostdev0","sysfsdev":"/sys/bus/mdev/devices/62177883-f1bb-47f0-914d-32a22e3a8804"}

When the qemu command is used to start the destination guest, the same
qemu command line will be used to start it. As such, qemu will try to open
an fd for that device. If the mdev with UUID does not exist, the migration
will fail. In other words, I don't think the guest can be started with any
arbitrary UUID. Am I wrong about this?

In any case, it is probably not relevant to mention this for this patch 
series
since it is not a KVM/kernel requirement, so I will remove it from the
cover-letter description.

>
>>>>>> 2. The AP configuration assigned via the VFIO AP mediated device on both
>>>>>>       guests must be compatible. As such, each AP configuration must meet
>>>>>>       the following requirements:
>>>>>>
>>>>>>       * Both guests must have the same number of APQNs
>>>>>>
>>>>>>       * Each APQN assigned to the source guest must also be assigned to the
>>>>>>         destination guest
>>>>>>
>>>>>>       * Each APQN assigned to both guests must reference an AP queue with the
>>>>>>         same hardware capabilities
>>>>> Why isn't this sufficient vs also requiring the same UUID?
>>>> I explained why in my previous response.
>>> See above, userspace tooling requirements don't imply kernel
>>> requirement.
>> Got it.
>>
>>> A userspace interface can still exist, I just don't find this path
>>> through the driver to the VM acceptable with this justification.
>>> Mechanisms already exist for the device to refuse a state transition or
>>> generate an error for a migration already in progress.  IMHO, it would
>>> be acceptable for the device to block a key change if the migration is
>>> already in progress.  If the key change cannot be represented in the
>>> migration data stream, then it's up to the orchestration of the
>>> migration to make sure they stay synchronized, but I don't see that
>>> the vfio uAPI needs to be involved.  Thanks,
>> As I stated in the cover letter description, all access to the AP
>> devices is handled by the s390 Interpretive Execution facility, so
>> without a complete redesign of the vfio_ap device driver, there is no
>> way to know that a master key change is being requested. I do get your
>> point, however, so I will figure out how best to handle this in
>> userspace. Thanks for you review.
> The cover letter has one sentence describing the Interpretive Execution
> facility handling access to the device.  There are a lot of subtleties
> there that are not obvious to laypersons.
>
> It seems like the architecture really doesn't have the ability
> to monitor state changes of the device, and therefore represent those
> changes in the migration data stream, so you want to fallback to a
> cooperative scheme with a side-band channel to interrupt or block
> migration when an asynchronous configuration change happens.
>
> I just don't see that such cooperation needs a new uAPI through the
> device; either the device itself could perform the same within the
> existing uAPI or the agent changing the configuration could coordinate
> with the migration orchestration.  Thanks,

I understand your view on this and have already agreed to remove
the new uAPI.

>
> Alex


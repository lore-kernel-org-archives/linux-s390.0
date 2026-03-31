Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7353B19B5;
	Tue, 31 Mar 2026 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955841; cv=none; b=QughEA9U2CLqhb8LZslkJCOnHBiL5yYCia4/eeUnbTvJWGBjnRBVSadPHpKl8qqHsaM4Na2tfh5EQISQc94ydBV/T30CE6mX7cgEAiNX8iB0Uv7SPmH/zZJih/7PoWBLdcr5y+rDx7weG9gltIvbjnqzD+kmd0zs92s6bbD1OoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955841; c=relaxed/simple;
	bh=uosfJHyJ0PgndOBCkuomCpw+akmmEVKGl42x5B5LXfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eeO8R4hz3IL+XmQeuJcQesHaUUhe3TUOp7I70eT8oK7L/I1TYYMC1TUElcN5n907Jr5EvujT1UIUogjfP/3UOxlwuifJ4VNLRyj3NtSMOLsx/zloII2fpzBwF0b/wPFHqMhQmi/5WFxbuvcAKAhrhtjKk6cqoIVZrK8/7B/z+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SR9OTIFx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SR9OTIFx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V8mmbG371620;
	Tue, 31 Mar 2026 11:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RIOWBn
	2h0WwLoKl1CfFSXwKcshhW6ZkrVgHm7r3aJDY=; b=SR9OTIFxxcv+9hNteXFIs3
	AA+nZs+G2L99dZ5ROfk3z6FoFAGFW8pO1W9oGtDv25XtevC3ee7q4x8oZzxGQ9sh
	FKvilUdc12oRTdMFoLnUaC70WAsbuWdI5Z84KqSstJxf359Jt7dqq8t3Bzu38qCp
	26ryGhZiswKjnuuuUZdECu3do38stdJQKAPGHPleMHSUMLBni67H5BOi67d6dE7G
	rybfDDQKlqt5DZwN6FCWmqWw3lnlWfYFG/fsGfs1mdPyreOBRG7Ql99Tcw6JuTWm
	aCJEdvlzDokFJh3YqNfqFV5/l/jvs/xhDnlw+tHEq/kOcs3Enh6xx1vQIQhRZRPQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcag9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:17:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V82lGj030990;
	Tue, 31 Mar 2026 11:17:13 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjrjq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:17:13 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VBHB8439060112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 11:17:11 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F6EF58055;
	Tue, 31 Mar 2026 11:17:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80A725804B;
	Tue, 31 Mar 2026 11:17:09 +0000 (GMT)
Received: from [9.61.13.195] (unknown [9.61.13.195])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 11:17:09 +0000 (GMT)
Message-ID: <70d7b2c7-77d7-4b53-bcb1-524b459fe426@linux.ibm.com>
Date: Tue, 31 Mar 2026 07:17:08 -0400
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
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260330102748.6423ff89@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cbad3a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=AhJJE_Kw0ly2J05s9D4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RGsLswygIdp7vEfyqIwS9gGHq-Rpp_HR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEwNCBTYWx0ZWRfX+nrgZJDuBaMb
 krF4kGdz9siXfHDYpMeBhCq6xKmJbny3Q2MH11VmMOKbAvcz0an2u9y1kWqEFJL2IujoYcAJMvG
 TFtvGThGteCq4tE7mUrIIig2WJ8+Ox2HN4kZ+qKRSoaUtfVPCR54NjqUT2lVP89etJV9NvUPRdK
 uxeuS+S+66pk+jJpiV0SaH15IUQzH40RMKNFM9KuwigQjxX34lmUDSYaltuKyrnPlnZK8Qwdivi
 2xi31p5w/WpA4E16e45V4/UDC5uectktyLDf10gbY0BJC56VlAY/rph2Gqo2oO2JATaCvdl0ccS
 fGJfA+nZ91epe/Nndc36PMPuYrAiErhVbvnOOKrTstnCSNEhv/JzNVJYrDInNy28mAZIzbw4lAX
 U3ZIDSX1eE6Bn8eY9TqglvW+LQ567TSKduee9hID7ac0O9IvKfrzShSYE5HC+jYXfKJE2sENsgV
 jg5sTWlUkbq0o0ax7JQ==
X-Proofpoint-ORIG-GUID: RGsLswygIdp7vEfyqIwS9gGHq-Rpp_HR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310104



On 3/30/26 12:27 PM, Alex Williamson wrote:
> On Wed, 25 Mar 2026 17:00:47 -0400
> Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> This patch series implements live guest migration of a guest to which AP
>> devices have been passed through. To better comprehend this design, one has
>> to understand that VFIO AP mediated device is not used to provide userspace
>> with direct access to a device as is the case with other devices that use
>> the VFIO framework to pass them through to a guest. The sole purpose of the
>> VFIO AP mediated device is to manage an AP configuration for a guest. An AP
>> configuration is comprised of the AP adapter IDs (APID), AP queue
>> indexes (APQI) and domain numbers of the control domains to which a guest
>> will be granted access. Once the VFIO AP mediated device is attached to a
>> guest, its AP configuration is set by the vfio_ap device driver. Once set,
>> all access to the AP devices is handled by the s390 Interpretive Execution
>> facility; in other words, the vfio_ap device driver plays no role in
>> providing direct access to the AP devices in the guest's AP configuration.
>>
>> The only role that the vfio_ap device driver plays in the migration
>> process is to verify that the AP configuration for the source guest is
>> compatible with the AP configuration of the destination guest.
>> Incompatibility will result in a live guest migration failure.
>> In order to be compatible, the following requirements must be met:
>>
>> 1. The destination guest will be started with the same QEMU command line
>>     as the source guest, so the mediated device supplying the AP
>>     configuration on both guests must have the same name (UUID).
> AFAIK, same UUID is not a requirement for out-of-tree mdev drivers
> supporting migration.  You're really concerned more with the
> configuration/composition of the mdev device, so requiring the same
> UUID seems a bit arbitrary.

As stated above, the destination guest will be started with the same
QEMU command line as the source guest. Within that command line
will be a '-device' parameter like the following:

-device 
'{"driver":"vfio-ap","id":"hostdev0","sysfsdev":"/sys/bus/mdev/devices/62177883-f1bb-47f0-914d-32a22e3a8804"}

Note that sysfsdev is the path to the mdev named 
62177883-f1bb-47f0-914d-32a22e3a8804;
therefore, the mdev with that name must exist on the destination guest or
the migration will fail with the following error:

error: device not found: mediated device 
'62177883-f1bb-47f0-914d-32a22e3a8804' not found

>
>> 2. The AP configuration assigned via the VFIO AP mediated device on both
>>     guests must be compatible. As such, each AP configuration must meet
>>     the following requirements:
>>
>>     * Both guests must have the same number of APQNs
>>
>>     * Each APQN assigned to the source guest must also be assigned to the
>>       destination guest
>>
>>     * Each APQN assigned to both guests must reference an AP queue with the
>>       same hardware capabilities
> Why isn't this sufficient vs also requiring the same UUID?
>        
>> Note: There is a forthcoming consumer of this series which will be a QEMU
>>        patch series is entitled:
>>        'hw/vfio/ap: Implement live guest migration of guests using AP
>>        devices'
>>
>> This design also adds a use case for enabling and disabling
>> migration of guests to which AP devices have been passed through. To
>> facilitate this, a new read/write sysfs 'migratable' attribute is added to
>> the mediated device. This attribute specifies whether the vfio device is
>> migratable (1) or not (0). When the value of this attribute is changed, the
>> vfio_ap device driver will signal an eventfd to userspace. It is up to
>> userspace to respond to the change by enabling or disabling migration of
>> the guest to which the mediated device is attached. The operation will be
>> rejected with a 'Device or resource busy' message if a migration is in
>> progress.
> This seems inherently racy.  What happens if the device becomes
> unmigratable while it's being migrated?
>
> If userspace is deciding that the device is now unmigratable, why does
> it need to signal this through the kernel driver rather than with the
> userspace orchestration agent?  The entire path seems unnecessary.
>
>> Userspace must also have a means for retrieving the value of the sysfs
>> 'migratable' attribute when the guest is started to initialize whether it
>> can be migrated. For this, The VFIO_DEVICE_GET_INFO ioctl is used. The
>> struct vfio_device_info object passed to the ioctl will be extended with a
>> capability specifying the vfio device attributes. One of the attributes
>> will contain the value of the mediated device's 'migratable' attribute.
> This is just broken, it's redundant to our current device feature
> mechanism for exposing migration support.  If you want the capability
> to create unmigratable devices statically, can't that be encompassed
> within the definition of the mdev type?  Dynamic migration support just
> seems like it's involving the kernel in orchestration it shouldn't be a
> part of.  Thanks,
>
> Alex
>   
>> Anthony Krowiak (23):
>>    s390/vfio-ap: Store queue hardware info when probed
>>    s390/vfio-ap: Provide access to queue objects and related info
>>    s390/vfio-ap: Add header file for xfer of vfio device caps to
>>      userspace
>>    MAINTAINERS: Add new header file for the S390 VFIO AP DRIVER
>>      maintainers
>>    s390/vfio-ap: A sysfs 'migratable' attribute to enable/disable
>>      migration of guest
>>    s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
>>    s390/vfio-ap: Signal event to enable/disable live guest migration
>>    s390/vfio-ap: Return value of sysfs migratable attribute from
>>      VFIO_DEVICE_GET_INFO ioctl
>>    s390/vfio-ap: Data structures for facilitating vfio device migration
>>    s390/vfio-ap: Initialize/release vfio device migration data
>>    s390-vfio-ap: Callback to set vfio device mig state during guest
>>      migration
>>    s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
>>    s390/vfio-ap: File ops called to save the vfio device migration state
>>    s390/vfio-ap: Transition device migration state from STOP to RESUMING
>>    s390/vfio-ap: File ops called to resume the vfio device migration
>>    s390/vfio-ap: Transition device migration state from RESUMING to STOP
>>    s390/vfio-ap: Transition device migration state from STOP_COPY to STOP
>>    s390/vfio-ap: Transition device migration state from STOP to RUNNING
>>      and vice versa
>>    s390-vfio-ap: Callback to get the current vfio device migration state
>>    s390/vfio-ap: Callback to get the size of data to be migrated during
>>      guest migration
>>    s390/vfio-ap: Provide API to query whether migration is in progress
>>    s390/vfio-ap: Disallow blocking migration in progress
>>    s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst
>>
>>   Documentation/arch/s390/vfio-ap.rst     |  339 +++++--
>>   MAINTAINERS                             |    1 +
>>   drivers/s390/crypto/Makefile            |    2 +-
>>   drivers/s390/crypto/vfio_ap_drv.c       |    4 +-
>>   drivers/s390/crypto/vfio_ap_migration.c | 1131 +++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_ops.c       |  263 +++++-
>>   drivers/s390/crypto/vfio_ap_private.h   |   20 +
>>   include/uapi/linux/vfio.h               |    2 +
>>   include/uapi/linux/vfio_ap.h            |   34 +
>>   9 files changed, 1685 insertions(+), 111 deletions(-)
>>   create mode 100644 drivers/s390/crypto/vfio_ap_migration.c
>>   create mode 100644 include/uapi/linux/vfio_ap.h
>>


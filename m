Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8053AA1B3;
	Tue, 31 Mar 2026 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958838; cv=none; b=C1nznB78sEYDWUFbf/9tf7IpxqZhP0Ur5moy+7JqhMdT9PE4YgbUsH9CrjCyO6Ugi1AImipzKvmEadrnZ9aS8jZZ7hT2ctD1gaGle4D1FkTidgnaaocPzUv0pjYJn6UiUcTrJeX/dxYe41GxF7MruGEzXs7e1/Vlx/53VcpJXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958838; c=relaxed/simple;
	bh=XxOaNzm/tdIixG2VUU9CHubJccm2Z+1XSprCA36LgfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpy7bFfBHAEFi7bKXjd/1zSRa1tpSnLe8pScd8FZDO6N1n4XG/ZqJhvM2RXljcJGaNw1q2ZVeicgVemgZDS9klOXlz6zO11tWIx/cLtfW2715va0tpC7Wwb/6ZizSLX4aNsCTeBXpQSFmvGj1IXGYEbyoURR1UcDMv+M2lx8dTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fnsl/Do2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fnsl/Do2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V2mESf3435060;
	Tue, 31 Mar 2026 12:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ohRer4
	HD1XAf8AJ+lbhu8kDyBtdoQkQyWbZh5AR6YbA=; b=Fnsl/Do2XHpVtadEclkfV3
	lwd8LnEAgT22bcP4o6eEwCS6tlarOWExMQd4GXmYdYziAGr6GA14CKmh3jRGPrOs
	/VeoI5/bn9pQm4e6ciaRsHGueaonJ+Tb2g4KXQkfcOujwEXfDMADhX189PDFkqNZ
	e8FLXazdLztaQmwsyu9XyQV+Lh9Ldb40BEkJhoxoi0b36IIt7QOnMKbO3mRju6d/
	J6B04NLHbc0GAN0WGlNw2B+YLmkuHeSf10s5MRS9Pc3GbXj4PsTC1cJ2ai/+QTQn
	Dn33AEU9wRUMeK7JLTCBykOXXmKCEZUOotYqz2d4lvxY2XF09pRfJm671ottAttQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcap3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 12:07:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VAtNGB021665;
	Tue, 31 Mar 2026 12:07:10 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sash2ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 12:07:10 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VC781D28443212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 12:07:09 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEF0058055;
	Tue, 31 Mar 2026 12:07:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 251AC5804B;
	Tue, 31 Mar 2026 12:07:07 +0000 (GMT)
Received: from [9.61.13.195] (unknown [9.61.13.195])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 12:07:07 +0000 (GMT)
Message-ID: <2949d622-fa65-4df1-af04-0665ed115ad4@linux.ibm.com>
Date: Tue, 31 Mar 2026 08:07:06 -0400
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
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cbb8ef cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=nmhNGB8zuyBSvq4kD5MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8Je2r02FS9xKskLVhbG5Hz-5-d7HyIy2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDExNCBTYWx0ZWRfX0jvAghv1TXyD
 /HfIxrSQZEdEtvTd99Grj44ofHzMAvY4YjY4w5UueqVCwGf/GTSACTDPHDz2cQeMfUBgtNNrEtJ
 q6E9T31A7/LXUTh/FQYPzKbl3Of5UkErnAoQHhwIZ1j8gZlxs26MBS3bl88dtzt6esRaNdfdw2W
 m7hAnxRDKOYb1js8ULmT1NFAkw4L6wmhUFfoZsBmW86+R8Sw+oOjfTsGlV3aNb3Hk1N+f0NEfUI
 DKoeo3v/DBk01OyXXMIQChcpaEV1RquWl51IjWNaSjiyDTI/hRSZMMwvwVaQU3fg5ha0YEd9Uee
 VJrW+8Q0YSx7TRJm5tkfRuIbQQ2qTk2kDmFVPcSNIN/m0LoxH7uFvDDnGJQAtNNdoPK0RaeBtE/
 u5LCtUt+9nXW9qkuzPy7tH2VuJhyAcx8pHjyy8cUUIiH9Xsj/fqNiE9Kh1cO9oKcr1s7c/kRlgV
 tfsNAtfRjoZxLAQpN9A==
X-Proofpoint-ORIG-GUID: 8Je2r02FS9xKskLVhbG5Hz-5-d7HyIy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310114



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

I explained why in my previous response.

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

I am not familiar with what a userspace orchestration agent is, so
I can't address that. Can you please describe how that would work?

Maybe it would help to provide the reason for this. For certain types
of crypto operations, a master key must be configured for the crypto
card domain being used. This master key must be synchronized
between the source and destination crypto device so that in-flight
crypto operations can be completed during migration. If these master
keys must be changed, migration must be blocked until the master
key changes can be synchronized between the source and destination
system(s).

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
> part of.

So, it appears you are suggesting the creation of a new mdev type
for unmigratable crypto devices. I don't see the value in that.
As I stated above, there is a valid reason for wanting to prevent
migration while master key synchronization is taking place.

If this feature violates the implicit rules of vfio device migration,
then so be it. Maybe we have to figure out another way to ensure
migration is not initiated during master key synchronization.

If we can't find an acceptable means to do this programmatically,
then maybe it will come down to a matter of documenting the
need to ensure migration is not initiated while master key
synchronization is taking place. This would put the onus on the
various system administrators responsible for host, guest and
master key administration to communicate out of band to
ensure they are all on the same page with regard to migration.

It would be preferable to be able to do this with a userspace
interface, so any suggestions would be greatly appreciated.

>    Thanks,
>
> Alex

Thank you for your review.

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


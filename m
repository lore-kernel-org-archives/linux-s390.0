Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbgFBOqb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jun 2020 10:46:31 -0400
Subject: Re: [PULL 08/10] vfio-ccw: Introduce a new CRW region
References: <20200525094115.222299-1-cohuck@redhat.com>
 <20200525094115.222299-9-cohuck@redhat.com>
 <20200602151313.0e639b57.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <71bf02e5-dbb4-0b3f-0956-b1b13dadf42a@linux.ibm.com>
Date: Tue, 2 Jun 2020 10:46:25 -0400
MIME-Version: 1.0
In-Reply-To: <20200602151313.0e639b57.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>



On 6/2/20 9:13 AM, Cornelia Huck wrote:
> On Mon, 25 May 2020 11:41:13 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> From: Farhan Ali <alifm@linux.ibm.com>
>>
>> This region provides a mechanism to pass a Channel Report Word
>> that affect vfio-ccw devices, and needs to be passed to the guest
>> for its awareness and/or processing.
>>
>> The base driver (see crw_collect_info()) provides space for two
>> CRWs, as a subchannel event may have two CRWs chained together
>> (one for the ssid, one for the subchannel).  As vfio-ccw will
>> deal with everything at the subchannel level, provide space
>> for a single CRW to be transferred in one shot.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Message-Id: <20200505122745.53208-7-farman@linux.ibm.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  Documentation/s390/vfio-ccw.rst     | 19 ++++++++++
>>  drivers/s390/cio/vfio_ccw_chp.c     | 55 +++++++++++++++++++++++++++++
>>  drivers/s390/cio/vfio_ccw_drv.c     | 20 +++++++++++
>>  drivers/s390/cio/vfio_ccw_ops.c     |  8 +++++
>>  drivers/s390/cio/vfio_ccw_private.h |  4 +++
>>  include/uapi/linux/vfio.h           |  2 ++
>>  include/uapi/linux/vfio_ccw.h       |  8 +++++
>>  7 files changed, 116 insertions(+)
>>
> 
> (...)
> 
>> @@ -413,6 +423,16 @@ static int __init vfio_ccw_sch_init(void)
>>  		goto out_err;
>>  	}
>>  
>> +	vfio_ccw_crw_region = kmem_cache_create_usercopy("vfio_ccw_crw_region",
>> +					sizeof(struct ccw_crw_region), 0,
>> +					SLAB_ACCOUNT, 0,
>> +					sizeof(struct ccw_crw_region), NULL);
> 
> Ugh, I just tested this rebased to the s390 features branch, and I must
> have used some different options, because I now get
> 
>    kmem_cache_create(vfio_ccw_crw_region) integrity check failed
> 
> presumably due to the size of the ccw_crw_region.
> 
> We maybe need to pad it up (leave it unpacked)? Eric, what do you think?

Certainly packing a single one-word struct is weird, and the message is
coming out of the tiny struct itself:

mm/slab-common.c:88:
        if (!name || in_interrupt() || size < sizeof(void *) ||
                size > KMALLOC_MAX_SIZE) {
                pr_err("kmem_cache_create(%s) integrity check failed\n",
name);

That's protected by CONFIG_DEBUG_VM which wasn't enabled in my config.
So playing around with things, we'd have to explicitly add a pad (or the
second CRW, ha!) to get the struct back up to a doubleword. That'd be
fine with me.

> 
>> +
>> +	if (!vfio_ccw_crw_region) {
>> +		ret = -ENOMEM;
>> +		goto out_err;
>> +	}
>> +
>>  	isc_register(VFIO_CCW_ISC);
>>  	ret = css_driver_register(&vfio_ccw_sch_driver);
>>  	if (ret) {
> 
> (...)
> 
>> diff --git a/include/uapi/linux/vfio_ccw.h b/include/uapi/linux/vfio_ccw.h
>> index 758bf214898d..cff5076586df 100644
>> --- a/include/uapi/linux/vfio_ccw.h
>> +++ b/include/uapi/linux/vfio_ccw.h
>> @@ -44,4 +44,12 @@ struct ccw_schib_region {
>>  	__u8 schib_area[SCHIB_AREA_SIZE];
>>  } __packed;
>>  
>> +/*
>> + * Used for returning a Channel Report Word to userspace.
>> + * Note: this is controlled by a capability
>> + */
>> +struct ccw_crw_region {
>> +	__u32 crw;
>> +} __packed;
>> +
>>  #endif
> 

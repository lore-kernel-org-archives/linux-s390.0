Return-Path: <SRS0=lgIa=TQ=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v1 0/2] New state handling for VFIO CCW
References: <1557148270-19901-1-git-send-email-pmorel@linux.ibm.com>
 <20190508115341.2be6b108.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 16 May 2019 10:59:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190508115341.2be6b108.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <118f3dc7-d950-75ac-527d-2eb65dce9a99@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, farman@linux.ibm.com, alifm@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 08/05/2019 11:53, Cornelia Huck wrote:
> On Mon,  6 May 2019 15:11:08 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> Hi,
>>
>> I did not integrate all my patches for state handling like I had
>> before but just two patches which seems interresting to me:
>>
>> - The first one allows the device ti be used only when a guest
>>    is currently using it.
>>    Otherwise the device is in NOT_OPER state
>>   
>> - The second rework the sch_event callback: AFAIU we can not
>>    consider that the event moves the device in IDLE state.
>>    I think we better let it as it is currently.
> 
> I agree with the direction of this patch series.
> 
>>
>> Regards,
>> Pierre
>>
>> Pierre Morel (2):
>>    vfio-ccw: Set subchannel state STANDBY on open
>>    vfio-ccw: rework sch_event
>>
>>   drivers/s390/cio/vfio_ccw_drv.c     | 21 ++-------------------
>>   drivers/s390/cio/vfio_ccw_fsm.c     |  7 +------
>>   drivers/s390/cio/vfio_ccw_ops.c     | 36 ++++++++++++++++++------------------
>>   drivers/s390/cio/vfio_ccw_private.h |  1 -
>>   4 files changed, 21 insertions(+), 44 deletions(-)
>>
> 
Thanks,
I will post a v2 with the corrections seen by you and Farhan,

Regards,
Pierre	

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

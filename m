From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/10] vfio: ccw: new SCH_EVENT event
Date: Wed, 25 Apr 2018 15:54:21 +0200
Message-ID: <c9dee10d-e189-6b3a-46b3-acb4baab9043@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-4-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180425102519.16e6195b.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425102519.16e6195b.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 25/04/2018 10:25, Cornelia Huck wrote:
> On Thu, 19 Apr 2018 16:48:06 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> The Sub channel event callback is threaded using workqueues.
>> The work uses the FSM introducing the VFIO_CCW_EVENT_SCH_EVENT
>> event.
> I don't think this is a good name; after all, all of the events are
> events for the subchannel :)
>
> This seems to be more of a "we need to update the schib" event...
> VFIO_CCW_EVENT_SCHIB_CHANGED? _SCH_CHANGED? _UPDATE_NEEDED?
>
> Tbh, I'm not quite sure this makes sense for me yet... will continue
> reading, but this probably needs a 'why'.

SCHIB_CHANGED or something like this sounds better indeed. :)

>
>> The update of the SCHIB is now done inside the FSM function.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_drv.c     | 33 +++++++++++++--------------------
>>   drivers/s390/cio/vfio_ccw_fsm.c     | 23 +++++++++++++++++++++++
>>   drivers/s390/cio/vfio_ccw_private.h |  3 +++
>>   3 files changed, 39 insertions(+), 20 deletions(-)


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

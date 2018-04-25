From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH 09/10] vfio: ccw: Suppressing the BOXED state
Date: Wed, 25 Apr 2018 15:55:51 +0200
Message-ID: <32efd6b2-78b0-ae44-3a64-a092f9d412fe@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-10-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180425104429.582618f8.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425104429.582618f8.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 25/04/2018 10:44, Cornelia Huck wrote:
> On Thu, 19 Apr 2018 16:48:12 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> VFIO_CCW_STATE_BOXED and VFIO_CCW_STATE_BUSY are the same
>> states.
>> Let's only keep one: VFIO_CCW_STATE_BUSY
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_fsm.c     | 9 ---------
>>   drivers/s390/cio/vfio_ccw_private.h | 1 -
>>   2 files changed, 10 deletions(-)
> I think they were initially supposed to cover two different things:
> - BUSY: we're currently dealing with an I/O request
> - BOXED: the device currently won't talk to us or we won't talk to it
>
> It seems we never really did anything useful with BOXED; but should we?
>
I do not know what.


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

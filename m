From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/10] vfio: ccw: Introduce the INIT event
Date: Thu, 3 May 2018 12:31:41 +0200
Message-ID: <70fdc9d5-2cdb-3721-8c9b-5d5fead72739@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-8-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180430173910.31f13a3a.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180430173910.31f13a3a.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 30/04/2018 17:39, Cornelia Huck wrote:
> On Thu, 19 Apr 2018 16:48:10 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> The VFIO_CCW_EVENT_INIT event allows to export the initial state
>> into the FSM.
> I don't know, that feels a bit unintuitive to me. I would naively
> expect initialization to be done _before_ we activate processing via
> the state machine.
>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_drv.c     | 26 +++++++++++---------------
>>   drivers/s390/cio/vfio_ccw_fsm.c     | 21 +++++++++++++++++++++
>>   drivers/s390/cio/vfio_ccw_ops.c     | 11 -----------
>>   drivers/s390/cio/vfio_ccw_private.h |  1 +
>>   4 files changed, 33 insertions(+), 26 deletions(-)
>>   /*
>>    * Device statemachine
>>    */
>>   fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
>>   	[VFIO_CCW_STATE_NOT_OPER] = {
>> +		[VFIO_CCW_EVENT_INIT]		= fsm_init,
>>   		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
>>   		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
>>   		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
>>   		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_nop,
>>   	},
>>   	[VFIO_CCW_STATE_STANDBY] = {
>> +		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
>>   		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>>   		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_error,
>>   		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>>   		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
>>   	},
>>   	[VFIO_CCW_STATE_IDLE] = {
>> +		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
>>   		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>>   		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_request,
>>   		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>>   		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
>>   	},
>>   	[VFIO_CCW_STATE_BOXED] = {
>> +		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
>>   		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>>   		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
>>   		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
>>   		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
>>   	},
>>   	[VFIO_CCW_STATE_BUSY] = {
>> +		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
>>   		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
>>   		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
>>   		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
> ...especially as you only call it if in the NOT_OPER state. Why should
> this event be generated in any case but in the very beginning?
>
It is the only way to go out of the NOT_OPER state.

The idea is to introduce recoverycode in a later version.

However, no problem to suppress this state until we get there so I will 
remove it in V2.


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

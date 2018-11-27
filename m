From: Michael Mueller <mimu@linux.ibm.com>
Date: Tue, 27 Nov 2018 17:22:46 +0000
Subject: Re: [PATCH v2 11/12] KVM: s390: add and wire function gib_alert_irq_handler()
Message-Id: <8ec147f8-63dc-3e67-7add-0c86991e7acc@linux.ibm.com>
In-Reply-To: <20181126173558.3a443c1b.cohuck@redhat.com>
References: <20181126173558.3a443c1b.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 26.11.18 17:35, Cornelia Huck wrote:
> On Mon, 19 Nov 2018 18:25:35 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> The patch implements a handler for GIB alert interruptions
>> on the host. Its task is to alert storage backed guests that
>> interrupts are pending for them.
>>
>> A GIB alert interrupt statistic counter is added as well:
>>
>> $ cat /proc/interrupts
>>            CPU0       CPU1
>>    ...
>>    GAL:       0          0   [I/O] GIB Alert
>>    ...
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/irq.h |  1 +
>>   arch/s390/include/asm/isc.h |  1 +
>>   arch/s390/kernel/irq.c      |  1 +
>>   arch/s390/kvm/interrupt.c   | 57 +++++++++++++++++++++++++++++++++++++--------
>>   arch/s390/kvm/kvm-s390.c    |  6 +++++
>>   arch/s390/kvm/kvm-s390.h    |  5 ++++
>>   6 files changed, 61 insertions(+), 10 deletions(-)
> 
>> @@ -2919,7 +2920,7 @@ static void nullify_gisa(struct kvm_s390_gisa *gisa)
>>    * belongs to. Thus, the pending guest interruption will be processed
>>    * in SIE context.
>>    */
>> -static void __maybe_unused process_gib_alert_list(void)
>> +static void process_gib_alert_list(void)
> 
> Can't you merge the patch creating that function into this patch, so
> you don't need to add __maybe_unused in the first place? (I don't think
> the function is big enough to need separate review.)

The function has been rewritten for v3 and I consider it worth to
stay separated now. The version is already in the starting blocks
and was just delayed by all your replies. ;)

> 
>>   {
>>   	struct kvm_s390_gisa *gisa = unlink_gib_alert_list();
>>   	struct kvm_s390_gisa *next_alert;
> 

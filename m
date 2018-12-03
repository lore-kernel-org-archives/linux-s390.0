From: Michael Mueller <mimu@linux.ibm.com>
Date: Mon, 03 Dec 2018 10:46:40 +0000
Subject: Re: [PATCH v4 10/10] KVM: s390: start using the GIB
Message-Id: <19c7a774-67ae-2c5c-4605-1b5fa2eed2cd@linux.ibm.com>
In-Reply-To: <20181203112918.5cf42e44.cohuck@redhat.com>
References: <20181203112918.5cf42e44.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 03.12.18 11:29, Cornelia Huck wrote:
> On Mon, 3 Dec 2018 11:09:37 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> On 03.12.18 10:50, Cornelia Huck wrote:
>>> On Fri, 30 Nov 2018 15:32:15 +0100
>>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>>   
>>>> By initializing the GIB, it will be used by the kvm host.
>>>>
>>>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>>>> ---
>>>>    Documentation/kmsg/s390/kvm | 12 ++++++++++++
>>>>    arch/s390/kvm/kvm-s390.c    | 10 +++++++++-
>>>>    2 files changed, 21 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/kmsg/s390/kvm b/Documentation/kmsg/s390/kvm
>>>> index 76ffe2012254..6908476a54f1 100644
>>>> --- a/Documentation/kmsg/s390/kvm
>>>> +++ b/Documentation/kmsg/s390/kvm
>>>> @@ -10,3 +10,15 @@
>>>>     * If this problem persists after a reload of the kvm kernel module, gather
>>>>     * Linux debug data and contact your support organization.
>>>>     */
>>>> +
>>>> +/*?
>>>> + * Text: "Failed to initialize GIB rc=%d\n"
>>>> + * Severity: Error
>>>> + * Parameter:
>>>> + *   @1: return code of the GIB initialization call
>>>> + * Description:
>>>> + * The initialization if the GIB (Guest Information Block) was not successful.
>>>> + * User action:
>>>> + * If this problem persists after a reload of the kvm kernel module, gather
>>>> + * Linux debug data and contact your support organization.
>>>> + */
>>> This does not exist upstream. Wrong branch?
>>
>> No, not the wrong branch, wrong file. These are the very first kmsgs for
>> kvm and
>> it turns out that we defined
>>
>> #define KMSG_COMPONENT "kvm-s390"
>>
>> as the location.
> 
> The upstream s390 features branch does not contain a
> Documentation/kmsg/ directory. IIRC this was never accepted upstream?

I wasn't aware of that but see it now! So the patch has to be broken
up...

> 

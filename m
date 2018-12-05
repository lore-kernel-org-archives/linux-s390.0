From: Michael Mueller <mimu@linux.ibm.com>
Date: Wed, 05 Dec 2018 10:32:11 +0000
Subject: Re: [PATCH v4 07/10] KVM: s390: add function process_gib_alert_list()
Message-Id: <296aa18c-af44-86b3-5f8a-3a9bf727ab0d@linux.ibm.com>
In-Reply-To: <118e6e58-2643-614b-c361-6192b3e6138f@linux.ibm.com>
References: <118e6e58-2643-614b-c361-6192b3e6138f@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 05.12.18 11:19, Halil Pasic wrote:
> On Wed, 5 Dec 2018 10:57:33 +0100
> Michael Mueller<mimu@linux.ibm.com>  wrote:
> 
>>
>> On 05.12.18 10:09, Halil Pasic wrote:
>>> On Fri, 30 Nov 2018 15:32:12 +0100
>>> Michael Mueller<mimu@linux.ibm.com>  wrote:
>>>
>>>> This function processes the gib alert list. It is required to
>>>> run when either a gib alert interruption has been received or
>>>> a gisa that might be in the alert list is cleared or dropped.
>>>>
>>>> The GIB alert list contains all GISAs that have pending
>>>> adapter interruptions.
>>> I'm not sure this last paragraph is 100% correct. If e.g. all vcpus
>>> of a guest are in SIE we don't ask for alerting, and we would not get
>>> alerted when an IPM bit is set in the GISA.
>>>
>> I will discard the "all" to make it 99.999% correct.
>>
> :). It ain't important. But discarding "all" helps only marginally. I
> think we can have GISAs with IPM all zeros in the list. If I were to try
> being constructive, I would propose something like: " The GIB alert list
> contains GISAs of guests that may need a some vCPUS kicked
> so their GISA interrupts can be delivered". But it really ain't
> important. Feel free to keep it as is.

Sorry, I'm going to ignore this.

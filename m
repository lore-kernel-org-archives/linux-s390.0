From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 1/2] kvm vcpu: Note down pause loop exit
Date: Thu, 12 Jul 2012 16:32:15 +0530
Message-ID: <4FFEAEB7.2020908@linux.vnet.ibm.com>
References: <20120709062012.24030.37154.sendpatchset@codeblue> <20120709062032.24030.10454.sendpatchset@codeblue> <4FFD3F10.5020900@redhat.com> <4FFD5AED.3030307@linux.vnet.ibm.com> <878vep4558.fsf@abhimanyu.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <878vep4558.fsf@abhimanyu.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Rik van Riel <riel@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/12/2012 04:28 PM, Nikunj A Dadhania wrote:
> On Wed, 11 Jul 2012 16:22:29 +0530, Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>  wrote:
>> On 07/11/2012 02:23 PM, Avi Kivity wrote:
>>>
>>> This adds some tiny overhead to vcpu entry.  You could remove it by
>>> using the vcpu->requests mechanism to clear the flag, since
>>> vcpu->requests is already checked on every entry.
>>
>> So IIUC,  let's have request bit for indicating PLE,
>>
>> pause_interception() /handle_pause()
>> {
>>    make_request(PLE_REQUEST)
>>    vcpu_on_spin()
>>
>> }
>>
>> check_eligibility()
>>    {
>>    !test_request(PLE_REQUEST) || ( test_request(PLE_REQUEST)&&
>> dy_eligible())
>> .
>> .
>> }
>>
>> vcpu_run()
>> {
>>
>> check_request(PLE_REQUEST)
>>
> I know check_request will clear PLE_REQUEST, but you just need a
> clear_request here, right?
>

Yes. tried to use check_request for clearing. But I ended up in
different implementation. (latest thread)

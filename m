Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC Patch 0/2] KVM: SVM: Cgroup support for SVM SEV ASIDs
References: <20200922004024.3699923-1-vipinsh@google.com>
 <20200922014836.GA26507@linux.intel.com>
 <45117fcc-d6b8-fab9-11dc-79181058ed62@redhat.com>
 <b896ea83-7b98-7c86-f147-446faf2dbc44@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <b9a7ae9f-0ec0-cd44-b466-29f6552804ed@de.ibm.com>
Date: Mon, 28 Sep 2020 11:21:00 +0200
MIME-Version: 1.0
In-Reply-To: <b896ea83-7b98-7c86-f147-446faf2dbc44@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Vipin Sharma <vipinsh@google.com>
Cc: thomas.lendacky@amd.com, tj@kernel.org, lizefan@huawei.com, joro@8bytes.org, corbet@lwn.net, brijesh.singh@amd.com, jon.grimm@amd.com, eric.vantassell@amd.com, gingell@google.com, rientjes@google.com, kvm@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Paul Mackerras <paulus@ozlabs.org>

On 28.09.20 11:12, Janosch Frank wrote:
> On 9/23/20 2:47 PM, Paolo Bonzini wrote:
>> On 22/09/20 03:48, Sean Christopherson wrote:
>>> This should be genericized to not be SEV specific.  TDX has a similar
>>> scarcity issue in the form of key IDs, which IIUC are analogous to SEV ASIDs
>>> (gave myself a quick crash course on SEV ASIDs).  Functionally, I doubt it
>>> would change anything, I think it'd just be a bunch of renaming.  The hardest
>>> part would probably be figuring out a name :-).
>>>
>>> Another idea would be to go even more generic and implement a KVM cgroup
>>> that accounts the number of VMs of a particular type, e.g. legacy, SEV,
>>> SEV-ES?, and TDX.  That has potential future problems though as it falls
>>> apart if hardware every supports 1:MANY VMs:KEYS, or if there is a need to
>>> account keys outside of KVM, e.g. if MKTME for non-KVM cases ever sees the
>>> light of day.
>>
>> Or also MANY:1 (we are thinking of having multiple VMs share the same
>> SEV ASID).
>>
>> It might even be the same on s390 and PPC, in which case we probably
>> want to implement this in virt/kvm.  Paul, Janosch, do you think this
>> would make sense for you?  The original commit message is below.
>>
>> Paolo
>>
>>> On Mon, Sep 21, 2020 at 05:40:22PM -0700, Vipin Sharma wrote:
>>>> Hello,
>>>>
>>>> This patch series adds a new SEV controller for tracking and limiting
>>>> the usage of SEV ASIDs on the AMD SVM platform.
>>>>
>>>> SEV ASIDs are used in creating encrypted VM and lightweight sandboxes
>>>> but this resource is in very limited quantity on a host.
>>>>
>>>> This limited quantity creates issues like SEV ASID starvation and
>>>> unoptimized scheduling in the cloud infrastructure.
>>>>
>>>> SEV controller provides SEV ASID tracking and resource control
>>>> mechanisms.
>>
> 
> On s390 we currently support a few million protected guests per LPAR so
> guest IDs are not exactly scarce. However having accounting for them
> might add some value nevertheless, especially when having large amount
> of protected containers.
> 
> @Christian: Any thoughts on this?

Yes, maybe it is a good idea to limit containers to only have a sane number
of secure guests, so that a malicious pod cannot consume all IDs by calling
CREATE_VM and KVM_PV_ENABLE million times or so.

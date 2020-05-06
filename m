Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbgEFGIf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 02:08:35 -0400
Subject: Re: [PATCH] KVM: s390: Remove false WARN_ON_ONCE for the PQAP
 instruction
References: <20200505073525.2287-1-borntraeger@de.ibm.com>
 <20200505095332.528254e5.cohuck@redhat.com>
 <f3512a63-91dc-ab9a-a9ab-3e2a6e24fea3@de.ibm.com>
 <889a7e3d-8318-4c85-67c8-a42a665b56f4@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <39228085-aed6-2fe8-79bc-dfd21c8cf2e9@de.ibm.com>
Date: Wed, 6 May 2020 08:08:28 +0200
MIME-Version: 1.0
In-Reply-To: <889a7e3d-8318-4c85-67c8-a42a665b56f4@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Qian Cai <cailca@icloud.com>, Pierre Morel <pmorel@linux.ibm.com>



On 06.05.20 00:34, Tony Krowiak wrote:
> 
> 
> On 5/5/20 3:55 AM, Christian Borntraeger wrote:
>>
>> On 05.05.20 09:53, Cornelia Huck wrote:
>>> On Tue,  5 May 2020 09:35:25 +0200
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>
>>>> In LPAR we will only get an intercept for FC==3 for the PQAP
>>>> instruction. Running nested under z/VM can result in other intercepts as
>>>> well, for example PQAP(QCI). So the WARN_ON_ONCE is not right. Let
>>>> us simply remove it.
>>> While I agree with removing the WARN_ON_ONCE, I'm wondering why z/VM
>>> gives us intercepts for those fcs... is that just a result of nesting
>>> (or the z/VM implementation), or is there anything we might want to do?
>> Yes nesting.
>> The ECA bit for interpretion is an effective one. So if the ECA bit is off
>> in z/VM (no crypto cards) our ECA bit is basically ignored as these bits
>> are ANDed.
>> I asked Tony to ask the z/VM team if that is the case here.
> 
> I apologize, but I was on vacation yesterday and did not have a
> chance to look at this until today. I left a slack message for
> my z/VM contact, but have not yet gotten a response.
> 
> The only AP virtualization support we currently provide with
> Linux on Z relies on AP interpretive execution. The ECA.28
> bit in the SIE state description determines whether AP
> instructions executed on a guest are intercepted (0) or
> interpreted (1). The problem here is that ECA.28 is an
> effective control meaning that ECA.28 for the guest is
> logically ANDed with the host's. If linux is running as a
> guest of z/VM and z/VM is sets ECA.28 to zero,
> then ECA.28 for the guest will also be zero, in which case
> every AP instruction executed on the guest will be intercepted.
> 
> The only AP instruction that has an interception handler is
> PQAP with function code 0x03 (AP-queue interruption control), so
> this warning is being issued for all other AP instructions being
> intercepted; so, maybe this is the right thing to do? After all,
> running a linux as a guest of z/VM that is setting ECA.28 to zero is not
> a supported configuration.
> 
> Having said that, the root of the problem is the fact that
> a guest is allowed to start without AP interpretive execution
> turned on because that is the only currently supported configuration.
> If there is a way to determine the effective value of ECA.28 for a
> KVM guest, when KVM could respond appropriately when QEMU
> queries whether the KVM_S390_VM_CRYPTO_ENABLE_APIE attribute
> is available in the CPU model. If it is not, then QEMU does not set the
> S390_FEAT_AP (AP instructions installed) feature and a guest started
> with cpu model feature ap='on' will fail to start.

I think the problem is that there is no way to find out the effective value
of ECA_APIE (and I think this could even change during the lifetime of a
guest). So I see 3 options:
1. check for z/VM and do not advertise crypto (ap=on will always fail). This
will disable the possibility to pass through a pass through device. (I think
if the zVM guest has an adapter APDEDICATED then z/VM does set ECA_APIE)
2. reject all crypto instructions that do exit and are not fc==3 (PQAP ACIQ).
This is kind of not ideal as we will pass through facility stfle.12 (PQAP QCI)
but then fail to handle it. Linux does handle faults on these instructions just
fine, though. 
3. Implement emulation of crypto. I think this not what we want to do, especially
as this only makes sense for acceleration but not for any of the secure key
or protected key schemes.

The WARN_ON is certainly something that must go as long as we construct cases
that can trigger this.

So I would suggest to go with the miminal patch (variant 2) which basically just
removes the WARN_ON.
We can then think about doing a nicer variant on top.
e.g. implement PQAP QCI that just returns an empty config. I will look into this.

From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 05/11] KVM: s390: Support Configuration z/Architecture
 Mode
Date: Mon, 28 Aug 2017 11:14:42 +0200
Message-ID: <21f91dc3-07aa-48ca-8a41-bfbec1668f80@de.ibm.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
 <1503907651-65296-2-git-send-email-borntraeger@de.ibm.com>
 <20170828110746.774d00e3.cohuck@redhat.com>
 <5865af6d-863f-f6b1-bc72-b2eec2ce953b@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <5865af6d-863f-f6b1-bc72-b2eec2ce953b@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 08/28/2017 11:11 AM, Christian Borntraeger wrote:
> 
> 
> On 08/28/2017 11:07 AM, Cornelia Huck wrote:
>> On Mon, 28 Aug 2017 10:07:28 +0200
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
>>>
>>> kvm has always supported the concept of starting in z/Arch mode so let's
>>> reflect the feature bit to the guest.
>>>
>>> Also, we change sigp set architecture to reject any request to change
>>> architecture modes.
>>
>> What are the implications of this for guests? IIRC, czam is a z14
>> feature (the updated PoP is not yet out, is it?). We now reject any set
>> arch sigp, even if we profess to be an older machine. Linux can
>> probably deal with this, but is it correct?
> 
> Linux can deal with it. Since KVM does not support IPL in ESA mode, we basically
> always provided the czam functionality. We now do it like it was architected.
> z/VM does it the same way when enabling czam on an older system like z13.
> 
> In other words the old code was not compliant (and never was), the new code
> is compliant. Since czam is kind of a "negative" facility, we can implement
> it also on older systems.

FWIW, this code will only run when QEMU does not enable the SIGP forwarding. 
All new QEMUs handle this in QEMU. The equivalent fix in QEMU is

commit 075e52b816648f21ca6bf5cc01624dff3993c99e
Author:     Jason J. Herne <jjherne@linux.vnet.ibm.com>
AuthorDate: Thu Sep 1 10:56:49 2016 +0200
Commit:     Christian Borntraeger <borntraeger@de.ibm.com>
CommitDate: Fri Jul 14 12:29:49 2017 +0200

    s390x/cpumodel: we are always in zarchitecture model

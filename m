From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 0/6] KVM: s390: Fixes and features for 4.16
Date: Tue, 16 Jan 2018 16:35:45 +0100
Message-ID: <10d9385c-923c-c932-927e-baa335516be6@redhat.com>
References: <20180116150314.201352-1-borntraeger@de.ibm.com>
 <a35355a6-26f9-ab7d-d9cd-80edd9181866@redhat.com>
 <69c45e6a-9ad6-ecb5-c7e2-1660ef35ffff@de.ibm.com>
 <20180116152724.GA23579@flask>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116152724.GA23579@flask>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 16/01/2018 16:27, Radim Krčmář wrote:
>>> We probably will have to rebase kvm/next, sorry, to remove a series that
>>> had problems and (worse) complaints from the arch/x86 maintainers. :(
>>> Can you rebase on top of 5cb0944c0c66004c0d9006a7f0fba5782ae38
>> Can you (when doing that) rebase on something newer? rc3 is broken in many ways
>> and only works on some of my test systems (those without multipath).
> I'd like to avoid rebasing that much -- so far we're only rebasing
> patches since Jan 11 and there is a batch from Dec 14 on top of rc3.
> 
>> I will rebase on 4.15-rc3 to give you all the freedom you need. 
> I think that basing s390 on a later -rc would work for all of us,

I agree---unless you need to rebase on top the VCPU lock pushdown,
4.15-rc3 would work great.

Paolo

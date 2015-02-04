From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/7] KVM: s390/CPACF: Choose crypto control block format
Date: Wed, 04 Feb 2015 14:48:09 +0100
Message-ID: <54D22319.4010009@redhat.com>
References: <1423043092-34044-1-git-send-email-borntraeger@de.ibm.com> <1423043092-34044-5-git-send-email-borntraeger@de.ibm.com> <54D217F8.5050302@redhat.com> <54D2191C.9000604@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <54D2191C.9000604@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 04/02/2015 14:05, Christian Borntraeger wrote:
>> > 
>> > Could this also be part of the "things" that KVM can choose to enable,
>> > even though it's not a facility?
> Can you re-ask that question? Not sure what you want to know. 
> 
> This is mostly a fixup for z13, which wants to have a bigger control block. but
> this block is not guest visible.

Okay, this is what I was asking.  If the block is not guest visible
that's fine.

What happens if the guest executes PQAP(QCI)?

Paolo

> Talking about key wrapping, this is actually masked via a facility bit (for MSA-3
> and MSA-4), therefore we have the test_vfacility thing in that function.

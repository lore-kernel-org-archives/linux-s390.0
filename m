Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfILLIk (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 07:08:40 -0400
Subject: Re: [PATCH] KVM: s390: Do not leak kernel stack data in the
 KVM_S390_INTERRUPT ioctl
References: <20190912090050.20295-1-thuth@redhat.com>
 <4ed0c815-c598-bb0f-9841-d579fc62877f@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b5b920af-49c0-6392-3ebf-74148310fb72@redhat.com>
Date: Thu, 12 Sep 2019 13:08:33 +0200
MIME-Version: 1.0
In-Reply-To: <4ed0c815-c598-bb0f-9841-d579fc62877f@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/09/2019 12.47, Christian Borntraeger wrote:
> 
> 
> On 12.09.19 11:00, Thomas Huth wrote:
>> When the userspace program runs the KVM_S390_INTERRUPT ioctl to inject
>> an interrupt, we convert them from the legacy struct kvm_s390_interrupt
>> to the new struct kvm_s390_irq via the s390int_to_s390irq() function.
>> However, this function does not take care of all types of interrupts
>> that we can inject into the guest later (see do_inject_vcpu()). Since we
>> do not clear out the s390irq values before calling s390int_to_s390irq(),
>> there is a chance that we copy unwanted data from the kernel stack
>> into the guest memory later if the interrupt data has not been properly
>> initialized by s390int_to_s390irq().
> 
> You mean by using the migration callbacks to get all interrupts back to 
> userspace?

Oh, I was not thinking about GET_IRQ_STATE yet, I was thinking about
__deliver_pfault_init() which would deliver the value into the guest
memory (from where the userspace program could extract it again).

>> Specifically, the problem exists with the KVM_S390_INT_PFAULT_INIT
>> interrupt: s390int_to_s390irq() does not handle it, but the function
>> __deliver_pfault_init() will later copy the uninitialized stack data
>> from the ext.ext_params2 into the guest memory.
> 
> Shouldnt we add some more detailed description how this can happen?
> Something like
> "By using the KVM_S390_INTERRUPT ioctl with a KVM_S390_INT_PFAULT_INIT
> interrupt followed by the KVM_S390_GET_IRQ_STATE ioctl the user can
> extract a value from the kernel stack."

GET_IRQ_STATE certainly deserves to be mentioned here, I'll add it to
the patch description and will send a v2.

 Thomas

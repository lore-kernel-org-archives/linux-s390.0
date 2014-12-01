From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 05/11] KVM: s390: refactor interrupt injection code
Date: Mon, 01 Dec 2014 09:00:28 +0100
Message-ID: <547C201C.7010004@de.ibm.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com> <1417181139-25623-6-git-send-email-borntraeger@de.ibm.com> <5478ADD3.10307@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <5478ADD3.10307@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 28.11.2014 um 18:16 schrieb Paolo Bonzini:
> 
> 
> On 28/11/2014 14:25, Christian Borntraeger wrote:
>>  
>> +static int __inject_prog_irq(struct kvm_vcpu *vcpu,
>> +			     struct kvm_s390_interrupt_info *inti)
>> +{
> 
> Why the __s? :)

In this case because its called with a lock already held. (from kvm_s390_inject_vcpu).
I usually extend the usage of the __ prefix to "heho, pay attention. YOu are calling this function, but you are maybe supposed to do something else).

Christian

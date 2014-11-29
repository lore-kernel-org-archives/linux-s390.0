From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 09/11] KVM: s390: add bitmap for handling cpu-local
 interrupts
Date: Sat, 29 Nov 2014 22:05:10 +0100
Message-ID: <547A3506.1080908@de.ibm.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com> <1417181139-25623-10-git-send-email-borntraeger@de.ibm.com> <5478AE7D.7010805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <5478AE7D.7010805@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 28.11.2014 um 18:18 schrieb Paolo Bonzini:
> 
> 
> On 28/11/2014 14:25, Christian Borntraeger wrote:
>>  
>> +struct kvm_s390_irq_payload {
>> +	struct kvm_s390_io_info io;
>> +	struct kvm_s390_ext_info ext;
>> +	struct kvm_s390_pgm_info pgm;
>> +	struct kvm_s390_emerg_info emerg;
>> +	struct kvm_s390_extcall_info extcall;
>> +	struct kvm_s390_prefix_info prefix;
>> +	struct kvm_s390_mchk_info mchk;
>> +};
>> +
> 
> struct or union?

struct. This is used for keeping the payload of the interrupts. Multiple different interrupts can be pending and most of them have payload - we want to keep everything.

Now, looking at that code again, as I/O is floating and emergency is also handled via a separate bitmap we could get rid of these two in a follow-up patch. Jens, can you have a look and prepare a followup-cleanup if appropriate?
Christian

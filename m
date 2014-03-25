From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PULL 4/4] KVM: s390: clear local interrupts at cpu initial reset
Date: Tue, 25 Mar 2014 15:18:12 +0100
Message-ID: <53319024.1030306@de.ibm.com>
References: <1395754523-43697-1-git-send-email-borntraeger@de.ibm.com> <1395754523-43697-5-git-send-email-borntraeger@de.ibm.com> <53318B25.9070805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <53318B25.9070805@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 25/03/14 14:56, Paolo Bonzini wrote:
> Il 25/03/2014 14:35, Christian Borntraeger ha scritto:
>> +    spin_lock_bh(&li->lock);
>> +    list_for_each_entry_safe(inti, n, &li->list, list) {
>> +        list_del(&inti->list);
>> +        kfree(inti);
>> +    }
>> +    atomic_set(&li->active, 0);
>> +    spin_unlock_bh(&li->lock);
>> +}
> 
> Out of curiosity, why the _bh?

Probably just copied from all other accesses. We normally protect against the hrtimer 
wakeup bottom half(see kvm_s390_tasklet). For normal guests/userspace this should not
happen, (after all we are resetting the CPU only on startup or during reset when the vCPUS
are nor running) but the KVM interface allows to trigger this while the CPU is waiting
for a timer.

In fact I think your question just made me realize that this code needs some more
fixes, e.g. resetting the timer on initial reset and getting the CPU out of wait.
Will investigate.

Christian

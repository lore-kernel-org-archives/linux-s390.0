From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCHv2/RFC] kvm/irqchip: Speed up KVM_SET_GSI_ROUTING
Date: Thu, 16 Jan 2014 14:06:39 +0100
Message-ID: <52D7D95F.5040600@de.ibm.com>
References: <52D7C186.1070700@redhat.com> <1389876260-46636-1-git-send-email-borntraeger@de.ibm.com> <52D7D7A2.2080409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <52D7D7A2.2080409@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@minantech.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, agraf@suse.de, mst@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 16/01/14 13:59, Paolo Bonzini wrote:
> Il 16/01/2014 13:44, Christian Borntraeger ha scritto:
>> I converted most of the rcu routines to srcu. Review for the unconverted
>> use of hlist_for_each_entry_rcu, hlist_add_head_rcu, hlist_del_init_rcu
>> is necessary, though. They look fine to me since they are protected by
>> outer functions.
> 
> They are fine because they do not have lockdep checks
> (hlist_for_each_entry_rcu uses rcu_dereference_raw rather than
> rcu_dereference, and write-sides do not do rcu lockdep at all).
> 
>> In addition, we should also discuss if a global srcu (for all guests) is
>> fine.
> 
> I think it is.  It is already way cheaper than it used to be, and we're
> hardly relying on the "sleepable" part of srcu.  We just want its faster
> detection of grace periods.  One instance should be fine because our
> read sides are so small and mostly they are not even preemptable.
> 
> Thanks for writing the patch!
> 
> Paolo
> 

Will you edit the patch description or shall I resend the patch?

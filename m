From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] KVM: Provide function for VCPU lookup by id
Date: Thu, 19 Nov 2015 13:55:27 +0100
Message-ID: <20151119135527.77ab6fda@thinkpad-w530>
References: <1447922251-54261-1-git-send-email-borntraeger@de.ibm.com>
	<1447922251-54261-2-git-send-email-borntraeger@de.ibm.com>
	<564DBC88.5020508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <564DBC88.5020508@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> 
> Any chance that you name this function differently? Otherwise we've got
> two functions that sound very similar and also have similar prototypes:
> 
> - kvm_get_vcpu(struct kvm *kvm, int i)
> - kvm_lookup_vcpu(struct kvm *kvm, int id)
> 
> I'm pretty sure this will cause confusion in the future!
> ==> Could you maybe name the new function something like
> "kvm_lookup_vcpu_by_id" or "kvm_get_vcpu_by_id" instead?

Had that in a previous version but decided to name it that way ... hmm ...
other opinions?

> 
> Also a short comment before the function would be nice to make the
> reader aware of the difference (e.g. when hot-plugging) between the
> vcpu-id and array-id.

Also not sure as the header directly includes the (for my eyes ;) ) easy code.
I would agree for a pure prototype. Other opinions?

> 
> Otherwise: +1 for finally having a proper common function for this!
> 

Thanks for having a look Thomas!

David

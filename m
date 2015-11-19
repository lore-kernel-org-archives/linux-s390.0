From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] KVM: Provide function for VCPU lookup by id
Date: Thu, 19 Nov 2015 14:36:03 +0100
Message-ID: <20151119143603.132952e7@thinkpad-w530>
References: <1447922251-54261-1-git-send-email-borntraeger@de.ibm.com>
	<1447922251-54261-2-git-send-email-borntraeger@de.ibm.com>
	<564DBC88.5020508@redhat.com>
	<20151119135527.77ab6fda@thinkpad-w530>
	<564DCAED.8020805@redhat.com>
	<564DCD43.8080108@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <564DCD43.8080108@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> On 11/19/2015 02:13 PM, Paolo Bonzini wrote:
> > 
> > 
> > On 19/11/2015 13:55, David Hildenbrand wrote:
> >>>>
> >>>> I'm pretty sure this will cause confusion in the future!
> >>>> ==> Could you maybe name the new function something like
> >>>> "kvm_lookup_vcpu_by_id" or "kvm_get_vcpu_by_id" instead?
> >> Had that in a previous version but decided to name it that way ... hmm ...
> >> other opinions?
> > 
> > Having _by_id at the end of the name makes sense indeed.
> 
> David,
> I will fix up the function name myself to kvm_get_vcpu_by_id. Ok?

Sure, thanks a lot!

David

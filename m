From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCHv3] kvm/irqchip: Speed up KVM_SET_GSI_ROUTING
Date: Fri, 17 Jan 2014 16:26:56 +0100
Message-ID: <52D94BC0.9010803@redhat.com>
References: <52D7C186.1070700@redhat.com> <1389876260-46636-1-git-send-email-borntraeger@de.ibm.com> <20140116185520.GC29522@redhat.com> <52D83BF2.6030705@de.ibm.com> <20140116202213.GF29522@redhat.com> <52D9383F.7040206@redhat.com> <52D94637.8090602@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <52D94637.8090602@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gleb Natapov <gleb@minantech.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

Il 17/01/2014 16:03, Christian Borntraeger ha scritto:
> > Well... I love to contradict myself, so: no way this can be accepted
> > this close to the end of the merge window.  :(
> > 
> > synchronize_rcu_expedited() forces a context switch on all CPUs, even
> > those that are not running KVM.  Thus, this patch might help a guest DoS
> > its host by changing the IRQ routing tables in a loop.
> > 
> > So this will have to wait for 3.15.  We have ~2 months to do performance
> > measurements on the v2 patch.  Sorry.
> 
> Any chance that you or Michael can give some performance feedback on v2? All
> my lab systems are s390 and not x86...

Yes, we will help.

Paolo

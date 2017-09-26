From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: Disable CONFIG_S390_GUEST_OLD_TRANSPORT by
 default
Date: Tue, 26 Sep 2017 13:10:52 +0200
Message-ID: <20170926131052.4f97f86d.cohuck@redhat.com>
References: <1506350729-11311-1-git-send-email-thuth@redhat.com>
        <3c2b8ae8-ca2a-7b26-8ebd-14f14c286529@linux.vnet.ibm.com>
        <83cacb4a-94b1-c7c2-e50d-70afea5d3e9c@de.ibm.com>
        <20170926104019.GA3209@osiris>
        <376655d1-87e3-4187-d2d1-d1f23c02431a@de.ibm.com>
        <20170926104752.GB3209@osiris>
        <ec6d80f2-17ca-4a5f-a357-5cc165b1acfd@redhat.com>
        <20170926110403.GC3209@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170926110403.GC3209@osiris>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 26 Sep 2017 13:04:03 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Tue, Sep 26, 2017 at 12:57:26PM +0200, Thomas Huth wrote:
> > On 26.09.2017 12:47, Heiko Carstens wrote:  
> > > So it's going to be removed with the next merge window.
> > > Where is the patch? ;)  
> > 
> > Hmm, so far the code was always enabled by default, so in the unlikely
> > case that somebody is still using it, they might not have noticed that
> > this is marked as deprecated. So maybe it's better to keep the code for
> > two more released, but disable it by default, so that people have time
> > to realize that it is going away? ... just my 0.02 € ... but if you
> > prefer, I can also write a patch that removes it immediately instead.  
> 
> Switching the default from yes to no won't prevent anybody from selecting
> it again. So I don't see any value in waiting even longer.
> 
> Besides the original commit already printed a message to the console that
> the transport is deprecated.
> See commit 3b2fbb3f06ef ("virtio/s390: deprecate old transport").
> 

Would ack a removal as well.

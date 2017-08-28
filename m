From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 05/11] KVM: s390: Support Configuration z/Architecture
 Mode
Date: Mon, 28 Aug 2017 13:33:53 +0200
Message-ID: <20170828133353.077b66ed.cohuck@redhat.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
        <1503907651-65296-2-git-send-email-borntraeger@de.ibm.com>
        <20170828110746.774d00e3.cohuck@redhat.com>
        <5865af6d-863f-f6b1-bc72-b2eec2ce953b@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <5865af6d-863f-f6b1-bc72-b2eec2ce953b@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 28 Aug 2017 11:11:15 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 08/28/2017 11:07 AM, Cornelia Huck wrote:
> > On Mon, 28 Aug 2017 10:07:28 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> >>
> >> kvm has always supported the concept of starting in z/Arch mode so let's
> >> reflect the feature bit to the guest.
> >>
> >> Also, we change sigp set architecture to reject any request to change
> >> architecture modes.  
> > 
> > What are the implications of this for guests? IIRC, czam is a z14
> > feature (the updated PoP is not yet out, is it?). We now reject any set
> > arch sigp, even if we profess to be an older machine. Linux can
> > probably deal with this, but is it correct?  
> 
> Linux can deal with it. Since KVM does not support IPL in ESA mode, we basically
> always provided the czam functionality. We now do it like it was architected.
> z/VM does it the same way when enabling czam on an older system like z13.

OK, this implies any z operating system needs to be able to deal with
czam on older machines.

> In other words the old code was not compliant (and never was), the new code
> is compliant. Since czam is kind of a "negative" facility, we can implement
> it also on older systems.

Looking at this, we should mirror this in qemu in tcg mode, as the
corresponding qemu patch only handles the kvm path (I obviously did not
look at the patch in enough detail...) Added to my list.

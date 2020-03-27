Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47940 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbgC0KlE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 06:41:04 -0400
Date: Fri, 27 Mar 2020 11:40:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] s390/gmap: return proper error code on ksm unsharing
Message-ID: <20200327114049.3d2aa4c7.cohuck@redhat.com>
In-Reply-To: <20200327113954.6d7c31e6.cohuck@redhat.com>
References: <20200327092356.25171-1-borntraeger@de.ibm.com>
        <859b9810-eb50-6f81-ec12-3f22cc5c1d2c@de.ibm.com>
        <20200327113954.6d7c31e6.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Fri, 27 Mar 2020 11:39:54 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 27 Mar 2020 11:23:33 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > On 27.03.20 10:23, Christian Borntraeger wrote:
> 
> > After the qemu patch discussion I would add
> > 
> > 
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index 0e268b3d1591..ba8f9cbe4376 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -4680,6 +4680,12 @@ KVM_PV_ENABLE
> >    command has succeeded, any CPU added via hotplug will become
> >    protected during its creation as well.
> >  
> > +  Errors:
> > +
> > +  =====      =============================
> > +  EINTR      an unmasked signal is pending
> > +  =====      =============================
> > +
> >  KVM_PV_DISABLE
> >  
> >    Deregister the VM from the Ultravisor and reclaim the memory that
> > 
> > 
> > and change the patch description to something like
> > 
> > 
> >     s390/gmap: return proper error code on ksm unsharing
> >     
> >     If a signal is pending we might return -ENOMEM instead of -EINTR.
> >     We should propagate the proper error during KSM unsharing.
> >     unmerge_ksm_pages returns -ERESTARTSYS on signal_pending. This gets
> >     translated by entry.S to -EINTR. It is important to get this error
> >     code so that userspace can retry.
> >     
> >     Fixes: 3ac8e38015d4 ("s390/mm: disable KSM for storage key enabled pages")
> >     Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> >     Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> >     Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> >     Reviewed-by: David Hildenbrand <david@redhat.com>
> >     Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > 
> 
> LGTM

...well, if you add my

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

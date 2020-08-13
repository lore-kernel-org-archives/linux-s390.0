Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgHMB7w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 12 Aug 2020 21:59:52 -0400
MIME-Version: 1.0
References: <1597260071-2219-1-git-send-email-mjrosato@linux.ibm.com>
 <1597260071-2219-2-git-send-email-mjrosato@linux.ibm.com> <20200812143254.2f080c38@x1.home>
In-Reply-To: <20200812143254.2f080c38@x1.home>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 13 Aug 2020 11:59:40 +1000
Message-ID: <CAOSf1CFh4ygZeeqpjpbWFWxJJEpDjHD+Q_L4dUaU_3wx7_35pg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Introduce flag for detached virtual functions
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, schnelle@linux.ibm.com, pmorel@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, linux-s390@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>

On Thu, Aug 13, 2020 at 6:33 AM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Wed, 12 Aug 2020 15:21:11 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
>
> > @@ -521,7 +522,8 @@ static int vfio_basic_config_read(struct vfio_pci_device *vdev, int pos,
> >       count = vfio_default_config_read(vdev, pos, count, perm, offset, val);
> >
> >       /* Mask in virtual memory enable for SR-IOV devices */
> > -     if (offset == PCI_COMMAND && vdev->pdev->is_virtfn) {
> > +     if ((offset == PCI_COMMAND) &&
> > +         (vdev->pdev->is_virtfn || vdev->pdev->detached_vf)) {
> >               u16 cmd = le16_to_cpu(*(__le16 *)&vdev->vconfig[PCI_COMMAND]);
> >               u32 tmp_val = le32_to_cpu(*val);
> >
> > @@ -1734,7 +1736,8 @@ int vfio_config_init(struct vfio_pci_device *vdev)
> >                                vconfig[PCI_INTERRUPT_PIN]);
> >
> >               vconfig[PCI_INTERRUPT_PIN] = 0; /* Gratuitous for good VFs */
> > -
> > +     }
> > +     if (pdev->is_virtfn || pdev->detached_vf) {
> >               /*
> >                * VFs do no implement the memory enable bit of the COMMAND
> >                * register therefore we'll not have it set in our initial
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 8355306..23a6972 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -445,6 +445,7 @@ struct pci_dev {
> >       unsigned int    is_probed:1;            /* Device probing in progress */
> >       unsigned int    link_active_reporting:1;/* Device capable of reporting link active */
> >       unsigned int    no_vf_scan:1;           /* Don't scan for VFs after IOV enablement */
> > +     unsigned int    detached_vf:1;          /* VF without local PF access */
>
> Is there too much implicit knowledge in defining a "detached VF"?  For
> example, why do we know that we can skip the portion of
> vfio_config_init() that copies the vendor and device IDs from the
> struct pci_dev into the virtual config space?  It's true on s390x, but
> I think that's because we know that firmware emulates those registers
> for us.
>
> We also skip the INTx pin register sanity checking.  Do we do
> that because we haven't installed the broken device into an s390x
> system?  Because we know firmware manages that for us too?  Or simply
> because s390x doesn't support INTx anyway, and therefore it's another
> architecture implicit decision?

Agreed. Any hacks we put in for normal VFs are going to be needed for
the passed-though VF case. Only applying the memory space enable
workaround doesn't make sense to me either.

> If detached_vf is really equivalent to is_virtfn for all cases that
> don't care about referencing physfn on the pci_dev, then we should
> probably have a macro to that effect.

A pci_is_virtfn() helper would be better than open coding both checks
everywhere. That said, it might be solving the wrong problem. The
union between ->physfn and ->sriov has always seemed like a footgun to
me so we might be better off switching the users who want a physfn to
a helper instead. i.e.

struct pci_dev *pci_get_vf_physfn(struct pci_dev *vf)
{
        if (!vf->is_virtfn)
                return NULL;

        return vf->physfn;
}

...

pf = pci_get_vf_physfn(vf)
if (pf)
    /* do pf things */

Then we can just use ->is_virtfn for the normal and detached cases.

Oliver

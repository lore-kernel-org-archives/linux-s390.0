Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730175AbgIJBza (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 9 Sep 2020 21:55:30 -0400
Date: Wed, 9 Sep 2020 19:39:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 1/3] PCI/IOV: Mark VFs as not implementing MSE bit
Message-ID: <20200910003916.GA741660@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f95349-237e-34e2-66ef-e626cd4aec25@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: alex.williamson@redhat.com, bhelgaas@google.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, cohuck@redhat.com, kevin.tian@intel.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 01:10:02PM -0400, Matthew Rosato wrote:
> On 9/3/20 12:41 PM, Bjorn Helgaas wrote:

> >    - How do we decide whether to use dev_flags vs a bitfield like
> >      dev->is_virtfn?  The latter seems simpler unless there's a reason
> >      to use dev_flags.  If there's a reason, maybe we could add a
> >      comment at pci_dev_flags for future reference.
> 
> Something like:
> 
> /*
>  * Device does not implement PCI_COMMAND_MEMORY - this is true for any
>  * device marked is_virtfn, but is also true for any VF passed-through
>  * a lower-level hypervisor where emulation of the Memory Space Enable
>  * bit was not provided.
>  */
> PCI_DEV_FLAGS_NO_COMMAND_MEMORY = (__force pci_dev_flags_t) (1 << 12),

Sorry, I wasn't clear about this.  I was trying to suggest that if
there are some situations where we need to use pci_dev_flags instead
of a bitfield, it would be useful to have a generic comment to help
decide between them.

I don't know that there *is* a good reason, and unless somebody can
think of one, I'd like to get rid of pci_dev_flags completely and
convert them all to bitfields.

Given that, my preference would be to just add a new bitfield,
something like this:

  struct pci_dev {
    ...
    unsigned int no_command_memory:1;  /* No PCI_COMMAND_MEMORY */

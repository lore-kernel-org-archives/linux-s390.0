Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 27 Aug 2020 13:17:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3] PCI: Introduce flag for detached virtual functions
Message-ID: <20200827131748.46b3f8bc@x1.home>
In-Reply-To: <20200827183138.GA1929779@bjorn-Precision-5520>
References: <1597333243-29483-2-git-send-email-mjrosato@linux.ibm.com>
        <20200827183138.GA1929779@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, bhelgaas@google.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

On Thu, 27 Aug 2020 13:31:38 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> Re the subject line, this patch does a lot more than just "introduce a
> flag"; AFAICT it actually enables important VFIO functionality, e.g.,
> something like:
> 
>   vfio/pci: Enable MMIO access for s390 detached VFs
> 
> On Thu, Aug 13, 2020 at 11:40:43AM -0400, Matthew Rosato wrote:
> > s390x has the notion of providing VFs to the kernel in a manner
> > where the associated PF is inaccessible other than via firmware.
> > These are not treated as typical VFs and access to them is emulated
> > by underlying firmware which can still access the PF.  After
> > the referened commit however these detached VFs were no longer able
> > to work with vfio-pci as the firmware does not provide emulation of
> > the PCI_COMMAND_MEMORY bit.  In this case, let's explicitly recognize
> > these detached VFs so that vfio-pci can allow memory access to
> > them again.  
> 
> Out of curiosity, in what sense is the PF inaccessible?  Is it
> *impossible* for Linux to access the PF, or is it just not enumerated
> by clp_list_pci() so Linux doesn't know about it?
> 
> VFs do not implement PCI_COMMAND, so I guess "firmware does not
> provide emulation of PCI_COMMAND_MEMORY" means something like "we
> can't access the PF so we can't enable/disable PCI_COMMAND_MEMORY"?
> 
> s/referened/referenced/
> 
> > Fixes: abafbc551fdd ("vfio-pci: Invalidate mmaps and block MMIO access on disabled memory")
> > Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > ---
> >  arch/s390/pci/pci_bus.c            | 13 +++++++++++++
> >  drivers/vfio/pci/vfio_pci_config.c |  8 ++++----
> >  include/linux/pci.h                |  4 ++++
> >  3 files changed, 21 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> > index 642a993..1b33076 100644
> > --- a/arch/s390/pci/pci_bus.c
> > +++ b/arch/s390/pci/pci_bus.c
> > @@ -184,6 +184,19 @@ static inline int zpci_bus_setup_virtfn(struct zpci_bus *zbus,
> >  }
> >  #endif
> >  
> > +void pcibios_bus_add_device(struct pci_dev *pdev)
> > +{
> > +	struct zpci_dev *zdev = to_zpci(pdev);
> > +
> > +	/*
> > +	 * If we have a VF on a non-multifunction bus, it must be a VF that is
> > +	 * detached from its parent PF.  We rely on firmware emulation to
> > +	 * provide underlying PF details.  
> 
> What exactly does "multifunction bus" mean?  I'm familiar with
> multi-function *devices*, but not multi-function buses.
> 
> > +	 */
> > +	if (zdev->vfn && !zdev->zbus->multifunction)
> > +		pdev->detached_vf = 1;
> > +}
> > +
> >  static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
> >  {
> >  	struct pci_bus *bus;
> > diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> > index d98843f..98f93d1 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
> > @@ -406,7 +406,7 @@ bool __vfio_pci_memory_enabled(struct vfio_pci_device *vdev)
> >  	 * PF SR-IOV capability, there's therefore no need to trigger
> >  	 * faults based on the virtual value.
> >  	 */
> > -	return pdev->is_virtfn || (cmd & PCI_COMMAND_MEMORY);
> > +	return dev_is_vf(&pdev->dev) || (cmd & PCI_COMMAND_MEMORY);  
> 
> I'm not super keen on the idea of having two subtly different ways of
> identifying VFs.  I think that will be confusing.  This seems to be
> the critical line, so whatever we do here, it will be out of the
> ordinary and probably deserves a little comment.
> 
> If Linux doesn't see the PF, does pci_physfn(VF) return NULL, i.e., is
> VF->physfn NULL?

FWIW, pci_physfn() never returns NULL, it returns the provided pdev if
is_virtfn is not set.  This proposal wouldn't change that return value.
AIUI pci_physfn(), the caller needs to test that the returned device is
different from the provided device if there's really code that wants to
traverse to the PF.

My interpretation of what's happening here is that we're a guest
running on a bare metal hypervisor (I assume z/VM) and we're assigned a
VF that appears on this non-multifunction bus, but the hypervisor
doesn't provide emulation of all of the non-implemented config space
features of a VF, the memory enable bit being relevant for this fix.
We're therefore trying to detect this VF nature of the device, which
gets a bit messy since a VF implies a PF on bare metal.  The PF would
be owned by the hypervisor and not accessible to us.

An alternative idea we tossed around, that might still be a possibility,
is using dev_flags to describe the specific missing feature, for
example something about the command register memory bit being hardwired
to zero but always enabled (assuming the PF SR-IOV MSE bit is not
cleared).  Thanks,

Alex

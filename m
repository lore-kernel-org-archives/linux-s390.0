From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Feb 2018 12:39:16 +0000
Subject: Re: [PATCH v4 3/3] s390/setup : enable display support for KVM guest
Message-Id: <20180227123916.GA31888@kroah.com>
References: <cover.1519315352.git.alifm@linux.vnet.ibm.com>
 <e23b61f4f599ba23881727a1e8880e9d60cc6a48.1519315352.git.alifm@linux.vnet.ibm.com>
 <0b58aec3-7434-e059-386d-2dacebdf39aa@de.ibm.com>
In-Reply-To: <0b58aec3-7434-e059-386d-2dacebdf39aa@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, cohuck@redhat.com, tomi.valkeinen@ti.com, b.zolnierkie@samsung.com, geert@linux-m68k.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 27, 2018 at 10:23:34AM +0100, Christian Borntraeger wrote:
> Greg FYI, I plan to carry this patch via the s390/kvm tree.
> As it drivers/tty/Kconfig, can you give an ack for this part?
> 
> 
> On 02/22/2018 05:22 PM, Farhan Ali wrote:
> > The S390 architecture does not support any graphics hardware,
> > but with the latest support for Virtio GPU in Linux and Virtio
> > GPU emulation in QEMU, it's possible to enable graphics for
> > S390 using the Virtio GPU device.
> > 
> > To enable display we need to enable the Linux Virtual Terminal (VT)
> > layer for S390. But the VT subsystem initializes quite early
> > at boot so we need a dummy console driver till the Virtio GPU
> > driver is initialized and we can run the framebuffer console.
> > 
> > The framebuffer console over a Virtio GPU device can be run
> > in combination with the serial SCLP console (default on S390).
> > The SCLP console can still be accessed by management applications
> > (eg: via Libvirt's virsh console).
> > 
> > Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  arch/s390/kernel/setup.c      | 2 ++
> >  drivers/tty/Kconfig           | 2 +-
> >  drivers/video/console/Kconfig | 2 +-
> >  3 files changed, 4 insertions(+), 2 deletions(-)


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

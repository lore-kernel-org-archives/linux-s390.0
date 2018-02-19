From: Thomas Huth <thuth@redhat.com>
Date: Mon, 19 Feb 2018 19:55:39 +0000
Subject: Re: [PATCH v3 3/3] s390/setup : enable display support for KVM guest
Message-Id: <b7e118a9-9920-07bc-ccac-f72f451fccea@redhat.com>
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
 <8a6103fcc2b05f4426dcf6573a2175ffe6211403.1519053920.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <8a6103fcc2b05f4426dcf6573a2175ffe6211403.1519053920.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com, tomi.valkeinen@ti.com, b.zolnierkie@samsung.com
List-ID: <linux-s390.vger.kernel.org>

On 19.02.2018 16:47, Farhan Ali wrote:
> The S390 architecture does not support any graphics hardware,
> but with the latest support for Virtio GPU in Linux and Virtio
> GPU emulation in QEMU, it's possible to enable graphics for
> S390 using the Virtio GPU device.
> 
> To enable display we need to enable the Linux Virtual Terminal (VT)
> layer for S390. But the VT subsystem initializes quite early
> at boot so we need a dummy console driver till the Virtio GPU
> driver is initialized and we can run the framebuffer console.
> 
> The framebuffer console over a Virtio GPU device can be run
> in combination with the serial SCLP console (default on S390).
> The SCLP console can still be accessed by management applications
> (eg: via Libvirt's virsh console).
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kernel/setup.c      | 2 ++
>  drivers/tty/Kconfig           | 2 +-
>  drivers/video/console/Kconfig | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

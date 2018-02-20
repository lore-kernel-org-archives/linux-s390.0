From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 20 Feb 2018 09:43:20 +0000
Subject: Re: [PATCH v3 0/3] Enable CONFIG_VT support for S390
Message-Id: <c4319571-96fd-8f5b-68e3-c06b7968203f@de.ibm.com>
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, tomi.valkeinen@ti.com, thuth@redhat.com, b.zolnierkie@samsung.com
List-ID: <linux-s390.vger.kernel.org>

Added to my linux next tree to check for any fallout.


On 02/19/2018 04:47 PM, Farhan Ali wrote:
> Hi,
> 
> This series of patches add support for an additional tty
> and console for a S390 KVM guest using a virtio-gpu device[1].
> 
> Patch 1 enables the "Graphics support" menu which is
> needed to enable dummy console, since the VT layer needs it.
> The dependency is moved to sub menu items and console
> drivers now.
> 
> Patch 2 fixes few linker issues.
> 
> Patch 3 add support for enabling VT layer for S390.
> 
> 
> ChangeLog
> ---------
> v2 -> v3
>     - Move HAS_IOMEM dependency to sub menu items and console
>     drivers (patch 1)
> 
> v1 -> v2
> 
> v1 was posted under a different subject and here is a link to it:
> https://www.spinics.net/lists/linux-s390/msg18175.html
> 
>    - Combine patch 1 and 2 from v1 into one patch (patch 1).
>    - Additional patches to enable CONFIG_VT for S390.
> 
> 
> Thanks
> Farhan
> 
> 
> Farhan Ali (3):
>   Kconfig : Remove HAS_IOMEM dependency for Graphics support
>   s390/char : Rename EBCDIC keymap variables
>   s390/setup : enable display support for KVM guest
> 
>  arch/s390/kernel/setup.c      |  2 ++
>  drivers/s390/char/defkeymap.c | 66 ++++++++++++++++++++++---------------------
>  drivers/s390/char/keyboard.c  | 32 ++++++++++-----------
>  drivers/s390/char/keyboard.h  | 11 ++++++++
>  drivers/tty/Kconfig           |  2 +-
>  drivers/video/Kconfig         | 21 +++++++-------
>  drivers/video/console/Kconfig |  6 ++--
>  7 files changed, 78 insertions(+), 62 deletions(-)
> 

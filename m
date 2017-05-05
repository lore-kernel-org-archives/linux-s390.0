From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v7 00/13] basic channel IO passthrough infrastructure
 based on vfio
Date: Fri, 5 May 2017 14:22:34 +0200
Message-ID: <20170505142234.487dfda9.cornelia.huck@de.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Fri,  5 May 2017 04:03:39 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> The patch series introduce a basic channel I/O passthrough
> infrastructure based on vfio.
> - Focus on supporting dasd-eckd(cu_type/dev_type = 0x3990/0x3390) as
>   the target device. 
> - Support new qemu parameters in the style of:
>     -machine s390-ccw-virtio(,s390-squash-mcss=on|off) \
>     -device vfio-ccw,sysfsdev=$MDEV_PATH
>   We want to support real (i.e. not virtual) channel devices even for
>   guests that do not support MCSS-E (where guests may see devices from
>   any channel subsystem image at once). As all virtio-ccw devices are in
>   css 0xfe (and show up in the default css 0 for guests not activating
>   MCSS-E), we need an option to squash e.g. passed-through channel devices
>   from their real css (0-3, or 0 for hosts not activating MCSS-E) into
>   the default css, that is what the new machine option s390-squash-css is
>   added.

Basically looks good, some small nitpicking and the virtual vs. virtio
issue I noticed.

Let's wait if others have more comments. Hopefully, the 3270 changes
will by then be in master and you can rebase on top of them :)

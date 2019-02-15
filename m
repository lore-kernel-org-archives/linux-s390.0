From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 3/9] s390: ap: new vfio_ap_queue structure
Date: Fri, 15 Feb 2019 10:37:16 +0100
Message-ID: <20190215103716.00cd40db.cohuck@redhat.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-4-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550152269-6317-4-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 14 Feb 2019 14:51:03 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> The AP interruptions are assigned on a queue basis
> and we need some information neloging to the queue

s/neloging/belonging/

> to handle interuptions.

s/interuptions/interruptions/

> 
> We add a new structure vfio_ap_queue, to hold per
> queue information useful to handle interruptions.
> 
> - apqn: AP queue number (defined here)
> - isc : Interrupt subclass (defined later)
> - nib : notification information byte (defined later)

So, you basically simply want quick access to these? Makes sense.

> 
> The vfio_ap_queue structure is allocated when the vfio_ap_driver
> is probed and added as driver data to the ap_queue device.
> It is free on remove.

s/free/freed/

> 
> The structure is linked to the matrix_dev host device.

Hm, I don't quite follow?

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     | 23 ++++++++++++++++++++++-
>  drivers/s390/crypto/vfio_ap_private.h |  3 +++
>  2 files changed, 25 insertions(+), 1 deletion(-)

Patch looks reasonable; might make sense to squash it with later
patches (still need to read).

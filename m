From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 08/10] vfio: ccw: Handling reset and shutdown with
 states
Date: Mon, 30 Apr 2018 17:43:24 +0200
Message-ID: <20180430174324.34f59569.cohuck@redhat.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1524149293-12658-9-git-send-email-pmorel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524149293-12658-9-git-send-email-pmorel@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 19 Apr 2018 16:48:11 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Two new events, VFIO_CCW_EVENT_ONLINE and VFIO_CCW_EVENT_OFFLINE
> allow to handle the enabling and disabling of a Sub Channel and
> the shutdown, quiesce and reset operations are changed accordingly.

OK, onlining/offlining via the fsm makes more sense conceptually than
the init event.

How is that supposed to play with enabling the subchannel in the init
event? I would rather expect it to be done in the onlining transition
only?

> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c     | 47 ++++++--------------------
>  drivers/s390/cio/vfio_ccw_fsm.c     | 66 +++++++++++++++++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_ops.c     | 15 +++------
>  drivers/s390/cio/vfio_ccw_private.h |  3 ++
>  4 files changed, 83 insertions(+), 48 deletions(-)

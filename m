From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 03/10] vfio: ccw: new SCH_EVENT event
Date: Wed, 25 Apr 2018 10:25:19 +0200
Message-ID: <20180425102519.16e6195b.cohuck@redhat.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1524149293-12658-4-git-send-email-pmorel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524149293-12658-4-git-send-email-pmorel@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 19 Apr 2018 16:48:06 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> The Sub channel event callback is threaded using workqueues.
> The work uses the FSM introducing the VFIO_CCW_EVENT_SCH_EVENT
> event.

I don't think this is a good name; after all, all of the events are
events for the subchannel :)

This seems to be more of a "we need to update the schib" event...
VFIO_CCW_EVENT_SCHIB_CHANGED? _SCH_CHANGED? _UPDATE_NEEDED?

Tbh, I'm not quite sure this makes sense for me yet... will continue
reading, but this probably needs a 'why'.

> The update of the SCHIB is now done inside the FSM function.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c     | 33 +++++++++++++--------------------
>  drivers/s390/cio/vfio_ccw_fsm.c     | 23 +++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_private.h |  3 +++
>  3 files changed, 39 insertions(+), 20 deletions(-)

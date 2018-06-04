From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 01/10] vfio: ccw: Moving state change out of IRQ
 context
Date: Mon, 4 Jun 2018 15:52:31 +0200
Message-ID: <20180604155231.42c139ac.cohuck@redhat.com>
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1527243678-3140-2-git-send-email-pmorel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527243678-3140-2-git-send-email-pmorel@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 25 May 2018 12:21:09 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Let's move the state change from the IRQ routine to the
> workqueue callback.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c | 20 +++++++-------------
>  drivers/s390/cio/vfio_ccw_fsm.c | 14 ++++++++------
>  2 files changed, 15 insertions(+), 19 deletions(-)

This causes a change in behaviour for devices in the notoper state.

Now:
- vfio_ccw_sch_irq is called
- via the state machine, disabling the subchannel is (re-)triggered

With your patch:
- the work function is queued in any case; eventually, it will change
  the device's state to idle (unless we don't have an mdev at that
  point in time)
- completion is signaled

I'm not sure that's what we want.

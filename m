From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] s390x/virtio-ccw: Adapter interrupt
 support.
Date: Tue, 4 Mar 2014 10:05:30 +0100
Message-ID: <20140304100530.2417276d.cornelia.huck@de.ibm.com>
References: <1393349120-18228-1-git-send-email-cornelia.huck@de.ibm.com>
	<1393349120-18228-2-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1393349120-18228-2-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: gleb@kernel.org, borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 25 Feb 2014 18:25:15 +0100
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> Handle the new CCW_CMD_SET_IND_ADAPTER command enabling adapter interrupts
> on guest request. When active, host->guest notifications will be handled
> via global_indicator -> queue indicators instead of queue indicators +
> subchannel I/O interrupt. Indicators for virtqueues may be present at an
> offset.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/s390x/css.c        |   10 +++++
>  hw/s390x/css.h        |    2 +
>  hw/s390x/virtio-ccw.c |  102 +++++++++++++++++++++++++++++++++++++++++++++----
>  hw/s390x/virtio-ccw.h |    4 ++
>  target-s390x/ioinst.h |    2 +
>  target-s390x/kvm.c    |    8 +++-
>  trace-events          |    1 +
>  7 files changed, 120 insertions(+), 9 deletions(-)
> 

As this is a nicely self-contained patch, I'd like to send a pull
request for this, unless there are any objections.

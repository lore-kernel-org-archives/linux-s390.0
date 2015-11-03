From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH/RFC 0/4] dma ops and virtio
Date: Tue, 3 Nov 2015 18:59:26 +0100
Message-ID: <20151103185926.1442d0a8.cornelia.huck@de.ibm.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
	<CALCETrVOsq4+z1HzQ2vthuHB91nt9FJ1a3jiAuOe5Fyb5vGXQA@mail.gmail.com>
	<5631629B.2050505@de.ibm.com>
	<CALCETrWcSKPUBvYQO4UuThtkUo6=c-HKJTpWKbYc5qgX6bth=Q@mail.gmail.com>
	<20151030092548.7abd51e1.cornelia.huck@de.ibm.com>
	<CALCETrWb5JAeRtsmPEuNNMY-oL1WyLMrr5sh=WL45K-Wq0gVeQ@mail.gmail.com>
	<20151102121658.11aa3375.cornelia.huck@de.ibm.com>
	<CALCETrXURKZCwBYLvPof9KZyrfFA6moEyLCQgssmqQmM-OVniQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CALCETrXURKZCwBYLvPof9KZyrfFA6moEyLCQgssmqQmM-OVniQ@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2 Nov 2015 12:23:25 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> No change.

I'm stumped :(

Here's what I see:

(...)

> CH DBG: css_interpret_ccw: cmd_code=e4
> CH DBG: css_interpret_ccw: ret=0

sense id -> works

(...)

> CH DBG: css_interpret_ccw: cmd_code=3
> CH DBG: css_interpret_ccw: ret=0

nop (path verification) -> works

> CH DBG: css_interpret_ccw: cmd_code=83
> CH DBG: css_interpret_ccw: ret=-38

set revision -> -ENOSYS

This is fine; the virtio device is in legacy mode and the kernel will
try revision 1; qemu will reject this. The code should end up
generating a unit check with command reject, however...

> qeth: register layer 2 discipline
> qeth: register layer 3 discipline
> oprofile: using timer interrupt.
> NET: Registered protocol family 10
> virtio_ccw 0.0.0000: Failed to set online: -5

...this shows the kernel driver somehow did not end up with that
command reject (it would have triggered a retry with revision 0, and
the return code shows that no unit check/command reject was detected,
but some other error.)

> The lack of much interesting output makes me think that maybe I
> misconfigured something.

It's just failing very early in the setup phase. As it works for me
with a kvm setup, I'm suspecting some error in qemu's emulation code,
which is unfortunately not my turf.

Some more poke-around-in-the-dark ideas:

- Do you get more debug out put when you switch back to s390-ccw-virtio
(virtio-1), i.e. does cmd 83 work and is it followed by further
commands?

- Can you try with the following qemu logging patch

-----8<----------8<-----

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index c033612..80853a6 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -868,6 +868,7 @@ int css_do_tsch_get_irb(SubchDev *sch, IRB *target_irb, int *irb_len)
     PMCW *p = &sch->curr_status.pmcw;
     uint16_t stctl;
     IRB irb;
+    int i;
 
     if (!(p->flags & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA))) {
         return 3;
@@ -898,6 +899,14 @@ int css_do_tsch_get_irb(SubchDev *sch, IRB *target_irb, int *irb_len)
         }
     }
     /* Store the irb to the guest. */
+    fprintf(stderr, "CH DBG: %s: flags=%04x ctrl=%04x cpa=%08x\n",
+            __func__, irb.scsw.flags, irb.scsw.ctrl, irb.scsw.cpa);
+    fprintf(stderr, "CH DBG: %s: dstat=%02x cstat=%02x count=%04x\n",
+            __func__, irb.scsw.dstat, irb.scsw.cstat, irb.scsw.count);
+    for (i = 0; i < ARRAY_SIZE(irb.ecw); i++) {
+        fprintf(stderr, "CH DBG: %s: ecw[%d]=%08x\n", __func__,
+                i, irb.ecw[i]);
+    }
     copy_irb_to_guest(target_irb, &irb, p, irb_len);
 
     return ((stctl & SCSW_STCTL_STATUS_PEND) == 0);

-----8<----------8<-----

and the following kernel patch

-----8<----------8<-----

diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 83da53c..ea4db09 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -540,6 +540,9 @@ callback:
 			create_fake_irb(&cdev->private->irb,
 					cdev->private->flags.fake_irb);
 			cdev->private->flags.fake_irb = 0;
+			CIO_TRACE_EVENT(0, "fake_irb");
+			CIO_HEX_EVENT(0, &cdev->private->irb,
+				      sizeof(struct irb));
 			if (cdev->handler)
 				cdev->handler(cdev, cdev->private->intparm,
 					      &cdev->private->irb);
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index 6acd0b5..e9bf357 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -446,6 +446,8 @@ ccw_device_call_handler(struct ccw_device *cdev)
 	/*
 	 * Now we are ready to call the device driver interrupt handler.
 	 */
+	CIO_TRACE_EVENT(0, "irb");
+	CIO_HEX_EVENT(0, &cdev->private->irb, sizeof(struct irb));
 	if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
 			      &cdev->private->irb);

-----8<----------8<-----

Just to verify that qemu will produce and the kernel end up with the
irb I'd expect. I'd rather prefer us getting the dma stuff right
instead of chasing qemu issues :/

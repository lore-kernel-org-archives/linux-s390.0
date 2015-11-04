From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH/RFC 0/4] dma ops and virtio
Date: Wed, 4 Nov 2015 18:52:52 +0100
Message-ID: <20151104185252.199973af.cornelia.huck@de.ibm.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
	<CALCETrVOsq4+z1HzQ2vthuHB91nt9FJ1a3jiAuOe5Fyb5vGXQA@mail.gmail.com>
	<5631629B.2050505@de.ibm.com>
	<CALCETrWcSKPUBvYQO4UuThtkUo6=c-HKJTpWKbYc5qgX6bth=Q@mail.gmail.com>
	<20151030092548.7abd51e1.cornelia.huck@de.ibm.com>
	<CALCETrWb5JAeRtsmPEuNNMY-oL1WyLMrr5sh=WL45K-Wq0gVeQ@mail.gmail.com>
	<20151102121658.11aa3375.cornelia.huck@de.ibm.com>
	<CALCETrXURKZCwBYLvPof9KZyrfFA6moEyLCQgssmqQmM-OVniQ@mail.gmail.com>
	<20151103185926.1442d0a8.cornelia.huck@de.ibm.com>
	<CALCETrXM96LKvy9ZsgPMOiMYD3ki2oju0e7OPzv-q9=Aq9dGcA@mail.gmail.com>
	<20151104152923.6b60ce4c.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20151104152923.6b60ce4c.cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 4 Nov 2015 15:29:23 +0100
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> I'm currently suspecting some endianness issues, probably with the ecw
> accesses, which is why I'd be interested in your trace information (as
> I currently don't have a LE test setup at hand.)

I think I've got it. We have sense_data as a byte array, which
implicitly makes it BE already. When we copy to the ecws while building
the irb, the data ends up in 32 bit values. The conversion from host
endianness to BE now treats them as LE on your system...

Could you please give the following qemu patch a try?

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index c033612..a13494e 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -892,8 +892,16 @@ int css_do_tsch_get_irb(SubchDev *sch, IRB *target_irb, int *irb_len)
         /* If a unit check is pending, copy sense data. */
         if ((s->dstat & SCSW_DSTAT_UNIT_CHECK) &&
             (p->chars & PMCW_CHARS_MASK_CSENSE)) {
+            uint32_t ecw[8];
+            int i;
+
             irb.scsw.flags |= SCSW_FLAGS_MASK_ESWF | SCSW_FLAGS_MASK_ECTL;
-            memcpy(irb.ecw, sch->sense_data, sizeof(sch->sense_data));
+            /* Attention: sense_data is already BE! */
+            memset(ecw, 0, sizeof(ecw));
+            memcpy(ecw, sch->sense_data, sizeof(sch->sense_data));
+            for (i = 0; i < ARRAY_SIZE(ecw); i++) {
+                irb.ecw[i] = be32_to_cpu(ecw[i]);
+            }
             irb.esw[1] = 0x01000000 | (sizeof(sch->sense_data) << 8);
         }
     }

Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 31 Dec 2015 21:10:01 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 33/34] xenbus: use virt_xxx barriers
Message-ID: <1451572003-2440-34-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20151231191001.nZVWlPOFpp6DI_IvragiERo90FPxeXl7M9ooHIXbsnk@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Vrabel <david.vrabel@citrix.com>
List-ID: <linux-s390.vger.kernel.org>

drivers/xen/xenbus/xenbus_comms.c uses
full memory barriers to communicate with the other side.

For guests compiled with CONFIG_SMP, smp_wmb and smp_mb
would be sufficient, so mb() and wmb() here are only needed if
a non-SMP guest runs on an SMP host.

Switch to virt_xxx barriers which serve this exact purpose.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/xen/xenbus/xenbus_comms.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index fdb0f33..ecdecce 100644
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -123,14 +123,14 @@ int xb_write(const void *data, unsigned len)
 			avail = len;
 
 		/* Must write data /after/ reading the consumer index. */
-		mb();
+		virt_mb();
 
 		memcpy(dst, data, avail);
 		data += avail;
 		len -= avail;
 
 		/* Other side must not see new producer until data is there. */
-		wmb();
+		virt_wmb();
 		intf->req_prod += avail;
 
 		/* Implies mb(): other side will see the updated producer. */
@@ -180,14 +180,14 @@ int xb_read(void *data, unsigned len)
 			avail = len;
 
 		/* Must read data /after/ reading the producer index. */
-		rmb();
+		virt_rmb();
 
 		memcpy(data, src, avail);
 		data += avail;
 		len -= avail;
 
 		/* Other side must not see free space until we've copied out */
-		mb();
+		virt_mb();
 		intf->rsp_cons += avail;
 
 		pr_debug("Finished read of %i bytes (%i to go)\n", avail, len);
-- 
MST

From: Dong Jia Shi <bjsdjshi@linux.ibm.com>
Subject: [PATCH v3 4/4] vfio: ccw: add traceponits for interesting error paths
Date: Wed, 23 May 2018 04:45:02 +0200
Message-ID: <20180523024502.94244-5-bjsdjshi@linux.ibm.com>
References: <20180523024502.94244-1-bjsdjshi@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180523024502.94244-1-bjsdjshi@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Add some tracepoints so we can inspect what is not working as is should.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
---
 drivers/s390/cio/Makefile         |  1 +
 drivers/s390/cio/vfio_ccw_fsm.c   | 17 +++++++++++-
 drivers/s390/cio/vfio_ccw_trace.h | 54 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.h

diff --git a/drivers/s390/cio/Makefile b/drivers/s390/cio/Makefile
index a070ef0efe65..f230516abb96 100644
--- a/drivers/s390/cio/Makefile
+++ b/drivers/s390/cio/Makefile
@@ -5,6 +5,7 @@
 
 # The following is required for define_trace.h to find ./trace.h
 CFLAGS_trace.o := -I$(src)
+CFLAGS_vfio_ccw_fsm.o := -I$(src)
 
 obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o idset.o isc.o \
 	fcx.o itcw.o crw.o ccwreq.o trace.o ioasm.o
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 3c800642134e..797a82731159 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -13,6 +13,9 @@
 #include "ioasm.h"
 #include "vfio_ccw_private.h"
 
+#define CREATE_TRACE_POINTS
+#include "vfio_ccw_trace.h"
+
 static int fsm_io_helper(struct vfio_ccw_private *private)
 {
 	struct subchannel *sch;
@@ -110,6 +113,10 @@ static void fsm_disabled_irq(struct vfio_ccw_private *private,
 	 */
 	cio_disable_subchannel(sch);
 }
+inline struct subchannel_id get_schid(struct vfio_ccw_private *p)
+{
+	return p->sch->schid;
+}
 
 /*
  * Deal with the ccw command request from the userspace.
@@ -121,6 +128,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	union scsw *scsw = &private->scsw;
 	struct ccw_io_region *io_region = &private->io_region;
 	struct mdev_device *mdev = private->mdev;
+	char *errstr = "request";
 
 	private->state = VFIO_CCW_STATE_BOXED;
 
@@ -132,15 +140,19 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 		/* Don't try to build a cp if transport mode is specified. */
 		if (orb->tm.b) {
 			io_region->ret_code = -EOPNOTSUPP;
+			errstr = "transport mode";
 			goto err_out;
 		}
 		io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev),
 					      orb);
-		if (io_region->ret_code)
+		if (io_region->ret_code) {
+			errstr = "cp init";
 			goto err_out;
+		}
 
 		io_region->ret_code = cp_prefetch(&private->cp);
 		if (io_region->ret_code) {
+			errstr = "cp prefetch";
 			cp_free(&private->cp);
 			goto err_out;
 		}
@@ -148,6 +160,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 		/* Start channel program and wait for I/O interrupt. */
 		io_region->ret_code = fsm_io_helper(private);
 		if (io_region->ret_code) {
+			errstr = "cp fsm_io_helper";
 			cp_free(&private->cp);
 			goto err_out;
 		}
@@ -164,6 +177,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 
 err_out:
 	private->state = VFIO_CCW_STATE_IDLE;
+	trace_vfio_ccw_io_fctl(scsw->cmd.fctl, get_schid(private),
+			       io_region->ret_code, errstr);
 }
 
 /*
diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
new file mode 100644
index 000000000000..b1da53ddec1f
--- /dev/null
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Tracepoints for vfio_ccw driver
+ *
+ * Copyright IBM Corp. 2018
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Halil Pasic <pasic@linux.vnet.ibm.com>
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM vfio_ccw
+
+#if !defined(_VFIO_CCW_TRACE_) || defined(TRACE_HEADER_MULTI_READ)
+#define _VFIO_CCW_TRACE_
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(vfio_ccw_io_fctl,
+	TP_PROTO(int fctl, struct subchannel_id schid, int errno, char *errstr),
+	TP_ARGS(fctl, schid, errno, errstr),
+
+	TP_STRUCT__entry(
+		__field(int, fctl)
+		__field_struct(struct subchannel_id, schid)
+		__field(int, errno)
+		__field(char*, errstr)
+	),
+
+	TP_fast_assign(
+		__entry->fctl = fctl;
+		__entry->schid = schid;
+		__entry->errno = errno;
+		__entry->errstr = errstr;
+	),
+
+	TP_printk("schid=%x.%x.%04x fctl=%x errno=%d info=%s",
+		  __entry->schid.cssid,
+		  __entry->schid.ssid,
+		  __entry->schid.sch_no,
+		  __entry->fctl,
+		  __entry->errno,
+		  __entry->errstr)
+);
+
+#endif /* _VFIO_CCW_TRACE_ */
+
+/* This part must be outside protection */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE vfio_ccw_trace
+
+#include <trace/define_trace.h>
-- 
2.16.3

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH v2 5/5] vfio: ccw: add traceponits for interesting error paths
Date: Mon, 23 Apr 2018 13:01:13 +0200
Message-ID: <20180423110113.59385-6-bjsdjshi@linux.vnet.ibm.com>
References: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Add some tracepoints so we can inspect what is not working as is should.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/Makefile         |  1 +
 drivers/s390/cio/vfio_ccw_fsm.c   | 16 +++++++-
 drivers/s390/cio/vfio_ccw_trace.h | 77 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 1 deletion(-)
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
index ff6963ad6e39..90cab4e1436e 100644
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
@@ -105,6 +108,10 @@ static void fsm_disabled_irq(struct vfio_ccw_private *private,
 	 */
 	cio_disable_subchannel(sch);
 }
+inline struct subchannel_id get_schid(struct vfio_ccw_private *p)
+{
+	return p->sch->schid;
+}
 
 /*
  * Deal with the ccw command request from the userspace.
@@ -135,6 +142,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 			goto err_out;
 
 		io_region->ret_code = cp_prefetch(&private->cp);
+		trace_vfio_ccw_cp_prefetch(get_schid(private),
+					   io_region->ret_code);
 		if (io_region->ret_code) {
 			cp_free(&private->cp);
 			goto err_out;
@@ -142,11 +151,13 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 
 		/* Start channel program and wait for I/O interrupt. */
 		io_region->ret_code = fsm_io_helper(private);
+		trace_vfio_ccw_fsm_io_helper(get_schid(private),
+					     io_region->ret_code);
 		if (io_region->ret_code) {
 			cp_free(&private->cp);
 			goto err_out;
 		}
-		return;
+		goto out;
 	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
 		/* XXX: Handle halt. */
 		io_region->ret_code = -EOPNOTSUPP;
@@ -159,6 +170,9 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 
 err_out:
 	private->state = VFIO_CCW_STATE_IDLE;
+out:
+	trace_vfio_ccw_io_fctl(scsw->cmd.fctl, get_schid(private),
+			       io_region->ret_code);
 }
 
 /*
diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
new file mode 100644
index 000000000000..25128331c285
--- /dev/null
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Tracepoints for vfio_ccw driver
+ *
+ * Copyright IBM Corp. 2018
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Halil Pasic <pasic@linux.vnet.ibm.com>
+ */
+
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM vfio_ccw
+
+#if !defined(_VFIO_CCW_TRACE_) || defined(TRACE_HEADER_MULTI_READ)
+#define _VFIO_CCW_TRACE_
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(vfio_ccw_schid_errno,
+	TP_PROTO(struct subchannel_id schid, int errno),
+	TP_ARGS(schid, errno),
+
+	TP_STRUCT__entry(
+		__field_struct(struct subchannel_id, schid)
+		__field(int, errno)
+	),
+
+	TP_fast_assign(
+		__entry->schid = schid;
+		__entry->errno = errno;
+	),
+
+	TP_printk("schid=%x.%x.%04x errno=%d", __entry->schid.cssid,
+		  __entry->schid.ssid, __entry->schid.sch_no, __entry->errno)
+);
+
+DEFINE_EVENT(vfio_ccw_schid_errno, vfio_ccw_cp_prefetch,
+	TP_PROTO(struct subchannel_id schid, int errno),
+	TP_ARGS(schid, errno)
+);
+
+DEFINE_EVENT(vfio_ccw_schid_errno, vfio_ccw_fsm_io_helper,
+	TP_PROTO(struct subchannel_id schid, int errno),
+	TP_ARGS(schid, errno)
+);
+
+TRACE_EVENT(vfio_ccw_io_fctl,
+	TP_PROTO(int fctl, struct subchannel_id schid, int errno),
+	TP_ARGS(fctl, schid, errno),
+
+	TP_STRUCT__entry(
+		__field(int, fctl)
+		__field_struct(struct subchannel_id, schid)
+		__field(int, errno)
+	),
+
+	TP_fast_assign(
+		__entry->fctl = fctl;
+		__entry->schid = schid;
+		__entry->errno = errno;
+	),
+
+	TP_printk("schid=%x.%x.%04x fctl=%x errno=%d", __entry->schid.cssid,
+		  __entry->schid.ssid, __entry->schid.sch_no,
+		  __entry->fctl, __entry->errno)
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
2.13.5

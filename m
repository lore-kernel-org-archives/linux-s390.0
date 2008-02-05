Return-Path: <linux-kernel-owner+w=401wt.eu-S1755862AbYBEPju@vger.kernel.org>
Message-Id: <20080205153910.442155040@de.ibm.com>
References: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:36 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/18] cio: make sense id procedure work with partial hardware response
Content-Disposition: inline; filename=001-cio-senseid.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

In some cases the current sense id procedure trips over incomplete
hardware responses. In these cases, checking against the preset value
of 0xFFFF is not enough. More critically, the VM DIAG call will always be
considered to have provided data after such an incident, even if it was not
successful at all.

The solution is to always initialize the control unit data before doing a
sense id call. Check the condition code before considering the control unit
data. And initialize again, before evaluating the VM data.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_id.c |  107 +++++++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 43 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device_id.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_id.c
+++ quilt-2.6/drivers/s390/cio/device_id.c
@@ -26,17 +26,18 @@
 #include "ioasm.h"
 #include "io_sch.h"
 
-/*
- * Input :
- *   devno - device number
- *   ps	   - pointer to sense ID data area
- * Output : none
+/**
+ * vm_vdev_to_cu_type - Convert vm virtual device into control unit type
+ *			for certain devices.
+ * @class: virtual device class
+ * @type: virtual device type
+ *
+ * Returns control unit type if a match was made or %0xffff otherwise.
  */
-static void
-VM_virtual_device_info (__u16 devno, struct senseid *ps)
+static int vm_vdev_to_cu_type(int class, int type)
 {
 	static struct {
-		int vrdcvcla, vrdcvtyp, cu_type;
+		int class, type, cu_type;
 	} vm_devices[] = {
 		{ 0x08, 0x01, 0x3480 },
 		{ 0x08, 0x02, 0x3430 },
@@ -68,8 +69,26 @@ VM_virtual_device_info (__u16 devno, str
 		{ 0x40, 0xc0, 0x5080 },
 		{ 0x80, 0x00, 0x3215 },
 	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vm_devices); i++)
+		if (class == vm_devices[i].class && type == vm_devices[i].type)
+			return vm_devices[i].cu_type;
+
+	return 0xffff;
+}
+
+/**
+ * diag_get_dev_info - retrieve device information via DIAG X'210'
+ * @devno: device number
+ * @ps: pointer to sense ID data area
+ *
+ * Returns zero on success, non-zero otherwise.
+ */
+static int diag_get_dev_info(u16 devno, struct senseid *ps)
+{
 	struct diag210 diag_data;
-	int ccode, i;
+	int ccode;
 
 	CIO_TRACE_EVENT (4, "VMvdinf");
 
@@ -79,21 +98,21 @@ VM_virtual_device_info (__u16 devno, str
 	};
 
 	ccode = diag210 (&diag_data);
-	ps->reserved = 0xff;
+	if ((ccode == 0) || (ccode == 2)) {
+		ps->reserved = 0xff;
 
-	/* Special case for bloody osa devices. */
-	if (diag_data.vrdcvcla == 0x02 &&
-	    diag_data.vrdcvtyp == 0x20) {
-		ps->cu_type = 0x3088;
-		ps->cu_model = 0x60;
-		return;
-	}
-	for (i = 0; i < ARRAY_SIZE(vm_devices); i++)
-		if (diag_data.vrdcvcla == vm_devices[i].vrdcvcla &&
-		    diag_data.vrdcvtyp == vm_devices[i].vrdcvtyp) {
-			ps->cu_type = vm_devices[i].cu_type;
-			return;
+		/* Special case for osa devices. */
+		if (diag_data.vrdcvcla == 0x02 && diag_data.vrdcvtyp == 0x20) {
+			ps->cu_type = 0x3088;
+			ps->cu_model = 0x60;
+			return 0;
 		}
+		ps->cu_type = vm_vdev_to_cu_type(diag_data.vrdcvcla,
+						diag_data.vrdcvtyp);
+		if (ps->cu_type != 0xffff)
+			return 0;
+	}
+
 	CIO_MSG_EVENT(0, "DIAG X'210' for device %04X returned (cc = %d):"
 		      "vdev class : %02X, vdev type : %04X \n ...  "
 		      "rdev class : %02X, rdev type : %04X, "
@@ -102,6 +121,8 @@ VM_virtual_device_info (__u16 devno, str
 		      diag_data.vrdcvcla, diag_data.vrdcvtyp,
 		      diag_data.vrdcrccl, diag_data.vrdccrty,
 		      diag_data.vrdccrmd);
+
+	return -ENODEV;
 }
 
 /*
@@ -130,6 +151,7 @@ __ccw_device_sense_id_start(struct ccw_d
 	/* Try on every path. */
 	ret = -ENODEV;
 	while (cdev->private->imask != 0) {
+		cdev->private->senseid.cu_type = 0xFFFF;
 		if ((sch->opm & cdev->private->imask) != 0 &&
 		    cdev->private->iretry > 0) {
 			cdev->private->iretry--;
@@ -153,7 +175,6 @@ ccw_device_sense_id_start(struct ccw_dev
 	int ret;
 
 	memset (&cdev->private->senseid, 0, sizeof (struct senseid));
-	cdev->private->senseid.cu_type = 0xFFFF;
 	cdev->private->imask = 0x80;
 	cdev->private->iretry = 5;
 	ret = __ccw_device_sense_id_start(cdev);
@@ -173,13 +194,7 @@ ccw_device_check_sense_id(struct ccw_dev
 
 	sch = to_subchannel(cdev->dev.parent);
 	irb = &cdev->private->irb;
-	/* Did we get a proper answer ? */
-	if (cdev->private->senseid.cu_type != 0xFFFF && 
-	    cdev->private->senseid.reserved == 0xFF) {
-		if (irb->scsw.count < sizeof (struct senseid) - 8)
-			cdev->private->flags.esid = 1;
-		return 0; /* Success */
-	}
+
 	/* Check the error cases. */
 	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
 		/* Retry Sense ID if requested. */
@@ -231,6 +246,15 @@ ccw_device_check_sense_id(struct ccw_dev
 				      sch->schid.ssid, sch->schid.sch_no);
 		return -EACCES;
 	}
+
+	/* Did we get a proper answer ? */
+	if (irb->scsw.cc == 0 && cdev->private->senseid.cu_type != 0xFFFF &&
+	    cdev->private->senseid.reserved == 0xFF) {
+		if (irb->scsw.count < sizeof(struct senseid) - 8)
+			cdev->private->flags.esid = 1;
+		return 0; /* Success */
+	}
+
 	/* Hmm, whatever happened, try again. */
 	CIO_MSG_EVENT(2, "SenseID : start_IO() for device %04x on "
 		      "subchannel 0.%x.%04x returns status %02X%02X\n",
@@ -283,20 +307,17 @@ ccw_device_sense_id_irq(struct ccw_devic
 			break;
 		/* fall through. */
 	default:		/* Sense ID failed. Try asking VM. */
-		if (MACHINE_IS_VM) {
-			VM_virtual_device_info (cdev->private->dev_id.devno,
+		if (MACHINE_IS_VM)
+			ret = diag_get_dev_info(cdev->private->dev_id.devno,
 						&cdev->private->senseid);
-			if (cdev->private->senseid.cu_type != 0xFFFF) {
-				/* Got the device information from VM. */
-				ccw_device_sense_id_done(cdev, 0);
-				return;
-			}
-		}
-		/*
-		 * If we can't couldn't identify the device type we
-		 *  consider the device "not operational".
-		 */
-		ccw_device_sense_id_done(cdev, -ENODEV);
+		else
+			/*
+			 * If we can't couldn't identify the device type we
+			 *  consider the device "not operational".
+			 */
+			ret = -ENODEV;
+
+		ccw_device_sense_id_done(cdev, ret);
 		break;
 	}
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

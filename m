Return-Path: <linux-kernel-owner+w=401wt.eu-S1761894AbZBYPSY@vger.kernel.org>
Message-Id: <20090225150839.854000919@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:07:08 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 46/46] tape message cleanup
Content-Disposition: inline; filename=145-kmsg-tape.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Carsten Otte <cotte@de.ibm.com>

This is a cleanup of all the messages this driver prints. It uses the
dev_message macros now.

Signed-off-by: Carsten Otte <cotte@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tape.h       |    2 
 drivers/s390/char/tape_34xx.c  |  161 +++++++-----------
 drivers/s390/char/tape_3590.c  |  364 ++++++++++++++++++++---------------------
 drivers/s390/char/tape_block.c |   18 --
 drivers/s390/char/tape_char.c  |    7 
 drivers/s390/char/tape_core.c  |   62 +-----
 drivers/s390/char/tape_proc.c  |    3 
 drivers/s390/char/tape_std.c   |   21 --
 8 files changed, 267 insertions(+), 371 deletions(-)

Index: quilt-2.6/drivers/s390/char/tape_34xx.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_34xx.c
+++ quilt-2.6/drivers/s390/char/tape_34xx.c
@@ -8,6 +8,8 @@
  *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "tape"
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/bio.h>
@@ -18,8 +20,6 @@
 #include "tape.h"
 #include "tape_std.h"
 
-#define PRINTK_HEADER "TAPE_34XX: "
-
 /*
  * Pointer to debug area.
  */
@@ -203,8 +203,7 @@ tape_34xx_unsolicited_irq(struct tape_de
 		tape_34xx_schedule_work(device, TO_MSEN);
 	} else {
 		DBF_EVENT(3, "unsol.irq! dev end: %08x\n", device->cdev_id);
-		PRINT_WARN("Unsolicited IRQ (Device End) caught.\n");
-		tape_dump_sense(device, NULL, irb);
+		tape_dump_sense_dbf(device, NULL, irb);
 	}
 	return TAPE_IO_SUCCESS;
 }
@@ -226,9 +225,7 @@ tape_34xx_erp_read_opposite(struct tape_
 		tape_std_read_backward(device, request);
 		return tape_34xx_erp_retry(request);
 	}
-	if (request->op != TO_RBA)
-		PRINT_ERR("read_opposite called with state:%s\n",
-			  tape_op_verbose[request->op]);
+
 	/*
 	 * We tried to read forward and backward, but hat no
 	 * success -> failed.
@@ -241,13 +238,9 @@ tape_34xx_erp_bug(struct tape_device *de
 		  struct irb *irb, int no)
 {
 	if (request->op != TO_ASSIGN) {
-		PRINT_WARN("An unexpected condition #%d was caught in "
-			   "tape error recovery.\n", no);
-		PRINT_WARN("Please report this incident.\n");
-		if (request)
-			PRINT_WARN("Operation of tape:%s\n",
-				   tape_op_verbose[request->op]);
-		tape_dump_sense(device, request, irb);
+		dev_err(&device->cdev->dev, "An unexpected condition %d "
+			"occurred in tape error recovery\n", no);
+		tape_dump_sense_dbf(device, request, irb);
 	}
 	return tape_34xx_erp_failed(request, -EIO);
 }
@@ -261,9 +254,8 @@ tape_34xx_erp_overrun(struct tape_device
 		      struct irb *irb)
 {
 	if (irb->ecw[3] == 0x40) {
-		PRINT_WARN ("Data overrun error between control-unit "
-			    "and drive. Use a faster channel connection, "
-			    "if possible! \n");
+		dev_warn (&device->cdev->dev, "A data overrun occurred between"
+			" the control unit and tape unit\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	}
 	return tape_34xx_erp_bug(device, request, irb, -1);
@@ -280,7 +272,8 @@ tape_34xx_erp_sequence(struct tape_devic
 		/*
 		 * cu detected incorrect block-id sequence on tape.
 		 */
-		PRINT_WARN("Illegal block-id sequence found!\n");
+		dev_warn (&device->cdev->dev, "The block ID sequence on the "
+			"tape is incorrect\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	}
 	/*
@@ -393,8 +386,6 @@ tape_34xx_unit_check(struct tape_device 
 			/* Writing at physical end of volume */
 			return tape_34xx_erp_failed(request, -ENOSPC);
 		default:
-			PRINT_ERR("Invalid op in %s:%i\n",
-				  __func__, __LINE__);
 			return tape_34xx_erp_failed(request, 0);
 		}
 	}
@@ -420,7 +411,8 @@ tape_34xx_unit_check(struct tape_device 
 							 irb, -4);
 
 			/* data check is permanent, CU recovery has failed */
-			PRINT_WARN("Permanent read error\n");
+			dev_warn (&device->cdev->dev, "A read error occurred "
+				"that cannot be recovered\n");
 			return tape_34xx_erp_failed(request, -EIO);
 		case 0x25:
 			// a write data check occurred
@@ -433,22 +425,26 @@ tape_34xx_unit_check(struct tape_device 
 							 irb, -5);
 
 			// data check is permanent, cu-recovery has failed
-			PRINT_WARN("Permanent write error\n");
+			dev_warn (&device->cdev->dev, "A write error on the "
+				"tape cannot be recovered\n");
 			return tape_34xx_erp_failed(request, -EIO);
 		case 0x26:
 			/* Data Check (read opposite) occurred. */
 			return tape_34xx_erp_read_opposite(device, request);
 		case 0x28:
 			/* ID-Mark at tape start couldn't be written */
-			PRINT_WARN("ID-Mark could not be written.\n");
+			dev_warn (&device->cdev->dev, "Writing the ID-mark "
+				"failed\n");
 			return tape_34xx_erp_failed(request, -EIO);
 		case 0x31:
 			/* Tape void. Tried to read beyond end of device. */
-			PRINT_WARN("Read beyond end of recorded area.\n");
+			dev_warn (&device->cdev->dev, "Reading the tape beyond"
+				" the end of the recorded area failed\n");
 			return tape_34xx_erp_failed(request, -ENOSPC);
 		case 0x41:
 			/* Record sequence error. */
-			PRINT_WARN("Invalid block-id sequence found.\n");
+			dev_warn (&device->cdev->dev, "The tape contains an "
+				"incorrect block ID sequence\n");
 			return tape_34xx_erp_failed(request, -EIO);
 		default:
 			/* all data checks for 3480 should result in one of
@@ -470,16 +466,12 @@ tape_34xx_unit_check(struct tape_device 
 	switch (sense[3]) {
 	case 0x00:
 		/* Unit check with erpa code 0. Report and ignore. */
-		PRINT_WARN("Non-error sense was found. "
-			   "Unit-check will be ignored.\n");
 		return TAPE_IO_SUCCESS;
 	case 0x21:
 		/*
 		 * Data streaming not operational. CU will switch to
 		 * interlock mode. Reissue the command.
 		 */
-		PRINT_WARN("Data streaming not operational. "
-			   "Switching to interlock-mode.\n");
 		return tape_34xx_erp_retry(request);
 	case 0x22:
 		/*
@@ -487,11 +479,8 @@ tape_34xx_unit_check(struct tape_device 
 		 * error on the lower interface, internal path not usable,
 		 * or error during cartridge load.
 		 */
-		PRINT_WARN("A path equipment check occurred. One of the "
-			   "following conditions occurred:\n");
-		PRINT_WARN("drive adapter error, buffer error on the lower "
-			   "interface, internal path not usable, error "
-			   "during cartridge load.\n");
+		dev_warn (&device->cdev->dev, "A path equipment check occurred"
+			" for the tape device\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x24:
 		/*
@@ -514,7 +503,6 @@ tape_34xx_unit_check(struct tape_device 
 		 * but the hardware isn't capable to do idrc, or a perform
 		 * subsystem func is issued and the CU is not on-line.
 		 */
-		PRINT_WARN ("Function incompatible. Try to switch off idrc\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x2a:
 		/*
@@ -552,23 +540,26 @@ tape_34xx_unit_check(struct tape_device 
 		 * reading the format id mark or that that format specified
 		 * is not supported by the drive.
 		 */
-		PRINT_WARN("Drive not capable processing the tape format!\n");
+		dev_warn (&device->cdev->dev, "The tape unit cannot process "
+			"the tape format\n");
 		return tape_34xx_erp_failed(request, -EMEDIUMTYPE);
 	case 0x30:
 		/* The medium is write protected. */
-		PRINT_WARN("Medium is write protected!\n");
+		dev_warn (&device->cdev->dev, "The tape medium is write-"
+			"protected\n");
 		return tape_34xx_erp_failed(request, -EACCES);
 	case 0x32:
 		// Tension loss. We cannot recover this, it's an I/O error.
-		PRINT_WARN("The drive lost tape tension.\n");
+		dev_warn (&device->cdev->dev, "The tape does not have the "
+			"required tape tension\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x33:
 		/*
 		 * Load Failure. The cartridge was not inserted correctly or
 		 * the tape is not threaded correctly.
 		 */
-		PRINT_WARN("Cartridge load failure. Reload the cartridge "
-			   "and try again.\n");
+		dev_warn (&device->cdev->dev, "The tape unit failed to load"
+			" the cartridge\n");
 		tape_34xx_delete_sbid_from(device, 0);
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x34:
@@ -576,8 +567,8 @@ tape_34xx_unit_check(struct tape_device 
 		 * Unload failure. The drive cannot maintain tape tension
 		 * and control tape movement during an unload operation.
 		 */
-		PRINT_WARN("Failure during cartridge unload. "
-			   "Please try manually.\n");
+		dev_warn (&device->cdev->dev, "Automatic unloading of the tape"
+			" cartridge failed\n");
 		if (request->op == TO_RUN)
 			return tape_34xx_erp_failed(request, -EIO);
 		return tape_34xx_erp_bug(device, request, irb, sense[3]);
@@ -589,8 +580,8 @@ tape_34xx_unit_check(struct tape_device 
 		 * - the cartridge loader does not respond correctly
 		 * - a failure occurs during an index, load, or unload cycle
 		 */
-		PRINT_WARN("Equipment check! Please check the drive and "
-			   "the cartridge loader.\n");
+		dev_warn (&device->cdev->dev, "An equipment check has occurred"
+			" on the tape unit\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x36:
 		if (device->cdev->id.driver_info == tape_3490)
@@ -603,7 +594,8 @@ tape_34xx_unit_check(struct tape_device 
 		 * Tape length error. The tape is shorter than reported in
 		 * the beginning-of-tape data.
 		 */
-		PRINT_WARN("Tape length error.\n");
+		dev_warn (&device->cdev->dev, "The tape information states an"
+			" incorrect length\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x38:
 		/*
@@ -620,12 +612,12 @@ tape_34xx_unit_check(struct tape_device 
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x3a:
 		/* Drive switched to not ready. */
-		PRINT_WARN("Drive not ready. Turn the ready/not ready switch "
-			   "to ready position and try again.\n");
+		dev_warn (&device->cdev->dev, "The tape unit is not ready\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x3b:
 		/* Manual rewind or unload. This causes an I/O error. */
-		PRINT_WARN("Medium was rewound or unloaded manually.\n");
+		dev_warn (&device->cdev->dev, "The tape medium has been "
+			"rewound or unloaded manually\n");
 		tape_34xx_delete_sbid_from(device, 0);
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x42:
@@ -633,7 +625,8 @@ tape_34xx_unit_check(struct tape_device 
 		 * Degraded mode. A condition that can cause degraded
 		 * performance is detected.
 		 */
-		PRINT_WARN("Subsystem is running in degraded mode.\n");
+		dev_warn (&device->cdev->dev, "The tape subsystem is running "
+			"in degraded mode\n");
 		return tape_34xx_erp_retry(request);
 	case 0x43:
 		/* Drive not ready. */
@@ -652,7 +645,6 @@ tape_34xx_unit_check(struct tape_device 
 					break;
 			}
 		}
-		PRINT_WARN("The drive is not ready.\n");
 		return tape_34xx_erp_failed(request, -ENOMEDIUM);
 	case 0x44:
 		/* Locate Block unsuccessful. */
@@ -663,7 +655,8 @@ tape_34xx_unit_check(struct tape_device 
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x45:
 		/* The drive is assigned to a different channel path. */
-		PRINT_WARN("The drive is assigned elsewhere.\n");
+		dev_warn (&device->cdev->dev, "The tape unit is already "
+			"assigned\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x46:
 		/*
@@ -671,11 +664,12 @@ tape_34xx_unit_check(struct tape_device 
 		 * the power supply may be switched off or
 		 * the drive address may not be set correctly.
 		 */
-		PRINT_WARN("The drive is not on-line.");
+		dev_warn (&device->cdev->dev, "The tape unit is not online\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x47:
 		/* Volume fenced. CU reports volume integrity is lost. */
-		PRINT_WARN("Volume fenced. The volume integrity is lost.\n");
+		dev_warn (&device->cdev->dev, "The control unit has fenced "
+			"access to the tape volume\n");
 		tape_34xx_delete_sbid_from(device, 0);
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x48:
@@ -683,20 +677,21 @@ tape_34xx_unit_check(struct tape_device 
 		return tape_34xx_erp_retry(request);
 	case 0x49:
 		/* Bus out check. A parity check error on the bus was found. */
-		PRINT_WARN("Bus out check. A data transfer over the bus "
-			   "has been corrupted.\n");
+		dev_warn (&device->cdev->dev, "A parity error occurred on the "
+			"tape bus\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x4a:
 		/* Control unit erp failed. */
-		PRINT_WARN("The control unit I/O error recovery failed.\n");
+		dev_warn (&device->cdev->dev, "I/O error recovery failed on "
+			"the tape control unit\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x4b:
 		/*
 		 * CU and drive incompatible. The drive requests micro-program
 		 * patches, which are not available on the CU.
 		 */
-		PRINT_WARN("The drive needs microprogram patches from the "
-			   "control unit, which are not available.\n");
+		dev_warn (&device->cdev->dev, "The tape unit requires a "
+			"firmware update\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x4c:
 		/*
@@ -721,8 +716,8 @@ tape_34xx_unit_check(struct tape_device 
 			 * the block to be written is larger than allowed for
 			 * buffered mode.
 			 */
-			PRINT_WARN("Maximum block size for buffered "
-				   "mode exceeded.\n");
+			dev_warn (&device->cdev->dev, "The maximum block size"
+				" for buffered mode is exceeded\n");
 			return tape_34xx_erp_failed(request, -ENOBUFS);
 		}
 		/* This erpa is reserved for 3480. */
@@ -759,22 +754,20 @@ tape_34xx_unit_check(struct tape_device 
 		return tape_34xx_erp_retry(request);
 	case 0x55:
 		/* Channel interface recovery (permanent). */
-		PRINT_WARN("A permanent channel interface error occurred.\n");
+		dev_warn (&device->cdev->dev, "A channel interface error cannot be"
+			" recovered\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x56:
 		/* Channel protocol error. */
-		PRINT_WARN("A channel protocol error occurred.\n");
+		dev_warn (&device->cdev->dev, "A channel protocol error "
+			"occurred\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x57:
 		if (device->cdev->id.driver_info == tape_3480) {
 			/* Attention intercept. */
-			PRINT_WARN("An attention intercept occurred, "
-				   "which will be recovered.\n");
 			return tape_34xx_erp_retry(request);
 		} else {
 			/* Global status intercept. */
-			PRINT_WARN("An global status intercept was received, "
-				   "which will be recovered.\n");
 			return tape_34xx_erp_retry(request);
 		}
 	case 0x5a:
@@ -782,42 +775,31 @@ tape_34xx_unit_check(struct tape_device 
 		 * Tape length incompatible. The tape inserted is too long,
 		 * which could cause damage to the tape or the drive.
 		 */
-		PRINT_WARN("Tape Length Incompatible\n");
-		PRINT_WARN("Tape length exceeds IBM enhanced capacity "
-			"cartdridge length or a medium\n");
-		PRINT_WARN("with EC-CST identification mark has been mounted "
-			"in a device that writes\n");
-		PRINT_WARN("3480 or 3480 XF format.\n");
+		dev_warn (&device->cdev->dev, "The tape unit does not support "
+			"the tape length\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x5b:
 		/* Format 3480 XF incompatible */
 		if (sense[1] & SENSE_BEGINNING_OF_TAPE)
 			/* The tape will get overwritten. */
 			return tape_34xx_erp_retry(request);
-		PRINT_WARN("Format 3480 XF Incompatible\n");
-		PRINT_WARN("Medium has been created in 3480 format. "
-			"To change the format writes\n");
-		PRINT_WARN("must be issued at BOT.\n");
+		dev_warn (&device->cdev->dev, "The tape unit does not support"
+			" format 3480 XF\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x5c:
 		/* Format 3480-2 XF incompatible */
-		PRINT_WARN("Format 3480-2 XF Incompatible\n");
-		PRINT_WARN("Device can only read 3480 or 3480 XF format.\n");
+		dev_warn (&device->cdev->dev, "The tape unit does not support tape "
+			"format 3480-2 XF\n");
 		return tape_34xx_erp_failed(request, -EIO);
 	case 0x5d:
 		/* Tape length violation. */
-		PRINT_WARN("Tape Length Violation\n");
-		PRINT_WARN("The mounted tape exceeds IBM Enhanced Capacity "
-			"Cartdridge System Tape length.\n");
-		PRINT_WARN("This may cause damage to the drive or tape when "
-			"processing to the EOV\n");
+		dev_warn (&device->cdev->dev, "The tape unit does not support"
+			" the current tape length\n");
 		return tape_34xx_erp_failed(request, -EMEDIUMTYPE);
 	case 0x5e:
 		/* Compaction algorithm incompatible. */
-		PRINT_WARN("Compaction Algorithm Incompatible\n");
-		PRINT_WARN("The volume is recorded using an incompatible "
-			"compaction algorithm,\n");
-		PRINT_WARN("which is not supported by the device.\n");
+		dev_warn (&device->cdev->dev, "The tape unit does not support"
+			" the compaction algorithm\n");
 		return tape_34xx_erp_failed(request, -EMEDIUMTYPE);
 
 		/* The following erpas should have been covered earlier. */
@@ -848,7 +830,6 @@ tape_34xx_irq(struct tape_device *device
 	    (irb->scsw.cmd.dstat & DEV_STAT_DEV_END) &&
 	    (request->op == TO_WRI)) {
 		/* Write at end of volume */
-		PRINT_INFO("End of volume\n"); /* XXX */
 		return tape_34xx_erp_failed(request, -ENOSPC);
 	}
 
@@ -869,9 +850,7 @@ tape_34xx_irq(struct tape_device *device
 	}
 
 	DBF_EVENT(6, "xunknownirq\n");
-	PRINT_ERR("Unexpected interrupt.\n");
-	PRINT_ERR("Current op is: %s", tape_op_verbose[request->op]);
-	tape_dump_sense(device, request, irb);
+	tape_dump_sense_dbf(device, request, irb);
 	return TAPE_IO_STOP;
 }
 
Index: quilt-2.6/drivers/s390/char/tape_3590.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_3590.c
+++ quilt-2.6/drivers/s390/char/tape_3590.c
@@ -8,12 +8,15 @@
  *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "tape"
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/bio.h>
 #include <asm/ebcdic.h>
 
 #define TAPE_DBF_AREA	tape_3590_dbf
+#define BUFSIZE 512	/* size of buffers for dynamic generated messages */
 
 #include "tape.h"
 #include "tape_std.h"
@@ -36,7 +39,7 @@ EXPORT_SYMBOL(TAPE_DBF_AREA);
  * - Read Alternate:		 implemented
  *******************************************************************/
 
-#define PRINTK_HEADER "TAPE_3590: "
+#define KMSG_COMPONENT "tape"
 
 static const char *tape_3590_msg[TAPE_3590_MAX_MSG] = {
 	[0x00] = "",
@@ -726,7 +729,7 @@ static void tape_3590_med_state_set(stru
 	}
 	c_info->medium_status |= TAPE390_MEDIUM_LOADED_MASK;
 	if (sense->flags & MSENSE_CRYPT_MASK) {
-		PRINT_INFO("Medium is encrypted (%04x)\n", sense->flags);
+		DBF_EVENT(6, "Medium is encrypted (%04x)\n", sense->flags);
 		c_info->medium_status |= TAPE390_MEDIUM_ENCRYPTED_MASK;
 	} else	{
 		DBF_EVENT(6, "Medium is not encrypted %04x\n", sense->flags);
@@ -847,8 +850,7 @@ tape_3590_unsolicited_irq(struct tape_de
 		tape_3590_schedule_work(device, TO_READ_ATTMSG);
 	} else {
 		DBF_EVENT(3, "unsol.irq! dev end: %08x\n", device->cdev_id);
-		PRINT_WARN("Unsolicited IRQ (Device End) caught.\n");
-		tape_dump_sense(device, NULL, irb);
+		tape_dump_sense_dbf(device, NULL, irb);
 	}
 	/* check medium state */
 	tape_3590_schedule_work(device, TO_MSEN);
@@ -876,8 +878,6 @@ tape_3590_erp_basic(struct tape_device *
 	case SENSE_BRA_DRE:
 		return tape_3590_erp_failed(device, request, irb, rc);
 	default:
-		PRINT_ERR("Unknown BRA %x - This should not happen!\n",
-			  sense->bra);
 		BUG();
 		return TAPE_IO_STOP;
 	}
@@ -910,7 +910,8 @@ tape_3590_erp_swap(struct tape_device *d
 	 * should proceed with the new tape... this
 	 * should probably be done in user space!
 	 */
-	PRINT_WARN("(%s): Swap Tape Device!\n", dev_name(&device->cdev->dev));
+	dev_warn (&device->cdev->dev, "The tape medium must be loaded into a "
+		"different tape unit\n");
 	return tape_3590_erp_basic(device, request, irb, -EIO);
 }
 
@@ -985,8 +986,6 @@ tape_3590_erp_read_opposite(struct tape_
 		return tape_3590_erp_failed(device, request, irb, -EIO);
 		break;
 	default:
-		PRINT_WARN("read_opposite_recovery_called_with_op: %s\n",
-			   tape_op_verbose[request->op]);
 		return tape_3590_erp_failed(device, request, irb, -EIO);
 	}
 }
@@ -998,50 +997,61 @@ static void
 tape_3590_print_mim_msg_f0(struct tape_device *device, struct irb *irb)
 {
 	struct tape_3590_sense *sense;
+	char *exception, *service;
+
+	exception = kmalloc(BUFSIZE, GFP_ATOMIC);
+	service = kmalloc(BUFSIZE, GFP_ATOMIC);
+
+	if (!exception || !service)
+		goto out_nomem;
 
 	sense = (struct tape_3590_sense *) irb->ecw;
 	/* Exception Message */
 	switch (sense->fmt.f70.emc) {
 	case 0x02:
-		PRINT_WARN("(%s): Data degraded\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(exception, BUFSIZE, "Data degraded");
 		break;
 	case 0x03:
-		PRINT_WARN("(%s): Data degraded in partion %i\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f70.mp);
+		snprintf(exception, BUFSIZE, "Data degraded in partion %i",
+			sense->fmt.f70.mp);
 		break;
 	case 0x04:
-		PRINT_WARN("(%s): Medium degraded\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(exception, BUFSIZE, "Medium degraded");
 		break;
 	case 0x05:
-		PRINT_WARN("(%s): Medium degraded in partition %i\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f70.mp);
+		snprintf(exception, BUFSIZE, "Medium degraded in partition %i",
+			sense->fmt.f70.mp);
 		break;
 	case 0x06:
-		PRINT_WARN("(%s): Block 0 Error\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(exception, BUFSIZE, "Block 0 Error");
 		break;
 	case 0x07:
-		PRINT_WARN("(%s): Medium Exception 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f70.md);
+		snprintf(exception, BUFSIZE, "Medium Exception 0x%02x",
+			sense->fmt.f70.md);
 		break;
 	default:
-		PRINT_WARN("(%s): MIM ExMsg: 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f70.emc);
+		snprintf(exception, BUFSIZE, "0x%02x",
+			sense->fmt.f70.emc);
 		break;
 	}
 	/* Service Message */
 	switch (sense->fmt.f70.smc) {
 	case 0x02:
-		PRINT_WARN("(%s): Reference Media maintenance procedure %i\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f70.md);
+		snprintf(service, BUFSIZE, "Reference Media maintenance "
+			"procedure %i", sense->fmt.f70.md);
 		break;
 	default:
-		PRINT_WARN("(%s): MIM ServiceMsg: 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f70.smc);
+		snprintf(service, BUFSIZE, "0x%02x",
+			sense->fmt.f70.smc);
 		break;
 	}
+
+	dev_warn (&device->cdev->dev, "Tape media information: exception %s, "
+		"service %s\n", exception, service);
+
+out_nomem:
+	kfree(exception);
+	kfree(service);
 }
 
 /*
@@ -1051,108 +1061,108 @@ static void
 tape_3590_print_io_sim_msg_f1(struct tape_device *device, struct irb *irb)
 {
 	struct tape_3590_sense *sense;
+	char *exception, *service;
+
+	exception = kmalloc(BUFSIZE, GFP_ATOMIC);
+	service = kmalloc(BUFSIZE, GFP_ATOMIC);
+
+	if (!exception || !service)
+		goto out_nomem;
 
 	sense = (struct tape_3590_sense *) irb->ecw;
 	/* Exception Message */
 	switch (sense->fmt.f71.emc) {
 	case 0x01:
-		PRINT_WARN("(%s): Effect of failure is unknown\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(exception, BUFSIZE, "Effect of failure is unknown");
 		break;
 	case 0x02:
-		PRINT_WARN("(%s): CU Exception - no performance impact\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(exception, BUFSIZE, "CU Exception - no performance "
+			"impact");
 		break;
 	case 0x03:
-		PRINT_WARN("(%s): CU Exception on channel interface 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f71.md[0]);
+		snprintf(exception, BUFSIZE, "CU Exception on channel "
+			"interface 0x%02x", sense->fmt.f71.md[0]);
 		break;
 	case 0x04:
-		PRINT_WARN("(%s): CU Exception on device path 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f71.md[0]);
+		snprintf(exception, BUFSIZE, "CU Exception on device path "
+			"0x%02x", sense->fmt.f71.md[0]);
 		break;
 	case 0x05:
-		PRINT_WARN("(%s): CU Exception on library path 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f71.md[0]);
+		snprintf(exception, BUFSIZE, "CU Exception on library path "
+			"0x%02x", sense->fmt.f71.md[0]);
 		break;
 	case 0x06:
-		PRINT_WARN("(%s): CU Exception on node 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f71.md[0]);
+		snprintf(exception, BUFSIZE, "CU Exception on node 0x%02x",
+			sense->fmt.f71.md[0]);
 		break;
 	case 0x07:
-		PRINT_WARN("(%s): CU Exception on partition 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f71.md[0]);
+		snprintf(exception, BUFSIZE, "CU Exception on partition "
+			"0x%02x", sense->fmt.f71.md[0]);
 		break;
 	default:
-		PRINT_WARN("(%s): SIM ExMsg: 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f71.emc);
+		snprintf(exception, BUFSIZE, "0x%02x",
+			sense->fmt.f71.emc);
 	}
 	/* Service Message */
 	switch (sense->fmt.f71.smc) {
 	case 0x01:
-		PRINT_WARN("(%s): Repair impact is unknown\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(service, BUFSIZE, "Repair impact is unknown");
 		break;
 	case 0x02:
-		PRINT_WARN("(%s): Repair will not impact cu performance\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(service, BUFSIZE, "Repair will not impact cu "
+			"performance");
 		break;
 	case 0x03:
 		if (sense->fmt.f71.mdf == 0)
-			PRINT_WARN("(%s): Repair will disable node "
-				   "0x%x on CU\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1]);
+			snprintf(service, BUFSIZE, "Repair will disable node "
+				"0x%x on CU", sense->fmt.f71.md[1]);
 		else
-			PRINT_WARN("(%s): Repair will disable nodes "
-				   "(0x%x-0x%x) on CU\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
+			snprintf(service, BUFSIZE, "Repair will disable "
+				"nodes (0x%x-0x%x) on CU", sense->fmt.f71.md[1],
+				sense->fmt.f71.md[2]);
 		break;
 	case 0x04:
 		if (sense->fmt.f71.mdf == 0)
-			PRINT_WARN("(%s): Repair will disable cannel path "
-				   "0x%x on CU\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1]);
+			snprintf(service, BUFSIZE, "Repair will disable "
+				"channel path 0x%x on CU",
+				sense->fmt.f71.md[1]);
 		else
-			PRINT_WARN("(%s): Repair will disable cannel paths "
-				   "(0x%x-0x%x) on CU\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
+			snprintf(service, BUFSIZE, "Repair will disable cannel"
+				" paths (0x%x-0x%x) on CU",
+				sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
 		break;
 	case 0x05:
 		if (sense->fmt.f71.mdf == 0)
-			PRINT_WARN("(%s): Repair will disable device path "
-				   "0x%x on CU\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1]);
+			snprintf(service, BUFSIZE, "Repair will disable device"
+				" path 0x%x on CU", sense->fmt.f71.md[1]);
 		else
-			PRINT_WARN("(%s): Repair will disable device paths "
-				   "(0x%x-0x%x) on CU\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
+			snprintf(service, BUFSIZE, "Repair will disable device"
+				" paths (0x%x-0x%x) on CU",
+				sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
 		break;
 	case 0x06:
 		if (sense->fmt.f71.mdf == 0)
-			PRINT_WARN("(%s): Repair will disable library path "
-				   "0x%x on CU\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1]);
+			snprintf(service, BUFSIZE, "Repair will disable "
+				"library path 0x%x on CU",
+				sense->fmt.f71.md[1]);
 		else
-			PRINT_WARN("(%s): Repair will disable library paths "
-				   "(0x%x-0x%x) on CU\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
+			snprintf(service, BUFSIZE, "Repair will disable "
+				"library paths (0x%x-0x%x) on CU",
+				sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
 		break;
 	case 0x07:
-		PRINT_WARN("(%s): Repair will disable access to CU\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(service, BUFSIZE, "Repair will disable access to CU");
 		break;
 	default:
-		PRINT_WARN("(%s): SIM ServiceMsg: 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f71.smc);
+		snprintf(service, BUFSIZE, "0x%02x",
+			sense->fmt.f71.smc);
 	}
+
+	dev_warn (&device->cdev->dev, "I/O subsystem information: exception"
+		" %s, service %s\n", exception, service);
+out_nomem:
+	kfree(exception);
+	kfree(service);
 }
 
 /*
@@ -1162,111 +1172,109 @@ static void
 tape_3590_print_dev_sim_msg_f2(struct tape_device *device, struct irb *irb)
 {
 	struct tape_3590_sense *sense;
+	char *exception, *service;
+
+	exception = kmalloc(BUFSIZE, GFP_ATOMIC);
+	service = kmalloc(BUFSIZE, GFP_ATOMIC);
+
+	if (!exception || !service)
+		goto out_nomem;
 
 	sense = (struct tape_3590_sense *) irb->ecw;
 	/* Exception Message */
 	switch (sense->fmt.f71.emc) {
 	case 0x01:
-		PRINT_WARN("(%s): Effect of failure is unknown\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(exception, BUFSIZE, "Effect of failure is unknown");
 		break;
 	case 0x02:
-		PRINT_WARN("(%s): DV Exception - no performance impact\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(exception, BUFSIZE, "DV Exception - no performance"
+			" impact");
 		break;
 	case 0x03:
-		PRINT_WARN("(%s): DV Exception on channel interface 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f71.md[0]);
+		snprintf(exception, BUFSIZE, "DV Exception on channel "
+			"interface 0x%02x", sense->fmt.f71.md[0]);
 		break;
 	case 0x04:
-		PRINT_WARN("(%s): DV Exception on loader 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f71.md[0]);
+		snprintf(exception, BUFSIZE, "DV Exception on loader 0x%02x",
+			sense->fmt.f71.md[0]);
 		break;
 	case 0x05:
-		PRINT_WARN("(%s): DV Exception on message display 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f71.md[0]);
+		snprintf(exception, BUFSIZE, "DV Exception on message display"
+			" 0x%02x", sense->fmt.f71.md[0]);
 		break;
 	case 0x06:
-		PRINT_WARN("(%s): DV Exception in tape path\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(exception, BUFSIZE, "DV Exception in tape path");
 		break;
 	case 0x07:
-		PRINT_WARN("(%s): DV Exception in drive\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(exception, BUFSIZE, "DV Exception in drive");
 		break;
 	default:
-		PRINT_WARN("(%s): DSIM ExMsg: 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f71.emc);
+		snprintf(exception, BUFSIZE, "0x%02x",
+			sense->fmt.f71.emc);
 	}
 	/* Service Message */
 	switch (sense->fmt.f71.smc) {
 	case 0x01:
-		PRINT_WARN("(%s): Repair impact is unknown\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(service, BUFSIZE, "Repair impact is unknown");
 		break;
 	case 0x02:
-		PRINT_WARN("(%s): Repair will not impact device performance\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(service, BUFSIZE, "Repair will not impact device "
+			"performance");
 		break;
 	case 0x03:
 		if (sense->fmt.f71.mdf == 0)
-			PRINT_WARN("(%s): Repair will disable channel path "
-				   "0x%x on DV\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1]);
+			snprintf(service, BUFSIZE, "Repair will disable "
+				"channel path 0x%x on DV",
+				sense->fmt.f71.md[1]);
 		else
-			PRINT_WARN("(%s): Repair will disable channel path "
-				   "(0x%x-0x%x) on DV\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
+			snprintf(service, BUFSIZE, "Repair will disable "
+				"channel path (0x%x-0x%x) on DV",
+				sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
 		break;
 	case 0x04:
 		if (sense->fmt.f71.mdf == 0)
-			PRINT_WARN("(%s): Repair will disable interface 0x%x "
-				   "on DV\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1]);
+			snprintf(service, BUFSIZE, "Repair will disable "
+				"interface 0x%x on DV", sense->fmt.f71.md[1]);
 		else
-			PRINT_WARN("(%s): Repair will disable interfaces "
-				   "(0x%x-0x%x) on DV\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
+			snprintf(service, BUFSIZE, "Repair will disable "
+				"interfaces (0x%x-0x%x) on DV",
+				sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
 		break;
 	case 0x05:
 		if (sense->fmt.f71.mdf == 0)
-			PRINT_WARN("(%s): Repair will disable loader 0x%x "
-				   "on DV\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1]);
+			snprintf(service, BUFSIZE, "Repair will disable loader"
+				" 0x%x on DV", sense->fmt.f71.md[1]);
 		else
-			PRINT_WARN("(%s): Repair will disable loader "
-				   "(0x%x-0x%x) on DV\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
+			snprintf(service, BUFSIZE, "Repair will disable loader"
+				" (0x%x-0x%x) on DV",
+				sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
 		break;
 	case 0x07:
-		PRINT_WARN("(%s): Repair will disable access to DV\n",
-			   dev_name(&device->cdev->dev));
+		snprintf(service, BUFSIZE, "Repair will disable access to DV");
 		break;
 	case 0x08:
 		if (sense->fmt.f71.mdf == 0)
-			PRINT_WARN("(%s): Repair will disable message "
-				   "display 0x%x on DV\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1]);
+			snprintf(service, BUFSIZE, "Repair will disable "
+				"message display 0x%x on DV",
+				sense->fmt.f71.md[1]);
 		else
-			PRINT_WARN("(%s): Repair will disable message "
-				   "displays (0x%x-0x%x) on DV\n",
-				   dev_name(&device->cdev->dev),
-				   sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
+			snprintf(service, BUFSIZE, "Repair will disable "
+				"message displays (0x%x-0x%x) on DV",
+				 sense->fmt.f71.md[1], sense->fmt.f71.md[2]);
 		break;
 	case 0x09:
-		PRINT_WARN("(%s): Clean DV\n", dev_name(&device->cdev->dev));
+		snprintf(service, BUFSIZE, "Clean DV");
 		break;
 	default:
-		PRINT_WARN("(%s): DSIM ServiceMsg: 0x%02x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f71.smc);
+		snprintf(service, BUFSIZE, "0x%02x",
+			sense->fmt.f71.smc);
 	}
+
+	dev_warn (&device->cdev->dev, "Device subsystem information: exception"
+		" %s, service %s\n", exception, service);
+out_nomem:
+	kfree(exception);
+	kfree(service);
 }
 
 /*
@@ -1282,46 +1290,44 @@ tape_3590_print_era_msg(struct tape_devi
 		return;
 	if ((sense->mc > 0) && (sense->mc < TAPE_3590_MAX_MSG)) {
 		if (tape_3590_msg[sense->mc] != NULL)
-			PRINT_WARN("(%s): %s\n", dev_name(&device->cdev->dev),
-				   tape_3590_msg[sense->mc]);
-		else {
-			PRINT_WARN("(%s): Message Code 0x%x\n",
-				   dev_name(&device->cdev->dev), sense->mc);
-		}
+			dev_warn (&device->cdev->dev, "The tape unit has "
+				"issued sense message %s\n",
+				tape_3590_msg[sense->mc]);
+		else
+			dev_warn (&device->cdev->dev, "The tape unit has "
+				"issued an unknown sense message code 0x%x\n",
+				sense->mc);
 		return;
 	}
 	if (sense->mc == 0xf0) {
 		/* Standard Media Information Message */
-		PRINT_WARN("(%s): MIM SEV=%i, MC=%02x, ES=%x/%x, "
-			   "RC=%02x-%04x-%02x\n", dev_name(&device->cdev->dev),
-			   sense->fmt.f70.sev, sense->mc,
-			   sense->fmt.f70.emc, sense->fmt.f70.smc,
-			   sense->fmt.f70.refcode, sense->fmt.f70.mid,
-			   sense->fmt.f70.fid);
+		dev_warn (&device->cdev->dev, "MIM SEV=%i, MC=%02x, ES=%x/%x, "
+			"RC=%02x-%04x-%02x\n", sense->fmt.f70.sev, sense->mc,
+			sense->fmt.f70.emc, sense->fmt.f70.smc,
+			sense->fmt.f70.refcode, sense->fmt.f70.mid,
+			sense->fmt.f70.fid);
 		tape_3590_print_mim_msg_f0(device, irb);
 		return;
 	}
 	if (sense->mc == 0xf1) {
 		/* Standard I/O Subsystem Service Information Message */
-		PRINT_WARN("(%s): IOSIM SEV=%i, DEVTYPE=3590/%02x, "
-			   "MC=%02x, ES=%x/%x, REF=0x%04x-0x%04x-0x%04x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f71.sev,
-			   device->cdev->id.dev_model,
-			   sense->mc, sense->fmt.f71.emc,
-			   sense->fmt.f71.smc, sense->fmt.f71.refcode1,
-			   sense->fmt.f71.refcode2, sense->fmt.f71.refcode3);
+		dev_warn (&device->cdev->dev, "IOSIM SEV=%i, DEVTYPE=3590/%02x,"
+			" MC=%02x, ES=%x/%x, REF=0x%04x-0x%04x-0x%04x\n",
+			sense->fmt.f71.sev, device->cdev->id.dev_model,
+			sense->mc, sense->fmt.f71.emc, sense->fmt.f71.smc,
+			sense->fmt.f71.refcode1, sense->fmt.f71.refcode2,
+			sense->fmt.f71.refcode3);
 		tape_3590_print_io_sim_msg_f1(device, irb);
 		return;
 	}
 	if (sense->mc == 0xf2) {
 		/* Standard Device Service Information Message */
-		PRINT_WARN("(%s): DEVSIM SEV=%i, DEVTYPE=3590/%02x, "
-			   "MC=%02x, ES=%x/%x, REF=0x%04x-0x%04x-0x%04x\n",
-			   dev_name(&device->cdev->dev), sense->fmt.f71.sev,
-			   device->cdev->id.dev_model,
-			   sense->mc, sense->fmt.f71.emc,
-			   sense->fmt.f71.smc, sense->fmt.f71.refcode1,
-			   sense->fmt.f71.refcode2, sense->fmt.f71.refcode3);
+		dev_warn (&device->cdev->dev, "DEVSIM SEV=%i, DEVTYPE=3590/%02x"
+			", MC=%02x, ES=%x/%x, REF=0x%04x-0x%04x-0x%04x\n",
+			sense->fmt.f71.sev, device->cdev->id.dev_model,
+			sense->mc, sense->fmt.f71.emc, sense->fmt.f71.smc,
+			sense->fmt.f71.refcode1, sense->fmt.f71.refcode2,
+			sense->fmt.f71.refcode3);
 		tape_3590_print_dev_sim_msg_f2(device, irb);
 		return;
 	}
@@ -1329,8 +1335,8 @@ tape_3590_print_era_msg(struct tape_devi
 		/* Standard Library Service Information Message */
 		return;
 	}
-	PRINT_WARN("(%s): Device Message(%x)\n",
-		   dev_name(&device->cdev->dev), sense->mc);
+	dev_warn (&device->cdev->dev, "The tape unit has issued an unknown "
+		"sense message code %x\n", sense->mc);
 }
 
 static int tape_3590_crypt_error(struct tape_device *device,
@@ -1355,9 +1361,8 @@ static int tape_3590_crypt_error(struct 
 		/* No connection to EKM */
 		return tape_3590_erp_basic(device, request, irb, -ENOTCONN);
 
-	PRINT_ERR("(%s): Unable to get encryption key from EKM\n", bus_id);
-	PRINT_ERR("(%s): CU=%02X DRIVE=%06X EKM=%02X:%04X\n", bus_id, cu_rc,
-		drv_rc, ekm_rc1, ekm_rc2);
+	dev_err (&device->cdev->dev, "The tape unit failed to obtain the "
+		"encryption key from EKM\n");
 
 	return tape_3590_erp_basic(device, request, irb, -ENOKEY);
 }
@@ -1443,8 +1448,6 @@ tape_3590_unit_check(struct tape_device 
 		 * print additional msg since default msg
 		 * "device intervention" is not very meaningfull
 		 */
-		PRINT_WARN("(%s): Tape operation when medium not loaded\n",
-			   dev_name(&device->cdev->dev));
 		tape_med_state_set(device, MS_UNLOADED);
 		tape_3590_schedule_work(device, TO_CRYPT_OFF);
 		return tape_3590_erp_basic(device, request, irb, -ENOMEDIUM);
@@ -1490,19 +1493,13 @@ tape_3590_unit_check(struct tape_device 
 		return tape_3590_erp_basic(device, request, irb, -ENOMEDIUM);
 
 	case 0x6020:
-		PRINT_WARN("(%s): Cartridge of wrong type ?\n",
-			   dev_name(&device->cdev->dev));
 		return tape_3590_erp_basic(device, request, irb, -EMEDIUMTYPE);
 
 	case 0x8011:
-		PRINT_WARN("(%s): Another host has reserved the tape device\n",
-			   dev_name(&device->cdev->dev));
 		return tape_3590_erp_basic(device, request, irb, -EPERM);
 	case 0x8013:
-		PRINT_WARN("(%s): Another host has privileged access to the "
-			   "tape device\n", dev_name(&device->cdev->dev));
-		PRINT_WARN("(%s): To solve the problem unload the current "
-			   "cartridge!\n", dev_name(&device->cdev->dev));
+		dev_warn (&device->cdev->dev, "A different host has privileged"
+			" access to the tape unit\n");
 		return tape_3590_erp_basic(device, request, irb, -EPERM);
 	default:
 		return tape_3590_erp_basic(device, request, irb, -EIO);
@@ -1552,9 +1549,7 @@ tape_3590_irq(struct tape_device *device
 	}
 
 	DBF_EVENT(6, "xunknownirq\n");
-	PRINT_ERR("Unexpected interrupt.\n");
-	PRINT_ERR("Current op is: %s", tape_op_verbose[request->op]);
-	tape_dump_sense(device, request, irb);
+	tape_dump_sense_dbf(device, request, irb);
 	return TAPE_IO_STOP;
 }
 
@@ -1609,7 +1604,6 @@ tape_3590_setup_device(struct tape_devic
 	if (rc)
 		goto fail_rdc_data;
 	if (rdc_data->data[31] == 0x13) {
-		PRINT_INFO("Device has crypto support\n");
 		data->crypt_info.capability |= TAPE390_CRYPT_SUPPORTED_MASK;
 		tape_3592_disable_crypt(device);
 	} else {
Index: quilt-2.6/drivers/s390/char/tape_block.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_block.c
+++ quilt-2.6/drivers/s390/char/tape_block.c
@@ -10,6 +10,8 @@
  *		 Stefan Bader <shbader@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "tape"
+
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/blkdev.h>
@@ -23,8 +25,6 @@
 
 #include "tape.h"
 
-#define PRINTK_HEADER "TAPE_BLOCK: "
-
 #define TAPEBLOCK_MAX_SEC	100
 #define TAPEBLOCK_MIN_REQUEUE	3
 
@@ -279,8 +279,6 @@ tapeblock_cleanup_device(struct tape_dev
 	tape_put_device(device);
 
 	if (!device->blk_data.disk) {
-		PRINT_ERR("(%s): No gendisk to clean up!\n",
-			dev_name(&device->cdev->dev));
 		goto cleanup_queue;
 	}
 
@@ -314,7 +312,8 @@ tapeblock_revalidate_disk(struct gendisk
 	if (!device->blk_data.medium_changed)
 		return 0;
 
-	PRINT_INFO("Detecting media size...\n");
+	dev_info(&device->cdev->dev, "Determining the size of the recorded "
+		"area...\n");
 	rc = tape_mtop(device, MTFSFM, 1);
 	if (rc)
 		return rc;
@@ -341,7 +340,8 @@ tapeblock_revalidate_disk(struct gendisk
 	device->bof = rc;
 	nr_of_blks -= rc;
 
-	PRINT_INFO("Found %i blocks on media\n", nr_of_blks);
+	dev_info(&device->cdev->dev, "The size of the recorded area is %i "
+		"blocks\n", nr_of_blks);
 	set_capacity(device->blk_data.disk,
 		nr_of_blks*(TAPEBLOCK_HSEC_SIZE/512));
 
@@ -376,8 +376,8 @@ tapeblock_open(struct block_device *bdev
 
 	if (device->required_tapemarks) {
 		DBF_EVENT(2, "TBLOCK: missing tapemarks\n");
-		PRINT_ERR("TBLOCK: Refusing to open tape with missing"
-			" end of file marks.\n");
+		dev_warn(&device->cdev->dev, "Opening the tape failed because"
+			" of missing end-of-file marks\n");
 		rc = -EPERM;
 		goto put_device;
 	}
@@ -452,7 +452,6 @@ tapeblock_ioctl(
 			rc = -EINVAL;
 			break;
 		default:
-			PRINT_WARN("invalid ioctl 0x%x\n", command);
 			rc = -EINVAL;
 	}
 
@@ -474,7 +473,6 @@ tapeblock_init(void)
 
 	if (tapeblock_major == 0)
 		tapeblock_major = rc;
-	PRINT_INFO("tape gets major %d for block device\n", tapeblock_major);
 	return 0;
 }
 
Index: quilt-2.6/drivers/s390/char/tape_char.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_char.c
+++ quilt-2.6/drivers/s390/char/tape_char.c
@@ -24,8 +24,6 @@
 #include "tape_std.h"
 #include "tape_class.h"
 
-#define PRINTK_HEADER "TAPE_CHAR: "
-
 #define TAPECHAR_MAJOR		0	/* get dynamic major */
 
 /*
@@ -102,8 +100,6 @@ tapechar_check_idalbuffer(struct tape_de
 	if (block_size > MAX_BLOCKSIZE) {
 		DBF_EVENT(3, "Invalid blocksize (%zd > %d)\n",
 			block_size, MAX_BLOCKSIZE);
-		PRINT_ERR("Invalid blocksize (%zd> %d)\n",
-			block_size, MAX_BLOCKSIZE);
 		return -EINVAL;
 	}
 
@@ -485,7 +481,6 @@ tapechar_init (void)
 		return -1;
 
 	tapechar_major = MAJOR(dev);
-	PRINT_INFO("tape gets major %d for character devices\n", MAJOR(dev));
 
 	return 0;
 }
@@ -496,7 +491,5 @@ tapechar_init (void)
 void
 tapechar_exit(void)
 {
-	PRINT_INFO("tape releases major %d for character devices\n",
-		tapechar_major);
 	unregister_chrdev_region(MKDEV(tapechar_major, 0), 256);
 }
Index: quilt-2.6/drivers/s390/char/tape_core.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_core.c
+++ quilt-2.6/drivers/s390/char/tape_core.c
@@ -11,6 +11,7 @@
  *		 Stefan Bader <shbader@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "tape"
 #include <linux/module.h>
 #include <linux/init.h>	     // for kernel parameters
 #include <linux/kmod.h>	     // for requesting modules
@@ -25,7 +26,6 @@
 #include "tape.h"
 #include "tape_std.h"
 
-#define PRINTK_HEADER "TAPE_CORE: "
 #define LONG_BUSY_TIMEOUT 180 /* seconds */
 
 static void __tape_do_irq (struct ccw_device *, unsigned long, struct irb *);
@@ -214,13 +214,13 @@ tape_med_state_set(struct tape_device *d
 	switch(newstate){
 	case MS_UNLOADED:
 		device->tape_generic_status |= GMT_DR_OPEN(~0);
-		PRINT_INFO("(%s): Tape is unloaded\n",
-			   dev_name(&device->cdev->dev));
+		dev_info(&device->cdev->dev, "The tape cartridge has been "
+			"successfully unloaded\n");
 		break;
 	case MS_LOADED:
 		device->tape_generic_status &= ~GMT_DR_OPEN(~0);
-		PRINT_INFO("(%s): Tape has been mounted\n",
-			   dev_name(&device->cdev->dev));
+		dev_info(&device->cdev->dev, "A tape cartridge has been "
+			"mounted\n");
 		break;
 	default:
 		// print nothing
@@ -333,7 +333,6 @@ tape_generic_online(struct tape_device *
 	/* Let the discipline have a go at the device. */
 	device->discipline = discipline;
 	if (!try_module_get(discipline->owner)) {
-		PRINT_ERR("Cannot get module. Module gone.\n");
 		return -EINVAL;
 	}
 
@@ -391,7 +390,6 @@ int
 tape_generic_offline(struct tape_device *device)
 {
 	if (!device) {
-		PRINT_ERR("tape_generic_offline: no such device\n");
 		return -ENODEV;
 	}
 
@@ -413,9 +411,6 @@ tape_generic_offline(struct tape_device 
 			DBF_EVENT(3, "(%08x): Set offline failed "
 				"- drive in use.\n",
 				device->cdev_id);
-			PRINT_WARN("(%s): Set offline failed "
-				"- drive in use.\n",
-				dev_name(&device->cdev->dev));
 			spin_unlock_irq(get_ccwdev_lock(device->cdev));
 			return -EBUSY;
 	}
@@ -435,14 +430,11 @@ tape_alloc_device(void)
 	device = kzalloc(sizeof(struct tape_device), GFP_KERNEL);
 	if (device == NULL) {
 		DBF_EXCEPTION(2, "ti:no mem\n");
-		PRINT_INFO ("can't allocate memory for "
-			    "tape info structure\n");
 		return ERR_PTR(-ENOMEM);
 	}
 	device->modeset_byte = kmalloc(1, GFP_KERNEL | GFP_DMA);
 	if (device->modeset_byte == NULL) {
 		DBF_EXCEPTION(2, "ti:no mem\n");
-		PRINT_INFO("can't allocate memory for modeset byte\n");
 		kfree(device);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -490,7 +482,6 @@ tape_put_device(struct tape_device *devi
 	} else {
 		if (remain < 0) {
 			DBF_EVENT(4, "put device without reference\n");
-			PRINT_ERR("put device without reference\n");
 		} else {
 			DBF_EVENT(4, "tape_free_device(%p)\n", device);
 			kfree(device->modeset_byte);
@@ -538,8 +529,6 @@ tape_generic_probe(struct ccw_device *cd
 	ret = sysfs_create_group(&cdev->dev.kobj, &tape_attr_group);
 	if (ret) {
 		tape_put_device(device);
-		PRINT_ERR("probe failed for tape device %s\n",
-			  dev_name(&cdev->dev));
 		return ret;
 	}
 	cdev->dev.driver_data = device;
@@ -547,7 +536,6 @@ tape_generic_probe(struct ccw_device *cd
 	device->cdev = cdev;
 	ccw_device_get_id(cdev, &dev_id);
 	device->cdev_id = devid_to_int(&dev_id);
-	PRINT_INFO("tape device %s found\n", dev_name(&cdev->dev));
 	return ret;
 }
 
@@ -584,7 +572,6 @@ tape_generic_remove(struct ccw_device *c
 
 	device = cdev->dev.driver_data;
 	if (!device) {
-		PRINT_ERR("No device pointer in tape_generic_remove!\n");
 		return;
 	}
 	DBF_LH(3, "(%08x): tape_generic_remove(%p)\n", device->cdev_id, cdev);
@@ -615,10 +602,8 @@ tape_generic_remove(struct ccw_device *c
 			 */
 			DBF_EVENT(3, "(%08x): Drive in use vanished!\n",
 				device->cdev_id);
-			PRINT_WARN("(%s): Drive in use vanished - "
-				"expect trouble!\n",
-				dev_name(&device->cdev->dev));
-			PRINT_WARN("State was %i\n", device->tape_state);
+			dev_warn(&device->cdev->dev, "A tape unit was detached"
+				" while in use\n");
 			tape_state_set(device, TS_NOT_OPER);
 			__tape_discard_requests(device);
 			spin_unlock_irq(get_ccwdev_lock(device->cdev));
@@ -830,30 +815,6 @@ __tape_end_request(
 }
 
 /*
- * Write sense data to console/dbf
- */
-void
-tape_dump_sense(struct tape_device* device, struct tape_request *request,
-		struct irb *irb)
-{
-	unsigned int *sptr;
-
-	PRINT_INFO("-------------------------------------------------\n");
-	PRINT_INFO("DSTAT : %02x  CSTAT: %02x	CPA: %04x\n",
-		   irb->scsw.cmd.dstat, irb->scsw.cmd.cstat, irb->scsw.cmd.cpa);
-	PRINT_INFO("DEVICE: %s\n", dev_name(&device->cdev->dev));
-	if (request != NULL)
-		PRINT_INFO("OP	  : %s\n", tape_op_verbose[request->op]);
-
-	sptr = (unsigned int *) irb->ecw;
-	PRINT_INFO("Sense data: %08X %08X %08X %08X \n",
-		   sptr[0], sptr[1], sptr[2], sptr[3]);
-	PRINT_INFO("Sense data: %08X %08X %08X %08X \n",
-		   sptr[4], sptr[5], sptr[6], sptr[7]);
-	PRINT_INFO("--------------------------------------------------\n");
-}
-
-/*
  * Write sense data to dbf
  */
 void
@@ -1051,8 +1012,6 @@ __tape_do_irq (struct ccw_device *cdev, 
 
 	device = (struct tape_device *) cdev->dev.driver_data;
 	if (device == NULL) {
-		PRINT_ERR("could not get device structure for %s "
-			  "in interrupt\n", dev_name(&cdev->dev));
 		return;
 	}
 	request = (struct tape_request *) intparm;
@@ -1064,13 +1023,13 @@ __tape_do_irq (struct ccw_device *cdev, 
 		/* FIXME: What to do with the request? */
 		switch (PTR_ERR(irb)) {
 			case -ETIMEDOUT:
-				PRINT_WARN("(%s): Request timed out\n",
+				DBF_LH(1, "(%s): Request timed out\n",
 					dev_name(&cdev->dev));
 			case -EIO:
 				__tape_end_request(device, request, -EIO);
 				break;
 			default:
-				PRINT_ERR("(%s): Unexpected i/o error %li\n",
+				DBF_LH(1, "(%s): Unexpected i/o error %li\n",
 					dev_name(&cdev->dev),
 					PTR_ERR(irb));
 		}
@@ -1182,8 +1141,6 @@ __tape_do_irq (struct ccw_device *cdev, 
 		default:
 			if (rc > 0) {
 				DBF_EVENT(6, "xunknownrc\n");
-				PRINT_ERR("Invalid return code from discipline "
-				  	"interrupt function.\n");
 				__tape_end_request(device, request, -EIO);
 			} else {
 				__tape_end_request(device, request, rc);
@@ -1323,7 +1280,6 @@ EXPORT_SYMBOL(tape_state_set);
 EXPORT_SYMBOL(tape_med_state_set);
 EXPORT_SYMBOL(tape_alloc_request);
 EXPORT_SYMBOL(tape_free_request);
-EXPORT_SYMBOL(tape_dump_sense);
 EXPORT_SYMBOL(tape_dump_sense_dbf);
 EXPORT_SYMBOL(tape_do_io);
 EXPORT_SYMBOL(tape_do_io_async);
Index: quilt-2.6/drivers/s390/char/tape.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape.h
+++ quilt-2.6/drivers/s390/char/tape.h
@@ -324,8 +324,6 @@ static inline void tape_proc_cleanup (vo
 #endif
 
 /* a function for dumping device sense info */
-extern void tape_dump_sense(struct tape_device *, struct tape_request *,
-			    struct irb *);
 extern void tape_dump_sense_dbf(struct tape_device *, struct tape_request *,
 				struct irb *);
 
Index: quilt-2.6/drivers/s390/char/tape_proc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_proc.c
+++ quilt-2.6/drivers/s390/char/tape_proc.c
@@ -20,8 +20,6 @@
 
 #include "tape.h"
 
-#define PRINTK_HEADER "TAPE_PROC: "
-
 static const char *tape_med_st_verbose[MS_SIZE] =
 {
 	[MS_UNKNOWN] = "UNKNOWN ",
@@ -128,7 +126,6 @@ tape_proc_init(void)
 		proc_create("tapedevices", S_IFREG | S_IRUGO | S_IWUSR, NULL,
 			    &tape_proc_ops);
 	if (tape_proc_devices == NULL) {
-		PRINT_WARN("tape: Cannot register procfs entry tapedevices\n");
 		return;
 	}
 }
Index: quilt-2.6/drivers/s390/char/tape_std.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_std.c
+++ quilt-2.6/drivers/s390/char/tape_std.c
@@ -26,8 +26,6 @@
 #include "tape.h"
 #include "tape_std.h"
 
-#define PRINTK_HEADER "TAPE_STD: "
-
 /*
  * tape_std_assign
  */
@@ -46,9 +44,8 @@ tape_std_assign_timeout(unsigned long da
 			device->cdev_id);
 	rc = tape_cancel_io(device, request);
 	if(rc)
-		PRINT_ERR("(%s): Assign timeout: Cancel failed with rc = %i\n",
+		DBF_EVENT(3, "(%s): Assign timeout: Cancel failed with rc = %i\n",
 			dev_name(&device->cdev->dev), rc);
-
 }
 
 int
@@ -82,8 +79,6 @@ tape_std_assign(struct tape_device *devi
 	del_timer(&timeout);
 
 	if (rc != 0) {
-		PRINT_WARN("%s: assign failed - device might be busy\n",
-			dev_name(&device->cdev->dev));
 		DBF_EVENT(3, "%08x: assign failed - device might be busy\n",
 			device->cdev_id);
 	} else {
@@ -105,8 +100,6 @@ tape_std_unassign (struct tape_device *d
 	if (device->tape_state == TS_NOT_OPER) {
 		DBF_EVENT(3, "(%08x): Can't unassign device\n",
 			device->cdev_id);
-		PRINT_WARN("(%s): Can't unassign device - device gone\n",
-			dev_name(&device->cdev->dev));
 		return -EIO;
 	}
 
@@ -120,8 +113,6 @@ tape_std_unassign (struct tape_device *d
 
 	if ((rc = tape_do_io(device, request)) != 0) {
 		DBF_EVENT(3, "%08x: Unassign failed\n", device->cdev_id);
-		PRINT_WARN("%s: Unassign failed\n",
-			   dev_name(&device->cdev->dev));
 	} else {
 		DBF_EVENT(3, "%08x: Tape unassigned\n", device->cdev_id);
 	}
@@ -242,8 +233,6 @@ tape_std_mtsetblk(struct tape_device *de
 	if (count > MAX_BLOCKSIZE) {
 		DBF_EVENT(3, "Invalid block size (%d > %d) given.\n",
 			count, MAX_BLOCKSIZE);
-		PRINT_ERR("Invalid block size (%d > %d) given.\n",
-			count, MAX_BLOCKSIZE);
 		return -EINVAL;
 	}
 
@@ -633,14 +622,6 @@ tape_std_mtcompression(struct tape_devic
 
 	if (mt_count < 0 || mt_count > 1) {
 		DBF_EXCEPTION(6, "xcom parm\n");
-		if (*device->modeset_byte & 0x08)
-			PRINT_INFO("(%s) Compression is currently on\n",
-				   dev_name(&device->cdev->dev));
-		else
-			PRINT_INFO("(%s) Compression is currently off\n",
-				   dev_name(&device->cdev->dev));
-		PRINT_INFO("Use 1 to switch compression on, 0 to "
-			   "switch it off\n");
 		return -EINVAL;
 	}
 	request = tape_alloc_request(2, 0);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

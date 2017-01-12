From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC v2 02/15] s390: cio: export more interfaces
Date: Thu, 12 Jan 2017 08:19:34 +0100
Message-ID: <20170112071947.98071-3-bjsdjshi@linux.vnet.ibm.com>
References: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Export the common I/O interfaces those are needed by an I/O
subchannel driver to actually talk to the subchannel.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/cio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 8f86072..f725461 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -170,12 +170,14 @@ cio_start_key (struct subchannel *sch,	/* subchannel structure */
 		return ccode;
 	}
 }
+EXPORT_SYMBOL_GPL(cio_start_key);
 
 int
 cio_start (struct subchannel *sch, struct ccw1 *cpa, __u8 lpm)
 {
 	return cio_start_key(sch, cpa, lpm, PAGE_DEFAULT_KEY);
 }
+EXPORT_SYMBOL_GPL(cio_start);
 
 /*
  * resume suspended I/O operation
@@ -208,6 +210,7 @@ cio_resume (struct subchannel *sch)
 		return -ENODEV;
 	}
 }
+EXPORT_SYMBOL_GPL(cio_resume);
 
 /*
  * halt I/O operation
@@ -241,6 +244,7 @@ cio_halt(struct subchannel *sch)
 		return -ENODEV;
 	}
 }
+EXPORT_SYMBOL_GPL(cio_halt);
 
 /*
  * Clear I/O operation
@@ -271,6 +275,7 @@ cio_clear(struct subchannel *sch)
 		return -ENODEV;
 	}
 }
+EXPORT_SYMBOL_GPL(cio_clear);
 
 /*
  * Function: cio_cancel
@@ -308,6 +313,7 @@ cio_cancel (struct subchannel *sch)
 		return -ENODEV;
 	}
 }
+EXPORT_SYMBOL_GPL(cio_cancel);
 
 /**
  * cio_cancel_halt_clear - Cancel running I/O by performing cancel, halt
@@ -368,6 +374,7 @@ int cio_cancel_halt_clear(struct subchannel *sch, int *iretry)
 	/* Function was unsuccessful */
 	return -EIO;
 }
+EXPORT_SYMBOL_GPL(cio_cancel_halt_clear);
 
 static void cio_apply_config(struct subchannel *sch, struct schib *schib)
 {
@@ -441,6 +448,7 @@ int cio_commit_config(struct subchannel *sch)
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cio_commit_config);
 
 /**
  * cio_update_schib - Perform stsch and update schib if subchannel is valid.
@@ -1046,6 +1054,7 @@ int cio_tm_start_key(struct subchannel *sch, struct tcw *tcw, u8 lpm, u8 key)
 		return cio_start_handle_notoper(sch, lpm);
 	}
 }
+EXPORT_SYMBOL_GPL(cio_tm_start_key);
 
 /**
  * cio_tm_intrg - perform interrogate function
@@ -1071,3 +1080,4 @@ int cio_tm_intrg(struct subchannel *sch)
 		return -ENODEV;
 	}
 }
+EXPORT_SYMBOL_GPL(cio_tm_intrg);
-- 
2.8.4

Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 10/12] s390: include: Remove redundant license text
Date: Fri, 24 Nov 2017 15:00:41 +0100
Message-Id: <20171124140043.10062-11-gregkh@linuxfoundation.org>
In-Reply-To: <20171124140043.10062-1-gregkh@linuxfoundation.org>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Now that the SPDX tag is in all arch/s390/include/ files, that
identifies the license in a specific and legally-defined manner.  So the
extra GPL text wording can be removed as it is no longer needed at all.

This is done on a quest to remove the 700+ different ways that files in
the kernel describe the GPL license text.  And there's unneeded stuff
like the address (sometimes incorrect) for the FSF which is never
needed.

No copyright headers or other non-license-description text was removed.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/cpu_mf.h          |  4 ----
 arch/s390/include/asm/kprobes.h         | 14 --------------
 arch/s390/include/asm/kvm_host.h        |  4 ----
 arch/s390/include/asm/kvm_para.h        |  6 ------
 arch/s390/include/asm/livepatch.h       |  7 -------
 arch/s390/include/asm/syscall.h         |  4 ----
 arch/s390/include/asm/sysinfo.h         |  4 ----
 arch/s390/include/uapi/asm/kvm.h        |  4 ----
 arch/s390/include/uapi/asm/kvm_para.h   |  4 ----
 arch/s390/include/uapi/asm/kvm_perf.h   |  4 ----
 arch/s390/include/uapi/asm/virtio-ccw.h |  4 ----
 arch/s390/include/uapi/asm/zcrypt.h     | 14 --------------
 12 files changed, 73 deletions(-)

diff --git a/arch/s390/include/asm/cpu_mf.h b/arch/s390/include/asm/cpu_mf.h
index a9ba5e322bf3..dd08db491b89 100644
--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -5,10 +5,6 @@
  *  Copyright IBM Corp. 2012
  *  Author(s): Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
  *	       Jan Glauber <jang@linux.vnet.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
  */
 #ifndef _ASM_S390_CPU_MF_H
 #define _ASM_S390_CPU_MF_H
diff --git a/arch/s390/include/asm/kprobes.h b/arch/s390/include/asm/kprobes.h
index 396b065ebb2c..13de80cf741c 100644
--- a/arch/s390/include/asm/kprobes.h
+++ b/arch/s390/include/asm/kprobes.h
@@ -4,20 +4,6 @@
 /*
  *  Kernel Probes (KProbes)
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
  * Copyright IBM Corp. 2002, 2006
  *
  * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> Kernel
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 66efb2979351..e14f381757f6 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2008, 2009
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  */
 
diff --git a/arch/s390/include/asm/kvm_para.h b/arch/s390/include/asm/kvm_para.h
index 2c623bf5c095..74eeec9c0a80 100644
--- a/arch/s390/include/asm/kvm_para.h
+++ b/arch/s390/include/asm/kvm_para.h
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2008
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Christian Borntraeger <borntraeger@de.ibm.com>
  */
 /*
@@ -21,8 +17,6 @@
  *
  * Copyright IBM Corp. 2007,2008
  * Author(s): Christian Borntraeger <borntraeger@de.ibm.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.
  */
 #ifndef __S390_KVM_PARA_H
 #define __S390_KVM_PARA_H
diff --git a/arch/s390/include/asm/livepatch.h b/arch/s390/include/asm/livepatch.h
index d1f97fafcc20..672f95b12d40 100644
--- a/arch/s390/include/asm/livepatch.h
+++ b/arch/s390/include/asm/livepatch.h
@@ -8,13 +8,6 @@
  *	      Jiri Slaby
  */
 
-/*
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- */
-
 #ifndef ASM_LIVEPATCH_H
 #define ASM_LIVEPATCH_H
 
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index 4d6463eb7a2d..96f9a9151fde 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -4,10 +4,6 @@
  *
  *  Copyright IBM Corp. 2008
  *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
  */
 
 #ifndef _ASM_SYSCALL_H
diff --git a/arch/s390/include/asm/sysinfo.h b/arch/s390/include/asm/sysinfo.h
index c2137e7d9310..25057c118d56 100644
--- a/arch/s390/include/asm/sysinfo.h
+++ b/arch/s390/include/asm/sysinfo.h
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2001, 2008
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Ulrich Weigand <weigand@de.ibm.com>
  *		 Christian Borntraeger <borntraeger@de.ibm.com>
  */
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 9ad172dcd912..38535a57fef8 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -6,10 +6,6 @@
  *
  * Copyright IBM Corp. 2008
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
  */
diff --git a/arch/s390/include/uapi/asm/kvm_para.h b/arch/s390/include/uapi/asm/kvm_para.h
index 0dc86b3a7cb0..b9ab584adf43 100644
--- a/arch/s390/include/uapi/asm/kvm_para.h
+++ b/arch/s390/include/uapi/asm/kvm_para.h
@@ -4,9 +4,5 @@
  *
  * Copyright IBM Corp. 2008
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Christian Borntraeger <borntraeger@de.ibm.com>
  */
diff --git a/arch/s390/include/uapi/asm/kvm_perf.h b/arch/s390/include/uapi/asm/kvm_perf.h
index c36c97ffdc6f..84606b8cc49e 100644
--- a/arch/s390/include/uapi/asm/kvm_perf.h
+++ b/arch/s390/include/uapi/asm/kvm_perf.h
@@ -4,10 +4,6 @@
  *
  * Copyright 2014 IBM Corp.
  * Author(s): Alexander Yarygin <yarygin@linux.vnet.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
  */
 
 #ifndef __LINUX_KVM_PERF_S390_H
diff --git a/arch/s390/include/uapi/asm/virtio-ccw.h b/arch/s390/include/uapi/asm/virtio-ccw.h
index 967aad390105..3a77833c74dc 100644
--- a/arch/s390/include/uapi/asm/virtio-ccw.h
+++ b/arch/s390/include/uapi/asm/virtio-ccw.h
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2013
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *  Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
  */
 #ifndef __KVM_VIRTIO_CCW_H
diff --git a/arch/s390/include/uapi/asm/zcrypt.h b/arch/s390/include/uapi/asm/zcrypt.h
index 137ef473584e..d568307321fc 100644
--- a/arch/s390/include/uapi/asm/zcrypt.h
+++ b/arch/s390/include/uapi/asm/zcrypt.h
@@ -9,20 +9,6 @@
  *	       Eric Rossman (edrossma@us.ibm.com)
  *
  *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #ifndef __ASM_S390_ZCRYPT_H
-- 
2.15.0

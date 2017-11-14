Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 8/9] s390: crypto: Remove redundant license text
Date: Tue, 14 Nov 2017 18:38:07 +0100
Message-Id: <20171114173808.25092-9-gregkh@linuxfoundation.org>
In-Reply-To: <20171114173808.25092-1-gregkh@linuxfoundation.org>
References: <20171114173808.25092-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Harald Freudenberger <freude@de.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Now that the SPDX tag is in all drivers/s390/crypto/ files, that
identifies the license in a specific and legally-defined manner.  So the
extra GPL text wording can be removed as it is no longer needed at all.

This is done on a quest to remove the 700+ different ways that files in
the kernel describe the GPL license text.  And there's unneeded stuff
like the address (sometimes incorrect) for the FSF which is never
needed.

No copyright headers or other non-license-description text was removed.

Cc: Harald Freudenberger <freude@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/crypto/ap_bus.c           | 14 --------------
 drivers/s390/crypto/ap_bus.h           | 14 --------------
 drivers/s390/crypto/pkey_api.c         |  5 -----
 drivers/s390/crypto/zcrypt_api.c       | 14 --------------
 drivers/s390/crypto/zcrypt_api.h       | 14 --------------
 drivers/s390/crypto/zcrypt_card.c      | 10 ----------
 drivers/s390/crypto/zcrypt_cca_key.h   | 14 --------------
 drivers/s390/crypto/zcrypt_cex2a.c     | 14 --------------
 drivers/s390/crypto/zcrypt_cex2a.h     | 14 --------------
 drivers/s390/crypto/zcrypt_error.h     | 14 --------------
 drivers/s390/crypto/zcrypt_msgtype50.c | 14 --------------
 drivers/s390/crypto/zcrypt_msgtype50.h | 14 --------------
 drivers/s390/crypto/zcrypt_msgtype6.c  | 14 --------------
 drivers/s390/crypto/zcrypt_msgtype6.h  | 14 --------------
 drivers/s390/crypto/zcrypt_pcixcc.c    | 14 --------------
 drivers/s390/crypto/zcrypt_pcixcc.h    | 14 --------------
 drivers/s390/crypto/zcrypt_queue.c     | 10 ----------
 17 files changed, 221 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 8c5fe6d925dd..4b978ef8b05e 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -8,20 +8,6 @@
  *	      Holger Dengler <hd@linux.vnet.ibm.com>
  *
  * Adjunct processor bus.
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
 
 #define KMSG_COMPONENT "ap"
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 9747d39bd0f4..61e4852357e5 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -8,20 +8,6 @@
  *	      Holger Dengler <hd@linux.vnet.ibm.com>
  *
  * Adjunct processor bus header file.
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
 
 #ifndef _AP_BUS_H_
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 869ace34972d..e7c2e4f9529a 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -4,11 +4,6 @@
  *
  *  Copyright IBM Corp. 2017
  *  Author(s): Harald Freudenberger
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  */
 
 #define KMSG_COMPONENT "pkey"
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index bf35457ebd13..dff9841c9819 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -11,20 +11,6 @@
  *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
  *				  Ralph Wuerthner <rwuerthn@de.ibm.com>
  *  MSGTYPE restruct:		  Holger Dengler <hd@linux.vnet.ibm.com>
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
 
 #include <linux/module.h>
diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
index 4883d51521fd..9fff8912f6e3 100644
--- a/drivers/s390/crypto/zcrypt_api.h
+++ b/drivers/s390/crypto/zcrypt_api.h
@@ -11,20 +11,6 @@
  *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
  *				  Ralph Wuerthner <rwuerthn@de.ibm.com>
  *  MSGTYPE restruct:		  Holger Dengler <hd@linux.vnet.ibm.com>
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
 
 #ifndef _ZCRYPT_API_H_
diff --git a/drivers/s390/crypto/zcrypt_card.c b/drivers/s390/crypto/zcrypt_card.c
index c0e7072f18a9..233e1e695208 100644
--- a/drivers/s390/crypto/zcrypt_card.c
+++ b/drivers/s390/crypto/zcrypt_card.c
@@ -11,16 +11,6 @@
  *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
  *				  Ralph Wuerthner <rwuerthn@de.ibm.com>
  *  MSGTYPE restruct:		  Holger Dengler <hd@linux.vnet.ibm.com>
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
  */
 
 #include <linux/module.h>
diff --git a/drivers/s390/crypto/zcrypt_cca_key.h b/drivers/s390/crypto/zcrypt_cca_key.h
index ebb9fbcb9bc0..011d61d8a4ae 100644
--- a/drivers/s390/crypto/zcrypt_cca_key.h
+++ b/drivers/s390/crypto/zcrypt_cca_key.h
@@ -8,20 +8,6 @@
  *
  *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
  *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
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
 
 #ifndef _ZCRYPT_CCA_KEY_H_
diff --git a/drivers/s390/crypto/zcrypt_cex2a.c b/drivers/s390/crypto/zcrypt_cex2a.c
index e00ffa44f85c..e701194d3611 100644
--- a/drivers/s390/crypto/zcrypt_cex2a.c
+++ b/drivers/s390/crypto/zcrypt_cex2a.c
@@ -10,20 +10,6 @@
  *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
  *				  Ralph Wuerthner <rwuerthn@de.ibm.com>
  *  MSGTYPE restruct:		  Holger Dengler <hd@linux.vnet.ibm.com>
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
 
 #include <linux/module.h>
diff --git a/drivers/s390/crypto/zcrypt_cex2a.h b/drivers/s390/crypto/zcrypt_cex2a.h
index 6f6830e0bab3..c3c116777c93 100644
--- a/drivers/s390/crypto/zcrypt_cex2a.h
+++ b/drivers/s390/crypto/zcrypt_cex2a.h
@@ -8,20 +8,6 @@
  *
  *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
  *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
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
 
 #ifndef _ZCRYPT_CEX2A_H_
diff --git a/drivers/s390/crypto/zcrypt_error.h b/drivers/s390/crypto/zcrypt_error.h
index 8d8892d14bd0..01598d83c60a 100644
--- a/drivers/s390/crypto/zcrypt_error.h
+++ b/drivers/s390/crypto/zcrypt_error.h
@@ -8,20 +8,6 @@
  *
  *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
  *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
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
 
 #ifndef _ZCRYPT_ERROR_H_
diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto/zcrypt_msgtype50.c
index 8fdf5d65c4d2..afe1b2bcd7ec 100644
--- a/drivers/s390/crypto/zcrypt_msgtype50.c
+++ b/drivers/s390/crypto/zcrypt_msgtype50.c
@@ -10,20 +10,6 @@
  *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
  *				  Ralph Wuerthner <rwuerthn@de.ibm.com>
  *  MSGTYPE restruct:		  Holger Dengler <hd@linux.vnet.ibm.com>
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
 
 #define KMSG_COMPONENT "zcrypt"
diff --git a/drivers/s390/crypto/zcrypt_msgtype50.h b/drivers/s390/crypto/zcrypt_msgtype50.h
index f6ce799c2239..0a36545cfb8e 100644
--- a/drivers/s390/crypto/zcrypt_msgtype50.h
+++ b/drivers/s390/crypto/zcrypt_msgtype50.h
@@ -9,20 +9,6 @@
  *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
  *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
  *  MSGTYPE restruct:		  Holger Dengler <hd@linux.vnet.ibm.com>
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
 
 #ifndef _ZCRYPT_MSGTYPE50_H_
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 3a19b69b846b..f54bef4a928e 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -10,20 +10,6 @@
  *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
  *				  Ralph Wuerthner <rwuerthn@de.ibm.com>
  *  MSGTYPE restruct:		  Holger Dengler <hd@linux.vnet.ibm.com>
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
 
 #define KMSG_COMPONENT "zcrypt"
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.h b/drivers/s390/crypto/zcrypt_msgtype6.h
index 52d140889377..d314f4525518 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.h
+++ b/drivers/s390/crypto/zcrypt_msgtype6.h
@@ -9,20 +9,6 @@
  *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
  *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
  *  MSGTYPE restruct:		  Holger Dengler <hd@linux.vnet.ibm.com>
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
 
 #ifndef _ZCRYPT_MSGTYPE6_H_
diff --git a/drivers/s390/crypto/zcrypt_pcixcc.c b/drivers/s390/crypto/zcrypt_pcixcc.c
index 9963018a6bbc..159b0a0dd211 100644
--- a/drivers/s390/crypto/zcrypt_pcixcc.c
+++ b/drivers/s390/crypto/zcrypt_pcixcc.c
@@ -10,20 +10,6 @@
  *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
  *				  Ralph Wuerthner <rwuerthn@de.ibm.com>
  *  MSGTYPE restruct:		  Holger Dengler <hd@linux.vnet.ibm.com>
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
 
 #include <linux/module.h>
diff --git a/drivers/s390/crypto/zcrypt_pcixcc.h b/drivers/s390/crypto/zcrypt_pcixcc.h
index a85778d5763c..d678a3af83a7 100644
--- a/drivers/s390/crypto/zcrypt_pcixcc.h
+++ b/drivers/s390/crypto/zcrypt_pcixcc.h
@@ -9,20 +9,6 @@
  *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
  *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
  *  MSGTYPE restruct:		  Holger Dengler <hd@linux.vnet.ibm.com>
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
 
 #ifndef _ZCRYPT_PCIXCC_H_
diff --git a/drivers/s390/crypto/zcrypt_queue.c b/drivers/s390/crypto/zcrypt_queue.c
index 5103727b4633..720434e18007 100644
--- a/drivers/s390/crypto/zcrypt_queue.c
+++ b/drivers/s390/crypto/zcrypt_queue.c
@@ -11,16 +11,6 @@
  *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
  *				  Ralph Wuerthner <rwuerthn@de.ibm.com>
  *  MSGTYPE restruct:		  Holger Dengler <hd@linux.vnet.ibm.com>
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
  */
 
 #include <linux/module.h>
-- 
2.15.0

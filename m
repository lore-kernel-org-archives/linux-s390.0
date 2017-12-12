From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] serial: forbid 8250 on s390
Date: Tue, 12 Dec 2017 09:08:35 +0100
Message-ID: <20171212080835.23610-1-borntraeger@de.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-serial/>
List-Post: <mailto:linux-serial@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Using "make kvmconfig" results in a potentially unusable linux image
on s390.  The reason is that both the (default on s390) sclp consoles
as well as the 8250 console register a ttyS<x> as console. Since there
will be no 8250 on s390 let's fence 8250. This will ensure that there
is always a working sclp console.

Reported-by: Alice Frosi <alice@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 drivers/tty/serial/8250/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index a5c0ef1..16b1496 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -5,6 +5,7 @@
 
 config SERIAL_8250
 	tristate "8250/16550 and compatible serial support"
+	depends on !S390
 	select SERIAL_CORE
 	---help---
 	  This selects whether you want to include the driver for the standard
-- 
2.9.4

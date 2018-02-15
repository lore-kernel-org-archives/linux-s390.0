From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 15 Feb 2018 11:14:23 +0000
Subject: [PATCH] s390/console: enable dummy console for vt
Message-Id: <20180215111423.96598-1-borntraeger@de.ibm.com>
References: <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com>
In-Reply-To: <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org, geert@linux-m68k.org, stefan.kristiansson@saunalahti.fi, tomi.valkeinen@ti.com, schwidefsky@de.ibm.com, dri-devel@lists.freedesktop.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

To enable the virtual terminal layer with virtio-gpu, we need to
provide the dummy console. This console is hidden behind CONFIG_IOMEM
via the graphics support. Instead of fully enabling the graphic
drivers lets just provide a Kconfig option for the dummy console.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
New version: instead of moving around the graphic and console stuff,
let's just keep an s390 specific variant of CONFIG_DUMMY_CONSOLE
 arch/s390/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index cbe1d978693a..a69690f616f3 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -952,6 +952,11 @@ config S390_HYPFS_FS
 
 source "arch/s390/kvm/Kconfig"
 
+config DUMMY_CONSOLE
+       bool
+       depends on VT
+       default y
+
 config S390_GUEST
 	def_bool y
 	prompt "s390 support for virtio devices"
-- 
2.14.3

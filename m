From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Thu, 01 Feb 2018 18:41:27 +0000
Subject: [PATCH v2 0/3]Enable CONFIG_VT support for S390
Message-Id: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com, stefan.kristiansson@saunalahti.fi, tomi.valkeinen@ti.com, schwidefsky@de.ibm.com, alifm@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi,

This series of patches add support for an additional tty
and console for a S390 KVM guest using a virtio-gpu device[1].

Patch 1 enables the "Graphics support" menu which is
needed to enable dummy console, since the VT layer needs it.
It also fixes a build error for Opencore framebuffer driver. 

Patch 2 fixes few linker issues.

Patch 3 add support for enabling VT layer for S390.


ChangeLog
---------
v1 -> v2

v1 was posted under a different subject and here is a link to it:
https://www.spinics.net/lists/linux-s390/msg18175.html

   - Combine patch 1 and 2 from v1 into one patch (patch 1).
   - Additional patches to enable CONFIG_VT for S390.


Thanks
Farhan


[1] https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg04184.html


Farhan Ali (3):
  Kconfig : Remove HAS_IOMEM dependency for Graphics support
  s390/char : Rename EBCDIC keymap variables
  s390/setup : enable display support for KVM guest

 arch/s390/kernel/setup.c      |  2 ++
 drivers/s390/char/defkeymap.c | 66 ++++++++++++++++++++++---------------------
 drivers/s390/char/keyboard.c  | 32 ++++++++++-----------
 drivers/s390/char/keyboard.h  | 11 ++++++++
 drivers/tty/Kconfig           |  2 +-
 drivers/video/Kconfig         |  1 -
 drivers/video/console/Kconfig |  2 +-
 drivers/video/fbdev/Kconfig   |  2 +-
 8 files changed, 66 insertions(+), 52 deletions(-)

-- 
2.7.4

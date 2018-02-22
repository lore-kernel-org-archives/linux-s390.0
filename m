From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Thu, 22 Feb 2018 16:22:21 +0000
Subject: [PATCH v4 0/3] Enable CONFIG_VT support for S390
Message-Id: <cover.1519315352.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, tomi.valkeinen@ti.com, b.zolnierkie@samsung.com, geert@linux-m68k.org, alifm@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi,

This series of patches add support for an additional tty
and console for a S390 KVM guest using a virtio-gpu device[1].

Patch 1 enables the "Graphics support" menu which is
needed to enable dummy console, since the VT layer needs it.
The dependency is moved to sub menu items and console
drivers now.

Patch 2 fixes few linker issues.

Patch 3 add support for enabling VT layer for S390.


ChangeLog
---------
v3 -> v4
   - Add r-b's.
   - Move HAS_IOMEM dependency in drivers/video/Kconfig to cover
     from config HAVE_FB_ATMEL to config HDMI (patch 1).
   - Add HAS_IOMEM for VGA_CONSOLE (patch 1).

v2 -> v3
    - Move HAS_IOMEM dependency to sub menu items and console
    drivers (patch 1)

v1 -> v2

v1 was posted under a different subject and here is a link to it:
https://www.spinics.net/lists/linux-s390/msg18175.html

   - Combine patch 1 and 2 from v1 into one patch (patch 1).
   - Additional patches to enable CONFIG_VT for S390.


Thanks
Farhan

Farhan Ali (3):
  Kconfig : Remove HAS_IOMEM dependency for Graphics support
  s390/char : Rename EBCDIC keymap variables
  s390/setup : enable display support for KVM guest

 arch/s390/kernel/setup.c      |  2 ++
 drivers/s390/char/defkeymap.c | 66 ++++++++++++++++++++++---------------------
 drivers/s390/char/keyboard.c  | 32 ++++++++++-----------
 drivers/s390/char/keyboard.h  | 11 ++++++++
 drivers/tty/Kconfig           |  2 +-
 drivers/video/Kconfig         |  5 +++-
 drivers/video/console/Kconfig |  6 ++--
 7 files changed, 71 insertions(+), 53 deletions(-)

-- 
2.7.4

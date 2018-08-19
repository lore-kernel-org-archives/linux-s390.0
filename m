From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 0/9] PCI hotplug diet
Date: Sun, 19 Aug 2018 16:29:00 +0200
Message-ID: <cover.1534686484.git.lukas@wunner.de>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Keith Busch <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>, Irene Zubarev <zubarev@us.ibm.com>, Prarit Bhargava <prarit@redhat.com>, Scott Murray <scott@spiteful.org>, Dan Zink <dan.zink@hpe.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Len Brown <lenb@kernel.org>, linux-s390@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, Gavin Shan <gwshan@linux.vnet.ibm.com>, Jyoti Shah <jshah@us.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Oza Pawandeep <poza@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Corentin Chary <corentin.chary@gmail.com>, linuxppc-dev@lists.ozlabs.org, Andy Shevchenko <andy@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Here's PCI hotplug material I've prepared for v4.20:

Patches [1/9] to [8/9] reduce the code by 488 lines.  There should be no
loss of functionality and no new features, just less and simpler code.

Patch [9/9] collects TODOs for hotplug drivers to spur contributions.


I've assumed that my patch "PCI: pciehp: Differentiate between surprise
and safe removal" (submitted July 31) gets merged before this series:
https://patchwork.ozlabs.org/patch/951386/

If that patch is not accepted or other pciehp-related patches are merged
before this series, I'll have to rebase patch [4/9] ("PCI: pciehp: Unify
controller and slot structs").  No big deal, just a heads-up.

Thanks,

Lukas


Lukas Wunner (9):
  PCI: Simplify disconnected marking
  PCI: pciehp: Drop unnecessary includes
  PCI: pciehp: Drop hotplug_slot_ops wrappers
  PCI: pciehp: Unify controller and slot structs
  PCI: pciehp: Reshuffle controller struct for clarity
  PCI: hotplug: Constify hotplug_slot_ops
  PCI: hotplug: Drop hotplug_slot_info
  PCI: hotplug: Embed hotplug_slot
  PCI: hotplug: Document TODOs

 arch/powerpc/include/asm/pnv-pci.h      |   2 +-
 drivers/pci/hotplug/TODO                |  74 +++++++
 drivers/pci/hotplug/acpiphp.h           |  10 +-
 drivers/pci/hotplug/acpiphp_core.c      |  36 +---
 drivers/pci/hotplug/acpiphp_ibm.c       |   2 +-
 drivers/pci/hotplug/cpci_hotplug.h      |  11 +-
 drivers/pci/hotplug/cpci_hotplug_core.c | 105 +++-------
 drivers/pci/hotplug/cpci_hotplug_pci.c  |   6 +-
 drivers/pci/hotplug/cpqphp.h            |   9 +-
 drivers/pci/hotplug/cpqphp_core.c       |  59 ++----
 drivers/pci/hotplug/cpqphp_ctrl.c       |  31 +--
 drivers/pci/hotplug/ibmphp.h            |   9 +-
 drivers/pci/hotplug/ibmphp_core.c       | 121 ++++-------
 drivers/pci/hotplug/ibmphp_ebda.c       |  70 +------
 drivers/pci/hotplug/pci_hotplug_core.c  |  53 ++---
 drivers/pci/hotplug/pciehp.h            | 138 ++++++-------
 drivers/pci/hotplug/pciehp_core.c       | 127 +++---------
 drivers/pci/hotplug/pciehp_ctrl.c       | 255 +++++++++++-------------
 drivers/pci/hotplug/pciehp_hpc.c        | 127 ++++--------
 drivers/pci/hotplug/pciehp_pci.c        |  24 +--
 drivers/pci/hotplug/pnv_php.c           |  35 ++--
 drivers/pci/hotplug/rpaphp.h            |  10 +-
 drivers/pci/hotplug/rpaphp_core.c       |  20 +-
 drivers/pci/hotplug/rpaphp_pci.c        |  11 +-
 drivers/pci/hotplug/rpaphp_slot.c       |  22 +-
 drivers/pci/hotplug/s390_pci_hpc.c      |  44 ++--
 drivers/pci/hotplug/sgi_hotplug.c       |  63 +++---
 drivers/pci/hotplug/shpchp.h            |   8 +-
 drivers/pci/hotplug/shpchp_core.c       |  48 ++---
 drivers/pci/hotplug/shpchp_ctrl.c       |  21 +-
 drivers/pci/pci.c                       |   4 +-
 drivers/pci/pcie/err.c                  |   8 +-
 drivers/pci/slot.c                      |   2 +-
 drivers/platform/x86/asus-wmi.c         |  39 +---
 drivers/platform/x86/eeepc-laptop.c     |  43 ++--
 include/linux/pci_hotplug.h             |  43 +---
 36 files changed, 638 insertions(+), 1052 deletions(-)
 create mode 100644 drivers/pci/hotplug/TODO

-- 
2.18.0

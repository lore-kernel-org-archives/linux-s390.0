From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 6/9] PCI: hotplug: Constify hotplug_slot_ops
Date: Mon, 20 Aug 2018 10:10:19 +0200
Message-ID: <CAJZ5v0i5ibrVf=KVvPsG5DVV3JeRKTwjiToir7=VHK7zqxMmeA@mail.gmail.com>
References: <cover.1534686484.git.lukas@wunner.de>
 <40b17d029c4fbf099535f989b1d6dd013f708a73.1534686485.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <40b17d029c4fbf099535f989b1d6dd013f708a73.1534686485.git.lukas@wunner.de>
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
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, scott@spiteful.org, sebott@linux.vnet.ibm.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Darren Hart <dvhart@infradead.org>, Len Brown <lenb@kernel.org>, linux-s390@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, gwshan@linux.vnet.ibm.com, okaya@kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, gerald.schaefer@de.ibm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Corentin Chary <corentin.chary@gmail.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Shevchenko <andy@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Aug 19, 2018 at 4:36 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> Hotplug drivers cannot declare their hotplug_slot_ops const, making them
> attractive targets for attackers, because upon registration of a hotplug
> slot, __pci_hp_initialize() writes to the "owner" and "mod_name" members
> in that struct.
>
> Fix by moving these members to struct hotplug_slot and constify every
> driver's hotplug_slot_ops except for pciehp.
>
> pciehp constructs its hotplug_slot_ops at runtime based on the PCIe
> port's capabilities, hence cannot declare them const.  It can be
> converted to __write_rarely once that's mainlined:
> http://www.openwall.com/lists/kernel-hardening/2016/11/16/3
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Scott Murray <scott@spiteful.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Cc: Corentin Chary <corentin.chary@gmail.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> ---
>  drivers/pci/hotplug/acpiphp_core.c      |  2 +-
>  drivers/pci/hotplug/cpci_hotplug_core.c |  2 +-
>  drivers/pci/hotplug/cpqphp_core.c       |  2 +-
>  drivers/pci/hotplug/ibmphp.h            |  2 +-
>  drivers/pci/hotplug/ibmphp_core.c       |  2 +-
>  drivers/pci/hotplug/pci_hotplug_core.c  | 27 +++++++++++++------------
>  drivers/pci/hotplug/pnv_php.c           |  2 +-
>  drivers/pci/hotplug/rpaphp.h            |  2 +-
>  drivers/pci/hotplug/rpaphp_core.c       |  2 +-
>  drivers/pci/hotplug/s390_pci_hpc.c      |  2 +-
>  drivers/pci/hotplug/sgi_hotplug.c       |  2 +-
>  drivers/pci/hotplug/shpchp_core.c       |  2 +-
>  drivers/pci/pci.c                       |  4 ++--
>  drivers/pci/slot.c                      |  2 +-
>  drivers/platform/x86/asus-wmi.c         |  3 +--
>  drivers/platform/x86/eeepc-laptop.c     |  3 +--
>  include/linux/pci_hotplug.h             | 10 ++++-----
>  17 files changed, 35 insertions(+), 36 deletions(-)

Nice!

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

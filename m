From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 7/9] PCI: hotplug: Drop hotplug_slot_info
Date: Mon, 3 Sep 2018 19:52:51 +0200 (CEST)
Message-ID: <alpine.LFD.2.21.1809031950100.1716@schleppi>
References: <cover.1534686484.git.lukas@wunner.de>
 <a364bcc959e01f2ebab27cefc5b87ff01633275c.1534686485.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <a364bcc959e01f2ebab27cefc5b87ff01633275c.1534686485.git.lukas@wunner.de>
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
Cc: Scott Murray <scott@spiteful.org>, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, Andy Shevchenko <andy@infradead.org>, acpi4asus-user@lists.sourceforge.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Corentin Chary <corentin.chary@gmail.com>, Paul Mackerras <paulus@samba.org>, Sinan Kaya <okaya@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Len Brown <lenb@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 19 Aug 2018, Lukas Wunner wrote:
> Ever since the PCI hotplug core was introduced in 2002, drivers had to
> allocate and register a struct hotplug_slot_info for every slot:
> https://git.kernel.org/tglx/history/c/a8a2069f432c
> 
> Apparently the idea was that drivers furnish the hotplug core with an
> up-to-date card presence status, power status, latch status and
> attention indicator status as well as notify the hotplug core of changes
> thereof.  However only 4 out of 12 hotplug drivers bother to notify the
> hotplug core with pci_hp_change_slot_info() and the hotplug core never
> made any use of the information:  There is just a single macro in
> pci_hotplug_core.c, GET_STATUS(), which uses the hotplug_slot_info if
> the driver lacks the corresponding callback in hotplug_slot_ops.  The
> macro is called when the user reads the attribute via sysfs.
> 
> Now, if the callback isn't defined, the attribute isn't exposed in sysfs
> in the first place (see e.g. has_power_file()).  There are only two
> situations when the hotplug_slot_info would actually be accessed:
> 
> * If the driver defines ->enable_slot or ->disable_slot but not
>   ->get_power_status.
> 
> * If the driver defines ->set_attention_status but not
>   ->get_attention_status.
> 
> There is no driver doing the former and just a single driver doing the
> latter, namely pnv_php.c.  Amend it with a ->get_attention_status
> callback.  With that, the hotplug_slot_info becomes completely unused by
> the PCI hotplug core.  But a few drivers use it internally as a cache:
> 
> cpcihp uses it to cache the latch_status and adapter_status.
> cpqhp uses it to cache the adapter_status.
> pnv_php and rpaphp use it to cache the attention_status.
> shpchp uses it to cache all four values.
> 
> Amend these drivers to cache the information in their private slot
> struct.  shpchp's slot struct already contains members to cache the
> power_status and adapter_status, so additional members are only needed
> for the other two values.  In the case of cpqphp, the cached value is
> only accessed in a single place, so instead of caching it, read the
> current value from the hardware.
> 
> Caution:  acpiphp, cpci, cpqhp, shpchp, asus-wmi and eeepc-laptop
> populate the hotplug_slot_info with initial values on probe.  That code
> is herewith removed.  There is a theoretical chance that the code has
> side effects without which the driver fails to function, e.g. if the
> ACPI method to read the adapter status needs to be executed at least
> once on probe.  That seems unlikely to me, still maintainers should
> review the changes carefully for this possibility.
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

for s390_pci_hpc.c:
Acked-by: Sebastian Ott <sebott@linux.ibm.com>

From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/9] PCI: hotplug: Constify hotplug_slot_ops
Date: Mon, 20 Aug 2018 17:38:06 -0700
Message-ID: <92f4ee2a-39b8-daa6-ea36-4214e4a438bd@linux.vnet.ibm.com>
References: <cover.1534686484.git.lukas@wunner.de>
 <40b17d029c4fbf099535f989b1d6dd013f708a73.1534686485.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <40b17d029c4fbf099535f989b1d6dd013f708a73.1534686485.git.lukas@wunner.de>
Content-Language: en-US
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
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Scott Murray <scott@spiteful.org>, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, acpi4asus-user@lists.sourceforge.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Corentin Chary <corentin.chary@gmail.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Darren Hart <dvhart@infradead.org>, linuxppc-dev@lists.ozlabs.org, Andy Shevchenko <andy@infradead.org>, Len Brown <lenb@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 08/19/2018 07:29 AM, Lukas Wunner wrote:
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

With regards to drivers/pci/hotplug/rpa*

Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

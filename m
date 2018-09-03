From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 8/9] PCI: hotplug: Embed hotplug_slot
Date: Mon, 3 Sep 2018 19:54:49 +0200 (CEST)
Message-ID: <alpine.LFD.2.21.1809031953000.1716@schleppi>
References: <cover.1534686484.git.lukas@wunner.de>
 <9918fbca94bcfc03d1560b191d138d3e6664cc86.1534686485.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <9918fbca94bcfc03d1560b191d138d3e6664cc86.1534686485.git.lukas@wunner.de>
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
Cc: linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Scott Murray <scott@spiteful.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Darren Hart <dvhart@infradead.org>, Len Brown <lenb@kernel.org>, linux-s390@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, Gavin Shan <gwshan@linux.vnet.ibm.com>, Sinan Kaya <okaya@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Corentin Chary <corentin.chary@gmail.com>, linuxppc-dev@lists.ozlabs.org, Andy Shevchenko <andy@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 19 Aug 2018, Lukas Wunner wrote:
> When the PCI hotplug core and its first user, cpqphp, were introduced in
> February 2002 with historic commit a8a2069f432c, cpqphp allocated a slot
> struct for its internal use plus a hotplug_slot struct to be registered
> with the hotplug core and linked the two with pointers:
> https://git.kernel.org/tglx/history/c/a8a2069f432c
> 
> Nowadays, the predominant pattern in the tree is to embed ("subclass")
> such structures in one another and cast to the containing struct with
> container_of().  But it wasn't until July 2002 that container_of() was
> introduced with historic commit ec4f214232cf:
> https://git.kernel.org/tglx/history/c/ec4f214232cf
> 
> pnv_php, introduced in 2016, did the right thing and embedded struct
> hotplug_slot in its internal struct pnv_php_slot, but all other drivers
> cargo-culted cpqphp's design and linked separate structs with pointers.
> 
> Embedding structs is preferrable to linking them with pointers because
> it requires fewer allocations, thereby reducing overhead and simplifying
> error paths.  Casting an embedded struct to the containing struct
> becomes a cheap subtraction rather than a dereference.  And having fewer
> pointers reduces the risk of them pointing nowhere either accidentally
> or due to an attack.
> 
> Convert all drivers to embed struct hotplug_slot in their internal slot
> struct.  The "private" pointer in struct hotplug_slot thereby becomes
> unused, so drop it.
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

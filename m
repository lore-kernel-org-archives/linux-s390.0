Return-Path: <linux-pci-owner@vger.kernel.org>
Date: Mon, 16 Jul 2018 07:46:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 14/32] PCI: hotplug: Demidlayer registration with the core
Message-ID: <20180716124637.GK28466@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1529173804.git.lukas@wunner.de>
 <6ef59b1fd3aa05f9989d29d0988152f18e3b824e.1529173804.git.lukas@wunner.de>
 <CAHp75Vf9ZETYLuMEA0B_0qkbAWUHqEw0LVzqrjTmry7GjvE1gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75Vf9ZETYLuMEA0B_0qkbAWUHqEw0LVzqrjTmry7GjvE1gw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ashok.raj@intel.com, Keith Busch <keith.busch@intel.com>, Yinghai Lu <yinghai@kernel.org>, okaya@kernel.org, linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>, scott@spiteful.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, gwshan@linux.vnet.ibm.com, Sebastian Ott <sebott@linux.vnet.ibm.com>, gerald.schaefer@de.ibm.com, Corentin Chary <corentin.chary@gmail.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-s390@vger.kernel.org, Platform Driver <platform-driver-x86@vger.kernel.org>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Jun 17, 2018 at 07:44:03PM +0300, Andy Shevchenko wrote:
> On Sat, Jun 16, 2018 at 10:37 PM Lukas Wunner <lukas@wunner.de> wrote:
> >
> > When a hotplug driver calls pci_hp_register(), all steps necessary for
> > registration are carried out in one go, including creation of a kobject
> > and addition to sysfs.  That's a problem for pciehp once it's converted
> > to enable/disable the slot exclusively from the IRQ thread:  The thread
> > needs to be spawned after creation of the kobject (because it uses the
> > kobject's name), but before addition to sysfs (because it will handle
> > enable/disable requests submitted via sysfs).
> >
> > pci_hp_deregister() does offer a ->release callback that's invoked
> > after deletion from sysfs and before destruction of the kobject.  But
> > because pci_hp_register() doesn't offer a counterpart, hotplug drivers'
> > ->probe and ->remove code becomes asymmetric, which is error prone
> > as recently discovered use-after-free bugs in pciehp's ->remove hook
> > have shown.
> >
> > In a sense, this appears to be a case of the midlayer antipattern:
> >
> >    "The core thesis of the "midlayer mistake" is that midlayers are
> >     bad and should not exist.  That common functionality which it is
> >     so tempting to put in a midlayer should instead be provided as
> >     library routines which can [be] used, augmented, or ignored by
> >     each bottom level driver independently.  Thus every subsystem
> >     that supports multiple implementations (or drivers) should
> >     provide a very thin top layer which calls directly into the
> >     bottom layer drivers, and a rich library of support code that
> >     eases the implementation of those drivers.  This library is
> >     available to, but not forced upon, those drivers."
> >         --  Neil Brown (2009), https://lwn.net/Articles/336262/
> >
> > The presence of midlayer traits in the PCI hotplug core might be ascribed
> > to its age:  When it was introduced in February 2002, the blessings of a
> > library approach might not have been well known:
> > https://git.kernel.org/tglx/history/c/a8a2069f432c
> >
> > For comparison, the driver core does offer split functions for creating
> > a kobject (device_initialize()) and addition to sysfs (device_add()) as
> > an alternative to carrying out everything at once (device_register()).
> > This was introduced in October 2002:
> > https://git.kernel.org/tglx/history/c/8b290eb19962
> >
> > The odd ->release callback in the PCI hotplug core was added in 2003:
> > https://git.kernel.org/tglx/history/c/69f8d663b595
> >
> > Clearly, a library approach would not force every hotplug driver to
> > implement a ->release callback, but rather allow the driver to remove
> > the sysfs files, release its data structures and finally destroy the
> > kobject.  Alternatively, a driver may choose to remove everything with
> > pci_hp_deregister(), then release its data structures.
> >
> > To this end, offer drivers pci_hp_initialize() and pci_hp_add() as a
> > split-up version of pci_hp_register().  Likewise, offer pci_hp_del()
> > and pci_hp_destroy() as a split-up version of pci_hp_deregister().
> >
> > Eliminate the ->release callback and move its code into each driver's
> > teardown routine.
> >
> > Declare pci_hp_deregister() void, in keeping with the usual kernel
> > pattern that enablement can fail, but disablement cannot.  It only
> > returned an error if the caller passed in a NULL pointer or a slot which
> > has never or is no longer registered or is sharing its name with another
> > slot.  Those would be bugs, so WARN about them.  Few hotplug drivers
> > actually checked the return value and those that did only printed a
> > useless error message to dmesg.  Remove that.
> >
> > For most drivers the conversion was straightforward since it doesn't
> > matter whether the code in the ->release callback is executed before or
> > after destruction of the kobject.  But in the case of ibmphp, it was
> > unclear to me whether setting slot_cur->ctrl and slot_cur->bus_on to
> > NULL needs to happen before the kobject is destroyed, so I erred on
> > the side of caution and ensured that the order stays the same.  Another
> > nontrivial case is pnv_php, I've found the list and kref logic difficult
> > to understand, however my impression was that it is safe to delete the
> > list element and drop the references until after the kobject is
> > destroyed.
> >
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Scott Murray <scott@spiteful.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
> > Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> > Cc: Corentin Chary <corentin.chary@gmail.com>
> > Cc: Darren Hart <dvhart@infradead.org>
> > Cc: Andy Shevchenko <andy@infradead.org>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> >  drivers/pci/hotplug/acpiphp_core.c      |  22 +---
> >  drivers/pci/hotplug/cpci_hotplug_core.c |  14 +--
> >  drivers/pci/hotplug/cpqphp_core.c       |  16 +--
> >  drivers/pci/hotplug/ibmphp_core.c       |  15 ++-
> >  drivers/pci/hotplug/ibmphp_ebda.c       |  20 ----
> >  drivers/pci/hotplug/pci_hotplug_core.c  | 139 +++++++++++++++++-------
> >  drivers/pci/hotplug/pciehp_core.c       |  19 +---
> >  drivers/pci/hotplug/pcihp_skeleton.c    |  16 +--
> >  drivers/pci/hotplug/pnv_php.c           |   5 +-
> >  drivers/pci/hotplug/rpaphp_core.c       |   2 +-
> >  drivers/pci/hotplug/rpaphp_slot.c       |  13 +--
> >  drivers/pci/hotplug/s390_pci_hpc.c      |  13 +--
> >  drivers/pci/hotplug/sgi_hotplug.c       |   9 +-
> >  drivers/pci/hotplug/shpchp_core.c       |  20 +---
> 
> >  drivers/platform/x86/asus-wmi.c         |  12 +-
> >  drivers/platform/x86/eeepc-laptop.c     |  12 +-
> 
> So, as far as I can see these are just mechanical changes due to
> internal API change.
> Thus,
> 
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> for PDx86 bits only.

Hi Andy, I'm not sure what you intend by "PDx86".  I'm happy to add a note
so your ack looks like

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>  # drivers/platform/x86

or something similar.  Is that what you have in mind?

> >  include/linux/pci_hotplug.h             |  15 ++-
> >  17 files changed, 171 insertions(+), 191 deletions(-)

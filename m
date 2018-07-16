Return-Path: <SRS0=+3MX=KA=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=+3MX=KA=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180716124637.GK28466@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1529173804.git.lukas@wunner.de> <6ef59b1fd3aa05f9989d29d0988152f18e3b824e.1529173804.git.lukas@wunner.de>
 <CAHp75Vf9ZETYLuMEA0B_0qkbAWUHqEw0LVzqrjTmry7GjvE1gw@mail.gmail.com> <20180716124637.GK28466@bhelgaas-glaptop.roam.corp.google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 16 Jul 2018 17:14:17 +0300
Message-ID: <CAHp75Vc0K34HybHL+VZioy19_EJNzjvZF4_4cTiKuiFKQiZmGQ@mail.gmail.com>
Subject: Re: [PATCH 14/32] PCI: hotplug: Demidlayer registration with the core
Content-Type: text/plain; charset="UTF-8"
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ashok.raj@intel.com, Keith Busch <keith.busch@intel.com>, Yinghai Lu <yinghai@kernel.org>, okaya@kernel.org, linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>, scott@spiteful.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, gwshan@linux.vnet.ibm.com, Sebastian Ott <sebott@linux.vnet.ibm.com>, gerald.schaefer@de.ibm.com, Corentin Chary <corentin.chary@gmail.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-s390@vger.kernel.org, Platform Driver <platform-driver-x86@vger.kernel.org>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jul 16, 2018 at 3:46 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sun, Jun 17, 2018 at 07:44:03PM +0300, Andy Shevchenko wrote:
>> On Sat, Jun 16, 2018 at 10:37 PM Lukas Wunner <lukas@wunner.de> wrote:

>> Thus,
>>
>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>
>> for PDx86 bits only.
>
> Hi Andy, I'm not sure what you intend by "PDx86".  I'm happy to add a note
> so your ack looks like
>
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>  # drivers/platform/x86
>
> or something similar.  Is that what you have in mind?

Ah, sorry, not everyone gets that abbreviation. It stands for Platform
Drivers x86.
What you crafted above is quite good fit to what I meant. Thanks!

-- 
With Best Regards,
Andy Shevchenko

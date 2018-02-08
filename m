Return-Path: <SRS0=wxkp=FC=nexb.com=pombredanne@kernel.org>
Return-Path: <SRS0=wxkp=FC=nexb.com=pombredanne@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180130003559.15416.18047.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130003559.15416.18047.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 8 Feb 2018 15:17:39 +0100
Message-ID: <CAOFm3uHagzL5r5MYfu1ep5nf9Y6RAj866+uUO74c1mJRYPfeQg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add SPDX tag for s390_pci_hpc.c
Content-Type: text/plain; charset="UTF-8"
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Bjorn,

On Tue, Jan 30, 2018 at 1:40 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> I previously posted patches [1] to add SPDX tags to all drivers/pci files
> except drivers/pci/hotplug/s390_pci_hpc.c.  I omitted that one because it
> contained only a "License: GPL" comment, which I thought was ambiguous.
>
> However, I think it is actually unambiguous because the file was added with
> a 'MODULE_LICENSE("GPL")', and include/linux/module.h shows that means "GPL
> v2 or later".
>
> So this patch adds the GPL-2.0+ tag to the file.  I plan to include this
> for v4.16 unless somebody objects.

As I as said in a previous email, context matters a lot in these case
and you made the right choice.
When there is a MODULE_LICENSE and a super terse "GPL" license notice,
the two taken together can provide the proper context e.g. here
GPL-2.0+ rather than a less common GPL-1.0+

Thank you for your efforts there!

-- 
Cordially
Philippe Ombredanne

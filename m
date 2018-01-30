Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 30 Jan 2018 13:44:32 +0100 (CET)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH] PCI: Add SPDX GPL-2.0+ to replace implicit GPL v2 or
 later statement
In-Reply-To: <20180130004051.15416.78620.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130003559.15416.18047.stgit@bhelgaas-glaptop.roam.corp.google.com>  <20180130004051.15416.78620.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1801301344060.1608@schleppi>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 29 Jan 2018, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 7441b0627e22 ("s390/pci: PCI hotplug support via SCLP") added
> s390_pci_hpc.c, which included this license information:
> 
>   +MODULE_LICENSE("GPL");
> 
> Based on "git show 7441b0627e22:include/linux/module.h", that "GPL" string
> means "GPL v2 or later":
> 
>    *      "GPL"                           [GNU Public License v2 or later]
> 
> 0729dcf24832 ("s390: hotplug: make pci_hpc explicitly non-modular")
> subsequently replaced the MODULE_LICENSE() with a "License: GPL" comment.
> 
> Add SPDX GPL-2.0+ and remove the "License: GPL" comment, relying on the
> assertion in b24413180f56 ("License cleanup: add SPDX GPL-2.0 license
> identifier to files with no license") that the SPDX identifier may be used
> instead of the full boilerplate text.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>

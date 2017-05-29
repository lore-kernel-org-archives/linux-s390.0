Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 29 May 2017 18:07:44 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390: provide default ioremap and iounmap declaration
In-Reply-To: <0dc5ea4a-6567-e0fc-8704-aab119de8cb4@deltatee.com>
References: <1495727028-27656-1-git-send-email-logang@deltatee.com> <20170526123801.GC14849@osiris> <0dc5ea4a-6567-e0fc-8704-aab119de8cb4@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.20.1705291803230.2108@schleppi>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Al Viro <viro@ZenIV.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>

Hi,

On Fri, 26 May 2017, Logan Gunthorpe wrote:
> On 26/05/17 06:38 AM, Heiko Carstens wrote:
> > On Thu, May 25, 2017 at 09:43:48AM -0600, Logan Gunthorpe wrote:
> > I'd rather move the #ifdef CONFIG_PCI than implementing this yet another
> > time (see patch below). But I'll leave that up to Sebastian.

Yes I've had prepared the same patch because of build failures in
linux-next due to this commit (linux-next commit id)
	db1534d linux/io.h: Add pci_remap_cfgspace() interface

But I'd never send it because this commit was changed to add
#ifdef CONFIG_PCI.

> I'd be more than happy with this change. Let me know if you want me to
> resubmit a patch that looks like that.

Yes please do. I'll Ack it.

Thanks,
Sebastian

Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Jul 2016 10:46:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] s390/pci: Remove unnecessary if condition
In-Reply-To: <alpine.LFD.2.20.1607291037530.3349@schleppi>
Message-ID: <alpine.DEB.2.10.1607291046000.2161@hadrien>
References: <20160729083150.GA8819@amitoj-Inspiron-3542> <alpine.LFD.2.20.1607291037530.3349@schleppi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Amitoj Kaur Chawla <amitoj1606@gmail.com>, gerald.schaefer@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr
List-ID: <linux-s390.vger.kernel.org>



On Fri, 29 Jul 2016, Sebastian Ott wrote:

> On Fri, 29 Jul 2016, Amitoj Kaur Chawla wrote:
> > Remove unnecessary error handling because the only failure value that
> > can be returned is NULL and so the test can never be true.
> >
> > The Coccinelle semantic patch used to make this change is as follows:
> > @@
> > expression e;
> > @@
> >
> >   e = debugfs_create_file(...);
> > - if(IS_ERR(e)) { e = NULL; }
>
> Nope. For !CONFIG_DEBUG_FS debugfs_create_file returns an ERR_PTR.

Clicking around in lxr doesn't show that, but perhaps an alternative
definition is overlooked?

julia

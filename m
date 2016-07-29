Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Jul 2016 11:46:08 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390/pci: Remove unnecessary if condition
In-Reply-To: <alpine.DEB.2.10.1607291046000.2161@hadrien>
References: <20160729083150.GA8819@amitoj-Inspiron-3542> <alpine.LFD.2.20.1607291037530.3349@schleppi> <alpine.DEB.2.10.1607291046000.2161@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.20.1607291138100.3349@schleppi>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Amitoj Kaur Chawla <amitoj1606@gmail.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 29 Jul 2016, Julia Lawall wrote:
> On Fri, 29 Jul 2016, Sebastian Ott wrote:
> > On Fri, 29 Jul 2016, Amitoj Kaur Chawla wrote:
> > > Remove unnecessary error handling because the only failure value that
> > > can be returned is NULL and so the test can never be true.
> > >
> > > The Coccinelle semantic patch used to make this change is as follows:
> > > @@
> > > expression e;
> > > @@
> > >
> > >   e = debugfs_create_file(...);
> > > - if(IS_ERR(e)) { e = NULL; }
> >
> > Nope. For !CONFIG_DEBUG_FS debugfs_create_file returns an ERR_PTR.
> 
> Clicking around in lxr doesn't show that, but perhaps an alternative
> definition is overlooked?

It looks that way.


[sebott@schleppi linux]$ git grep -W "debugfs_create_file(" include/linux/debugfs.h
include/linux/debugfs.h:struct dentry *debugfs_create_file(const char *name, umode_t mode,
include/linux/debugfs.h-                                   struct dentry *parent, void *data,
include/linux/debugfs.h-                                   const struct file_operations *fops);
--
include/linux/debugfs.h:static inline struct dentry *debugfs_create_file(const char *name, umode_t mode,
include/linux/debugfs.h-                                        struct dentry *parent, void *data,
include/linux/debugfs.h-                                        const struct file_operations *fops)
include/linux/debugfs.h-{
include/linux/debugfs.h-        return ERR_PTR(-ENODEV);
include/linux/debugfs.h-}
include/linux/debugfs.h-

Regards,
Sebastian

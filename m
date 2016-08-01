Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 1 Aug 2016 08:39:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] s390/pci: Remove unnecessary if condition
In-Reply-To: <alpine.LFD.2.20.1607291138100.3349@schleppi>
Message-ID: <alpine.DEB.2.10.1608010838030.3078@hadrien>
References: <20160729083150.GA8819@amitoj-Inspiron-3542> <alpine.LFD.2.20.1607291037530.3349@schleppi> <alpine.DEB.2.10.1607291046000.2161@hadrien> <alpine.LFD.2.20.1607291138100.3349@schleppi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Amitoj Kaur Chawla <amitoj1606@gmail.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On Fri, 29 Jul 2016, Sebastian Ott wrote:

> On Fri, 29 Jul 2016, Julia Lawall wrote:
> > On Fri, 29 Jul 2016, Sebastian Ott wrote:
> > > On Fri, 29 Jul 2016, Amitoj Kaur Chawla wrote:
> > > > Remove unnecessary error handling because the only failure value that
> > > > can be returned is NULL and so the test can never be true.
> > > >
> > > > The Coccinelle semantic patch used to make this change is as follows:
> > > > @@
> > > > expression e;
> > > > @@
> > > >
> > > >   e = debugfs_create_file(...);
> > > > - if(IS_ERR(e)) { e = NULL; }
> > >
> > > Nope. For !CONFIG_DEBUG_FS debugfs_create_file returns an ERR_PTR.
> >
> > Clicking around in lxr doesn't show that, but perhaps an alternative
> > definition is overlooked?
>
> It looks that way.
>
>
> [sebott@schleppi linux]$ git grep -W "debugfs_create_file(" include/linux/debugfs.h
> include/linux/debugfs.h:struct dentry *debugfs_create_file(const char *name, umode_t mode,
> include/linux/debugfs.h-                                   struct dentry *parent, void *data,
> include/linux/debugfs.h-                                   const struct file_operations *fops);
> --
> include/linux/debugfs.h:static inline struct dentry *debugfs_create_file(const char *name, umode_t mode,
> include/linux/debugfs.h-                                        struct dentry *parent, void *data,
> include/linux/debugfs.h-                                        const struct file_operations *fops)
> include/linux/debugfs.h-{
> include/linux/debugfs.h-        return ERR_PTR(-ENODEV);
> include/linux/debugfs.h-}
> include/linux/debugfs.h-

Thanks for the pointer.  I guess that if the result of debugfs_create_file
is actully dereferenced, then both test should be present, eg:

drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c

       ent = debugfs_create_file(name,
                                 S_IFREG | S_IRUGO, root,
                                 ring, &amdgpu_debugfs_ring_fops);
       if (IS_ERR(ent))
		return PTR_ERR(ent);

       i_size_write(ent->d_inode, ring->ring_size + 12);

This problem seems to only occur in this directory.

thanks,
julia

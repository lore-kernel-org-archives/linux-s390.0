Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbgJHMlv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 08:41:51 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FEBC0613D5
        for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2020 05:41:51 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so3868275pfo.12
        for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2020 05:41:51 -0700 (PDT)
Date: Thu, 8 Oct 2020 09:41:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 10/13] PCI: revoke mappings like devmem
Message-ID: <20201008124147.GD5177@ziepe.ca>
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-11-daniel.vetter@ffwll.ch>
 <CAPcyv4hBL68A7CZa+YnooufDH2tevoxrx32DTJMQ6OHRnec7QQ@mail.gmail.com>
 <20201007232448.GC5177@ziepe.ca>
 <CAPcyv4jA9fe40r_2SfrCtOaeE85V88TA3NNQZOmQMNj=MdsPyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jA9fe40r_2SfrCtOaeE85V88TA3NNQZOmQMNj=MdsPyw@mail.gmail.com>
List-ID: <linux-s390.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>

On Thu, Oct 08, 2020 at 12:49:54AM -0700, Dan Williams wrote:

> > This is what got me thinking maybe this needs to be a bit bigger
> > generic infrastructure - eg enter this scheme from fops mmap and
> > everything else is in mm/user_iomem.c
> 
> It still requires every file that can map physical memory to have its
> ->open fop do

Common infrastructure would have to create a dummy struct file at mmap
time with the global inode and attach that to the VMA.

Jason

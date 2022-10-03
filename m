Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6386FC433F5
	for <linux-s390@archiver.kernel.org>; Mon,  3 Oct 2022 16:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJCQWE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 Oct 2022 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJCQWC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Oct 2022 12:22:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045361A805
        for <linux-s390@vger.kernel.org>; Mon,  3 Oct 2022 09:21:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA57261148
        for <linux-s390@vger.kernel.org>; Mon,  3 Oct 2022 16:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C863C433D7;
        Mon,  3 Oct 2022 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664814113;
        bh=VTqxixtRfZ1cqoQoc7riPul/A+U8/gArsffJmC8qpto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3CTmKINIb0JgJDTUTT2zDLBirlmklF9ciLNeNaXcOgWEKU8tXE4nmexWQkW1SSSD
         Zk00wtwpggMkrnxbhhPiVOStWn++Qnm9yYSeZo6o+M9djPmEk4tILvJGSWtvl8Xnfx
         amktooN8CjXGlFqG/fBA5KFeC629SeOakNwF5sxmyyI4zwXsSSfqr6Hh4VY+anWhFB
         Zq3ayG9WpH4w/8Ql38zNgmAU9TPxlpqn6ODHNy/D4yu/mLM4TPHBZbbQJME/W4lOos
         vMdMIS+pfMt8mM3WQ/Cgj3wowQU3oc3RNMQdXFcYXE3vQd7aa1bjtVfhwl0QJ9Entk
         bg7rj/4jBC83g==
Date:   Mon, 3 Oct 2022 09:21:50 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [linux-next:master 7287/11993] s390x-linux-ld:
 topology.c:undefined reference to `__tsan_memcpy'
Message-ID: <YzsMHqG9LvMZXTz8@dev-arch.thelio-3990X>
References: <202210010718.2kaVANGb-lkp@intel.com>
 <YzeW3yqxvkpYKCxa@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzeW3yqxvkpYKCxa@yury-laptop>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Yury,

On Fri, Sep 30, 2022 at 06:24:47PM -0700, Yury Norov wrote:
> On Sat, Oct 01, 2022 at 07:12:48AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > head:   274d7803837da78dfc911bcda0d593412676fc20
> > commit: aa47a7c215e79a2ade6916f163c5a17b561bce4f [7287/11993] lib/cpumask: deprecate nr_cpumask_bits
> > config: s390-randconfig-r023-20220926
> > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install s390 cross compiling tool for clang build
> >         # apt-get install binutils-s390x-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=aa47a7c215e79a2ade6916f163c5a17b561bce4f
> >         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >         git fetch --no-tags linux-next master
> >         git checkout aa47a7c215e79a2ade6916f163c5a17b561bce4f
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    s390x-linux-ld: ipl.c:(.text+0x1004): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: ipl.c:(.text+0x1046): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: arch/s390/kernel/ipl.o: in function `reipl_fcp_scpdata_write':
> 
> I can't reproduce the bug. In fact, the build is broken for me on
> next-20220930. To make the s390 image somehow building, I commented
> out some functions that aren't found by the LD.

Sorry for the noise, this is not a kernel issue, it is a toolchain
problem that will be fixed soon:

https://github.com/ClangBuiltLinux/linux/issues/1704
https://lore.kernel.org/20220912094541.929856-1-elver@google.com/

I had asked the Intel folks to stop sending reports based on this build
breakage a few times but it seems like their filter is not working
still?

https://lore.kernel.org/Yx3HnuEDyFG0+G62@dev-arch.thelio-3990X/
https://lore.kernel.org/Yy3PxL973jtEtEUK@dev-arch.thelio-3990X/

Cheers,
Nathan

> Thanks,
> Yury
> 
> diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
> index 886de028a901..d696d78132a0 100644
> --- a/drivers/irqchip/irq-al-fic.c
> +++ b/drivers/irqchip/irq-al-fic.c
> @@ -235,6 +235,7 @@ static struct al_fic *al_fic_wire_init(struct device_node *node,
>         return ERR_PTR(ret);
>  }
> 
> +void __iomem *of_iomap(struct device_node *np, int index);
>  static int __init al_fic_init_dt(struct device_node *node,
>                                  struct device_node *parent)
>  {
> @@ -249,7 +250,7 @@ static int __init al_fic_init_dt(struct device_node *node,
>                 return -EINVAL;
>         }
> 
> -       base = of_iomap(node, 0);
> +       base = NULL;//of_iomap(node, 0);
>         if (!base) {
>                 pr_err("%s: fail to map memory\n", node->name);
>                 return -ENOMEM;
> diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
> index 7633b227b2ca..4e4c9d9743bf 100644
> --- a/drivers/net/ethernet/altera/altera_tse_main.c
> +++ b/drivers/net/ethernet/altera/altera_tse_main.c
> @@ -1122,8 +1122,8 @@ static int request_and_map(struct platform_device *pdev, const char *name,
>                 return -EBUSY;
>         }
> 
> -       *ptr = devm_ioremap(device, region->start,
> -                                   resource_size(region));
> +       *ptr = NULL;//devm_ioremap(device, region->start,
> +               //                  resource_size(region));
>         if (*ptr == NULL) {
>                 dev_err(device, "ioremap of %s failed!", name);
>                 return -ENOMEM;
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 230c2d19116d..9f88be3c2b08 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -49,6 +49,7 @@ static bool afs_dir_dirty_folio(struct address_space *mapping,
>                 struct folio *folio)
>  {
>         BUG(); /* This should never happen. */
> +       return false;
>  }
> 
>  const struct file_operations afs_dir_file_operations = {
> 

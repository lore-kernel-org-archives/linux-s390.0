Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56306 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731021AbgIHP62 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 11:58:28 -0400
Date: Tue, 8 Sep 2020 14:26:37 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: set_fs removal for s390
Message-ID: <20200908122637.GB14136@osiris>
References: <20200908063133.GA14217@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908063133.GA14217@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org

On Tue, Sep 08, 2020 at 08:31:33AM +0200, Christoph Hellwig wrote:
> Hi s390 maintainers,
> 
> the base work to remove address space overrides using set_fs() has
> landed in linux-next through this tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=base.set_fs
> 
> and in addition to x86 and powerpc converted there, we have arm, arm64
> and RISC-V conversion in progress.  That means s390 is the only "tier 1"
> architecture still missing.  Due to the special instructions for
> accessing the user space address space I don't really feel like doing
> the conversion myself, but it would be great if we could get s390 done
> for 5.10 as well.
> 
> The rought TODO list is:
>  (1) actually stop using set_fs in the zrcypt driver.  I could prepare
>      a crude untested patch for that if it helps.

Hmm.. Harald's initial implementation years ago was without set_fs(),
if I remember correctly, and then he was talked into using set_fs() ;)

Harald, can you take care of this part?

>  (2) implement the __get_user_nofault and __put_user_nofault helpers to
>      safely access kernel memory.  These should behave like
>      get_user/put_user under set_fs(KERNEL_DS), but not actually
>      manipulate any task state to do so
>  (3) unselect CONFIG_SET_FS and remove all the code related to overriding
>      the address space(3) unselect CONFIG_SET_FS and remove all the code
>      related to overriding the address space limit

Ok, I guess everything will have to land in vfs.git then.

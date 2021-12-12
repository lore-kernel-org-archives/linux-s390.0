Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA89C433EF
	for <linux-s390@archiver.kernel.org>; Sun, 12 Dec 2021 14:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhLLOWb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 12 Dec 2021 09:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhLLOWb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 12 Dec 2021 09:22:31 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC65C061714
        for <linux-s390@vger.kernel.org>; Sun, 12 Dec 2021 06:22:30 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x131so12709852pfc.12
        for <linux-s390@vger.kernel.org>; Sun, 12 Dec 2021 06:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZjYIL5Meh9WPTLeEH+cczxaNrQ4dGhT95FlbuKwOdM=;
        b=InloMfMHit9I2BP2ZAxscR4m8S0WqeQXb/3EdrF9Humvvh2KWl+DC597jSlAGabELB
         DKTerSvnwB6GzWYotS0B9i033X/RFINibj/zOD0xrbstT+NhnIidusj/k7Ta2k1KwAr+
         EG4TvrpQJgRKRNS+j8HgfWmKEn0+BAHbJ+kjXAkWBw/H2S7Ll4HSeVLamvPnZ0Gv8yyl
         TLlpEyqP9KcyM139lWFcqovUaohDL62uyQPIquf1zd1gLEhLHxB1hln6xdDrM6LbhG63
         WHJWWDnlHRBcfJYMi86Gvpdgy5byWgeSLzaPT/b6VuOcGwSqgKTbI7648s4ZDB3zrsX3
         7FTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZjYIL5Meh9WPTLeEH+cczxaNrQ4dGhT95FlbuKwOdM=;
        b=QiwZLQeSDpTg3Zzcv2peQAFdj+1Y+V2qWGro6aQd0om5zorM03s+ozpZep9I/AD3rs
         jp5npOER0kVgtWaCD0oZ+7wZTCpsqujCuIJ/r4IwCdFTvUYZ7StUSLJBw4ejmTjjswDM
         QtfBwjGo2BikxfXFcp1vYjJ9D0azpszzCIt1anbU5Xf8C/OaihfA4bWe+wJKNYHfLBA6
         Dqw0naQNkEb2V8InpeCotDC4QMrZtYFv33/giVrjPoY+FxYaWzGVdcEIDzMB41PPNCRT
         /jc8n63nEAdGa+CA+fxBGZtc4U5kGZZFwc/PW+KccS5tqiiWGYLmvq386q1PZfce1/PB
         7F/g==
X-Gm-Message-State: AOAM530munqr4TJ/5YrgWrq3oWOvMnIF3W7j7YYUc6x11fnPZTHOp8Mv
        OguveByy0JjUaQmhkhFJFsHHSiqFpv+0GnXp7cXQoQ==
X-Google-Smtp-Source: ABdhPJyxbhOi5AL5eM6jiu7484TwbdU5pKz4nFxYJvBebbsi3mSjMdfP5DTSAeCbzo51p2wcGaag8JGjamOTAXCXkd0=
X-Received: by 2002:a62:7ec4:0:b0:4a3:219b:7008 with SMTP id
 z187-20020a627ec4000000b004a3219b7008mr28747585pfc.3.1639318950463; Sun, 12
 Dec 2021 06:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20211209063828.18944-1-hch@lst.de> <20211209063828.18944-2-hch@lst.de>
In-Reply-To: <20211209063828.18944-2-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 12 Dec 2021 06:22:20 -0800
Message-ID: <CAPcyv4gwfVi389e+cES=E6O13+y36OffZPCe+iZguCT_gpjmZA@mail.gmail.com>
Subject: Re: [PATCH 1/5] uio: remove copy_from_iter_flushcache() and copy_mc_to_iter()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Dec 8, 2021 at 10:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> These two wrappers are never used.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvdimm/pmem.c |  4 ++--
>  include/linux/uio.h   | 20 +-------------------
>  2 files changed, 3 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 4190c8c46ca88..8294f1c701baa 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -302,8 +302,8 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
>  }
>
>  /*
> - * Use the 'no check' versions of copy_from_iter_flushcache() and
> - * copy_mc_to_iter() to bypass HARDENED_USERCOPY overhead. Bounds
> + * Use the 'no check' versions of _copy_from_iter_flushcache() and
> + * _copy_mc_to_iter() to bypass HARDENED_USERCOPY overhead. Bounds
>   * checking, both file offset and device offset, is handled by
>   * dax_iomap_actor()
>   */

This comment change does not make sense since it is saying why pmem is
using the "_" versions. However, I assume this whole comment goes away
in a later patch.

> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 6350354f97e90..494d552c1d663 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -196,7 +196,7 @@ bool copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
>  #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
>  /*
>   * Note, users like pmem that depend on the stricter semantics of
> - * copy_from_iter_flushcache() than copy_from_iter_nocache() must check for
> + * _copy_from_iter_flushcache() than _copy_from_iter_nocache() must check for
>   * IS_ENABLED(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) before assuming that the
>   * destination is flushed from the cache on return.
>   */

Same here.

> @@ -211,24 +211,6 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
>  #define _copy_mc_to_iter _copy_to_iter
>  #endif
>
> -static __always_inline __must_check
> -size_t copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
> -{
> -       if (unlikely(!check_copy_size(addr, bytes, false)))
> -               return 0;
> -       else
> -               return _copy_from_iter_flushcache(addr, bytes, i);
> -}
> -
> -static __always_inline __must_check
> -size_t copy_mc_to_iter(void *addr, size_t bytes, struct iov_iter *i)
> -{
> -       if (unlikely(!check_copy_size(addr, bytes, true)))
> -               return 0;
> -       else
> -               return _copy_mc_to_iter(addr, bytes, i);
> -}
> -
>  size_t iov_iter_zero(size_t bytes, struct iov_iter *);
>  unsigned long iov_iter_alignment(const struct iov_iter *i);
>  unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
> --
> 2.30.2
>

Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E91C433EF
	for <linux-s390@archiver.kernel.org>; Sun, 12 Dec 2021 14:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhLLOXx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 12 Dec 2021 09:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhLLOXw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 12 Dec 2021 09:23:52 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94386C061751
        for <linux-s390@vger.kernel.org>; Sun, 12 Dec 2021 06:23:52 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so12814911pjb.5
        for <linux-s390@vger.kernel.org>; Sun, 12 Dec 2021 06:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lwwZWzMg5a3s7lwMASlg5tu9b+fzGmp/D7TMwKxKFc=;
        b=C1VDazYvOsHerGRum3UpDemvC3bLBABNz77cgqTNDNW/AlDRjmxr+knCqOb3lbM8WO
         nCuRMxTi17hjy2mfZFS6DLg1CC+TyYg8zaU2aBeKKFky3Rcsp4/9vOZKTntOjByb+hJ5
         0z6NFJU2SLN62ZWqorLtNFaHccHYM1JZ7Mu2yHUUiPrzmD1llDNRqRtKoHw0vprZZn1C
         nm6MqHIyalByp/KuSOcHH4nPAdw2l3b13tMdWhLdbsNZfg7ms1Wl3ArmPz5baUq43ARi
         V4c990kOWIh9SL0yrCBDZ7oIc/+hdYouELCNB6m6IMhS2kuwbJLs9VZytg0tPw2o9EEM
         7w2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lwwZWzMg5a3s7lwMASlg5tu9b+fzGmp/D7TMwKxKFc=;
        b=wmxznaLO84IHXsf+L0qLAby2vT3cwPZTQpcJ+IR63Cilx9YxJSSpaFcfe22znNWnEa
         apAFp895tztDZnuKGw8F1iw3M6B4E8rfYey84oln0poakIJW+bazs5jAPOEc/U+rC6M7
         fgVerbCwVcbDJ4Wn+mRXsD8/ffsvm+LUz42vi2Sfxzown7WtQVsb00QmDNegNi+faS2b
         lj6l/7DP12b/uymLiSArKRnKOZRmcX/qw0c8wk3GbSzr31vhDifdWG0+aued5fJXv5S2
         AoZelU0+5ZNp2b4/yAhCcnrc3ZjS4y844Rwh9iYYdDOl6Q0rw8gWKFeYOPG03DPPnEfg
         Iv9Q==
X-Gm-Message-State: AOAM532K2rfrDsUUoq2Z6ClUw+x5uik43DftCrME8xMhmEcAN/pjHN3a
        eQqcz3RCe0lbQ9I4FUgQW2DPeqNpbMjTghusiBCllg==
X-Google-Smtp-Source: ABdhPJwD+M0MBopqkFuJGa9sgfSVBzZnNozNDZqwXOq1RFaO0zbunOMva9BpA++y2ooxKRxQrM2G01fpVQgDA3WnFR8=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr38028565pjb.220.1639319032132;
 Sun, 12 Dec 2021 06:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20211209063828.18944-1-hch@lst.de> <20211209063828.18944-3-hch@lst.de>
In-Reply-To: <20211209063828.18944-3-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 12 Dec 2021 06:23:41 -0800
Message-ID: <CAPcyv4gZvE69C8wCukFGgFLqzD49U8Wn8X4F9N6RmMFebgyqzg@mail.gmail.com>
Subject: Re: [PATCH 2/5] dax: simplify dax_synchronous and set_dax_synchronous
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
> Remove the pointless wrappers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good, not sure why those ever existed.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> ---
>  drivers/dax/super.c |  8 ++++----
>  include/linux/dax.h | 12 ++----------
>  2 files changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index e7152a6c4cc40..e18155f43a635 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -208,17 +208,17 @@ bool dax_write_cache_enabled(struct dax_device *dax_dev)
>  }
>  EXPORT_SYMBOL_GPL(dax_write_cache_enabled);
>
> -bool __dax_synchronous(struct dax_device *dax_dev)
> +bool dax_synchronous(struct dax_device *dax_dev)
>  {
>         return test_bit(DAXDEV_SYNC, &dax_dev->flags);
>  }
> -EXPORT_SYMBOL_GPL(__dax_synchronous);
> +EXPORT_SYMBOL_GPL(dax_synchronous);
>
> -void __set_dax_synchronous(struct dax_device *dax_dev)
> +void set_dax_synchronous(struct dax_device *dax_dev)
>  {
>         set_bit(DAXDEV_SYNC, &dax_dev->flags);
>  }
> -EXPORT_SYMBOL_GPL(__set_dax_synchronous);
> +EXPORT_SYMBOL_GPL(set_dax_synchronous);
>
>  bool dax_alive(struct dax_device *dax_dev)
>  {
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 87ae4c9b1d65b..3bd1fdb5d5f4b 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -48,16 +48,8 @@ void put_dax(struct dax_device *dax_dev);
>  void kill_dax(struct dax_device *dax_dev);
>  void dax_write_cache(struct dax_device *dax_dev, bool wc);
>  bool dax_write_cache_enabled(struct dax_device *dax_dev);
> -bool __dax_synchronous(struct dax_device *dax_dev);
> -static inline bool dax_synchronous(struct dax_device *dax_dev)
> -{
> -       return  __dax_synchronous(dax_dev);
> -}
> -void __set_dax_synchronous(struct dax_device *dax_dev);
> -static inline void set_dax_synchronous(struct dax_device *dax_dev)
> -{
> -       __set_dax_synchronous(dax_dev);
> -}
> +bool dax_synchronous(struct dax_device *dax_dev);
> +void set_dax_synchronous(struct dax_device *dax_dev);
>  /*
>   * Check if given mapping is supported by the file / underlying device.
>   */
> --
> 2.30.2
>

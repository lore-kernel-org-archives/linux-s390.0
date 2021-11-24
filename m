Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C37AC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 24 Nov 2021 03:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbhKXDzc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 Nov 2021 22:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240234AbhKXDzc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Nov 2021 22:55:32 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B458FC061714
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 19:52:22 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u17so740386plg.9
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 19:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zOlc/LjY/38MNl2fNjkOvdM3xFlyfeXQW77bsVPs7U=;
        b=lAK1cPsbcZgDOnzv+wRyX5hFeuNtWn74alyzSOfh2WTiCK6b1Gd9bfDzl0+LSFYqBx
         NFA78tBSHfT8IWLc76OROAypo1vlQiiVSp+deqPBmSErFfOP18cWXFbnZCxI9VIMHHuR
         rkB6XFn/xh99StS9siD+gMovD+TGGHheUMxQDm6Fs4TRxLl6LVPgdXFahdYzrs2kgHk1
         2vtAqiLmzKNsso+noEF/MbJXbTSUoUVvNEOcLZD7XraD8UxaJOkOnpqbEwEn6rei4bjJ
         t5MvTN9s/WuPOzLWfQKYxVJtbNdZgfs/23Dfq3WeRbXM/0WgTMF9HeylQ/9xSVmw3Fc5
         g5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zOlc/LjY/38MNl2fNjkOvdM3xFlyfeXQW77bsVPs7U=;
        b=roIC+CAitqQP0tesJu8K2t4deDNCHSXBr2rcumzd5jBuA+JhCKoyFh1cRIvrDfW8N2
         oMyOWY3Ev/o7xeUZHqsIDoWgZvToG4wvhycc4rLI1x2ZTCQwf0hVOruHtbcaVdHygOYn
         emF7VH+ndbLCBKP4bWPO9nxPVp7QWHovXJOAVEeSo8dIn1UDF0xBg3NjMl9FfWMfbh3d
         iPHN8lFdINzvZMBTBrDtzy58UYxHuOcBEJVk3bm51bhHaa8ClD/qxZa6boUIcExtIdZh
         AN02J57phu+LdyfkgpMCQsr9GG6CswhIt/WezyECywwXz1qZUkn72biJOt+oxqHVnwd0
         tnCw==
X-Gm-Message-State: AOAM5322R7owd0Hd0NSOXzmmkR+07mlnDrVk82pRTk2o4XHvsqBnxNge
        uzIOzTkIfH3F8W2YTr/mnAjl4Q6ZfR0iV6zq952KQxVRJdA=
X-Google-Smtp-Source: ABdhPJymXNtj/xuoHYk/qKEwmz57TlRY6ykmrutCD2G8CDlG536bSV07F4JpqasRcpvkUcp5iE8OReW1Fq5UwnxXf/0=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr10703847pjb.8.1637725942362;
 Tue, 23 Nov 2021 19:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-30-hch@lst.de>
In-Reply-To: <20211109083309.584081-30-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 19:52:11 -0800
Message-ID: <CAPcyv4gNH1ex_6+pHmpv_pWGV8H8KomzWFtfMvtntNe++x8OBA@mail.gmail.com>
Subject: Re: [PATCH 29/29] fsdax: don't require CONFIG_BLOCK
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The file system DAX code now does not require the block code.  So allow
> building a kernel with fuse DAX but not block layer.

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

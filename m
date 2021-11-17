Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11CCC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 17 Nov 2021 17:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9554F61549
	for <linux-s390@archiver.kernel.org>; Wed, 17 Nov 2021 17:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhKQRq7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Nov 2021 12:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbhKQRq7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 Nov 2021 12:46:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B3AC061766
        for <linux-s390@vger.kernel.org>; Wed, 17 Nov 2021 09:44:00 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso5891521pji.0
        for <linux-s390@vger.kernel.org>; Wed, 17 Nov 2021 09:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvHf9aM+bFVV8YG4MJi5X6jszYRFNPnvYw8P8XxAMSs=;
        b=Pv9ANnOgMM3OWe87npnRfFAHy06jY7erPMdRcRc3VaKoizlrQvir6ceQnBEYeLyHYq
         r090jiPNw0sW2/Hep475ohjoYTOQRdpvhHcth1Xy44B2FrZqXQwnGcHV2wnXbXiiNy2O
         MDFnhNTzB1g4/CDk+YjqQXYVRalwhzm8GBHuQpfxBToXDBsfgLgdgSQoTQw5N7NkHGFW
         TO5GeE55hpjrU15s7LrDdGRZzL745vjZFcejg91qo0BT5VlwUF4cAT1X4T2RsJHhvJDD
         yt9A6syUQNrss5NuJD0lDiesCY4CCjNhydNUyUTp9hI7U9JLuZ9oCU9X4sETOzbxu27f
         +aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvHf9aM+bFVV8YG4MJi5X6jszYRFNPnvYw8P8XxAMSs=;
        b=lVwbVG9aldDjTyZw3qvk17X0rF+GZXUh4ZTEs0xWrNKlPIS0HxzM1B8tx7rONMo+Tp
         8TvEvxGcxUDsYtV9hEhkxbKDD1J8XHb21oEFcDPeZciA0bhhGGy0efIYW9vGtjssLRsa
         s0i014WUQtdUOclJnlMwIe/MWS6ZBmVMnUfByYRMmaFMEQCdLMrAHNcziED99BpOvqkf
         zheOhcIK4QO83+56//LW7AwIl4pXsWEhwIKhFBiqdnj/xng+VLV/nAyvPP01Lr8yleRg
         fcv/iME15h2BDU6JXz8jb/FFlN9CWj6gFnbqULBIcKcRHYgOQUWHU3wRMQudVhnaSHhe
         hrog==
X-Gm-Message-State: AOAM533SD5eHn0INROq7dm97C5dHuITSZVXrealSY946lsMiHmdl7XK3
        tG5noF8SW53LoKvcAJ480feWRGPTdgEQR7A0Byn2ow==
X-Google-Smtp-Source: ABdhPJzkkUh8z9sNK4035DW8QI/H+P4iSKXjlSdI0PBBNtw2VKYOtUcKXKOrARUi3RsvsZHwUrgnG1t18LSvWsJCfmc=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr57313687plt.89.1637171039968; Wed, 17
 Nov 2021 09:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-4-hch@lst.de>
In-Reply-To: <20211109083309.584081-4-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Nov 2021 09:43:46 -0800
Message-ID: <CAPcyv4hzWBZfex=C2_+nNLFKODw8+E9NSgK50COqE748cfEKTg@mail.gmail.com>
Subject: Re: [PATCH 03/29] dax: remove CONFIG_DAX_DRIVER
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

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> CONFIG_DAX_DRIVER only selects CONFIG_DAX now, so remove it.

Applied.

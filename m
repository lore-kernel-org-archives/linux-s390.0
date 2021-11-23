Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953ECC433FE
	for <linux-s390@archiver.kernel.org>; Tue, 23 Nov 2021 21:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbhKWVvw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 Nov 2021 16:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239030AbhKWVvo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Nov 2021 16:51:44 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE16C061746
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 13:48:34 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b13so200331plg.2
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 13:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYkPf9vJ648gXjsCEnGEexU4+Ifkiqg1wwbcGn6CCJ4=;
        b=VQApAlcktwMcpaq5jFhkMxeNGyvexkKC3i6bBW7J48mF8DsF1/7CQAqKNzOE+eTccI
         MukZz7spVxbYqcrXVw8V1NPJ/pO4n52l7m+S0Ph4Ybr+mw2kgqAqtZa3pLex/+BZstf8
         /wFsj02Qj6TChPn0/3voEI1RYYWUipBK72irmVx+QhYrnrndgBztGcQeijJ0cPmWiSB8
         zysPKFzjgdDt9boZOOp48eyCMBg3PV9MBTwiNrvClt0hBzUO02OKjJgpyz/mrusiP8R+
         CYs52zo3lmHwTSmYl1Jahz6zyoWzMdW1LqR6lyuLMEqjEjPScDcZZh/xx6IU/yB7SEwD
         h9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYkPf9vJ648gXjsCEnGEexU4+Ifkiqg1wwbcGn6CCJ4=;
        b=KPfYAMQsfV7On/NqM7SpbPHfHqU/tNl8qJ1uKbCvMnHTLpc/CaATHTbjfE2RkEddVK
         bVeWoQzVU7QcRFIK+0cr6VnXEcwvhdqeH0zNiNH+cA/AmSEPo1uXM0NocwRtGk1vvbKc
         HUUYKSKbpD/mMDefk0rLcGq6VgyX2jNDUjwt4GoC5/E2HWxMoMsPhyTyxiYv9fR5nf2x
         ufjSHv9J2va4NIBe0IlZ6x5uCZJDTSYoXmVY41za0GrhWN0H0zMmvJMQ+cCWYAZ0134R
         MdLbXbxFUmt2JjUF6QoaCXtc7Gcgtp/8xKGuMUjE1cSIdoC5cauBOSkz9l4xnYO6B58C
         bXuA==
X-Gm-Message-State: AOAM532ZAFefQ37DaKQ0fAyeE/+a2Fy2LtE+/RzZmv5d8JKIOfi9Xaa+
        Y0j9lOT+oHkLykXYmLJGphS2BYGOaHe3UnoMq0PGZFYoM28=
X-Google-Smtp-Source: ABdhPJyT9foSDeohZagrJ9StTFco2dwZgw3K6Q2oNHo7YSNAudlmobBOmJCjxwVnaF6MiMXxVYrJ5EOKlp8j1MbCkKE=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr7435174pjb.8.1637704113737;
 Tue, 23 Nov 2021 13:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-20-hch@lst.de>
In-Reply-To: <20211109083309.584081-20-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 13:48:23 -0800
Message-ID: <CAPcyv4isfhSxr+MJnw2UBCFN_3_dCzwAjJERHzycnR5Ncy2RQQ@mail.gmail.com>
Subject: Re: [PATCH 19/29] ext2: cleanup the dax handling in ext2_fill_super
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
> Only call fs_dax_get_by_bdev once the sbi has been allocated and remove
> the need for the dax_dev local variable.

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

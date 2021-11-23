Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA2BC4332F
	for <linux-s390@archiver.kernel.org>; Tue, 23 Nov 2021 02:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhKWC6B (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Nov 2021 21:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhKWC6A (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 22 Nov 2021 21:58:00 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79980C06173E
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 18:54:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso934125pji.0
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 18:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzu6WTfZUrCey1J7m6mzu3SyuG3mlb0cV5bc4AfptPs=;
        b=beaUT1FtsNFsra95ne0owHh0REAyyuUzujf6WfZCqbHVqWDCseUjZNBp1imtZrvl25
         Tle8IyUp3iiK6T7rSedrQcl9c/h0UQVa4ff4523mpAef4KYGb1TbGvy3lfGAL4G4Ooqr
         TH0f0Xw5heidYTCEKZrSbgx6eXucck48D1PdG9bQqnHF3xFKgaR12HFK4qLWfYdcBAaW
         hyr06oXivq4GX87hiZVUip/cxW8DPPmY1DWSzEzAGLteKQgqOmlnE0Fzbh+eO2i8dmuO
         d0czzqQ7InLmIRWHjnUfTxiVsP9Xg6prNyjUDIVMDnnmk947ZrGB8bNv0YUysQL48hVn
         bE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzu6WTfZUrCey1J7m6mzu3SyuG3mlb0cV5bc4AfptPs=;
        b=2QXiYe/R34nuteyvjMw7qLc419RK4uqjhgl6fVJlmiUjROfUODkNXzQZOo0Jh3g4PP
         lnqH5FmNNT74o/UNW4ssYp+ZGJzKWsof4UHWoxvd5e4bpDm1306UTl0RmbZ8Vdi+hXrU
         yZRLD23CzmjjA6MOqwD3/SmJw5SmySPH8htWsBPfSKb8HFCcteKwRrMF4SiGLpkiTmZI
         RQxNvY9sqtDeO76j9p4AaIOwT5pdsWdjvDeXPaNIWvmiSngPiN7hM0S2S+YyNcFk6Sfd
         yNzMDvL1MrIZdbzYPOeoVXj7k/tfIRh1YgsujW3aY6zs8f90LDdQ6k3ky7HzqjiP//84
         6tcA==
X-Gm-Message-State: AOAM530IQ1FK9Am5qjGOoQNQyFYWc1lkyVizyiITeM7xmWlBcwFCVTbW
        fH8Lte19UPVxq0PcN/juoNngM6tDB3RlS5FBTFVhut8+TQo=
X-Google-Smtp-Source: ABdhPJxeiX5ifpjvIOpWVxQMDUuHcOe3OIdJeR8Imw/gLHmEQwl4x/JiO/uU+o3bH9o5PQYkURGBJLUFMItHEKRZD78=
X-Received: by 2002:a17:902:a50f:b0:143:7dec:567 with SMTP id
 s15-20020a170902a50f00b001437dec0567mr2776615plq.18.1637636093077; Mon, 22
 Nov 2021 18:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-4-hch@lst.de>
 <CAPcyv4hzWBZfex=C2_+nNLFKODw8+E9NSgK50COqE748cfEKTg@mail.gmail.com>
In-Reply-To: <CAPcyv4hzWBZfex=C2_+nNLFKODw8+E9NSgK50COqE748cfEKTg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Nov 2021 18:54:42 -0800
Message-ID: <CAPcyv4g=KgKZR6JF8_=mTs7Ndgq7DSU+5_sTJ7gQuwUgC5dRYg@mail.gmail.com>
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

On Wed, Nov 17, 2021 at 9:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > CONFIG_DAX_DRIVER only selects CONFIG_DAX now, so remove it.
>
> Applied.

Unapplied,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

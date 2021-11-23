Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83210C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 23 Nov 2021 19:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhKWThN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhKWThE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Nov 2021 14:37:04 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE8BC061714
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 11:33:56 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x131so239264pfc.12
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 11:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hj7PcxuLnKzRepBdxbumr3rSJH1rp9RXoQiNS6BkqqY=;
        b=jjyjzax1feHZ07LUiZ/Yf1E9Hxm1wgDLlAZ2cYg6AJFLe/d321qFax/yEEu22m6fed
         iBHNc8Kk34bMQQ2nIQi6MEMltBfNwsAHFQR0AWSHQwNal+nFXc7edty5ia7jOUicLQW1
         FuRddFObFySh+nkUL24rBP+JDHWbRQRoHp4NV/QyPAV4R/iAhHEl65ZT4s43voxcaEMy
         Oc8zToerc/pGHUlRu2jWA79GIW6I3ZHT1zjOZ64ig8LsDtvPs4/T2LyRFd31HHpRYYun
         TIkUF+RfmunDs0Ue5w+xrykDMWgvw58GCXj/wKIs5Ax9Klji3Cu6QKxzZO3Z0ZwENfiJ
         dDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hj7PcxuLnKzRepBdxbumr3rSJH1rp9RXoQiNS6BkqqY=;
        b=TnBXe6PSCQRrQyCZgnBwbJHF3BmZM2/6LLiUuhy5ibJ6/V3hqp+0TwC7GznpmzLrjx
         3HwgAwSEkTtnBX5z3WU1VFFSyKqGpstGUm2NMM+xo/cjrjK3aPlfIDXxOabCMiHQUkNK
         aSjEW7QSbvRe4CVt1RQKUpglFJub0PNu6IpM3dGEQOv1dXeQvt8/vlOVaB+abi2LLwKB
         bg6HaTvDRBS+I8PHyvpBKnZFOOIkgjlNw36X1fgsYWvNa/0Ui8xd+2a82aSNKyZffBr8
         MyMKgulnXgIY4sOalxhQgdKRRjLwbxFT6SJ8+nSg2UF2dOO2er1USqjDGKg77eLkJ1B1
         podA==
X-Gm-Message-State: AOAM531otJIqYCUs+1nRB10qL7LJ56r1vvnB4k4TtitvGeU9WTEXdOJR
        ViDagut0XPOY1t2O9dKmDGhfS8tWObTVhP0pHBzZHQ==
X-Google-Smtp-Source: ABdhPJzfbK/HXngr7c4SVqoUjU1z90TEgx7yZs5kS94X6ib8WevHTs6s6Lbm19DO5En0QIDCaOcGr0Q9P6r3KEtQ2kY=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr5465536pgd.377.1637696035778;
 Tue, 23 Nov 2021 11:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-5-hch@lst.de>
 <CAPcyv4ic=Mz_nr5biEoBikTBySJA947ZK3QQ9Mn=KhVb_HiwAA@mail.gmail.com> <20211123055742.GB13711@lst.de>
In-Reply-To: <20211123055742.GB13711@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 11:33:45 -0800
Message-ID: <CAPcyv4jd2eUo4bDfX=idG7js6W=L8uKKveG97r1a8DWa-pJ=mQ@mail.gmail.com>
Subject: Re: [PATCH 04/29] dax: simplify the dax_device <-> gendisk association
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

On Mon, Nov 22, 2021 at 9:58 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Nov 22, 2021 at 07:33:06PM -0800, Dan Williams wrote:
> > Is it time to add a "DAX" symbol namespace?
>
> What would be the benefit?

Just the small benefit of identifying DAX core users with a common
grep line, and to indicate that DAX exports are more intertwined than
standalone exports, but yeah those are minor.

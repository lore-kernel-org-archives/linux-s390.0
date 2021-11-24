Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D18FC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 24 Nov 2021 02:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhKXCoJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbhKXCoJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Nov 2021 21:44:09 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26AAC06173E
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 18:40:58 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t4so758812pgn.9
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 18:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XY5RlfJ4wk969SAhdu0eeba/cRDcEGFX6BIC3EnLQt8=;
        b=u4emMr/x1DnGrylyXG/XED1B0JAzKJIqIDcJvC7Dltb93SI0bgLALNc/xx3fE/eqZ+
         JLZdSBXcBeUsE3gYFy2qkeo6t2y2XuFS7FedCduv1RHpO8vyWXlQcx11qWzGXljZ4Nta
         5OYO1lIxqTIseUFqkypGfAJj577OlmYBnt7dfkNQv9WXesT9Vr2pO7qsjUMO6hVcoGvW
         LWz11ROd5H62YcZRNEwDlvUMRryoYOk1DV1Dg4YBgp+MSllvRl7B5PMc3nehblVandHp
         KDygLbglHM1zSoblBzsW1nhsjCF5iPULo9A3DjLMb5w2hx0fDJrK0R8dTmPxHRAXcCgM
         L96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XY5RlfJ4wk969SAhdu0eeba/cRDcEGFX6BIC3EnLQt8=;
        b=zUTYH71D6KNWYTGQ7wa07eSclGMd02P5fYqBi9pzTu8ra1BnA9P0Cd3XAWQtS6OLoO
         OYhTqB28NjAP7vTHDLHXJe/1oiPNMgYug2+03D3TvS/fjbJGDL+Y/bopozUZPv/TNqIw
         lJWFwBJWywHnajLwWSzTjKP/+vLmWTi3EtOn+RH0ZlYeG+cOu0tQ9/yups0A6lZD8Qd9
         lrVnZkZlKpEY3Mi8lY0NUsgNloXCXlkic/UmWM3iZBmun3fIxf07PWceNbfqz00CQy/s
         Lgy/xYxN69/EwRFKI7SGKT6L5Gc/7keSAIazeZHjvwk7cbuDlCL53SoxYBuu043hoDU3
         GSQQ==
X-Gm-Message-State: AOAM531pifBk+6WhlAn40vcTc7mmgjh0W5CaoWC/w9/EaVpzHuY+5Fur
        4IG6GxGdnaP1vHPtq2idV1eiz0+QhDiryDwasEkvmTphtW4=
X-Google-Smtp-Source: ABdhPJzf7x9CNNO+bnTL7ccWPdJMGj5rcrJdH+gi4z67GahFamuGnCABtN5RCIhrCvjUMVb9BfOrAHDXXr0x3X1l1Pc=
X-Received: by 2002:a63:88c3:: with SMTP id l186mr1768633pgd.377.1637721658407;
 Tue, 23 Nov 2021 18:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-22-hch@lst.de>
In-Reply-To: <20211109083309.584081-22-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 18:40:47 -0800
Message-ID: <CAPcyv4hY4g82PrjMPO=1kiM5sL=3=yR66r6LeG8RS3Ha2k1eUw@mail.gmail.com>
Subject: Re: [PATCH 21/29] xfs: move dax device handling into xfs_{alloc,free}_buftarg
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
> Hide the DAX device lookup from the xfs_super.c code.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

That's an interesting spelling of "Signed-off-by", but patch looks
good to me too. I would have expected a robot to complain about
missing sign-off?

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

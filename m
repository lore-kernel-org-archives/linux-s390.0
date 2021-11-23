Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AB1C433FE
	for <linux-s390@archiver.kernel.org>; Tue, 23 Nov 2021 21:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbhKWVxM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 Nov 2021 16:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhKWVxL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Nov 2021 16:53:11 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB24C061574
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 13:50:03 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i12so599848pfd.6
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 13:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYkPf9vJ648gXjsCEnGEexU4+Ifkiqg1wwbcGn6CCJ4=;
        b=Zg2lBRkAMXF8A+wvUtTCMUUrMwJSgDxXgPFdIJ6mN7vtPUcxzmlaWcpTf9u8Q3z98h
         X/Q6JeK0cyueZaLleVAsw/AXaT4zKEIJmobxui02H2iRJwR6JQ6k+7ohKUH/xkhZtcrk
         AUpJh1ywhRU6oaywvvX2nXCy9HlVnkwENOYB/cohnRCUpdHTb0Po2TpaAZ5v/3eSZpRI
         8V3uh9/QGNOkIwreJn4bL+pCGYZydEDpnqKywmkmy4aH4tbxUO5DJdIr7F4HLJ2A0sqA
         ygzmFWm5Okq9v0BfBD825f1vPnJFQ6RvtJm08BV2t1iAQ4uh6Zl3udb+YoU4MJmQj7Nw
         WjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYkPf9vJ648gXjsCEnGEexU4+Ifkiqg1wwbcGn6CCJ4=;
        b=i4e4wDWjWITro4kyDx6HOClpjigaFeXeaPKlyguqWe0TmOzdr4JH5mdXAY+VpodtsC
         rE83JiJfIOUO2i6RoFsL5xZ4YVHON4rlg/7NL/0f4DCIEEfKa6c8CZhvyROFES/RN8Sv
         X+RoGida/zmmRX5EFQikbQKPlXwiAqllwXB6wksXVVy4/jZpEZVaBD5atWtbhGUIbawQ
         x7mxYg3ShbPW3TvEUETZZXAtlpR+7Fpfx+15gfLmq8kcD+f5m3VhunuKGFcbMhgOYFSh
         3CEg2Rg5yi5oPL0lF7lOdQnTaSzOENz0fd2r6yIFUzKADuPyjU7Q8kjV+7d4yVk3lHSl
         BRMg==
X-Gm-Message-State: AOAM533FLvXr5bwbpMJJZi8HnQBLmhtb5UKReSGkqhHR93e1+B5uCiSo
        I21fp6pKeqVjiFSroasAFRLS1f0EDaK443vmXUC8RA==
X-Google-Smtp-Source: ABdhPJyGFtcTnW/NcVjiSH5pncdxregmswvMZp0GGEC99SZ7f8Vh58bATLOZJ9aYCBUx/N4xWCbII0nzMB7q2Ks2bo4=
X-Received: by 2002:a63:5401:: with SMTP id i1mr6259530pgb.356.1637704203058;
 Tue, 23 Nov 2021 13:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-21-hch@lst.de>
In-Reply-To: <20211109083309.584081-21-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 13:49:52 -0800
Message-ID: <CAPcyv4htTDV10OkdXfWJzES2dUdm+7PDsX6LPYSxEYFnNVeMwA@mail.gmail.com>
Subject: Re: [PATCH 20/29] ext4: cleanup the dax handling in ext4_fill_super
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

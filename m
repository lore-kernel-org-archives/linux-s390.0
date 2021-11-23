Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792DBC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 23 Nov 2021 03:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhKWDiz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Nov 2021 22:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhKWDiy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 22 Nov 2021 22:38:54 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88294C061574
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 19:35:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id m24so15854035pls.10
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 19:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ciNARavW8blBNA0+Xvi8Iqp5SUe+gHu1UDO5Z2Om1Uw=;
        b=qv3CnJ11m0PYkOHoQ0rgeVwNALQf3M43R9jDn4noWbPwiyV5PFAUAobozTfJVM6jMN
         gGOMgeqNRIErcKP2vDX0zyTVsNeLTY8lzpDrTr9FaVXz7Nyuss7duyWWUC0w+OEpk0Y3
         wvFH7hCTeTDTzwtCf3LKbmurKbK1zzBM5VImDQVIB5KEn/Ze3QrYkkB8uns0eG1gogCu
         IMFX3s7C31lnzF9JxLo5DwiOin4O3xPlpFSzS/8STpqCkYOQubL9wZiMJBM7MgXl2Mw3
         PQRBvA8Ue2rAduBgzFAmSH8HYxXYHYxgpo2RnZmBQjB4Z5gLkF+OPLhfOEwFkjXAcpRy
         xi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciNARavW8blBNA0+Xvi8Iqp5SUe+gHu1UDO5Z2Om1Uw=;
        b=Atv9QnOdThl0FTWFsLwUogAsk0S3IryGj8940RqIF17DzIOthVcc/WThA0KHh/WMlk
         Ysj+REP8LvIoV340H1bfUyTG7i1RS1O/5NBuMuX2AJHpN4fttNI4zMUt8ODSP10sCwbf
         7y9KtPZm0iD4PHvJi/a6RXXVdla7jbfVijW7LxvsGNNUCXgkEcLGrp9Vy8LVqVRl8/UK
         cE0igyx/dBrIm9iwi4+ECduckocnMUCoZu0LOcbkme2DNXjkykGbB5Y1olnoRGU1JRa8
         LhArUhVHXqyeqBTPrd8yfHcreD9nGlJJzMhdMCZvJXsvem6ofRX1IFjqMYSS5Y5iuJC5
         BTcg==
X-Gm-Message-State: AOAM532VxQdrR5+XvSGDpRPm4lTB1u+g1XctiFJvkd726Cq/LS+HVw17
        2bGf3FQQ4BwBXGwcpQheq0UPxIR5alCbwbb3B9JriA==
X-Google-Smtp-Source: ABdhPJxIzgcp9HElKDkpBTZbaiahamawtMq8srzUwJcfkFqOm9FQKmJevZaNWPkBJ7GMZd7Eb5XWuI6lWDv1nhHZNS4=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr38062347pjb.8.1637638546993;
 Mon, 22 Nov 2021 19:35:46 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-6-hch@lst.de>
In-Reply-To: <20211109083309.584081-6-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Nov 2021 19:35:36 -0800
Message-ID: <CAPcyv4hQ+=_8_6O77Ayv6Y2suxCKM+8bpBoqKTjjYjBLBp=GZg@mail.gmail.com>
Subject: Re: [PATCH 05/29] dax: remove the pgmap sanity checks in generic_fsdax_supported
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
> Drivers that register a dax_dev should make sure it works, no need
> to double check from the file system.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...with a self-reminder to migrate this validation to a unit test to
backstop any future refactoring of the memmap reservation code.

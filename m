Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3995C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 23 Nov 2021 04:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhKWEUd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Nov 2021 23:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhKWEUd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 22 Nov 2021 23:20:33 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA7C06173E
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 20:17:26 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id o4so18094838pfp.13
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 20:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQsMyZujMjnowhAwZ2baLD9uO7OCrRs7T2rtVARAjVk=;
        b=r5BttbD0H9Ys+86N0W8OZt6YhGoGDH1OlqQzbeJL1DHVrD2yQYBFcAQpDJZdPp96ld
         u7ZRxawo8C15Rm8P9h/VH5gu3oohxCYJiT1x83EZ7S5DS8ZwExgaHogTmXUfy49vrooy
         uY9QBu9K0yN5b+5oZTDqMIVuo71/tE10X4peb5+q5eiDHecfanupjPCqOSworjGI5IQ5
         Aj7bWFf9mIURtRUlNDfH2tKdJ15j6ud19enU8mc5XfzSZ1qi5lkH5u7vzXmkUNvPZ8ua
         waA1d5UF/uDBNAN49ee3fRWBvihtr0fagsdWiD2SnKCZhsMGyCRgbV3y2BeBkd6hwREP
         GcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQsMyZujMjnowhAwZ2baLD9uO7OCrRs7T2rtVARAjVk=;
        b=dbkprGaWMg89DHhgN8AXDGqJzyMDVx63W10nuVEi8gK7mrBmnfnS3jNrplkIiWB9RL
         bNisfjp9wLB484yJUsQSAk11oNEmqv4AXTfq3uFH4CUvZmz1miMQvbL+Mw7KvXHzaV71
         FD3+6qhgFEVUwGP5FWcoO/oEqJicHmvB57oFYGFbXlo9EL+dx4TBmNsr0MV6TQ3YnfXe
         K30rF3QVO+wSc1fVgGvWyqgMDjhWwL3BSW6I5kOxO3UWEAqCyCfmf1i6vNjZNhZ7vKue
         ouEPlxiSwmrJsoBPncg6kq64OKM7XAoZR91GL5D0eNTyMTp7b5fUvqHuZepL8mQGMcL7
         U3sA==
X-Gm-Message-State: AOAM533IMsd3Ug400FUQqqq+OGMXK+RvWDw9rxYbP2xq0ix4wav0P656
        BGsDmb3ZHvkEQnY9KtILcFdfDq/7Gjy4Xta4gBfNbA==
X-Google-Smtp-Source: ABdhPJyduKiEJGam42hMgnTTV6OAgsDuX6QGWziIbZi1yEyOpgOf+OAOhzM4qFm0U34fEtUNE/R0JNCPUbjj9GmSWQ0=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr1612542pgd.377.1637641045591;
 Mon, 22 Nov 2021 20:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-13-hch@lst.de>
In-Reply-To: <20211109083309.584081-13-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Nov 2021 20:17:14 -0800
Message-ID: <CAPcyv4g_ZeZCZwfSvoAXL_xnnM2dTSCgN8atodfr8vfJTbYOXA@mail.gmail.com>
Subject: Re: [PATCH 12/29] fsdax: remove a pointless __force cast in copy_cow_page_dax
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
> Despite its name copy_user_page expected kernel addresses, which is what
> we already have.

Yup,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

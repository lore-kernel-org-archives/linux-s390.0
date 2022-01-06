Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52374C433EF
	for <linux-s390@archiver.kernel.org>; Thu,  6 Jan 2022 14:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbiAFOmk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 6 Jan 2022 09:42:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237699AbiAFOmj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Jan 2022 09:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641480159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ziI0c5zpDrfARzHWSXczYyQXV4rhV2uF5H/yu3MCuIA=;
        b=hzjCB8vgmtRRoJgUfU+7Tqssh59RVeI0eWmS+3a235FiajsGSLfkkjpWwp66nYDVgZKDHu
        0yztWn5AnhP0IX+hXURGGUimEoM8kpTf1fXD44UzYUNcbaFzDdLHqtYvs0e9pQmkpTQptt
        sHvQUJudodyszxvXBV1+OGJoz3TnMns=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-d15LkCC6P1m9gSVpK1645A-1; Thu, 06 Jan 2022 09:42:38 -0500
X-MC-Unique: d15LkCC6P1m9gSVpK1645A-1
Received: by mail-qv1-f71.google.com with SMTP id jr7-20020a0562142a8700b00411a73d8adaso2260851qvb.3
        for <linux-s390@vger.kernel.org>; Thu, 06 Jan 2022 06:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ziI0c5zpDrfARzHWSXczYyQXV4rhV2uF5H/yu3MCuIA=;
        b=G+Bv0sO2tKBKFlnaqc5zj1mva6lDrNGWoh3U+j2YnOcsL27XiTs6Lj6ZYEP0KXkqxv
         F2sbGd/uIDw2Vk0G6EYduy2cVsQ+NZ3sWkAbrbyAQQ22CcGXCy/rZB51O+OEsdxLb3Oz
         CmyutqlHPAvrx/T+/O0NFmWP4BqpF8j0qikUQxPjVSrV1GieBay5urcjS9T5qlsLV/LG
         OkNSZsdBtlEzIMKQ2mVkFDTt0oOeLQfmBjOHoz4zf5OeQdJ7+2rOi9i01xfdBekNtVZL
         Yljmml0MfQAIFPXcrxNpgGc4VhDcYsaNTLHDbaS3AdOhF8BPgGY8IVij8g0teRCZUJbQ
         udTw==
X-Gm-Message-State: AOAM532OcCkoCJhH1ocaOdBYW9qPknFJenQP6nJ7SXDcJaV5QXALU6h6
        2LXEG46z7WvM/eqCMB2zx7Tzle5CLNNVlV0vrN9f1uuQssfzkjv2j14CBg0MG4Cqa4VF+xQtCA9
        zr4oXjPhPSQDKy7AIOEo5
X-Received: by 2002:a05:620a:bcc:: with SMTP id s12mr40958046qki.440.1641480157661;
        Thu, 06 Jan 2022 06:42:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3FRhHacqx3hvXCbD5dR5jpsBPvBE8m7URZnWLXDzc/nf2wfv2oNDbZeyhxFZfEJhygNyDig==
X-Received: by 2002:a05:620a:bcc:: with SMTP id s12mr40958035qki.440.1641480157454;
        Thu, 06 Jan 2022 06:42:37 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id t3sm2038461qtc.7.2022.01.06.06.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 06:42:37 -0800 (PST)
Date:   Thu, 6 Jan 2022 09:42:36 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 4/4] dax: remove the copy_from_iter and copy_to_iter
 methods
Message-ID: <Ydb/3P+8nvjCjYfO@redhat.com>
References: <20211215084508.435401-1-hch@lst.de>
 <20211215084508.435401-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215084508.435401-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Dec 15 2021 at  3:45P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> These methods indirect the actual DAX read/write path.  In the end pmem
> uses magic flush and mc safe variants and fuse and dcssblk use plain ones
> while device mapper picks redirects to the underlying device.
> 
> Add set_dax_nocache() and set_dax_nomc() APIs to control which copy
> routines are used to remove indirect call from the read/write fast path
> as well as a lot of boilerplate code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Vivek Goyal <vgoyal@redhat.com> [virtiofs]

Late to the game here, but quite a lot of dax DM code removed, thanks!

Reviewed-by: Mike Snitzer <snitzer@redhat.com>


Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF31C47082
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 04:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE2C610FC
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 04:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFGEqF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Jun 2021 00:46:05 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:47021 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhFGEqE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Jun 2021 00:46:04 -0400
Received: by mail-pl1-f171.google.com with SMTP id e1so7932927pld.13
        for <linux-s390@vger.kernel.org>; Sun, 06 Jun 2021 21:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CRj471fcopWwQDLwVjladgw5/TWtqNQ37b4ozfCN7s8=;
        b=mUwrryrMK2/51rlcR19uFKtt3Uz+vhowS1qfTyT3U4jbSFAWkNWauh6vZ1LO5VmIVs
         5ECi3fnIpqEf7SJMnMZB8oq3crwKNTWITd/ZeOFm876BQIrYAX3u/vNdV2CgZCK01tkz
         C8YU7ud0HQKax1RxO59EYt6KRwvWGHRSNo9PWsgDov28KfdcU8hcxJqxXgxw+nPdjo7K
         342fva71vreSrrP8Kmd82X7Kbm8YcsSnvq3hNSryExEQqxyEuVJkiKabNqk+zLsUk8un
         QX0WKhwpmqtVabr66aXRDGAcLJ6aoyf/DzL3OqIqE10TWaZPFDhN5OQPz3qcG9KZwqa3
         ZqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CRj471fcopWwQDLwVjladgw5/TWtqNQ37b4ozfCN7s8=;
        b=DZhMwE+G4g1lNIMeyr7Wdy7BM0GkUyV3ErfFSXVma6D4XjaXB0oRaRC444euAN8jCm
         EWcC4+But+wmGm7cbtwU9+ct6ATv6EfwhIJl05Pd3F5lTMXgIXW5haBUjZ0ymBxggfYc
         gCqKi7fr+uW1bpGKH2/vpcAkQla2Ri6dy4jtH74aiE6iRo9/hdgdsFFp/lZTgwcX7TXc
         F5g13eOF8fdNjI1TUwNdXp5J1++7Ql/oyKYEOt2dJLjVMXmd3zhQ5zpss6F/1mQmYgGy
         qUcMjqWNT214lnVK1A5+Z7p4tC8Pty3YdT8jcNXlbzin6P6WRJj2XySuuyaadhJRiYlJ
         UmzA==
X-Gm-Message-State: AOAM533gcy8kUoGvj40Qn20V2t3/7JDbR62xwTK1YRrOf+v1gywVwwfu
        In5pGPFeZtQPNwBGL4vr3mIeCg6H2IwJufmOP+HNEg==
X-Google-Smtp-Source: ABdhPJylkfr3HkdoqNF9xRMFqCn7oO5cpDCL+nuDgN1ppB6ZETr18hlSAOgBmuySRxZfODa5nUP7K4JpxKKLUl+WZPE=
X-Received: by 2002:a17:902:f1cb:b029:10c:5c6d:88b with SMTP id
 e11-20020a170902f1cbb029010c5c6d088bmr16307416plc.52.1623040994149; Sun, 06
 Jun 2021 21:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210521055116.1053587-1-hch@lst.de> <20210521055116.1053587-18-hch@lst.de>
In-Reply-To: <20210521055116.1053587-18-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 6 Jun 2021 21:43:03 -0700
Message-ID: <CAPcyv4gFEbZH4sXbkvQ32Xv1HiZ6JPL04efGpAWCqaJP_X9jaA@mail.gmail.com>
Subject: Re: [PATCH 17/26] nvdimm-pmem: convert to blk_alloc_disk/blk_cleanup_disk
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jim Paris <jim@jtan.com>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Matias Bjorling <mb@lightnvm.io>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-block@vger.kernel.org,
        device-mapper development <dm-devel@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
        drbd-dev@lists.linbit.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-mmc@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-nvme@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

[ add Sachin who reported this commit in -next ]

On Thu, May 20, 2021 at 10:52 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Convert the nvdimm-pmem driver to use the blk_alloc_disk and
> blk_cleanup_disk helpers to simplify gendisk and request_queue
> allocation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvdimm/pmem.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 968b8483c763..9fcd05084564 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -338,7 +338,7 @@ static void pmem_pagemap_cleanup(struct dev_pagemap *pgmap)
>         struct request_queue *q =
>                 container_of(pgmap->ref, struct request_queue, q_usage_counter);
>
> -       blk_cleanup_queue(q);
> +       blk_cleanup_disk(queue_to_disk(q));

This is broken. This comes after del_gendisk() which means the queue
device is no longer associated with its disk parent. Perhaps @pmem
could be stashed in pgmap->owner and then this can use pmem->disk? Not
see any other readily available ways to get back to the disk from here
after del_gendisk().

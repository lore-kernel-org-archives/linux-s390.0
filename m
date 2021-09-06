Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F1DC433EF
	for <linux-s390@archiver.kernel.org>; Mon,  6 Sep 2021 17:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED5261004
	for <linux-s390@archiver.kernel.org>; Mon,  6 Sep 2021 17:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244024AbhIFRMN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Sep 2021 13:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243946AbhIFRML (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Sep 2021 13:12:11 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE90CC0613C1
        for <linux-s390@vger.kernel.org>; Mon,  6 Sep 2021 10:11:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so14534970lfu.5
        for <linux-s390@vger.kernel.org>; Mon, 06 Sep 2021 10:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cu2xJTqozk4xsbaxL8H9BoFzyGhonAhAaycqLOW0ec8=;
        b=OlLhUgbAfIRcaQBkm3ucc7CkjQAA3BY3foo15moLBOuI3bnD2Kus4MNZyf0QsYgIYo
         nYbwNGvkReFol2qerrmiIPhJwlB8yfL4VS7xERe6PQW1ZAkPROcukdDIAppf1FTAiEtW
         y+1oyCqSnc3RJ5wKu+lHo6J8Hhxb89KqfMf2R86r38NWDbRsmOlMpqbHkNHi7bCFiSqW
         cl3lahlfSxznPdky39hR5eu7x7LzmxY6PmVuGHoR2GG6KV3mnQh2ksxW1J/2m2kjXAZA
         AXoTX3K6GFv1heJQ79c2pUmD74HsC98NaYlHdj2R9LB8Mw6mkN6Kj8B5D6ZJn7udld5B
         OXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cu2xJTqozk4xsbaxL8H9BoFzyGhonAhAaycqLOW0ec8=;
        b=EVFG8VpcGEPB0N+RS3hJDtNhN8iADMUmvn7gxiuSgslYVdmvis5n1BuDAgBhd+tr+P
         kgRGMl9rFsz+7sjm6MS4+/Fz2Y0aWJVfbb3HVZtD2yQNm6RaO7X9+EWOhOGiv3hiAunW
         ozRRqpnTX0iZTEH18XfRL1iRKjcniGn15bhJqMYqVfYPMr6uMjzv+lnrJFuEJmEexjKs
         7Lh0z/3hJCXGa8SBAt9etmLYPVsB6e52t97KAHXnalhwWQtVxZCgfy8Km/WMKfnjMOId
         Sob/xLy8e0KussFjmNo2aBkmmc2qZ6QGvPOyN04IKR8W6xS8NluFsgBINBzAuHAnuoHD
         v8jg==
X-Gm-Message-State: AOAM532L4WImMccJK5MdUXUFK+GFhcXHbTVtqAEzGzVSKCX7QQKY7evC
        3I5BDsTAhEWGb6yeU6StKy+76fMVtWLP5aH0mM/p5w==
X-Google-Smtp-Source: ABdhPJySjVy/4t45uf+nwvNhsrs7H6NHiflWPlp7zgQ9bQXGTclgeFZjH9Q4gk7PApD5uzg0A1VOJOtWwiyVL3oaHNk=
X-Received: by 2002:a05:6512:1043:: with SMTP id c3mr9631426lfb.358.1630948263963;
 Mon, 06 Sep 2021 10:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210902174105.2418771-1-mcgrof@kernel.org> <20210902174105.2418771-4-mcgrof@kernel.org>
In-Reply-To: <20210902174105.2418771-4-mcgrof@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 19:10:27 +0200
Message-ID: <CAPDyKFrwjJyLXfr48+Jujfp7VvxPu5JCGJAhZJn3-GzDb1Kh5A@mail.gmail.com>
Subject: Re: [PATCH 3/9] mspro_block: add error handling support for add_disk()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        chaitanya.kulkarni@wdc.com, atulgopinathan@gmail.com,
        Hannes Reinecke <hare@suse.de>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Colin King <colin.king@canonical.com>,
        Shubhankar Kuranagatti <shubhankarvk@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, Tom Rix <trix@redhat.com>,
        dongsheng.yang@easystack.cn, ceph-devel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>, sth@linux.ibm.com,
        hoeppner@linux.ibm.com, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        oberpar@linux.ibm.com, Tejun Heo <tj@kernel.org>,
        linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 2 Sept 2021 at 19:41, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
>
> Contrary to the typical removal which delays the put_disk()
> until later, since we are failing on a probe we immediately
> put the disk on failure from add_disk by using
> blk_cleanup_disk().
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Queued for v5.16 on the temporary devel branch, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/mspro_block.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
> index 22778d0e24f5..c0450397b673 100644
> --- a/drivers/memstick/core/mspro_block.c
> +++ b/drivers/memstick/core/mspro_block.c
> @@ -1239,10 +1239,14 @@ static int mspro_block_init_disk(struct memstick_dev *card)
>         set_capacity(msb->disk, capacity);
>         dev_dbg(&card->dev, "capacity set %ld\n", capacity);
>
> -       device_add_disk(&card->dev, msb->disk, NULL);
> +       rc = device_add_disk(&card->dev, msb->disk, NULL);
> +       if (rc)
> +               goto out_cleanup_disk;
>         msb->active = 1;
>         return 0;
>
> +out_cleanup_disk:
> +       blk_cleanup_disk(msb->disk);
>  out_free_tag_set:
>         blk_mq_free_tag_set(&msb->tag_set);
>  out_release_id:
> --
> 2.30.2
>

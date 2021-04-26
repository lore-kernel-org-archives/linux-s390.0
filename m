Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C36CC433B4
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 16:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4A460C3D
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 16:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhDZQ0J (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:26:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58036 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhDZQ0J (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 26 Apr 2021 12:26:09 -0400
Received: from mail-oo1-f72.google.com ([209.85.161.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.ehrhardt@canonical.com>)
        id 1lb434-0003QR-I7
        for linux-s390@vger.kernel.org; Mon, 26 Apr 2021 16:25:26 +0000
Received: by mail-oo1-f72.google.com with SMTP id g12-20020a4ae88c0000b02901f8995df46dso1639443ooe.4
        for <linux-s390@vger.kernel.org>; Mon, 26 Apr 2021 09:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mqrL8WPMdNcuWjnjVuPNloD30djsAyHRsSfo1f63cI=;
        b=TE7Jp4HiVnx1EHFpMm75cRq30Or0XtTyLr1wmGoEXIj1Ppr1pevqBGlf4+rz2uQQmf
         4BICj9vk+ed0vv5J5w/uylQGeE9JtemV0yjI8jtXWzrMC9HPaqF3OoDGHlgHtfrUjWvo
         9wonS+jal2UzTClHkJZC4wAH9T4xeVnIAgi86Hjt+vD2I7fRgU3Rla7vNwVpQXMJnFgT
         chpVuAxi45DzOVH5Ohan2NRP7nxeGAdTc6SB3dSfVU2eKSxoe4m/N/XnAuGR8WFoFSbg
         JI2y+9MTuLsrT7upDNvjjv5T/IDZH90AsJAwB+HJTC5R6W+b+r1fzNgNM5HEtbJHIT0U
         ewDg==
X-Gm-Message-State: AOAM531icX7JJN32IjXtsMjxdkjzxA6vf7oAImnrNDLDhzrpQwVOwDjA
        RDRDFNbuPX9GkIbNb29wTb7TUbmUZlngr4LT82lM9u1e1A6cSNB/UWeBt7uAUmVqFLYwooJNe1f
        7D70l1B0SDVNby5j6sDsSTdGiQhMZMWNpel9WXY9FB0R/JhXIG3qTNo0=
X-Received: by 2002:aca:f4cd:: with SMTP id s196mr13989144oih.165.1619454325250;
        Mon, 26 Apr 2021 09:25:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziCCx0K0Tq2DBKooSdWGFDhdlp53bW682lCQ0SI8TfmiPGTJtrN/XSO872jNbeESqKDAdMX5HJbYBukj/PSR0=
X-Received: by 2002:aca:f4cd:: with SMTP id s196mr13989130oih.165.1619454325005;
 Mon, 26 Apr 2021 09:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210423100843.2230969-1-vneethv@linux.ibm.com>
In-Reply-To: <20210423100843.2230969-1-vneethv@linux.ibm.com>
From:   Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date:   Mon, 26 Apr 2021 18:24:59 +0200
Message-ID: <CAATJJ0JRorRRG=jBPb9FKZohUa1v_hWyL52dRN3uHo70xj0Z6A@mail.gmail.com>
Subject: Re: [PATCH] s390/cio: Remove the invalid condition on IO_SCH_UNREG
To:     Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     oberpar@linux.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Apr 23, 2021 at 12:08 PM Vineeth Vijayan <vneethv@linux.ibm.com> wrote:
>
> The condition to check the cdev pointer validity on
> css_sch_device_unregister() is a leftover from the 'commit c97cd8c81d4a
> ("s390/cio: Remove pm support from ccw bus driver")'. This could lead to a
> situation, where detaching the disk is not happening completely. Remove
> this invalid condition in the IO_SCH_UNREG case.
>
> Fixes: 8cc0dcfdc1c0 ("s390/cio: remove pm support from ccw bus driver")
> Reported-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> Suggested-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>

Thanks, and if you want for a hattrick now also
  Tested-by Christian Ehrhardt <christian.ehrhardt@canonical.com>

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
> ---
>  drivers/s390/cio/device.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index 3f026021e95e..84f659cafe76 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -1532,8 +1532,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
>         switch (action) {
>         case IO_SCH_ORPH_UNREG:
>         case IO_SCH_UNREG:
> -               if (!cdev)
> -                       css_sch_device_unregister(sch);
> +               css_sch_device_unregister(sch);
>                 break;
>         case IO_SCH_ORPH_ATTACH:
>         case IO_SCH_UNREG_ATTACH:
> --
> 2.25.1
>


-- 
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

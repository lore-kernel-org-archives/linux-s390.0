Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6680DC05027
	for <linux-s390@archiver.kernel.org>; Thu,  2 Feb 2023 21:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjBBVBn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Feb 2023 16:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjBBVBm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Feb 2023 16:01:42 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1400A834B0
        for <linux-s390@vger.kernel.org>; Thu,  2 Feb 2023 13:01:41 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hx15so9631744ejc.11
        for <linux-s390@vger.kernel.org>; Thu, 02 Feb 2023 13:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oTODos+JhjSsHMBz5WWde+ZXEzF0nlSS0ENQxh5rzZM=;
        b=Wkc5GlD/FMKs5jzKPItNIB48d18Vt5fgOxWvYT6sO6WbX7UR5gcq8Temv+KOltBFcU
         UFd5KeCB2LK0vUvPqnpH+j6bfqKyOR/J9PnFMbgMpZgEM71rYA19/8B8pVNDAYa84JYo
         YyRF5TNqz/s/9lOOewI7FVv/Om4/CNsFznsBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTODos+JhjSsHMBz5WWde+ZXEzF0nlSS0ENQxh5rzZM=;
        b=jAuEZ3TyYUXMRKxuV/IySBNgbDCQznp7pjbyi4igkWabDYRVnMEtaHniCzXGNso/vZ
         WsjR4G/Zmg3DNntGFLXxN38jaed0Xvttyx1+qExrYWB8oJTOs5P0Siln4BAfvY6UcjZ+
         4og8Cnfi5k+15B1fUeBlxbPsAGhJf+KXRTy4CgrBvSRHgRVw4w2D4dvG2VjE04xXT5HA
         v6Eu+udKVIYvwWmtq9eGcnn8sXol751JEpp7QhIqyW+h/iWe5z3pDcqKXtf+XNFiMQJo
         0dD4ClExX/7BHZO2hEh1+IN3do+w1umvewiD9TrDprlhoJ9EbPjtWfsUW3upbkmUbOSt
         i/xw==
X-Gm-Message-State: AO0yUKUB4WDWQR+np9oSN7gYP+vVn1qzbreQw7pim8XwbwwYaZNyQBuV
        nJJZ0z42lna+UL/UPLDkZEPNF4vBvWYcFHjizR/S1Q==
X-Google-Smtp-Source: AK7set82EGVr/hCEOa/FYiJiIJhPN/37sAkrejr38wPcvv0zLsngiA7Tdxci7m/rsra+FgWbd3/kbg==
X-Received: by 2002:a17:907:8d16:b0:878:955e:b4a4 with SMTP id tc22-20020a1709078d1600b00878955eb4a4mr8553088ejc.33.1675371699232;
        Thu, 02 Feb 2023 13:01:39 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id lx21-20020a170906af1500b0084f7d38713esm303349ejb.108.2023.02.02.13.01.38
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 13:01:38 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id p26so9606517ejx.13
        for <linux-s390@vger.kernel.org>; Thu, 02 Feb 2023 13:01:38 -0800 (PST)
X-Received: by 2002:a17:906:892:b0:87a:7098:ca09 with SMTP id
 n18-20020a170906089200b0087a7098ca09mr2044808eje.78.1675371698233; Thu, 02
 Feb 2023 13:01:38 -0800 (PST)
MIME-Version: 1.0
References: <Y9wYTnwXVwg/3Dv3@osiris>
In-Reply-To: <Y9wYTnwXVwg/3Dv3@osiris>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Feb 2023 13:01:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3u9fG-Oy_NV+w2H7pFUWmfyX5JXHGvxynxA9b1sNZGw@mail.gmail.com>
Message-ID: <CAHk-=wg3u9fG-Oy_NV+w2H7pFUWmfyX5JXHGvxynxA9b1sNZGw@mail.gmail.com>
Subject: Re: [GIT PULL] s390 fixes for 6.2-rc7
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Feb 2, 2023 at 12:08 PM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> - With CONFIG_VMAP_STACK enabled it is not possible to load the s390
>   specific diag288_wdt watchdog module. Reason is that a pointer to a
>   string is passed to an inline assembly; this string however is located on
>   the stack, while the instruction within the inline assembly expects a
>   physicial address. Fix this by copying the string to a kmalloc'ed buffer.

Ugh. I have pulled this, but I think that fix is disgusting.

I think the kmalloc/kfree should have been done inside __diag288_vm()
itself, where it actually does that whole "virt_to_phys()" too.

Now there are three callers of __diag288_vm(), and they all do that
ugly kmalloc game with no comment about why it's needed.

If __diag288_vm() just did it itself, and had a comment right next to
the virt_to_phys() about why, that would look a lot better, I think.

That said, I don't know the code, and maybe there was some reason to
do it this way. As mentioned, I've pulled it, I just don't
particularly love the patch.

              Linus

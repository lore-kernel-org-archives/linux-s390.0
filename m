Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgFHTKA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 15:10:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B304DC08C5C3
        for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2020 12:09:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so10974042ljb.12
        for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2020 12:09:59 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id w25sm4562004lfn.42.2020.06.08.12.09.56
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 12:09:56 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id d7so10918555lfi.12
        for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2020 12:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01591630479-ext-3636@work.hours>
In-Reply-To: <your-ad-here.call-01591630479-ext-3636@work.hours>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jun 2020 12:09:39 -0700
Message-ID: <CAHk-=whC98Ge2Y2uooRkbt11R1QpF0283Oqnz6X6AUBa_XBbzQ@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 5.8 merge window
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>

On Mon, Jun 8, 2020 at 8:35 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> Please note 2 minor merge conflict resolutions below:

There was a third because of the iommu tree I merged today.

That one looked trivial too, but please double-check things anyway,

              Linus

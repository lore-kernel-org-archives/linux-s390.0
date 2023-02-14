Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8699DC05027
	for <linux-s390@archiver.kernel.org>; Tue, 14 Feb 2023 13:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjBNNeM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Feb 2023 08:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjBNNeL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Feb 2023 08:34:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C80E25951
        for <linux-s390@vger.kernel.org>; Tue, 14 Feb 2023 05:34:10 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id by3so14349093wrb.10
        for <linux-s390@vger.kernel.org>; Tue, 14 Feb 2023 05:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WGHU8++hSasBHq0auor+ITetD5qlqdDHtoEhmOgHC2Q=;
        b=SPTzUWH/X5kgsBzTcLZOEcoua5kSuTJjKXXpUg9amC5bVjZeR8mGyuW4I/Sry1HH0u
         kOP9zXc9AYIkxMbPlqjJlTDLKmO7Z6Zwl93nWglvDWQVCW6PaEFAoG0ncEUz/xve9CUC
         hM0LdOix+uQqxXHMgWED0BTtP7/juaHBGpfl0PobnhwQt5Rkqa/5yDRGpb0VKHrIWecw
         uQRl+SNTq3H3IRKIHEGMjnRL+9lotYP8JiNJVYDc4061EASMuKRHtrCft+SWJKZAOCK+
         I9QWpQI6lkVfFJtWkzVMX7RsO/uGjLM8DfIopjft8xChJAIV6pOCjcr2IDyFnDCoVLlq
         wyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGHU8++hSasBHq0auor+ITetD5qlqdDHtoEhmOgHC2Q=;
        b=5VvUS9CQEOw8FHIW+DuDRiL5rm0tGW+5ReHOFxhqUyFUAmcgB6DJDAM+b9eTE1gDsz
         STCH4hKmnmKbZlamjVYW87+BAwjhtVL5q/A6EmsgOThFegruifQCiuosYPgHAdvrl5Yp
         Oip7/cRhLVSCo9RK500UWaurWyDKCblPHLwNOBs0SqYgfc0OFcMTZJN8DbplgzbEsSV4
         XBnY4+Yps+OO7ggXZPgNCRlgM1sVLXROX+mFbwqpbaxCgKE4UsXts/gDg45kyFFSZmz1
         MhDainoQ2H5jLZRq2iOxM6nQSO8hMSh9Kiv/RaH7zVcajBRD1qMHMg632KUMzATLQTaf
         Cztw==
X-Gm-Message-State: AO0yUKVmajVzx4Xj7Wwf22IfN7yV3x8PS3wQIekL+FFIKFe/y1wv1I5a
        m9YzWE4uFZEkr35QHBoNQLo5Ipcxh8B9jRxm22iYBg==
X-Google-Smtp-Source: AK7set/FJhWVX9bcheAVW2cRW8gw2NQSjN3nIpKQOyB1fAOvHf8ARFeSbB8M6ccTThoujaOGWU2kcvTrKw/YjEzkTCs=
X-Received: by 2002:adf:fd4d:0:b0:2c5:521a:18ca with SMTP id
 h13-20020adffd4d000000b002c5521a18camr112575wrs.526.1676381648896; Tue, 14
 Feb 2023 05:34:08 -0800 (PST)
MIME-Version: 1.0
References: <20230213183858.1473681-1-hca@linux.ibm.com>
In-Reply-To: <20230213183858.1473681-1-hca@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 14 Feb 2023 14:33:31 +0100
Message-ID: <CAG_fn=Wo-RyxDDvV3bVugfxzxxQN75GaOoRhKOQv1b5yrbPynQ@mail.gmail.com>
Subject: Re: [PATCH] s390/kfence: fix page fault reporting
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Feb 13, 2023 at 7:39 PM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> Baoquan He reported lots of KFENCE reports when /proc/kcore is read,
> e.g. with crash or even simpler with dd:
>
>  BUG: KFENCE: invalid read in copy_from_kernel_nofault+0x5e/0x120
>  Invalid read at 0x00000000f4f5149f:
>   copy_from_kernel_nofault+0x5e/0x120
>   read_kcore+0x6b2/0x870
>   proc_reg_read+0x9a/0xf0
>   vfs_read+0x94/0x270
>   ksys_read+0x70/0x100
>   __do_syscall+0x1d0/0x200
>   system_call+0x82/0xb0
>
> The reason for this is that read_kcore() simply reads memory that might
> have been unmapped by KFENCE with copy_from_kernel_nofault(). Any fault due
> to pages being unmapped by KFENCE would be handled gracefully by the fault
> handler (exception table fixup).
>
> However the s390 fault handler first reports the fault, and only afterwards
> would perform the exception table fixup. Most architectures have this in
> reversed order, which also avoids the false positive KFENCE reports when an
> unmapped page is accessed.
>
> Therefore change the s390 fault handler so it handles exception table
> fixups before KFENCE page faults are reported.
>
> Reported-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Alexander Potapenko <glider@google.com>

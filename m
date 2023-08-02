Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EB4C001DF
	for <linux-s390@archiver.kernel.org>; Wed,  2 Aug 2023 22:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjHBW0N (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Aug 2023 18:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjHBWZw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Aug 2023 18:25:52 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FC1468F
        for <linux-s390@vger.kernel.org>; Wed,  2 Aug 2023 15:24:35 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bbb34b091dso2953455ad.0
        for <linux-s390@vger.kernel.org>; Wed, 02 Aug 2023 15:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691015074; x=1691619874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F9yIn4dK3mSmUtcCp8LFFT4F/LQPHHPvz5xo49Hmxkk=;
        b=H+aTSYmBYRO7DEl0/Htl+Y5MU3zO0wo2l+1FTpMwOYDrAjZnYx7ET8cvGNBa+VhiQo
         VNh5q/Dn9hvp4uKDjTfLgLfw15kkhnDEnfRhiU9yFwZZHyeTWZpXkJqPylFoHBgQAyaf
         aBTifmJXqJLmP5lVQAoPZsli5/e5GDX78w5BAZjdL1vToFkiklboUC2FYPw4yrY5o7zi
         FKfloQC0qrIZC8aaCFXsGriAuqPWzKBenKQfVkqPaUsunkHJ9IDkCXMZqn79LQm2+khs
         y6UAtFp77IpR1eHxik0mHjgsYCbadkRl1CkaPHJo8SdYL1zsjEcOXb/edT5pHOCJNcVZ
         haXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691015074; x=1691619874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9yIn4dK3mSmUtcCp8LFFT4F/LQPHHPvz5xo49Hmxkk=;
        b=e8mSgeUG7narYZ5bIAYqiPZ0IONPXlIK8j3FC4J5qteq67XoH0CuTJfWkenkyTsiJh
         u6fiYCHr/0rqAVM1z9WdoBEUfP7snmhMmGYGe3qXnB8++CnIxD3HMK+yD15a7D2B6RD0
         d6Yt4XA3uEvHKscIfW8mEMffWFsInP888IVUYK9CSRpxLM59TeC8eP0fmexK4JhJo9Yt
         QeNbQxYqQfKsPhcee2wVZlSpzEjk4BEJwVmDL6a29DlsOAmhNBryM5cZKzR1kLtZzf8c
         x+KAS/p1aCpVezGwTSFZO3ilVtytEFvFSQo+kClGs9x/XK4aG+dq6VwCZayzFvChKGhF
         ldVw==
X-Gm-Message-State: ABy/qLYMl00m1nlQ6YCYdNsdZigah0goD32VGiVEqTs/yUe3P4ed+aEb
        XFsGJ/5zYirEZMWrGyCQENrDmZ39QNI=
X-Google-Smtp-Source: APBJJlEIByBfYoY/KC32/g8HzkxLqseO0XeVYpg+NMSyLBH6gtwD9otmWgLk0cSs3kJzChFA66PNbRObft0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2291:b0:1b5:2b14:5f2c with SMTP id
 b17-20020a170903229100b001b52b145f2cmr105841plh.4.1691015074397; Wed, 02 Aug
 2023 15:24:34 -0700 (PDT)
Date:   Wed, 2 Aug 2023 15:24:33 -0700
In-Reply-To: <20230725143857.228626-1-iii@linux.ibm.com>
Mime-Version: 1.0
References: <20230725143857.228626-1-iii@linux.ibm.com>
Message-ID: <ZMrXoQ0wN5ZyCf6Q@google.com>
Subject: Re: [PATCH v4 0/6] KVM: s390: interrupt: Fix stepping into interrupt handlers
From:   Sean Christopherson <seanjc@google.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Freimann <jfreimann@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 25, 2023, Ilya Leoshkevich wrote:
> Ilya Leoshkevich (6):
>   KVM: s390: interrupt: Fix single-stepping into interrupt handlers
>   KVM: s390: interrupt: Fix single-stepping into program interrupt
>     handlers
>   KVM: s390: interrupt: Fix single-stepping kernel-emulated instructions
>   KVM: s390: interrupt: Fix single-stepping userspace-emulated
>     instructions
>   KVM: s390: interrupt: Fix single-stepping keyless mode exits
>   KVM: s390: selftests: Add selftest for single-stepping

FYI, the selftests change silently conflicts with a global s/ASSERT_EQ/TEST_ASSERT_EQ
rename[1], but the conflicts are very straightforward to resolve (just prepend TEST_).
If we want to proactively avoid mild pain in linux-next, one option would be to merge
the full kvm-x86/selftests branch/tag once I've made that immutable[2] (will be done
Friday if there are no fireworks).  Though we can probably just get away with doing
nothing other than letting Paolo know there's a silent conflict.

[1] https://lore.kernel.org/all/169101245511.1754469.7852701829984104093.b4-ty@google.com
[2] https://lore.kernel.org/all/169101267140.1755771.17089576255751273053.b4-ty@google.com


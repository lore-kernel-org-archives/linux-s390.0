Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0FFC07E95
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 19:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2103E61C84
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 19:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhGGTpP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 7 Jul 2021 15:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGGTpP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Jul 2021 15:45:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE2AC061574;
        Wed,  7 Jul 2021 12:42:33 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id t24-20020a9d7f980000b029046f4a1a5ec4so3428895otp.1;
        Wed, 07 Jul 2021 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=86K7g6xk1w1rzYS0KSqb5hgP7+OyClopI7gZPdUQgbI=;
        b=PMWxYxFk4kMyuAJ9tresyY9N/+YWoX+ChH8bdDXlNe8+7VtNxuhhhPnb+mDUq+0O79
         OvWhR5kTRH5djowXPdZ7hzprz5EFURsT4M7nUv7SXenjjpUyzdL7XrqvloPMlPK8PFTl
         CGju4ZoO6IDrsGYtejKRYBpnHbJBevm7DZiWvpepJLWFCApaK+WGB37VCeUAoZn+1nmW
         2WEIg44ZadrGBNX8cO/1KY2l98VMKT3EKN4gJyzqkvsLxrgQK2vtSHr1AAiFTlh7pNZM
         PWqzUD3Qs453iSGxkiDnYEWc1qoe63sTuKNX6el6d3aAf/CNxUPMebyGzE7C4MMgXsfW
         gifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=86K7g6xk1w1rzYS0KSqb5hgP7+OyClopI7gZPdUQgbI=;
        b=YwFBhIFK533F5uwnL8thCMFm8EbiGAv0tM2kCPFlC32oTRcA5AM75l5PHDhTLcQVhu
         t5oCUu/AaS9QAHlldI5Z+g2hi7g3En0AvZZNBnPS2F8EbD0N8gGrXyEQNkxb9VdgZgRK
         kNunIN5jtJmBIfAW92DlX0ZRWMv5tyh2h8GZ+e45za0Xh1C4AukgzTpsjx/zQWDsCi8G
         lbGIIxt7crJh9kh58itzlrGt6Cfits3TVypaligx/56aGMiDW00JJLpXEJEgiM016Bxu
         ASqqH2ZyhV0Ywx/gpQDeKRjp/hiPKZfO2Vw3GvVwEEbn9QAudSu9eSzRMQXz9iJBMlBP
         7cSQ==
X-Gm-Message-State: AOAM530mWVxJHZ4JZT7fWR1NQvbXh1IYdi6iS45sY9oWLbb2JlkIsZsA
        xv21EwpTCqiX6MexYrgwJbE=
X-Google-Smtp-Source: ABdhPJwec+PsmiC8fiA6YcocAv6d877eOPASCrTPx/0uMZx2+q3keJZkElyNpFLBj/k3NjBvOSqclA==
X-Received: by 2002:a9d:2aa5:: with SMTP id e34mr13122111otb.366.1625686952982;
        Wed, 07 Jul 2021 12:42:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k67sm6849oia.8.2021.07.07.12.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 12:42:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 7 Jul 2021 12:42:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] s390: preempt: Fix preempt_count initialization
Message-ID: <20210707194226.GA2318012@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 07, 2021 at 05:33:38PM +0100, Valentin Schneider wrote:
> S390's init_idle_preempt_count(p, cpu) doesn't actually let us initialize the
> preempt_count of the requested CPU's idle task: it unconditionally writes
> to the current CPU's. This clearly conflicts with idle_threads_init(),
> which intends to initialize *all* the idle tasks, including their
> preempt_count (or their CPU's, if the arch uses a per-CPU preempt_count).
> 
> Unfortunately, it seems the way s390 does things doesn't let us initialize
> every possible CPU's preempt_count early on, as the pages where this
> resides are only allocated when a CPU is brought up and are freed when it
> is brought down.
> 
> Let the arch-specific code set a CPU's preempt_count when its lowcore is
> allocated, and turn init_idle_preempt_count() into an empty stub.
> 
> Fixes: f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

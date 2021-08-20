Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425B8C43216
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 22:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFF1601FE
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 22:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241013AbhHTWvV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 Aug 2021 18:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbhHTWvQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 Aug 2021 18:51:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF4C0617AE
        for <linux-s390@vger.kernel.org>; Fri, 20 Aug 2021 15:50:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j9-20020a2581490000b02905897d81c63fso11046886ybm.8
        for <linux-s390@vger.kernel.org>; Fri, 20 Aug 2021 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Ut0lClAqKM9RGqTS5MESEM+F5WoPZRTQUckNTBRjTyg=;
        b=TA/KEkzCm9eGIgSQhw9KNiaLFa6mERWpjzl8Sm2LP0D8MHshBELhR9PNTUHRE29ifz
         mo90lRoRaNLAOUKwpDqprlo0/pMwtc5l0/AtaGDQuwQPp72yFVvsNL3ynlMO5kSBRj5m
         LzAltW2EylkOxsEkvhRVhVSBOVOdYc11dmbjDqZ/XhKiygxbSFOOyUayIR4kGClbFLgR
         /kFKufJdXalO6BD5koMO2tBk/9JBu0VO4U4stsueIYQrrElmsEUFhO7RIz6hEZLybaDq
         KKumExIW2OSfE2RbrTkormhrvk3570q+R6kLizKIzC3ltGy9bDIK5NfDidM6k/fKRiu/
         zAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Ut0lClAqKM9RGqTS5MESEM+F5WoPZRTQUckNTBRjTyg=;
        b=Hv2IBFj6ZdfJFQkk6cktspcxRTgmgqRiZVXwkHBBzbjVYwF7n5DAxfQA7rM/dFjnkN
         vOWsA6VjFa9NMCoUhFrvL2QeMs/nQ/QtMd7nSYQo2JIdjsEgiDkCHEoBK3/mModdl5u7
         2zN9WDI6hiTgvQvmbg3AgFp8lgDm3quss9v962qdBHkF+kltACb8MLHGXoV9ZGH5azia
         cG6FfL1CakkB45SHr2SkOks+PaXzPwAkfuZouajcmKQKWWX8W50KnfJ9Dq7hocbZolGa
         Y454YQ56kOK0Gp9wFYsftZ/iRS4gBhGs/i/CUWY5slOTfvRT94ZnvgReCNKhHYJgBVha
         Bw7w==
X-Gm-Message-State: AOAM5313Mgn8zF2g/Xd9nbo5+RUQvHqQjUsqQjC18b0RHwlS/b7jjRbH
        o9/EUEF3Dnfzw/eXZ1RF8hxau+qb5RU=
X-Google-Smtp-Source: ABdhPJx3Gy465odAHrKuwh+xxU3EOcrY9EoPkXADk8KHQbivIS4NsZANbgwhJ1nQlBB3M+0Hs3NCAAyvqg4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:f11d:a281:af9b:5de6])
 (user=seanjc job=sendgmr) by 2002:a25:acc4:: with SMTP id x4mr8790476ybd.376.1629499835531;
 Fri, 20 Aug 2021 15:50:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 20 Aug 2021 15:50:02 -0700
In-Reply-To: <20210820225002.310652-1-seanjc@google.com>
Message-Id: <20210820225002.310652-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210820225002.310652-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 5/5] KVM: selftests: Remove __NR_userfaultfd syscall fallback
From:   Sean Christopherson <seanjc@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Revert the __NR_userfaultfd syscall fallback added for KVM selftests now
that x86's unistd_{32,63}.h overrides are under uapi/ and thus not in
KVM sefltests' search path, i.e. now that KVM gets x86 syscall numbers
from the installed kernel headers.

No functional change intended.

Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/arch/x86/include/uapi/asm/unistd_64.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index 4205ed4158bf..cb52a3a8b8fc 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -1,7 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __NR_userfaultfd
-#define __NR_userfaultfd 282
-#endif
 #ifndef __NR_perf_event_open
 # define __NR_perf_event_open 298
 #endif
-- 
2.33.0.rc2.250.ged5fa647cd-goog


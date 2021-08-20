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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2FBC00143
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 22:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380EC610FF
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 22:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbhHTWvL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 Aug 2021 18:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhHTWvK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 Aug 2021 18:51:10 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9094C061760
        for <linux-s390@vger.kernel.org>; Fri, 20 Aug 2021 15:50:31 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id x19-20020a05620a099300b003f64d79cbbaso1758181qkx.7
        for <linux-s390@vger.kernel.org>; Fri, 20 Aug 2021 15:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=I/xOfL043wSWIjKBt5HEcjocrLFqM7QFZBSdMiXJO5I=;
        b=M3kumjeMVm4eYjRmGUO/zlfNkMo/9WsvowPCfp+9Abh1lIA5cu2tJl3skXJ/c/DpNR
         DLaw0wylFTflUtaBDHF3r8l7A76rdGodfuy8Xw4K2Xaz3gqIPcTyNFWKlYle9HWjHKGq
         qU3WbdHt/DBXmgLXabDaUFuqIQYx2gN5h7frBxsWiYmFdafmGsqF2epkbsV/DTDNzjzg
         PCJTz+nVi+FBxX5K3c+PMjIS5Pxl13qw5qxXA6951o10atA6WmUd5KSBBUoWmQdqTUG8
         8FvYZ0DNWMFeNHDNeMBE9g+GRNrPryzsmQCKYDRVSsmTYkEKei9vpwFi3kpWR9Pluy7M
         t7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=I/xOfL043wSWIjKBt5HEcjocrLFqM7QFZBSdMiXJO5I=;
        b=X57nPqlEWM55s86vkg8G3/w5tRvhAfPOT6lnj13wgNsAlKPC0RaTYyBZN/5Dfj9etx
         +3emtoyt+USesBkfE6ool1fxR0TkjlaJDx7cI7qhP/gwEFpqIGKMPd1dnKkeNhsA4zRX
         xiLMe09TvkKkwUETG55CXY+KeqS8rMXNLB0ri+V5uZ9e5YHPgcT4f1H/iwua0u6eHaGV
         jsyv04acIeNkZTlOAdKiP5dIvdmOFePtoQ3ngXiZWyu8q+J4UN1wfngrV8mm8lY+QD2Y
         oIwymaYP21TBIbCYnDDDJgXOQaVkYb5cJ5zAohfiyofjAaB7U3Lm8zS4C9+TWxrJ8mx/
         gEKQ==
X-Gm-Message-State: AOAM530Vya50qv/pOb2UdOQY68LdoaJ9pjbC8bf+a6BZbfeK2M9dOP0c
        pFQWfbmZerg5GGTVslZmRAR4pbqz8Ec=
X-Google-Smtp-Source: ABdhPJwPDeDEGSWBZzPAgrzEB3/9Tm6acMQwHqWt26WElPNAfJ7mDGPZ+5pXO64WxmSA3x2M0eH0pY71OXc=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:f11d:a281:af9b:5de6])
 (user=seanjc job=sendgmr) by 2002:a05:6214:728:: with SMTP id
 c8mr22408148qvz.53.1629499830911; Fri, 20 Aug 2021 15:50:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 20 Aug 2021 15:50:00 -0700
In-Reply-To: <20210820225002.310652-1-seanjc@google.com>
Message-Id: <20210820225002.310652-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210820225002.310652-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 3/5] tools: Move x86 syscall number fallbacks to .../uapi/
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

Move unistd_{32,64}.h from x86/include/asm to x86/include/uapi/asm so
that tools/selftests that install kernel headers, e.g. KVM selftests, can
include non-uapi tools headers, e.g. to get 'struct list_head', without
effectively overriding the installed non-tool uapi headers.

Swapping KVM's search order, e.g. to search the kernel headers before
tool headers, is not a viable option as doing results in linux/type.h and
other core headers getting pulled from the kernel headers, which do not
have the kernel-internal typedefs that are used through tools, including
many files outside of selftests/kvm's control.

Prior to commit cec07f53c398 ("perf tools: Move syscall number fallbacks
from perf-sys.h to tools/arch/x86/include/asm/"), the handcoded numbers
were actual fallbacks, i.e. overriding unistd_{32,64}.h from the kernel
headers was unintentional.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/arch/x86/include/{ => uapi}/asm/unistd_32.h | 0
 tools/arch/x86/include/{ => uapi}/asm/unistd_64.h | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename tools/arch/x86/include/{ => uapi}/asm/unistd_32.h (100%)
 rename tools/arch/x86/include/{ => uapi}/asm/unistd_64.h (100%)

diff --git a/tools/arch/x86/include/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
similarity index 100%
rename from tools/arch/x86/include/asm/unistd_32.h
rename to tools/arch/x86/include/uapi/asm/unistd_32.h
diff --git a/tools/arch/x86/include/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
similarity index 100%
rename from tools/arch/x86/include/asm/unistd_64.h
rename to tools/arch/x86/include/uapi/asm/unistd_64.h
-- 
2.33.0.rc2.250.ged5fa647cd-goog


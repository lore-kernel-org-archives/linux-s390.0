Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EEEC433ED
	for <linux-s390@archiver.kernel.org>; Fri, 23 Apr 2021 18:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F25A61261
	for <linux-s390@archiver.kernel.org>; Fri, 23 Apr 2021 18:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243633AbhDWSSL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Apr 2021 14:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbhDWSSI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Apr 2021 14:18:08 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AEFC06138D
        for <linux-s390@vger.kernel.org>; Fri, 23 Apr 2021 11:17:31 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id cu23-20020a17090afa97b0290152471ab665so4370963pjb.8
        for <linux-s390@vger.kernel.org>; Fri, 23 Apr 2021 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jZ9aELeTtebSkfbpomfAFciujOueU+/1u2IVpj9kO9Q=;
        b=RyBxs7miM4jdCQ3yugSc8OvrTlv5u+dF3p+Ra7seVMrj1RVtjB+pFXakJoRIl1jsLS
         4JBtMKLiNnj9NnUNB9BsPmg2GgDdmytyBuu/qlKens774np+kb3bnNCuXir7AcEhlc1/
         MMqfYw4RQYaFjE94XkSwKSrhOxKcqkWzlvWkJUaoPIQajn3YTSQmT7PSjqoq+mzFElwD
         Nmi2pZp5/s1xwbLuQYIu7SednNnDgqlgHAbjSb3Ng+chogeOuRdzvwODmr0TjSFEqRbh
         /2xlGDh8qLD5AOsfQQHMcbZvPA7WcxPJHgBTYDJjHZfxvE6utLgsp5D6rJBK8yPps95G
         xQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jZ9aELeTtebSkfbpomfAFciujOueU+/1u2IVpj9kO9Q=;
        b=h0wbra842uZaJ9648fZSmiX3AhcfcgU2AodH/RZjd1/cGjuyrzAbqSvqtpiBe7MatJ
         ceUPql59OTV+3pa7HE1FzrZA4f/e0IqpiVg9iM/ncj2lvEUeq9rJA+UxBEdRIbAZ0XgW
         Ki/d1iSr0LLnGP9VyvmUwfIRNPWSkINBEnuSQ2QAQPLnRTcf2TVblw4AGhv/Jud192yU
         Cgl+1o3VtYR4S6CeiRhh5UaIhQ607Zr8rlAe2AQJQvVlEV5UsBTlxXasvBRRuzI484hI
         I7AeGDtNfciCtpp9nGQL/y1NzQRMheODn9yYhaRwg0lvoYUQfBf9SxDHhP2lsqmhUQWc
         RnXA==
X-Gm-Message-State: AOAM533vxVeVTdYnR/fMcAckU/A3gqwf6mL0/jNV0OSHHa7EOg+VJD2Z
        3lGueVRxRYOii4EQnSfpexMLVsOh/XfQ/pL1Rw==
X-Google-Smtp-Source: ABdhPJybLPMWN/SpAe3p+WeheeiGCmvt6zlmflTWrm4w6vD8liP2VaphrDYff46dFN5dJ0IrExvz0uL99CbVXXMV7Q==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a17:90b:e98:: with SMTP id
 fv24mr1049588pjb.1.1619201850403; Fri, 23 Apr 2021 11:17:30 -0700 (PDT)
Date:   Fri, 23 Apr 2021 18:17:23 +0000
Message-Id: <20210423181727.596466-1-jingzhangos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v3 0/4] KVM statistics data fd-based binary interface
From:   Jing Zhang <jingzhangos@google.com>
To:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This patchset provides a file descriptor for every VM and VCPU to read
KVM statistics data in binary format.
It is meant to provide a lightweight, flexible, scalable and efficient
lock-free solution for user space telemetry applications to pull the
statistics data periodically for large scale systems. The pulling
frequency could be as high as a few times per second.
In this patchset, every statistics data are treated to have some
attributes as below:
  * architecture dependent or common
  * VM statistics data or VCPU statistics data
  * type: cumulative, instantaneous,
  * unit: none for simple counter, nanosecond, microsecond,
    millisecond, second, Byte, KiByte, MiByte, GiByte. Clock Cycles
Since no lock/synchronization is used, the consistency between all
the statistics data is not guaranteed. That means not all statistics
data are read out at the exact same time, since the statistics date
are still being updated by KVM subsystems while they are read out.

---

* v2 -> v3
  - Rebase to kvm/queue, commit edf408f5257b ("KVM: avoid "deadlock" between
    install_new_memslots and MMU notifier")
  - Resolve some nitpicks about format

* v1 -> v2
  - Use ARRAY_SIZE to count the number of stats descriptors
  - Fix missing `size` field initialization in macro STATS_DESC

[1] https://lore.kernel.org/kvm/20210402224359.2297157-1-jingzhangos@google.com
[2] https://lore.kernel.org/kvm/20210415151741.1607806-1-jingzhangos@google.com

---

Jing Zhang (4):
  KVM: stats: Separate common stats from architecture specific ones
  KVM: stats: Add fd-based API to read binary stats data
  KVM: stats: Add documentation for statistics data binary interface
  KVM: selftests: Add selftest for KVM statistics data binary interface

 Documentation/virt/kvm/api.rst                | 171 ++++++++
 arch/arm64/include/asm/kvm_host.h             |   9 +-
 arch/arm64/kvm/guest.c                        |  42 +-
 arch/mips/include/asm/kvm_host.h              |   9 +-
 arch/mips/kvm/mips.c                          |  67 +++-
 arch/powerpc/include/asm/kvm_host.h           |   9 +-
 arch/powerpc/kvm/book3s.c                     |  68 +++-
 arch/powerpc/kvm/book3s_hv.c                  |  12 +-
 arch/powerpc/kvm/book3s_pr.c                  |   2 +-
 arch/powerpc/kvm/book3s_pr_papr.c             |   2 +-
 arch/powerpc/kvm/booke.c                      |  63 ++-
 arch/s390/include/asm/kvm_host.h              |   9 +-
 arch/s390/kvm/kvm-s390.c                      | 133 ++++++-
 arch/x86/include/asm/kvm_host.h               |   9 +-
 arch/x86/kvm/x86.c                            |  71 +++-
 include/linux/kvm_host.h                      | 132 ++++++-
 include/linux/kvm_types.h                     |  12 +
 include/uapi/linux/kvm.h                      |  50 +++
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/kvm_bin_form_stats.c        | 370 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  11 +
 virt/kvm/kvm_main.c                           | 237 ++++++++++-
 24 files changed, 1405 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/kvm_bin_form_stats.c


base-commit: edf408f5257ba39e63781b820528e1ce1ec0f543
-- 
2.31.1.498.g6c1eba8ee3d-goog


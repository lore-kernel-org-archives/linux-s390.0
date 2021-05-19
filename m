Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E756C433ED
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 20:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018AA611BD
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 20:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhESUDP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 19 May 2021 16:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232496AbhESUDO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 May 2021 16:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621454514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oqR82qYZ5cHPW+jMmb6LKw1zBxDgfEa0K+Sm55MnPRw=;
        b=EPf+1bHeNhuGn0Rrr6sUg9QfQAd3pj66II1RbGEWOtigcjPVeLdlvnzLgdbZ4Y3Ml5/UY+
        JV4+aRg24ZyBhNCJp+s2XFZ1vidOVJ/5Fg0FSke4zSpY4N3zWQdfhJSfd69xWB+3HO+5KU
        EsCQ+Uui8eWob2LecfwVc6NOTIvYi0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-6OHx4A6KP1SdsuldedHntQ-1; Wed, 19 May 2021 16:01:50 -0400
X-MC-Unique: 6OHx4A6KP1SdsuldedHntQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65013107AFA7;
        Wed, 19 May 2021 20:01:48 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7788D60BF1;
        Wed, 19 May 2021 20:01:44 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v4 0/3] audit: add support for openat2
Date:   Wed, 19 May 2021 16:00:19 -0400
Message-Id: <cover.1621363275.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The openat2(2) syscall was added in v5.6.  Add support for openat2 to the
audit syscall classifier and for recording openat2 parameters that cannot
be captured in the syscall parameters of the SYSCALL record.

Supporting userspace code can be found in
https://github.com/rgbriggs/audit-userspace/tree/ghau-openat2

Supporting test case can be found in
https://github.com/linux-audit/audit-testsuite/pull/103

Changelog:
v4:
- change filename include/linux/auditscm.h to auditsc_classmacros.h to avoid socket association

v3:
- re-add commit descriptions that somehow got dropped
- add new file to MAINTAINERS

v2:
- add include/linux/auditscm.h for audit syscall class macros due to syscall redefinition warnings:
        arch/x86/ia32/audit.c:3:
        ./include/linux/audit.h:12,
        ./include/linux/sched.h:22,
        ./include/linux/seccomp.h:21,
        ./arch/x86/include/asm/seccomp.h:5,
        ./arch/x86/include/asm/unistd.h:20,
        ./arch/x86/include/generated/uapi/asm/unistd_64.h:4: warning: "__NR_read" redefined #define __NR_read 0
	...
        ./arch/x86/include/generated/uapi/asm/unistd_64.h:338: warning: "__NR_rseq" redefined #define __NR_rseq 334
    previous:
        arch/x86/ia32/audit.c:2:
        ./arch/x86/include/generated/uapi/asm/unistd_32.h:7: note: this is the location of the previous definition #define __NR_read 3                                                                                                      
	...
        ./arch/x86/include/generated/uapi/asm/unistd_32.h:386: note: this is the location of the previous definition #define __NR_rseq 386

Richard Guy Briggs (3):
  audit: replace magic audit syscall class numbers with macros
  audit: add support for the openat2 syscall
  audit: add OPENAT2 record to list how

 MAINTAINERS                         |  1 +
 arch/alpha/kernel/audit.c           | 10 ++++++----
 arch/ia64/kernel/audit.c            | 10 ++++++----
 arch/parisc/kernel/audit.c          | 10 ++++++----
 arch/parisc/kernel/compat_audit.c   | 11 ++++++----
 arch/powerpc/kernel/audit.c         | 12 ++++++-----
 arch/powerpc/kernel/compat_audit.c  | 13 +++++++-----
 arch/s390/kernel/audit.c            | 12 ++++++-----
 arch/s390/kernel/compat_audit.c     | 13 +++++++-----
 arch/sparc/kernel/audit.c           | 12 ++++++-----
 arch/sparc/kernel/compat_audit.c    | 13 +++++++-----
 arch/x86/ia32/audit.c               | 13 +++++++-----
 arch/x86/kernel/audit_64.c          | 10 ++++++----
 fs/open.c                           |  2 ++
 include/linux/audit.h               | 11 ++++++++++
 include/linux/auditsc_classmacros.h | 24 ++++++++++++++++++++++
 include/uapi/linux/audit.h          |  1 +
 kernel/audit.h                      |  2 ++
 kernel/auditsc.c                    | 31 +++++++++++++++++++++++------
 lib/audit.c                         | 14 ++++++++-----
 lib/compat_audit.c                  | 15 +++++++++-----
 21 files changed, 169 insertions(+), 71 deletions(-)
 create mode 100644 include/linux/auditsc_classmacros.h

-- 
2.27.0


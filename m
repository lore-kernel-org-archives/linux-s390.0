Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5ACECAAD3
	for <linux-s390@archiver.kernel.org>; Fri,  9 Sep 2022 07:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIIHs4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 9 Sep 2022 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiIIHsU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Sep 2022 03:48:20 -0400
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9C411A0E
        for <linux-s390@vger.kernel.org>; Fri,  9 Sep 2022 00:44:27 -0700 (PDT)
Received: by mail-ej1-f74.google.com with SMTP id o18-20020a170906975200b007747bc763d8so572720ejy.23
        for <linux-s390@vger.kernel.org>; Fri, 09 Sep 2022 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=ZgjuXiR7GOoWQwHIqm/Zq+w7cYIxur6W3viv+dY7RH8=;
        b=j+UIMYBTztIdEddAyQiLGMbyZseB1O22pSgIKiq3dObuMbk/LL18hQYw2XnwhChEno
         njdoU+3QMR7gbmgwGyVpo44ABifiMAXrO2NcXAV20tvaK2to9ta9VgLe7oqbevNVn+My
         CY1IKSTmC7bwqSToFhdGidMuTizf0IuFctMiiQ22E0ixlDDbZuVt102UdCmuTQUeDRA1
         naSl15bd2TUlgku+q5RdYvuyrx7QEZPOGsl+hbf2M6OGLfZUQW6IlzJV9y38f0cRr33g
         JcMkGIiKLKS00KTmIczkcO+n7iSbzJfAOyzGap2cwppwbotjo7CBfOlAK5w52TOPfKwb
         MWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ZgjuXiR7GOoWQwHIqm/Zq+w7cYIxur6W3viv+dY7RH8=;
        b=wQLespByfFNtTwPTzo36QF3vs+wG3OGzUhP2iRmFpKEYN9gCnfR0sKTfG3ulxgp4o3
         u5cemVw/ArY+nKMaHbG+M6U0kIs7jxm1/mox4Pf3bUPbwtdWzSe0DU+7g3ebASiRZ2I1
         HLgiOQEp18bo5qPxFZUA7/baw5Pt+uVyJv/WJl/JXNXtaxAz+y77R5jpvO5oMTnDMR5V
         pO/UynMNO1tPGm+OQ/Xj9YMxIZKgMm27QLBUlujklSIH95k0xzDLz/94ivuS3WQruOPA
         bTi1cuP+Bu8B9XjihY1O0MzUa2+W9vmWoW1S2bOeB923KSmkJ9qXWfcLZzHuyd4o5B50
         DQKQ==
X-Gm-Message-State: ACgBeo2tZD7qcudF5nQZtiqZlvLA1poN42mi4vz3A/J4cEBqoaujOUS3
        m/Oh030PTnCYY8AAe3RjnEemjR6xNg==
X-Google-Smtp-Source: AA6agR72lEybpcVa7cBjPW4pKXFE8r3tYkQb5/NC95gOTISnGkgRwU/Efuez6zfWhM70OFPhqME9JBdrGw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:1d1e:ddcd:2020:36c2])
 (user=elver job=sendgmr) by 2002:a05:6402:27cd:b0:44e:c4aa:5ff with SMTP id
 c13-20020a05640227cd00b0044ec4aa05ffmr10390086ede.193.1662709131149; Fri, 09
 Sep 2022 00:38:51 -0700 (PDT)
Date:   Fri,  9 Sep 2022 09:38:38 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220909073840.45349-1-elver@google.com>
Subject: [PATCH v2 1/3] s390: Always declare __mem functions
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Like other architectures, always declare __mem*() functions if the
architecture defines __HAVE_ARCH_MEM*.

For example, this is required by sanitizer runtimes to unambiguously
refer to the arch versions of the mem-functions, and the compiler not
attempting any "optimizations" such as replacing the calls with builtins
(which may later be inlined etc.).

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch.
---
 arch/s390/include/asm/string.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/string.h b/arch/s390/include/asm/string.h
index 3fae93ddb322..2c3c48d526b9 100644
--- a/arch/s390/include/asm/string.h
+++ b/arch/s390/include/asm/string.h
@@ -20,8 +20,11 @@
 #define __HAVE_ARCH_MEMSET64	/* arch function */
 
 void *memcpy(void *dest, const void *src, size_t n);
+void *__memcpy(void *dest, const void *src, size_t n);
 void *memset(void *s, int c, size_t n);
+void *__memset(void *s, int c, size_t n);
 void *memmove(void *dest, const void *src, size_t n);
+void *__memmove(void *dest, const void *src, size_t n);
 
 #ifndef CONFIG_KASAN
 #define __HAVE_ARCH_MEMCHR	/* inline & arch function */
@@ -55,10 +58,6 @@ char *strstr(const char *s1, const char *s2);
 
 #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
 
-extern void *__memcpy(void *dest, const void *src, size_t n);
-extern void *__memset(void *s, int c, size_t n);
-extern void *__memmove(void *dest, const void *src, size_t n);
-
 /*
  * For files that are not instrumented (e.g. mm/slub.c) we
  * should use not instrumented version of mem* functions.
-- 
2.37.2.789.g6183377224-goog


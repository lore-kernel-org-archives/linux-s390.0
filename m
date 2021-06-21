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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C673DC49EA2
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 23:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB5161245
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 23:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhFUXVQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhFUXVM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Jun 2021 19:21:12 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FA3C061787
        for <linux-s390@vger.kernel.org>; Mon, 21 Jun 2021 16:18:57 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 2-20020a3709020000b02903aa9873df32so15824203qkj.15
        for <linux-s390@vger.kernel.org>; Mon, 21 Jun 2021 16:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rjB5gl/OyQ1mYdw8idF1qN2FUIQyyWYhNBNVDiw+uvU=;
        b=Fx/5r3tL8gCFAJtd4rl2DAmVtq/Hcag/FqOXfbZTiumpQvK7IpCiwSoO4s2r3Pg4kG
         DjgqzwZbw38zdRoLWEIFqajlU0HyzgooEI43aq0nXoB3xcXQkKM3CW4mob90gDiP9WK2
         hHrDsQKAVpOhYF9U5V1S3QpzKlSx5rhNkESwPwwewApEl53L6IrVLx7uL19uIuHFuiOo
         6lolqnl8of8SHB6qJI16xb6wkcrAAnCL9U5ewHgz0C+f0vibak7dCVxmIJY/mPLRKbjo
         OXIV6b2Ew6sgl0PP+wDqL797jk1u3lvn2QWTbcBZRMFj+LYkj51nlwS6pHOjBj5NB8Kb
         CkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rjB5gl/OyQ1mYdw8idF1qN2FUIQyyWYhNBNVDiw+uvU=;
        b=On/+bP09Vg/nLgs6IQXHZLrCFdk4JOjNy0mvGspxYjo5fRXK9GPxP6eyzfsDqdEDgh
         C6K2nqhCtVrSGljg/27/ZRqK18/B3vHSVvVE7OZ9LtSXOypAtIKMASwqBzvvE8i9cI4R
         CNzWeG6+s/Y5719l16BOHHvh3jc/M9TDleboSoKSqbnb+BK1+1WY9BJtbIjUuII+JKdt
         3Wx/4adjxHLK02EC9QXhMfjmaOW8tpA+Q1/K+ipF15FBZ/u6PjhtIt2+yoRx90gH1bpJ
         T4LUriJNTDzkyWgbUvH6PQO0ro/un/Sqf4sFY/l+V2WBLlb5fV0sFfLb5B5rrg5d9NOc
         Jd2g==
X-Gm-Message-State: AOAM533D1aMUYs38eugbrMlrvHDMO3abJUkZyJ8BYIXL+Q1YvQ1a33Wj
        IQoNQOXczHMNFYwX/YdQYmBwE0kCvKZTWiVjJBE=
X-Google-Smtp-Source: ABdhPJyXTOipiZC/T1Rh2LGkpucm8jFtJ6//dT3xhNEPf1PixdbviPLfrtW8WqYG2ren4BZlrLSA6JcmNbcRdaRhqhk=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:dfd:ebf9:4ec7:1783])
 (user=ndesaulniers job=sendgmr) by 2002:a25:aea4:: with SMTP id
 b36mr794382ybj.428.1624317536807; Mon, 21 Jun 2021 16:18:56 -0700 (PDT)
Date:   Mon, 21 Jun 2021 16:18:21 -0700
In-Reply-To: <20210621231822.2848305-1-ndesaulniers@google.com>
Message-Id: <20210621231822.2848305-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210621231822.2848305-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v2 2/3] compiler_attributes.h: cleanups for GCC 4.9+
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Bill Wendling <wcw@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Martin Liska <mliska@suse.cz>, Marco Elver <elver@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Fangrui Song <maskray@google.com>, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        johannes.berg@intel.com, linux-toolchains@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Since
commit 6ec4476ac825 ("Raise gcc version requirement to 4.9")
we no longer support building the kernel with GCC 4.8; drop the
preprocess checks for __GNUC_MINOR__ version. It's implied that if
__GNUC_MAJOR__ is 4, then the only supported version of __GNUC_MINOR__
left is 9.

Cc: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler_attributes.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 225511b17223..84b1c970acb3 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -27,7 +27,7 @@
  */
 #ifndef __has_attribute
 # define __has_attribute(x) __GCC4_has_attribute_##x
-# define __GCC4_has_attribute___assume_aligned__      (__GNUC_MINOR__ >= 9)
+# define __GCC4_has_attribute___assume_aligned__      1
 # define __GCC4_has_attribute___copy__                0
 # define __GCC4_has_attribute___designated_init__     0
 # define __GCC4_has_attribute___externally_visible__  1
@@ -35,8 +35,8 @@
 # define __GCC4_has_attribute___noclone__             1
 # define __GCC4_has_attribute___no_profile_instrument_function__ 0
 # define __GCC4_has_attribute___nonstring__           0
-# define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
-# define __GCC4_has_attribute___no_sanitize_undefined__ (__GNUC_MINOR__ >= 9)
+# define __GCC4_has_attribute___no_sanitize_address__ 1
+# define __GCC4_has_attribute___no_sanitize_undefined__ 1
 # define __GCC4_has_attribute___fallthrough__         0
 #endif
 
-- 
2.32.0.288.g62a8d224e6-goog


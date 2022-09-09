Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A082ECAAA1
	for <linux-s390@archiver.kernel.org>; Fri,  9 Sep 2022 07:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiIIHs5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 9 Sep 2022 03:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiIIHsb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Sep 2022 03:48:31 -0400
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ABC1277F
        for <linux-s390@vger.kernel.org>; Fri,  9 Sep 2022 00:44:27 -0700 (PDT)
Received: by mail-ed1-f73.google.com with SMTP id s17-20020a056402521100b004511c8d59e3so192636edd.11
        for <linux-s390@vger.kernel.org>; Fri, 09 Sep 2022 00:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=Sukv368ybnyGEDYWzkXqyAnNVv6jo8OLy5FNfbPUdMM=;
        b=ktFLEBNoqWRWObHClbSd+xRmqYvoRP5s7bLvDdfwvktoIRphaCmNmyKmEO/oMcNTLa
         WnpnwFGujucx+4vgMOUIJl8O7pvj70JRkdhu7xb2Yvk3xyIBFZKHOiqwbrt/qOA2BkOM
         Y6S9sO/IHWcAR+cGowS4woP+B7UiiDDUvnJbE7QZJQOcMxabUJRUExiVwVLvQ5g3coI6
         RXh5mhIqw3nJ7mmt8vNYOb/+hEh6xdo0K0/sSaM9PMFJw7l8RteJK3yBKVmmx7CzX/2i
         zyXGigoAR6gmoY1w4oayrAGDU8zN4InMJzmqBvI2Lm5y6IIH89960NoG7piKM/fT1Hu4
         JDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=Sukv368ybnyGEDYWzkXqyAnNVv6jo8OLy5FNfbPUdMM=;
        b=mxl0yyr6t8pfNbAGScBAnsSZueG0bOYPW3k0ZVTQhFG7hIA9KCt5TyfPXcsTQnul1Y
         XmYM+56kubmmhb0T3esC6nSzUvULk6UeOMkNBS+NcspnqGVv3YRNzd80w+k5NRX3a941
         wGqnPIb+ED7gwCdjst3YgqNXnbDSymfjwfjXKlRUo9icPdQC/SNnxsruPXFTG7Cks/lI
         /9qYwi6z29kf/ZrrF6f1T0tWnQP27q7sEKmcSS7atfdyZB9laLD1qBXyTnGIQGFE+zu4
         O9HWzp6firsAQV64uGR/YnFCLNB3y+DN47zBOTQ4Ze2ziL7jgUnyzetm2U3qweNppRD6
         P+nA==
X-Gm-Message-State: ACgBeo1pvCrt7YgZ9I94Apc/ZLCDteeAYzrFHgd6qulr6BNCslLKhzws
        PsP4p830/mu2B23oJDb1A3+IsfvA+Q==
X-Google-Smtp-Source: AA6agR5rZ0SNiJLzG65aHEI8QPNYNkzDeSiGkJ4eXG6mWebhV8vDZYhMeNLLUHHNjKvwSPd7hEMfMKStTw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:1d1e:ddcd:2020:36c2])
 (user=elver job=sendgmr) by 2002:a05:6402:c8a:b0:44e:81b3:4b7e with SMTP id
 cm10-20020a0564020c8a00b0044e81b34b7emr10294408edb.181.1662709136924; Fri, 09
 Sep 2022 00:38:56 -0700 (PDT)
Date:   Fri,  9 Sep 2022 09:38:40 +0200
In-Reply-To: <20220909073840.45349-1-elver@google.com>
Mime-Version: 1.0
References: <20220909073840.45349-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220909073840.45349-3-elver@google.com>
Subject: [PATCH v2 3/3] objtool, kcsan: Add volatile read/write
 instrumentation to whitelist
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

Adds KCSAN's volatile instrumentation to objtool's uaccess whitelist.

Recent kernel change have shown that this was missing from the uaccess
whitelist (since the first upstreamed version of KCSAN):

  mm/gup.o: warning: objtool: fault_in_readable+0x101: call to __tsan_volatile_write1() with UACCESS enabled

Fixes: 75d75b7a4d54 ("kcsan: Support distinguishing volatile accesses")
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Fix commit message.
---
 tools/objtool/check.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e55fdf952a3a..67afdce3421f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -999,6 +999,16 @@ static const char *uaccess_safe_builtin[] = {
 	"__tsan_read_write4",
 	"__tsan_read_write8",
 	"__tsan_read_write16",
+	"__tsan_volatile_read1",
+	"__tsan_volatile_read2",
+	"__tsan_volatile_read4",
+	"__tsan_volatile_read8",
+	"__tsan_volatile_read16",
+	"__tsan_volatile_write1",
+	"__tsan_volatile_write2",
+	"__tsan_volatile_write4",
+	"__tsan_volatile_write8",
+	"__tsan_volatile_write16",
 	"__tsan_atomic8_load",
 	"__tsan_atomic16_load",
 	"__tsan_atomic32_load",
-- 
2.37.2.789.g6183377224-goog


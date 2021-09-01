Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B449C43216
	for <linux-s390@archiver.kernel.org>; Wed,  1 Sep 2021 23:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1AC561026
	for <linux-s390@archiver.kernel.org>; Wed,  1 Sep 2021 23:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhIAXi6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 1 Sep 2021 19:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237583AbhIAXi6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Sep 2021 19:38:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D207DC061764
        for <linux-s390@vger.kernel.org>; Wed,  1 Sep 2021 16:38:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r2so14930pgl.10
        for <linux-s390@vger.kernel.org>; Wed, 01 Sep 2021 16:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RxdL+VgiEITm77P72mXqj1juue9pFyRDnlJ226qSqOk=;
        b=Jbl9R7AetfXUtlTSqQfQeMt5goiVd9fYlyH88ROwH+bq+V9EQVo5UoZSeOShvsQISz
         Sg+XZ7RNLdgSBf4shb2MQTL3sGq9ldrNVXHbq8vqnOSst5D39rfjszhKkU18XZ5z/OiV
         2f+YgNBt7eBWEDcDexEYe+vyafUeY4b0a5m4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RxdL+VgiEITm77P72mXqj1juue9pFyRDnlJ226qSqOk=;
        b=XvRo1dq3wKs4JFutRkhysSgRlLTnxrudTTRATuuvbBqQmsRdlb6bYHEGaP22bM8dLL
         loCRdVIznrOFOdcKHlDWFP18hqJ5BI+98s6muVzxJCzPSFyw0K+s0/T5ke/zGmXaBQAi
         S/Dp+RSPLAsYFx/wTN8tE6k4wy4rsO2luV+fXiLgqisqrUSafcU8L3Yq4ciNOfH60rsv
         W3i8vJ1ZrrWJvA2dIfcki0pKIvpAnlFj17YZkL366vzqogCoMZ43aMQqpE11omf2A3eR
         NqRei2zU3OYfHTIrtrYl8VR8K3/Q4A4d4m7W5b9ST1xViLNbIJwl7/pIbglOkMAKII6+
         jvrg==
X-Gm-Message-State: AOAM530HnFrKO34Zb7eRm1Uba9V65W6WxVPaWpp7JV1mG+NN1kRM6Y6/
        5ZD3yMRMaCZ9tbgn8WGKorVeUA==
X-Google-Smtp-Source: ABdhPJxT2cTby+PY8aMY7trtE+gYWoZMu+G6MSnOS/xdIcoJvz/BnEcjifQyuX5rHVbTHt9iSDGEFw==
X-Received: by 2002:a65:6785:: with SMTP id e5mr194762pgr.199.1630539480296;
        Wed, 01 Sep 2021 16:38:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4sm46709pgn.6.2021.09.01.16.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:37:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/4] vmlinux.lds.h: Split .static_call_sites from .static_call_tramp_key
Date:   Wed,  1 Sep 2021 16:37:55 -0700
Message-Id: <20210901233757.2571878-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901233757.2571878-1-keescook@chromium.org>
References: <20210901233757.2571878-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; h=from:subject; bh=56oU5NReCT+37O4WLHXZ85h0ziLuQWtTwnsC2nNGLJ8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhMA7UhoSvWtO81e3TFXafwBzjsYLbvYhWr+qC5Mo9 +YqFZyKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTAO1AAKCRCJcvTf3G3AJj4mEA CSolxL5P/inpJXqh5EZIzgbFYXSHCVgnhosBd2gSUUcJj7WSJTZKprQS8u0LuwbErkqEw5P+/6ipkW lbpyRwIuzRVbCO7ZTJ2QT8HJ60iBvotFZruzGxSlYjp6XW3UY2nJWh9jFgxVrfCaJzlTeptyUnGAbh vs8FwUxVjvMzUFi2cEHkul9wJRYM7qTO/YDcEPQ2Gzo9lakGbj+4Y66qRws7Zf9/3CLnT6vgtZ+ICT 644LxnGmKXWnWmnJPA6QoQfV6lxwa0NeaQOgK6FWb0g75fctrINKtL/+gbVtS6e87FiLJAfrzfMSNw P0f9NjntwVFyXAMnBtvaBX9QrDDICK/rdadtB1CyCEOd06U21nWvT4WuiN14nsEA/eNH5oDBiBEKLd zr9ZjasRAKRRH/haIyrdPs66nWV7JAaanN/fFIZzBg6t9Fe83MWvwlz2rvX4GGn6t85czeapWUKG8Z qGBamm9ADH6O55H4wXjtC+DYNY9Jy8ZnL4sLmQ2XfUt4+1SR5n56hy9By+AKUPnfZeWdRa3oHz+zF8 NwVOZciw3hwIXJKobG6aeuXF8HqFthU643Iqx/PvdZtEvHpCBIyffQDTpFf9hzd06dPdd+OqvtLXIz 3EztP6U/BTUINzzamAGRcchHXQ1fwVh197yy0Qsx6Hj3L9Fq+USBuVbQtqnA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

These two sections are ro_after_init and .rodata respectively. While
they will ultimately become read-only, there's no reason to confuse
their macro names.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 70c74fdf9c9b..4781a8154254 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -396,17 +396,22 @@
 	. = __start_init_task + THREAD_SIZE;				\
 	__end_init_task = .;
 
+/* Sorted during __init. */
 #define JUMP_TABLE_RO_AFTER_INIT_DATA					\
 	. = ALIGN(8);							\
 	__start___jump_table = .;					\
 	KEEP(*(__jump_table))						\
 	__stop___jump_table = .;
 
+/* Sorted during __init. */
 #define STATIC_CALL_RO_AFTER_INIT_DATA					\
 	. = ALIGN(8);							\
 	__start_static_call_sites = .;					\
 	KEEP(*(.static_call_sites))					\
 	__stop_static_call_sites = .;					\
+
+#define STATIC_CALL_RODATA						\
+	. = ALIGN(8);							\
 	__start_static_call_tramp_key = .;				\
 	KEEP(*(.static_call_tramp_key))					\
 	__stop_static_call_tramp_key = .;
@@ -434,6 +439,7 @@
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
 		SCHED_RODATA						\
+		STATIC_CALL_RODATA					\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
 		__start___tracepoints_ptrs = .;				\
-- 
2.30.2


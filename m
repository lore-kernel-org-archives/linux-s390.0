Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5133C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 17 Nov 2021 17:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5C261BA2
	for <linux-s390@archiver.kernel.org>; Wed, 17 Nov 2021 17:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbhKQRv0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Nov 2021 12:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbhKQRv0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 Nov 2021 12:51:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D39FC061570;
        Wed, 17 Nov 2021 09:48:27 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x15so14812605edv.1;
        Wed, 17 Nov 2021 09:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZjOXRFe4kBHeHpuMhDtkr/g9/szioJdpeaJnfZ4kbQ=;
        b=F8R+uJ3fc4fFkn5jwhW2fdO+lATwUDuRWeIjB0BW6ubv0DQtKO6LzirZrw4DhgBYGg
         2Z0baDB+gQctNSyPOOwgmm+V6+09YSTbwUFvmYssUJtz2EzYnwakqPvKb9IZm/o1wAgI
         n99CDdOwMSpu/5fa2uz1Vl08Wf79RFNQrF74q2Yr+BQ2pvD2VyaQ/q0vErB5tab8W6Ng
         RIbzWt3HFFeZBHhgtc18saTKKrmfaKk2qtGSZ8i/iEfePqSF135ZSjvae4ddlu17KC28
         3cAf5VowCXr60ydlI7vqY7IvMjOlsBABjG8kPK3piT/u+iGfoFjxOIqVnDFZQPuinDsg
         0DHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZjOXRFe4kBHeHpuMhDtkr/g9/szioJdpeaJnfZ4kbQ=;
        b=aDJqBpuk0UQ/DoiZTN7jr/3QP8rfx7I+fs8zZo8a7dfYNgWBnQ7QgUTaza33mBpE4I
         Weukk1on5jvDTitQYp5QN4m2uCSfTdalaRZnuCZSufTogpsZxrzngqwdwmjMovvOtpNr
         mKMIOazQ9KWtQQDZP41p/+3wijHCK8c1kY5vMUSK8k+lPqGd/g+Ey3cQZE+RTvoWF3P4
         4f+8Hj8pckkIdcWxVdy9n4gfrO7EBLOZJk5lDW8j6wp4OUK3wCX/wUcsLYzdLdW25AwL
         ycYr8H2Ditv5HROTT1mPuB1arY3QHg8h+W3tCLuP+8N+/TaSpQM/VRjOC55KuyDW8Fjg
         4G3Q==
X-Gm-Message-State: AOAM53205ACiteOx3ojNkksdNqIl5u9gUAH+Mkwe7ICiORm/SqKmH1k5
        EYPcEjrjWs6sGM3USYj1E01XfLwQs5XysQ==
X-Google-Smtp-Source: ABdhPJw+qL1QPzZ5AdE2opgq04rudnPWXFWVMorBLzCbct64V52ZFe3zXCWxuEt5RIeKDZAlTdSpHA==
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr762999edz.96.1637171306150;
        Wed, 17 Nov 2021 09:48:26 -0800 (PST)
Received: from localhost.localdomain ([82.78.89.185])
        by smtp.gmail.com with ESMTPSA id go10sm253902ejc.115.2021.11.17.09.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 09:48:25 -0800 (PST)
From:   Ilie Halip <ilie.halip@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Mete Durlu <meted@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] s390/test_unwind: use raw opcode instead of invalid instruction
Date:   Wed, 17 Nov 2021 19:48:21 +0200
Message-Id: <20211117174822.3632412-1-ilie.halip@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Building with clang & LLVM_IAS=1 leads to an error:
    arch/s390/lib/test_unwind.c:179:4: error: invalid register pair
                        "       mvcl    %%r1,%%r1\n"
                        ^

The test creates an invalid instruction that would trap at runtime, but the
LLVM inline assembler tries to validate it at compile time too.

Use the raw instruction opcode instead.

Link: https://github.com/ClangBuiltLinux/linux/issues/1421
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
---
 arch/s390/lib/test_unwind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index cfc5f5557c06..d342bc884b94 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -176,7 +176,7 @@ static noinline int unwindme_func4(struct unwindme *u)
 		 * trigger specification exception
 		 */
 		asm volatile(
-			"	mvcl	%%r1,%%r1\n"
+			"	.insn e,0x0e11\n"	/* mvcl	%%r1,%%r1" */
 			"0:	nopr	%%r7\n"
 			EX_TABLE(0b, 0b)
 			:);
-- 
2.25.1


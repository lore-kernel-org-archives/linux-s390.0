Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66182C433B4
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 04:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B7A60E08
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 04:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345098AbhEREcB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 May 2021 00:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbhEREcB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 May 2021 00:32:01 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70291C061573
        for <linux-s390@vger.kernel.org>; Mon, 17 May 2021 21:30:43 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id b25so8646634oic.0
        for <linux-s390@vger.kernel.org>; Mon, 17 May 2021 21:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=edTAC+VberfNzmpERBE9GVjs5mtrV8JaHhvqsq7uIFU=;
        b=dLuJJej8/uEvpBeGhA1/Y5GsGsMFYUb/0EpYi6VrxMEsPJDrwau71hC9S9lRuH1IOk
         dFhwzmE9tIkNpO72l4uL612FG4Zug54KwbTPgz1iX5iwvzU0aaPwt8xo8yuvf8IlA+pi
         tk1mxusnY/enJDT9/0PutctBU475awvAap+Q8hW6ondtgnBnBc/mVEwnGersCBtZUol7
         Bo9od8yNmsNzVmQka6iDvM8tXqB+RdmSMgiUBloAzxZyj3ccCXO7tLny+Hxb07+7Cjuc
         iH8rOphOk6OhoEoeRCXqHtiQndHa9BEtelnN/ZUinVzuJZ7P3hF9mEY7zXteIQ6OqUnu
         RnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=edTAC+VberfNzmpERBE9GVjs5mtrV8JaHhvqsq7uIFU=;
        b=CT2v82p15RN7bZiv/8RAXKx6N8qwVwTnutzQpAw62HTDFFkbUBgt+IeXC0+UfocBns
         6q+3+OA+aVIiIe9h1VBTxKrClGJ9XsmEg/5DKGtXzy9jcFC+Prr2OuqLf4Vjvn96QASu
         AP8HQqEO+AY4/B12uzG3e04A06jdiMBmiMTPi9bQ/gO1JMchEdH5Fc8SJfVY6FZItRra
         O30yqA3mQDGmGtFZEuPnF3GUNmV8Gm21Z9tghQ4zYrsa02Lq/pnfsF1UrNyq395lQjcF
         rRB8UxZxM1HsdLheuVMiBLALaNRtGJG/eKdhKi5XGQbGZ4VErRuMoMCdcg8MSpuVtDJF
         fe5w==
X-Gm-Message-State: AOAM532jSxdIqrVxzV35X20sgFhpImPgvOZ0wB7kU6KZUF32Ig61T3+Q
        lCcIH58/zU1ZqHLDr+xw/w2vgA==
X-Google-Smtp-Source: ABdhPJw3rg34jdvRBg7UfZMvjZh9ZVnoXPaRDW7+ClvXOuEC35VQdlhboR/aOy6EX77F75BWPpCMWw==
X-Received: by 2002:aca:c685:: with SMTP id w127mr1961677oif.89.1621312242855;
        Mon, 17 May 2021 21:30:42 -0700 (PDT)
Received: from [192.168.86.127] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id w66sm3492578ooa.37.2021.05.17.21.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 21:30:42 -0700 (PDT)
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Rob Landley <rob@landley.net>
Subject: [PATCH] Replace use of perl with sed and tr in s390x build.
Message-ID: <a48c51f8-5fe4-87e7-284e-c96e2381801a@landley.net>
Date:   Mon, 17 May 2021 23:46:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Rob Landley <rob@landley.net>

Commit 246218962e21 in November added a perl dependency to the s390x vmlinux
build, complicating the "countering trusting trust" build approach ala
http://lists.landley.net/pipermail/toybox-landley.net/2020-July/011898.html

Signed-off-by: Rob Landley <rob@landley.net>
---

 arch/s390/boot/compressed/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index de18dab518bb..e941b165bd4f 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -33,7 +33,7 @@ $(obj)/vmlinux.syms: $(obj)/vmlinux.lds $(objtree)/arch/s390/boot/startup.a $(OB
 
 quiet_cmd_dumpsyms = DUMPSYMS $<
 define cmd_dumpsyms
-	$(NM) -n -S --format=bsd "$<" | $(PERL) -ne '/(\w+)\s+(\w+)\s+[tT]\s+(\w+)/ and printf "%x %x %s\0",hex $$1,hex $$2,$$3' > "$@"
+	$(NM) -n -S --format=bsd "$<" | sed -nE 's/^0*([0-9a-fA-F]+) 0*([0-9a-fA-F]+) [tT] ([^ ]*)$$/\1 \2 \3/p' | tr '\n' '\0' > "$@"
 endef
 
 $(obj)/syms.bin: $(obj)/vmlinux.syms FORCE

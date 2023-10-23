Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA276C25B46
	for <linux-s390@archiver.kernel.org>; Mon, 23 Oct 2023 19:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjJWTPH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Oct 2023 15:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjJWTPA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 Oct 2023 15:15:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE93510F9
        for <linux-s390@vger.kernel.org>; Mon, 23 Oct 2023 12:14:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a8d9dcdd2bso71232797b3.2
        for <linux-s390@vger.kernel.org>; Mon, 23 Oct 2023 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698088491; x=1698693291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vxgSbbJcJ8k4AfzUm+i0fvFrr1WhMJ4/9BqOAlfxPD4=;
        b=EGJLS4hsyrKQrmApbhKMoMNFbjk3sO5dXvNP5c7TpkfiFksMlw7r+uChP8fI4UHJ18
         11VAlY81efoGiYa0RMS1Wnx7ox7ErfM6QJg3QUV9D872FLzkHdu5li4jjynaM4TOchqP
         7PdtufYAmBYGQV/SyE69P/aLSZnjfqj6rTcTPQV1CTLpY+ZrPS1bdzU6d4N6NsJj41Lz
         GTbzKpLWmdEradq+f5UNA1h8hPvLuMQRCBnzmXhlAqh1DaWhQHx8uvxdEZuF08CTVRp3
         zP1m6w4hOAG0xKj/T6riWeNtmWgpWST3vkLj/vDu5n6DR8JNWzml3CA+mX3z20UC6gER
         s9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698088491; x=1698693291;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vxgSbbJcJ8k4AfzUm+i0fvFrr1WhMJ4/9BqOAlfxPD4=;
        b=AzXC7WlpBflU5mToM5H1KZrDndCtCkh/FBV08q+ctOLPEPy/UHIrLVZ5dVCKQLdlE7
         5nyuvrtPge7KSgh0S4ux/30WTPv935jTEiJTv7udIDe3G3BC+hXLRKk3AdTgcGBNt9O6
         KkRBDhjwtdQzcvljWseQbdHYicz9amdmkjC+S7GgmfI6AcXpeY1o51jsU+c3zBBnWt75
         jIghJEXUyNwPIPGd/nvoOfbG3HUAq1KGVqezZQmBonUPhBG3zav52xck7+O2XWVES5YF
         gvCSHWNROuhI4kWL7sgMox6e5FR+pYFipy3O5lb9BnhLkWNDguaEAtN9OS50FscsHVJn
         Idlg==
X-Gm-Message-State: AOJu0Yx7G1lW9jtjKZRt6EQVYpl1qogfVF0NYnToSKkTKbsPWt/TWE0T
        QBqKN60QdXP5UBbGvYSjmQ3KvJS7B45EJw7NzA==
X-Google-Smtp-Source: AGHT+IFk2+a4Nwy+lDfofeMbQ00SIqXpTu6BSVqVMj6WMyiEKt+3HATCvTqDUHblwYDVOJKzh9KBN8QLmBbu9+PP0w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:4aa:b0:d9a:4421:6ec5 with
 SMTP id r10-20020a05690204aa00b00d9a44216ec5mr192426ybs.3.1698088491059; Mon,
 23 Oct 2023 12:14:51 -0700 (PDT)
Date:   Mon, 23 Oct 2023 19:14:49 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACjGNmUC/x2NQQqFMAwFryJZG9AKFb2KuKg1akBqSUT+R7y7w
 cUsBob3blASJoW+uEHoYuUjmdRlAXELaSXk2Rxc5ZraQD0lxfzHWfgiUdSmq9BSQY17xojT5L1 zPrQUAthMFlr4910M4/O877gOK3IAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698088489; l=1329;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=EGwnKAJDKIDhDdM+Wm5gicTjSyZs8Iw8n/yqjAF6sKU=; b=hXZYoncvcCMCdrJCj2u1tX/RyKLEry7HTYxF3H64/3saG8BxaQs9lpvqUl3fHHLAOWr/VzuTB
 OctOIGa57zRAk5zf4e/Dvn7iORD79F6Mcn9oLX2C40QC6rUOBCknrzz
X-Mailer: b4 0.12.3
Message-ID: <20231023-strncpy-drivers-s390-char-sclp-c-v1-1-eaeef80522bb@google.com>
Subject: [PATCH] s390/sclp: replace deprecated strncpy with strtomem
From:   Justin Stitt <justinstitt@google.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Let's move away from using strncpy() as it is deprecated [1].

Instead use strtomem() as `e.id` is already marked as nonstring:
|       char id[4] __nonstring;

We don't need strtomem_pad() because `e` is already memset to 0 --
rendering any additional NUL-padding useless.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/s390/char/sclp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 8f74db689a0c..486cf57a1605 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -81,7 +81,7 @@ static inline void sclp_trace(int prio, char *id, u32 a, u64 b, bool err)
 	struct sclp_trace_entry e;
 
 	memset(&e, 0, sizeof(e));
-	strncpy(e.id, id, sizeof(e.id));
+	strtomem(e.id, id);
 	e.a = a;
 	e.b = b;
 	debug_event(&sclp_debug, prio, &e, sizeof(e));

---
base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
change-id: 20231023-strncpy-drivers-s390-char-sclp-c-bb66226a7eaa

Best regards,
--
Justin Stitt <justinstitt@google.com>


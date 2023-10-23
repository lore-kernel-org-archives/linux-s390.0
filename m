Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825B4C25B46
	for <linux-s390@archiver.kernel.org>; Mon, 23 Oct 2023 19:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjJWTfM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Oct 2023 15:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJWTfM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 Oct 2023 15:35:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FA6C5
        for <linux-s390@vger.kernel.org>; Mon, 23 Oct 2023 12:35:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a3942461aso4550100276.2
        for <linux-s390@vger.kernel.org>; Mon, 23 Oct 2023 12:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698089709; x=1698694509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mpNGvrnmepFOL5iK9OsktiyedII/7KGUTR0lq/BVReE=;
        b=GyU9jYC+/dOkM74MwmYBuGf7qN/0HP8h0pp8c6CNv1O34l8VdC5UVz9HA7PBd5zp2m
         6P9X7CK8bjinlGHJBxFmhz/8MgYlADCLQd8xRH/3Lop+s/XjP5BtA7Ww08/Z5biPjw+B
         7uN2ki6wAoaq4OmiuY/CqX3eFryNJy7wuBsf0F+dPJxQogAUiATOFb/PJDcCr8716LN5
         4LtAOUZRicgJioKfgcyE9Xsx9VFt061GumeQUueXx/eXv1EskFiDCBAJ8B3wzooN80Ol
         vE743Mq7JvxWbCCgydLjyl02yl7cKz8xf+x9ywYs8pqIg6n/QgLrPksE9LzL9mGnyA/C
         QP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698089709; x=1698694509;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpNGvrnmepFOL5iK9OsktiyedII/7KGUTR0lq/BVReE=;
        b=l/e414/1DlhyVZQK1HDOnR/PfURGPDAb+PgrhnFSnVFz7RLbOXX/svpk0SS9Fro+U/
         2OwIPGXpk0kI55VpX/OPCLHpMDRdhJC72wcp60FoN7+4O60305Ht5l9oUQa27Q0WiIX/
         /U2ZVwCNhO2ojcm16dk/NxTamUjaozN9mHcxvrCzfqu3+j7eTHMAGhFwa6ma2BrP6Nyl
         KFx9SK/r7yoPjHvOImH2p0kbSJ3hsMtZ4mcDYQqA5mNVeiPzT2/tWNFJpvwyv0dwpta5
         t6Wvl+FnbNSgt3dL98Tas2SzHiMHaNJ+TKD2kzjx7pyKU8tqRBVCRbwV6qm94NNF4Zm5
         g6aQ==
X-Gm-Message-State: AOJu0Ywp9lvox2LIC+LmT1jgXqJXozTOui/knEEVumvGP4QJri4k9fO5
        kRlQso+v46563mWFWZAiizECGvjGrKEZFTAahw==
X-Google-Smtp-Source: AGHT+IETefzX2fjRbWGPZdZ7MnkUWmJiCSF1lyuREmMHugp81jgO3yXXMfhHZ/Y/bU0zTaFhuljISUlkljUy47Dwng==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:dccf:0:b0:d77:f6f9:159 with SMTP
 id y198-20020a25dccf000000b00d77f6f90159mr200286ybe.9.1698089709778; Mon, 23
 Oct 2023 12:35:09 -0700 (PDT)
Date:   Mon, 23 Oct 2023 19:35:07 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOrKNmUC/x2NQQqDQAwAvyI5N7Crpbr9SilFYlZzMJVkkRbx7
 116mMNcZg5wNmGHe3OA8S4ub60SLw3QMurMKFN1aEPbxQp6MaXti5PJzuboXQqoXJAKra91FEX CnOIQ8rUPdEtQU5txls9/83ie5w+JKpDSdgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698089708; l=2146;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=2i13pUNg5jdPNAKizwFkDgsEeFj20v602g+x3gcL7mQ=; b=ky84JixLgjvwMNGmiy2NSzwFeHDXPKLBEYdk92wBMLHMD7ib2CZNN4xkwdsRAgNnU8scCvJZ6
 grVyjyo+v9WDPSdC5jcZNOWZG0aCmk3iFtMEQDho7OnlVjudLIvWdr8
X-Mailer: b4 0.12.3
Message-ID: <20231023-strncpy-drivers-s390-net-ctcm_main-c-v1-1-265db6e78165@google.com>
Subject: [PATCH] s390/ctcm: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect chid to be NUL-terminated based on its use with format
strings:

	CTCM_DBF_TEXT_(SETUP, CTC_DBF_INFO, "%s(%s) %s", CTCM_FUNTAIL,
			chid, ok ? "OK" : "failed");

Moreover, NUL-padding is not required as it is _only_ used in this one
instance with a format string.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

We can also drop the +1 from chid's declaration as we no longer need to
be cautious about leaving a spot for a NUL-byte. Let's use the more
idiomatic strscpy usage of (dest, src, sizeof(dest)) as this more
closely ties the destination buffer to the length.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/s390/net/ctcm_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 6faf27136024..ac15d7c2b200 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -200,13 +200,13 @@ static void channel_free(struct channel *ch)
 static void channel_remove(struct channel *ch)
 {
 	struct channel **c = &channels;
-	char chid[CTCM_ID_SIZE+1];
+	char chid[CTCM_ID_SIZE];
 	int ok = 0;
 
 	if (ch == NULL)
 		return;
 	else
-		strncpy(chid, ch->id, CTCM_ID_SIZE);
+		strscpy(chid, ch->id, sizeof(chid));
 
 	channel_free(ch);
 	while (*c) {

---
base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
change-id: 20231023-strncpy-drivers-s390-net-ctcm_main-c-f9180f470c69

Best regards,
--
Justin Stitt <justinstitt@google.com>


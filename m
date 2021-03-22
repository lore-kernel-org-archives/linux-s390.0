Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59854C433C1
	for <linux-s390@archiver.kernel.org>; Mon, 22 Mar 2021 06:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D6246191B
	for <linux-s390@archiver.kernel.org>; Mon, 22 Mar 2021 06:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhCVGZi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Mar 2021 02:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCVGZP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 22 Mar 2021 02:25:15 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B2AC061574;
        Sun, 21 Mar 2021 23:25:13 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c3so9508428qkc.5;
        Sun, 21 Mar 2021 23:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZVcmpP+UhARS/m30lTvHE+dZzN9PzNCkFcm7OvwBa0=;
        b=fI4TX7ek17FCkiIKIik/zYR/zzXube6XqFTXl7ypQK2fQV/SS0wvIIamtkm5pFpGvY
         oVGegTi/XwVv8s3ye7H7dmfe+Vk3sNOWHLY6WaOmfjbfwTE2H/wCMQgzCbLy2q/WKjax
         TnLOWbzq1eaVtxiIeAXjjlnUaLOrm/eDC+BOcBPVpg1I6N79DqKnhdiHhdBBL67jp7uW
         8q/OfW0HvP7hA2Po/PuSKgacoIBsrXKfOxU2NDN+qIgYYNLwDkDRqVQ2447WzwzGV2vI
         /aO8SOr0UNcQaLoow4N1j7LzumtgSdl8hxooOS4OqndLa+PhlLwatyAKK+JenSU1qZkP
         yxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZVcmpP+UhARS/m30lTvHE+dZzN9PzNCkFcm7OvwBa0=;
        b=D6r+NS9wTbQgAahEhx6pdcDGwlBmO/xcSCZtFRagoC8L9iKINaZY4jhvE1zn8s/Mgx
         cwmWluOJbgusuHbL7Ju888S4/WOz/00yAuz2mKm7aJgvrzSnjhBmleszO1Yj7Aru/kry
         Vv97GsY7b5dpoEHP83n4ah8DNSwcAbn+tLHSj7Wx8vLhlt8VLjI/qLcmZlpvb8sl1z7N
         66AdISu6VMvabdP3fR0Ye/G/ekzdFMqGmHHf76sOCT9B10yuyB/D19ne7ebW93iKBao1
         OaGv25i2pX0bsgp03SxBOy/2D/MIYObt2bXUn4VBQaA6LCstf/Vn4hIjfJ8qmyyC+gXx
         tMdQ==
X-Gm-Message-State: AOAM531kwuDJrvyssCTA40Ldjstc6+zR8jGFqlpn441lCJ0id7Xmso/9
        MVXa0M7eS3KFfhEdWSUKIF8=
X-Google-Smtp-Source: ABdhPJzDteIeotbCZo7rUyWGV2nQDEyu7pM6SIXZRyMwH6OPizPZEwwcf8mfAqB+8yLNZc22NP7/eg==
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr9141795qkx.501.1616394313206;
        Sun, 21 Mar 2021 23:25:13 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.40])
        by smtp.gmail.com with ESMTPSA id t188sm10402244qke.91.2021.03.21.23.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 23:25:12 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        unixbhaskar@gmail.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] s390/kernel: Fix a typo
Date:   Mon, 22 Mar 2021 11:55:00 +0530
Message-Id: <20210322062500.3109603-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


s/struture/structure/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/s390/kernel/os_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/os_info.c b/arch/s390/kernel/os_info.c
index 0a5e4bafb6ad..5a7420b23aa8 100644
--- a/arch/s390/kernel/os_info.c
+++ b/arch/s390/kernel/os_info.c
@@ -52,7 +52,7 @@ void os_info_entry_add(int nr, void *ptr, u64 size)
 }

 /*
- * Initialize OS info struture and set lowcore pointer
+ * Initialize OS info structure and set lowcore pointer
  */
 void __init os_info_init(void)
 {
--
2.31.0


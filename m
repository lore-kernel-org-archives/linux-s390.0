Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61065C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 18 Oct 2021 18:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46EAD61212
	for <linux-s390@archiver.kernel.org>; Mon, 18 Oct 2021 18:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhJRSeB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Oct 2021 14:34:01 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:45708
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229696AbhJRSeA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Oct 2021 14:34:00 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DB3D23FFF6
        for <linux-s390@vger.kernel.org>; Mon, 18 Oct 2021 18:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634581904;
        bh=HFCqmmgGshFFk9Syuf7ZjEDzMD/vEAtb4d+n4IvelGU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=wbA4lAFcAOvtL2j1H50kauWIDO+EDcbk4MNh0bbr8VKoJ3Ryu3RJfWPrtvGKqC7LC
         Nrtks3FnZR/BUhRIBS1khpWmbX/i5CweGpGAZHst6ETOLc0CFPcF7BIf3XOg3EEcKI
         +7rXy/BxleEhUn/huOU6PUTUjLUpfpPzM5rLQA4JqKnKh2+9LawnkmYqGQloGlIpw1
         nffA/RtLLUEzoi6NjL6eb3ZeSfmhMeL0SEw0ASuDM7yts8W5PEaALAaqd2AhgW0hbO
         NlNY3dbxgj13qzVjzUHjyiEXm0JlUp+iu9bO4UA/X2d7iR/RzV6RZcV5rKbUqpwTGU
         qZAgl+0Qjt0ZA==
Received: by mail-pl1-f200.google.com with SMTP id v14-20020a170902e8ce00b0013fcb85c0ebso616004plg.22
        for <linux-s390@vger.kernel.org>; Mon, 18 Oct 2021 11:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HFCqmmgGshFFk9Syuf7ZjEDzMD/vEAtb4d+n4IvelGU=;
        b=lPtcqp3NXyjdlMDLrWH/60g4zf/qEBtX7QzWcxbGzJjMVLA0X3lwJimBtH5KF5CBnS
         U/d7IT3TAU/nYL4tdgnUXaX7L1iOjbi53nFZZQ0k1YLR7p4eFQkgpGe7mgq/d6zqr+yj
         O8LVqlWz91aYa44WeJsJ7oy3PfjKj1DYDPFZbdHj6NCUB3SDycPGOMUSH8ZGVGf2mbFR
         eBjZHYZb7uK4WTm646HvwjdlVY7xABfnODbgbKG/KsOpI8KjIMq4x2UZwAFt2wucAlvO
         9c/Whv5/ulxp2FZhcNGwH3KDftcDzR4bAKyx1IFX21GX2RMBcpL0hfNOTxtvF78VnnYn
         iprQ==
X-Gm-Message-State: AOAM533SX2B2LG0Fmf5dtgqOCneyWesEDZlQRlj5aZpgiTz8yGF/iY9v
        Pr1SAuCa9a50eYUTCntLWuJwazSKVCSvNTlYZxpYj/iD+C9PFooiiYVSk3Mmcek4agL3GofrzHa
        g36kTeMYQW5ijbdYhqeeLOfGaJ78LCdy8uGeujm0=
X-Received: by 2002:a17:903:3092:b0:13f:663d:f008 with SMTP id u18-20020a170903309200b0013f663df008mr28686683plc.13.1634581903338;
        Mon, 18 Oct 2021 11:31:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeZKqqzL7kOSOOmZKx3zrVqfqotBymsSZ8Z+rtKngOuFribJIyCUFc4W1ckNYy2Q0PUArrJA==
X-Received: by 2002:a17:903:3092:b0:13f:663d:f008 with SMTP id u18-20020a170903309200b0013f663df008mr28686657plc.13.1634581903114;
        Mon, 18 Oct 2021 11:31:43 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id x31sm13807633pfu.40.2021.10.18.11.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 11:31:42 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     linux-s390@vger.kernel.org
Cc:     tim.gardner@canonical.com, Karsten Graul <kgraul@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH][linux-next] net/smc: prevent NULL dereference in smc_find_rdma_v2_device_serv()
Date:   Mon, 18 Oct 2021 12:31:28 -0600
Message-Id: <20211018183128.17743-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Coverity complains of a possible NULL dereference in smc_find_rdma_v2_device_serv().

1782        smc_v2_ext = smc_get_clc_v2_ext(pclc);
CID 121151 (#1 of 1): Dereference null return value (NULL_RETURNS)
5. dereference: Dereferencing a pointer that might be NULL smc_v2_ext when calling smc_clc_match_eid. [show details]
1783        if (!smc_clc_match_eid(ini->negotiated_eid, smc_v2_ext, NULL, NULL))
1784                goto not_found;

Fix this by checking for NULL.

Fixes: e49300a6bf621 ("net/smc: add listen processing for SMC-Rv2")
Cc: Karsten Graul <kgraul@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 net/smc/af_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5e50e007a7da..ff23d5b40793 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1780,7 +1780,7 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
 		goto not_found;
 
 	smc_v2_ext = smc_get_clc_v2_ext(pclc);
-	if (!smc_clc_match_eid(ini->negotiated_eid, smc_v2_ext, NULL, NULL))
+	if (!smc_v2_ext || !smc_clc_match_eid(ini->negotiated_eid, smc_v2_ext, NULL, NULL))
 		goto not_found;
 
 	/* prepare RDMA check */
-- 
2.33.1


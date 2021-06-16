Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20DDC48BE5
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 20:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82155613BF
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 20:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhFPUUf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Jun 2021 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbhFPUUe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Jun 2021 16:20:34 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9281CC061574
        for <linux-s390@vger.kernel.org>; Wed, 16 Jun 2021 13:18:26 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k15so3123894pfp.6
        for <linux-s390@vger.kernel.org>; Wed, 16 Jun 2021 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ENcTAx1+EcPab9VvytuBkxLny+10kPvSLUe64LidxdQ=;
        b=WiJb+wIGnlurv+4H8fQ+LNqceh747H/iS8/ddDHb8RXs0QrPh64CvyuhKeDIdbSZpV
         bOT+gLasC9PAqK6XbSRIaDJ9Y7PxN4oXKdKFuJmy4vjX+ziiSkuXtP6/+hO4GRuudVCH
         EDZixhsEtKuwCb81WXNcHQPfDxz/FgeyUQXo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ENcTAx1+EcPab9VvytuBkxLny+10kPvSLUe64LidxdQ=;
        b=K3NxP1xrTijtIWiDT7uUgiYwfr1ffkkZn1f6AJ4oLPtfRXQwP3R2/tvDMaM+dntKpZ
         VtpzxQDTVhw6Qp0MPEY2gcIMfkEDYaOPFkWYlOpZY/ZzOGWou0z4KXo3XmO9evH+gvXe
         1GOC8XBOiI2Yo48HAaLk/p1yoGjIc2dOjEeeZwcY86G+qbSjrvC8ecYF1V/7tI7PSDOg
         LNuH/XBXMoCGypiasg0ocZX7hbmV8aP0vrElq24yU1ooulAZj7da+ljnOF/0zD5gUm5z
         7WXefol2jdujadhwBRWN9fUJNLex4QLr4abQL+3h23iAMMrwRQ4UkcK4aP2iXz7QJq0W
         KDpg==
X-Gm-Message-State: AOAM531kiz7ykanW7DJWbckWLbmX6czcQa2FXxCQ8WhpdYfSRu9C9Ok1
        pJCobxgMba+Zr+gGQCaBRkNdRA==
X-Google-Smtp-Source: ABdhPJxJXoNLJNPVD/BDos5tH8MG8XXv2KfMC8Gw7X3jsaO48fFygMTufgOap4HYcAorEZqiwVSTUg==
X-Received: by 2002:aa7:9a50:0:b029:2e9:a536:c4f0 with SMTP id x16-20020aa79a500000b02902e9a536c4f0mr1486497pfj.5.1623874706170;
        Wed, 16 Jun 2021 13:18:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l12sm2811933pff.105.2021.06.16.13.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:18:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] s390/speculation: Use statically initialized const for instructions
Date:   Wed, 16 Jun 2021 13:18:23 -0700
Message-Id: <20210616201823.1245603-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=a7efa10bf74410da3d723823c01a21cb7719ac72; i=0EJdiCO/sZbZCBfXSQAnM+hJ3BSDIu+0E7SNvnsr1Uw=; m=5FhAIifPI+dYPrslVAUOeGdnxZTyWY2lqLeWsSo/HBg=; p=pzb0+IfaYNnb577lCHX4XoK00ch1a0s2NZRs99V638o=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKXI4ACgkQiXL039xtwCbagBAAjg+ 2FPDcEj+98as41P97H8JzfPrDikMwwmT9fIza8v1hc5o/MoU7LMRBDYfN7hxPAecO1FI+g81xscyE 0+4M+nfN11I78iH/RVuXJPG01xutEahxwzplV2phTKv/EipRvUwtD32BALG6c/p9IZpluCFuw8t4U iaF1bGdBwFlRgvUM0OhKgLbQ4Qa7jDdPJbj2N2X8gQiCDm6HWn7vIVtHRZmE6QZRl36KD+DmPxlJD GtxKQMfQ5Crk34O1Dneyk8xNYwxLAzllBtFHf2fM7Bz3QahNqYVwq0MtQRZaPJHGpi152wnArP4Ab jko4+W3/y0FmzFDyQCRMPocr0opF5vAc75zzpw1N/wAOrN6qKaiuBCeUzy4wGWAiXZy9cyuqbfRkC 6Lra/zcvwchjeGkDkb+Ljr4mFqxPQuvi3vpZy0YRtrZG0GmKpLcfP/Kzc1/e9letFMIZ8FsGGoZit lh04A5WbfQGcRCxcEAO/tyF6M3qpAS4A8UF1Sak6XHMSU03FmHLUChgcBR4qNO17tehsGkFKa2RUl enuHuUUz9VethESRmN9Zi+grMhDPQ6efbk2VTDgIUBQvT+mnPjIg6kGn1qQrGeLsBgJx09yAs1Asx +k6L4NCoVoo0hRyn1jpCr/IdVMImeHDj3TRzxUW5G1NjVDaGXfIXb4m9d/OsNGGA=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
confusing the checks when using a static const source.

Move the static const array into a variable so the compiler can perform
appropriate bounds checking.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/kernel/nospec-branch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index 2c5c3756644b..250e4dbf653c 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -99,6 +99,7 @@ early_param("spectre_v2", spectre_v2_setup_early);
 static void __init_or_module __nospec_revert(s32 *start, s32 *end)
 {
 	enum { BRCL_EXPOLINE, BRASL_EXPOLINE } type;
+	static const u8 branch[] = { 0x47, 0x00, 0x07, 0x00 };
 	u8 *instr, *thunk, *br;
 	u8 insnbuf[6];
 	s32 *epo;
@@ -128,7 +129,7 @@ static void __init_or_module __nospec_revert(s32 *start, s32 *end)
 		if ((br[0] & 0xbf) != 0x07 || (br[1] & 0xf0) != 0xf0)
 			continue;
 
-		memcpy(insnbuf + 2, (char[]) { 0x47, 0x00, 0x07, 0x00 }, 4);
+		memcpy(insnbuf + 2, branch, sizeof(branch));
 		switch (type) {
 		case BRCL_EXPOLINE:
 			insnbuf[0] = br[0];
-- 
2.25.1


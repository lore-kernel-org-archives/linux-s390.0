Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EDAC001DC
	for <linux-s390@archiver.kernel.org>; Tue, 18 Jul 2023 16:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjGRQey (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 Jul 2023 12:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjGRQew (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 Jul 2023 12:34:52 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA8126
        for <linux-s390@vger.kernel.org>; Tue, 18 Jul 2023 09:34:50 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R54Kx5lXszBR9sr
        for <linux-s390@vger.kernel.org>; Wed, 19 Jul 2023 00:34:45 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689698085; x=1692290086; bh=IaCpewkLQ0ZG/6p0J4gZVTIkck2
        SfVEL+4NQGXefsFU=; b=lZy+ZjV0Tf12hM7xuOb37UqVueXm7aERFewORYJhxzr
        /3GluMpv4gnxCuGYIZbwXbSLK7apzD1YnsrArgQIIwpWsUg4BEE8JgQpf+mp5VfK
        616g26228HoF8+c3V49c6Fjyqwl1N6DF1YX2+FwP14Oh8y8FvkAjrkptPYCITy0q
        z7qqon4ddPNGXAFIrCXLqatkN6DLAYbaaBs7tZ+X48KuIz1YXhllMwPyZZkO+HRo
        JEoog4jy392s5kVjd/0Uf7hM8lN+6yAczxrkXpS1N/Jwrv2nsrQSNGGE8yNgU4ke
        LnorPQbfAsJsZmwH3PUDkw/nCFXKQhfQuHTL677PBlg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id occJuPpPL_ky for <linux-s390@vger.kernel.org>;
        Wed, 19 Jul 2023 00:34:45 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R54Kx4XffzBR1PQ;
        Wed, 19 Jul 2023 00:34:45 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 00:34:45 +0800
From:   pangzizhen001@208suo.com
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/kernel: Fix comment typo
In-Reply-To: <34bf6e8c9b846ad9fe716ff522b244be@208suo.com>
References: <20230712094239.16048-1-wangjianli@cdjrlc.com>
 <34bf6e8c9b846ad9fe716ff522b244be@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <4d07ec491fdc078d8ace172bb5dcb554@208suo.com>
X-Sender: pangzizhen001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Delete duplicate word "the"

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
  arch/s390/kernel/sthyi.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 4d141e2c132e..dfc350fab384 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -250,7 +250,7 @@ static void fill_diag_mac(struct sthyi_sctns *sctns,
      sctns->mac.infmval1 |= MAC_CNT_VLD;
  }

-/* Returns a pointer to the the next partition block. */
+/* Returns a pointer to the next partition block. */
  static struct diag204_x_part_block *lpar_cpu_inf(struct lpar_cpu_inf 
*part_inf,
                           bool this_lpar,
                           void *diag224_buf,

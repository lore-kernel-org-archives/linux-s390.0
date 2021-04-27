Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE9EC433B4
	for <linux-s390@archiver.kernel.org>; Tue, 27 Apr 2021 19:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABFF6023B
	for <linux-s390@archiver.kernel.org>; Tue, 27 Apr 2021 19:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbhD0Tq4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 27 Apr 2021 15:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbhD0Tqz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 27 Apr 2021 15:46:55 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Apr 2021 12:46:12 PDT
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D936C061574;
        Tue, 27 Apr 2021 12:46:12 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 5AD575726; Tue, 27 Apr 2021 21:40:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=valentin-vidic.from.hr; s=2020; t=1619552430;
        bh=l0jf3je7Taq6bjLlRaBk8R2JjLc/aoQA0pAo1/ZWMFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWI/hwNGbVtZ9vXHXZUDL94f3QGd/JcWsUyJxn/0M5uR6KyCiQaToVR9t+NnZxvR8
         aLcGJleyCchUcdVdMi1JFgseJ9hJMvCFFQZZmZiN+mavJJi2jmVL7XkBbGNPm+xY3a
         UnFbbAxu3SsDpHgHTUz7Xfqz+YZ339UG4CxDnyzKM21UD6k6+dNzH18l5CaHKhIcIJ
         nuxyLgTBLXJi2N8gcLHlvjEkTCTLlpl84Ma3xjP16vRvABx4sa17F5zPmG1u94fIYL
         RsVwZx66sBv8eKAiiHFMTVGDoLb0c8unXyBwCchQYFrVVIIklTM+riJ8fCNCKsc4Hz
         1PohB0Bp65yHCTnS0bYzmfx9YO0n84ToEiZyzYgzfnpU2s5rUdfypKH5sKn6Otz/mN
         ZwF4OdJ9nq7WoqlaPid828qgrEK0D7vtLAv2mrNtVtS826zSRop99d5K+koRT2FLWO
         MCYVMaOhBfHFTeWBTG1KysEwCr9LMrkqVASnwv6FdM7jwhtGtY6/Zod5lT4lHtRntq
         nFbpvV4XrLMkN7EZTaVMSR5FCJRUpu5P6n1BGgw6wDXEF+Y2rIP4yLigb3pP0LV4tv
         h4Y2dxaf0Bcc4HajUeTTpZgj5lnuXD21t3KsWtRtX1AnBTHxG/OpA3ZyRvAEtJXKi4
         DCiJ2eoFZie7cA1IKsaMG254=
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Philipp Kern <pkern@debian.org>,
        Benjamin Zimmermann <dave@oss.volkswagen.com>,
        debian-s390@lists.debian.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH v2] s390/sclp_vt220: Fix console name to match device
Date:   Tue, 27 Apr 2021 21:40:10 +0200
Message-Id: <20210427194010.9330-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519181654.16765-1-vvidic@valentin-vidic.from.hr>
References: <20200519181654.16765-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Console name reported in /proc/consoles:

  ttyS1                -W- (EC p  )    4:65

does not match the char device name:

  crw--w----    1 root     root        4,  65 May 17 12:18 /dev/ttysclp0

so debian-installer inside a QEMU s390x instance gets confused and fails
to start with the following error:

  steal-ctty: No such file or directory

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 v2: also update preferred console for VT220 case

 arch/s390/kernel/setup.c       | 2 +-
 drivers/s390/char/sclp_vt220.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 72134f9f6ff5..3ec6ca9c26c0 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -165,7 +165,7 @@ static void __init set_preferred_console(void)
 	else if (CONSOLE_IS_3270)
 		add_preferred_console("tty3270", 0, NULL);
 	else if (CONSOLE_IS_VT220)
-		add_preferred_console("ttyS", 1, NULL);
+		add_preferred_console("ttysclp", 0, NULL);
 	else if (CONSOLE_IS_HVC)
 		add_preferred_console("hvc", 0, NULL);
 }
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 047f812d1a1c..71ed1bf15598 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -35,8 +35,8 @@
 #define SCLP_VT220_MINOR		65
 #define SCLP_VT220_DRIVER_NAME		"sclp_vt220"
 #define SCLP_VT220_DEVICE_NAME		"ttysclp"
-#define SCLP_VT220_CONSOLE_NAME		"ttyS"
-#define SCLP_VT220_CONSOLE_INDEX	1	/* console=ttyS1 */
+#define SCLP_VT220_CONSOLE_NAME		"ttysclp"
+#define SCLP_VT220_CONSOLE_INDEX	0	/* console=ttysclp0 */
 
 /* Representation of a single write request */
 struct sclp_vt220_request {
-- 
2.20.1


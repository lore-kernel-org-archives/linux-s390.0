Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DBEC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 11 Jul 2022 18:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiGKSVL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Jul 2022 14:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiGKSVK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Jul 2022 14:21:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B192B253;
        Mon, 11 Jul 2022 11:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 466E0B81125;
        Mon, 11 Jul 2022 18:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749D9C34115;
        Mon, 11 Jul 2022 18:21:06 +0000 (UTC)
Date:   Mon, 11 Jul 2022 14:21:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] trace-cmd: Fix writing of uncompressed size
Message-ID: <20220711142104.090b9030@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

pointer in struct tracecmd_compression is 'unsigned long', which is 8 byte
in size on most platforms, but the tep_read_number() call in the next line
treats it as a 4 byte value. As there's no need for unsigned long change
the type to unsigned int.

Link: https://lore.kernel.org/all/20220711074418.858843-1-svens@linux.ibm.com/
Link: https://lore.kernel.org/all/20220711094340.2829115-1-svens@linux.ibm.com/

Fixes: 3f8447b1 ("trace-cmd library: Add support for compression algorithms")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 lib/trace-cmd/trace-compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/trace-cmd/trace-compress.c b/lib/trace-cmd/trace-compress.c
index a63295e..461de8d 100644
--- a/lib/trace-cmd/trace-compress.c
+++ b/lib/trace-cmd/trace-compress.c
@@ -32,7 +32,7 @@ struct tracecmd_compression {
 	int				fd;
 	unsigned int			capacity;
 	unsigned int			capacity_read;
-	unsigned long			pointer;
+	unsigned int			pointer;
 	char				*buffer;
 	struct compress_proto		*proto;
 	struct tep_handle		*tep;
-- 
2.36.1

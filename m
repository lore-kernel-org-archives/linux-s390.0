Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2271CEB64D9
	for <linux-s390@archiver.kernel.org>; Wed, 12 Jul 2023 09:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjGLJki (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 12 Jul 2023 05:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjGLJkY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 12 Jul 2023 05:40:24 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACBD1FC0
        for <linux-s390@vger.kernel.org>; Wed, 12 Jul 2023 02:40:16 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1CQN25zHzBR7b8
        for <linux-s390@vger.kernel.org>; Wed, 12 Jul 2023 17:40:12 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689154812; x=1691746813; bh=EAMpXsiaSYTo5oEE8hQAmIO+2wP
        QvJdgOG78JHu50g8=; b=t7YSHUvk+z/tKuo72lvPku4fwQJ8AeTt9luQbiFtC6e
        0DdatW2h4EQWH21djcv3j3yQuhLtUE1WQgje2glQZuseyC+Rs7I5QIOA+ptKwqvi
        qj6di+5CbPEsnmVYP5J7K1IuFN29KgYYnVgSS0NoLHAn/wl0Bu3OzFMpu9czAi67
        rUfydyV54Jubed/gFnIBsvOE1k8Czob2RDOaXnEv0TMPsZmqF/qtqfmO2PlKmZG3
        D4A5rl6THLgQxsTnhq3HazMsbPFxiPZPZIUrNys0c35nMKAsTW98HZQD7ZqxwvOC
        aLgD65CfCgz+T0CGwFWJ9Bgy7ZjLJinbMYqRtdOypMQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JuhnXZBDzkFu for <linux-s390@vger.kernel.org>;
        Wed, 12 Jul 2023 17:40:12 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1CQM6bxszBR7b0;
        Wed, 12 Jul 2023 17:40:11 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 17:40:11 +0800
From:   pangzizhen001@208suo.com
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] s390/kernel: Fix comment typo
In-Reply-To: <20230712093757.36116-1-wangjianli@cdjrlc.com>
References: <20230712093757.36116-1-wangjianli@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <24163a6fd52a3a496a27740039e07dd7@208suo.com>
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
  arch/s390/kernel/perf_cpum_sf.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c 
b/arch/s390/kernel/perf_cpum_sf.c
index 06efad5b4f93..3e1d8c58e4d1 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1193,7 +1193,7 @@ static void perf_event_count_update(struct 
perf_event *event, u64 count)
   * combined-sampling data entry consists of a basic- and a 
diagnostic-sampling
   * data entry.    The sampling function is determined by the flags in 
the perf
   * event hardware structure.  The function always works with a 
combined-sampling
- * data entry but ignores the the diagnostic portion if it is not 
available.
+ * data entry but ignores the diagnostic portion if it is not 
available.
   *
   * Note that the implementation focuses on basic-sampling data entries 
and, if
   * such an entry is not valid, the entire combined-sampling data entry 
is

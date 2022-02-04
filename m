Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5E9C433FE
	for <linux-s390@archiver.kernel.org>; Fri,  4 Feb 2022 17:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376965AbiBDRiE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 4 Feb 2022 12:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376952AbiBDRhs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Feb 2022 12:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643996267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=meBYTrvQY3Vzaw6ouSwzbarO8+EcbkWn/cKrybubalA=;
        b=UMzIIorG5XRIf3Ngj/HGBA8gAJZfOqJVvyYkhPyTajSi0Gy5fAFAndRYBskXwNJpdbCwKe
        W0ReziBI7WFPG6YEXLUh4kTteMrpnrgwOshyo5+oNPZq9hLT+EJ43vv66Du0KOMFHkzHgR
        aLCZFB4OkLDNTo5qlBVVx7Aar5HTbLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-qPJobStOO-ivGJ3dYYyzrw-1; Fri, 04 Feb 2022 12:37:44 -0500
X-MC-Unique: qPJobStOO-ivGJ3dYYyzrw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E6AC801B2D;
        Fri,  4 Feb 2022 17:37:43 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F8927DE50;
        Fri,  4 Feb 2022 17:37:08 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 722D2416D5C7; Fri,  4 Feb 2022 14:36:46 -0300 (-03)
Message-ID: <20220204173554.491925589@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Fri, 04 Feb 2022 14:35:38 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        linux-s390@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v11 01/13] s390: add support for TIF_TASK_ISOL
References: <20220204173537.429902988@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add TIF_TASK_ISOL handling for s390.

Cc: linux-s390@vger.kernel.org
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/arch/s390/include/asm/thread_info.h
===================================================================
--- linux-2.6.orig/arch/s390/include/asm/thread_info.h
+++ linux-2.6/arch/s390/include/asm/thread_info.h
@@ -73,6 +73,7 @@ void arch_setup_new_exec(void);
 #define TIF_ISOLATE_BP		8	/* Run process with isolated BP */
 #define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
 #define TIF_PER_TRAP		10	/* Need to handle PER trap on exit to usermode */
+#define TIF_TASK_ISOL		11	/* task isolation work pending */
 
 #define TIF_31BIT		16	/* 32bit process */
 #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
@@ -97,6 +98,7 @@ void arch_setup_new_exec(void);
 #define _TIF_ISOLATE_BP		BIT(TIF_ISOLATE_BP)
 #define _TIF_ISOLATE_BP_GUEST	BIT(TIF_ISOLATE_BP_GUEST)
 #define _TIF_PER_TRAP		BIT(TIF_PER_TRAP)
+#define _TIF_TASK_ISOL		BIT(TIF_TASK_ISOL)
 
 #define _TIF_31BIT		BIT(TIF_31BIT)
 #define _TIF_SINGLE_STEP	BIT(TIF_SINGLE_STEP)



Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2B3C43214
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 14:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A299610FC
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 14:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbhHCORT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 3 Aug 2021 10:17:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56880 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbhHCORS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Aug 2021 10:17:18 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwrlDXH24IzEKOiVHeBOyZfb8HhrShrfYnaKPeVNnCo=;
        b=ZRMonc/85ksCCbHfdagARTThkDl8RLwbMbyPuMjYDpvEQ3XCO5lezJTSr0wrmrNHJb2nEz
        zEY5gF4yIFoQBaXP+upN479GSAmB6YYr3ysXr+7WUvc3gyVZ5Qn+EzMQJMV2ba26ca3o19
        ZV7WBXleTd7fDnhAfgeZ17lPUeGuhsRLtFxRRbGPXPnbZJe5z4rFyJuDsTS3zZl8yNYpd2
        +fZpmj/Sz8D8dWPdshpH9Duf0iaK7CfhKsAYeB/NyI3cOAUpc8y+S+0yHc+7awlNCT8RXl
        3S7bNYt5lDRz7gZRhwkF4CX5Qz64bO/i/CsUrw7BVzMZfR2Nsn7yBFsgUaxvQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwrlDXH24IzEKOiVHeBOyZfb8HhrShrfYnaKPeVNnCo=;
        b=qUq5efzjLGEIiYL/MaF+IHtyPVQ4VCTO0anL94WOH7kcr8fWjXC16kaOTUj1VH0Z2lHuSn
        +9ctiPj+Z6VByqCw==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 05/38] s390/sclp: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:15:48 +0200
Message-Id: <20210803141621.780504-6-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/char/sclp_config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_config.c b/drivers/s390/char/sclp_confi=
g.c
index 039b2074db7e5..c365110f2daec 100644
--- a/drivers/s390/char/sclp_config.c
+++ b/drivers/s390/char/sclp_config.c
@@ -50,12 +50,12 @@ static void sclp_cpu_capability_notify(struct work_stru=
ct *work)
=20
 	s390_update_cpu_mhz();
 	pr_info("CPU capability may have changed\n");
-	get_online_cpus();
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		dev =3D get_cpu_device(cpu);
 		kobject_uevent(&dev->kobj, KOBJ_CHANGE);
 	}
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 static void __ref sclp_cpu_change_notify(struct work_struct *work)
--=20
2.32.0


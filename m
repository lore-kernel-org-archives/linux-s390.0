Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C954FC4320E
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 14:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A786054F
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 14:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbhHCOR2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 3 Aug 2021 10:17:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57036 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbhHCORX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Aug 2021 10:17:23 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJCTTyLFQs7CESiqKFiNcjPz5Rqmd8DPP0BSu23XP8Y=;
        b=jiXwz5H4tydaMM7Ymbpz0SVGcpb9T59NjRRDIuDEofuku3rQhkH7Ewlbum4yDgVx8xTexo
        BKqX+C73axfVqyAnVrhQ5yMJhSJl2Q0YbZ18lFm/3v3vx46TH44B8qDBNueX29bPnrfCqF
        ybvXsqWimmOuSNOJWBns7OVLngzmfUl4wDs3mZeU1BWFPH0d2z0BhxkoxgwWZ9k+YiJi5H
        Cn9DOJmj4DDyJe4AMQTQg3rfsCFnR4TyHN9dzUmsB+PTIoBndI0qiHvTejaCq7WozfP7gS
        TgJfp1BdGV/JY1nS43GzlvDsxW9IDjMsqmPMUg6nj2J/wwaODWLYWy5S4GvkDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJCTTyLFQs7CESiqKFiNcjPz5Rqmd8DPP0BSu23XP8Y=;
        b=I1pw6idI4jy8GIdu/nypT4+VrP973M2qt30B4F9UGNgFmMNXIcl9XudkdlcNxayDTKCcb0
        lARKrV9SjSNMVPCg==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 22/38] net/af_iucv: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:05 +0200
Message-Id: <20210803141621.780504-23-bigeasy@linutronix.de>
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

Cc: Julian Wiedmann <jwi@linux.ibm.com>
Cc: Karsten Graul <kgraul@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/iucv/iucv.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index e6795d5a546a0..2b29e55a09b92 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -500,14 +500,14 @@ static void iucv_setmask_mp(void)
 {
 	int cpu;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	for_each_online_cpu(cpu)
 		/* Enable all cpus with a declared buffer. */
 		if (cpumask_test_cpu(cpu, &iucv_buffer_cpumask) &&
 		    !cpumask_test_cpu(cpu, &iucv_irq_cpumask))
 			smp_call_function_single(cpu, iucv_allow_cpu,
 						 NULL, 1);
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 /**
@@ -540,7 +540,7 @@ static int iucv_enable(void)
 	size_t alloc_size;
 	int cpu, rc;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	rc =3D -ENOMEM;
 	alloc_size =3D iucv_max_pathid * sizeof(struct iucv_path);
 	iucv_path_table =3D kzalloc(alloc_size, GFP_KERNEL);
@@ -553,12 +553,12 @@ static int iucv_enable(void)
 	if (cpumask_empty(&iucv_buffer_cpumask))
 		/* No cpu could declare an iucv buffer. */
 		goto out;
-	put_online_cpus();
+	cpus_read_unlock();
 	return 0;
 out:
 	kfree(iucv_path_table);
 	iucv_path_table =3D NULL;
-	put_online_cpus();
+	cpus_read_unlock();
 	return rc;
 }
=20
@@ -571,11 +571,11 @@ static int iucv_enable(void)
  */
 static void iucv_disable(void)
 {
-	get_online_cpus();
+	cpus_read_lock();
 	on_each_cpu(iucv_retrieve_cpu, NULL, 1);
 	kfree(iucv_path_table);
 	iucv_path_table =3D NULL;
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 static int iucv_cpu_dead(unsigned int cpu)
@@ -784,7 +784,7 @@ static int iucv_reboot_event(struct notifier_block *thi=
s,
 	if (cpumask_empty(&iucv_irq_cpumask))
 		return NOTIFY_DONE;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	on_each_cpu_mask(&iucv_irq_cpumask, iucv_block_cpu, NULL, 1);
 	preempt_disable();
 	for (i =3D 0; i < iucv_max_pathid; i++) {
@@ -792,7 +792,7 @@ static int iucv_reboot_event(struct notifier_block *thi=
s,
 			iucv_sever_pathid(i, NULL);
 	}
 	preempt_enable();
-	put_online_cpus();
+	cpus_read_unlock();
 	iucv_disable();
 	return NOTIFY_DONE;
 }
--=20
2.32.0


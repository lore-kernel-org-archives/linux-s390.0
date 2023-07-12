Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90031EB64DD
	for <linux-s390@archiver.kernel.org>; Wed, 12 Jul 2023 15:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjGLPDo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 12 Jul 2023 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjGLPDg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 12 Jul 2023 11:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7208F1BDF
        for <linux-s390@vger.kernel.org>; Wed, 12 Jul 2023 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689174168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kvr3qVn5V77zWJcaKe9AHXcXT+HniwXcgFa7KzwlkrU=;
        b=IGAxpxuH/LxgylPFj87iLqWfo/NJqhGJxN2QqJgSqmq6jm9WOch4nRnc1oB1tJOKYw/zlW
        9fRqOCZCpr5b3sgQ67ivJjLsKsRHhnvvvTjhlLRQCb0uxm+5U25l5xS5va0KaFNp1mZ2RV
        3R/VlWsP7xIIOvWbBtd7DV/vwAgSqpw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-x4yK7EmrNJ-1oPciU6YDVA-1; Wed, 12 Jul 2023 11:02:45 -0400
X-MC-Unique: x4yK7EmrNJ-1oPciU6YDVA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76783ba6d62so821945785a.3
        for <linux-s390@vger.kernel.org>; Wed, 12 Jul 2023 08:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689174164; x=1691766164;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kvr3qVn5V77zWJcaKe9AHXcXT+HniwXcgFa7KzwlkrU=;
        b=Jr9E5sfTSxxkQqPx6nj6HNbZe9BDMYIM9ReGo1QDeNzIw4Q24siMBZ7SSp8QGIrcPB
         7Mxdv75PL+DIKxBX6wH3fl08GTMLKJVxyvahC79MG623CAjshn6jk/dXcEwemh7dvKA4
         6RZpD6y2nDa7JHqutK550Tiwn2WoM6nwrOvhpBosTsOQui1kEpyZhgz/wHXs89PPL8aT
         SDfixgnMoAJ+XcYdWss3qeQg3fxtCAd0e1CbqTPGgAV8U4wWqajha68YD1s1vK3mBv42
         fwljetbzB51KMs73/5I0PlMdu6MufpJqw1PmsguIb8oaf6g3pJ6F9FfD6ly9bzshYz+U
         yfKQ==
X-Gm-Message-State: ABy/qLY9jpx3+ClmIrfOYc1rxitF/mpK9aV2DMB6OXfgnvbZONYKH8PM
        km3mbzKLltbj/Nksv9iCfQqQBOZeIso6BNYfpjUwEl9UDxdYLg1xfJANkBjjT7MaQB1mwWmKxbZ
        wMXw8VPzjXeLwELxqlMyALszUotK1whYfA09GPM83ib899+Ym5iHFEBgC3D1s56nzFcUhG1xjr0
        vrSrBWOw==
X-Received: by 2002:a0c:e545:0:b0:636:2169:4298 with SMTP id n5-20020a0ce545000000b0063621694298mr15517864qvm.1.1689174163936;
        Wed, 12 Jul 2023 08:02:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH++qRRrnEHCZes7rTAj13UdiM5e25ZcfTV6Uk9SSKDV/YGCPR9BTbMWih8KQjwtk707jkosQ==
X-Received: by 2002:a0c:e545:0:b0:636:2169:4298 with SMTP id n5-20020a0ce545000000b0063621694298mr15517822qvm.1.1689174163605;
        Wed, 12 Jul 2023 08:02:43 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id o6-20020a0ccb06000000b0062ff0dd0332sm2251154qvk.38.2023.07.12.08.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:02:43 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [RFC][PATCH] sched: Rename DIE domain
In-Reply-To: <20230712141056.GI3100107@hirez.programming.kicks-ass.net>
References: <20230712141056.GI3100107@hirez.programming.kicks-ass.net>
Date:   Wed, 12 Jul 2023 16:02:38 +0100
Message-ID: <xhsmh1qhduq9d.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/07/23 16:10, Peter Zijlstra wrote:
> Hi
>
> Thomas just tripped over the x86 topology setup creating a 'DIE' domain
> for the package mask :-)
>
> Since these names are SCHED_DEBUG only, rename them.
> I don't think anybody *should* be relying on this, but who knows.
>

FWIW I don't care much about the actual name.

There are some stray references to DIE in comments - see below. Bit funny
to see:
- *  - Package (DIE)
+ *  - Package (PKG)

With that:
Acked-by: Valentin Schneider <vschneid@redhat.com>

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2a..190a647534984 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9439,7 +9439,7 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
  * can only do it if @group is an SMT group and has exactly on busy CPU. Larger
  * imbalances in the number of CPUS are dealt with in find_busiest_group().
  *
- * If we are balancing load within an SMT core, or at DIE domain level, always
+ * If we are balancing load within an SMT core, or at PKG domain level, always
  * proceed.
  *
  * Return: true if @env::dst_cpu can do with asym_packing load balance. False
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e9d9cf776b7ab..2cdcfec1d1c89 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1118,7 +1118,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
  *
  *  - Simultaneous multithreading (SMT)
  *  - Multi-Core Cache (MC)
- *  - Package (DIE)
+ *  - Package (PKG)
  *
  * Where the last one more or less denotes everything up to a NUMA node.
  *
@@ -1140,13 +1140,13 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
  *
  * CPU   0   1   2   3   4   5   6   7
  *
- * DIE  [                             ]
+ * PKG  [                             ]
  * MC   [             ] [             ]
  * SMT  [     ] [     ] [     ] [     ]
  *
  *  - or -
  *
- * DIE  0-7 0-7 0-7 0-7 0-7 0-7 0-7 0-7
+ * PKG  0-7 0-7 0-7 0-7 0-7 0-7 0-7 0-7
  * MC	0-3 0-3 0-3 0-3 4-7 4-7 4-7 4-7
  * SMT  0-1 0-1 2-3 2-3 4-5 4-5 6-7 6-7
  *


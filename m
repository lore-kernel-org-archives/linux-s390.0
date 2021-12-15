Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8906EC433FE
	for <linux-s390@archiver.kernel.org>; Wed, 15 Dec 2021 02:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbhLOCbv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Dec 2021 21:31:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50960 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbhLOCbv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Dec 2021 21:31:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 265A4617B4;
        Wed, 15 Dec 2021 02:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F37C3460E;
        Wed, 15 Dec 2021 02:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639535510;
        bh=2wZ+UURKbZvHgojJB88tl5FRcu4BOxSu67wzI+vjpGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYgReUjkcRSOvU23BK1Lgznx3Lo2FvicBcb/7FkbUjji5AwjqcCjD2OVtlZ2ByTsf
         SKP81dj9Eg8P4smVy9xIv3t2uMWgwyY1RJwqIdATL2rOLOHKKicEYkSN3n5IMBhWii
         PWYV3KbJBe5qnHtGMA7Jl0GBXxL/c4f05Dv/qbfcIJfZ3L9Aquk2tmkTWj7BrYieUA
         Klvuto06CiKX/i6gnMxaBbarqR4E7AcI+jMsMtQwW1ISYHV3cZUymJqoRzssOSLo+w
         5c0anW1JHM28IU7ZyqrLxcQhDwVzH6vSp/9LEq4t3QV8nO4ZawnBpAXZvIgtDPfjUf
         oRVeYJiJzJ4qA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        agordeev@linux.ibm.com, akpm@linux-foundation.org,
        peterx@redhat.com, linux-s390@vger.kernel.org
Subject: [PATCH bpf-next v2 3/4] add includes masked by cgroup -> bpf dependency
Date:   Tue, 14 Dec 2021 18:31:25 -0800
Message-Id: <20211215023126.659200-4-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211215023126.659200-1-kuba@kernel.org>
References: <20211215023126.659200-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

cgroup pulls in BPF which pulls in a lot of includes.
We're about to break that chain so fix those who were
depending on it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hca@linux.ibm.com
CC: gor@linux.ibm.com
CC: borntraeger@linux.ibm.com
CC: agordeev@linux.ibm.com
CC: akpm@linux-foundation.org
CC: peterx@redhat.com
CC: linux-s390@vger.kernel.org
---
 arch/s390/mm/hugetlbpage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index da36d13ffc16..082793d497ec 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -9,6 +9,7 @@
 #define KMSG_COMPONENT "hugetlb"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
+#include <asm/pgalloc.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/mman.h>
-- 
2.31.1


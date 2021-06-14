Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D73FC49EA4
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 02:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91E2613AB
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 02:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhFNC4V (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 13 Jun 2021 22:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhFNC4S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 13 Jun 2021 22:56:18 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D080EC0617AF
        for <linux-s390@vger.kernel.org>; Sun, 13 Jun 2021 19:54:02 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id e17-20020aa798110000b02902f12fffef4eso7469281pfl.7
        for <linux-s390@vger.kernel.org>; Sun, 13 Jun 2021 19:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G0BvcWLb4IeXiMagmDzrz7Uqmh6mNFjQeYSUfBYTeS0=;
        b=J5d2R6fWgIT7owLOkJV6VeWqsPNmA3XhITMy2ACzrDEZhT0Hlwu1Mv1CGvxmT9xZEJ
         zOh45iAE5qCbYIz/1wXZBdrottBUD7tpMTeePsXb7v9pq1MVKNz/w44zNDX5DV7GJSNw
         tUg2JDh1hnHw8Fct0UeMIcmZl+UUTt3HJqYS4yXoEOYYItYDzo+7W04DATqfZNjGj0EE
         FJ4jtuO3fwrMXv+WswutYrXdpiDAx3BQTTnr1PTdXUUB8IPOb33aV1KfvgYWQbQSHSW+
         jN4K6ERakZJxjI6TqbwlCEllee61z7OrSO6pbKuyV3wieGgx7IAhVQP6z/uCtPoNXmQE
         gfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G0BvcWLb4IeXiMagmDzrz7Uqmh6mNFjQeYSUfBYTeS0=;
        b=nGrBvDmV8vAwzTFntxR8gQeIctEnOPt41BfTLqTDmZYeVVB/EV1jfzH0+S+7S9Ovt9
         iIJeQ95ZBMq+iCh1ned4dBCnsNBY6AoJxms+LwMO1FJKQMe+orj4PZu/wmTiprzl6y15
         LkEDRlfpRcr6zjBTyPUt+7RCgsgsTTUW+zsTIQDaQPGxUm21h1isdyioU/z92dOjUKy2
         DwwSN2o7VrZJ38YpnsuwWvtfL0SK4xfRTKYlp3+NZrA8A7IorfEprxGEUXgRJkhlIS/v
         5BexuGWw0JUPYO8OYPWP2993tczoUWvDuFiIze9XLdcZ71QruObl9EDXdJMlxn5cZhPu
         Bygg==
X-Gm-Message-State: AOAM530+wnqcd311THCjjw4pRhwGNgIKcLG8M2hXtm7S4GVPpaXA3Nki
        nioENKyO5lJ/pC8fsXcDxKP59mubL/Fhpg6KXg==
X-Google-Smtp-Source: ABdhPJycgiFSbxMZLS8Bil1CYzhmeCE7vWg07Yh1drE2XVuoYrfaHxoRxI6LH8bCvEcGVqokSkYhAgwO3CRfAtV4/A==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a63:ed4d:: with SMTP id
 m13mr15005137pgk.433.1623639242315; Sun, 13 Jun 2021 19:54:02 -0700 (PDT)
Date:   Mon, 14 Jun 2021 02:53:51 +0000
In-Reply-To: <20210614025351.365284-1-jingzhangos@google.com>
Message-Id: <20210614025351.365284-5-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210614025351.365284-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH 4/4] KVM: selftests: Update binary stats test for stats mode
From:   Jing Zhang <jingzhangos@google.com>
To:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fuad Tabba <tabba@google.com>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Update binary stats selftest to support sanity test for stats
read/write mode and offset.

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 tools/testing/selftests/kvm/kvm_binary_stats_test.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index d85859a6815a..2a34b5e822e8 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -77,6 +77,8 @@ static void stats_test(int stats_fd)
 				<= KVM_STATS_UNIT_MAX, "Unknown KVM stats unit");
 		TEST_ASSERT((pdesc->flags & KVM_STATS_BASE_MASK)
 				<= KVM_STATS_BASE_MAX, "Unknown KVM stats base");
+		TEST_ASSERT((pdesc->flags & KVM_STATS_MODE_MASK)
+				<= KVM_STATS_MODE_MAX, "Unknown KVM stats mode");
 		/* Check exponent for stats unit
 		 * Exponent for counter should be greater than or equal to 0
 		 * Exponent for unit bytes should be greater than or equal to 0
@@ -106,11 +108,18 @@ static void stats_test(int stats_fd)
 	}
 	/* Check overlap */
 	TEST_ASSERT(header->data_offset >= header->desc_offset
-			|| header->data_offset + size_data <= header->desc_offset,
-			"Data block is overlapped with Descriptor block");
+		|| header->data_offset + size_data <= header->desc_offset,
+		"Data block is overlapped with Descriptor block");
 	/* Check validity of all stats data size */
 	TEST_ASSERT(size_data >= header->count * sizeof(stats_data->value[0]),
 			"Data size is not correct");
+	/* Check stats offset */
+	for (i = 0; i < header->count; ++i) {
+		pdesc = (void *)stats_desc + i * size_desc;
+		TEST_ASSERT(pdesc->offset < size_data,
+			"Invalid offset (%u) for stats: %s",
+			pdesc->offset, pdesc->name);
+	}
 
 	/* Allocate memory for stats data */
 	stats_data = malloc(size_data);
-- 
2.32.0.272.g935e593368-goog


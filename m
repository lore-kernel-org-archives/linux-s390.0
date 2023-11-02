Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652E0C4332F
	for <linux-s390@archiver.kernel.org>; Thu,  2 Nov 2023 18:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjKBSQy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Nov 2023 14:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjKBSQx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Nov 2023 14:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9210195
        for <linux-s390@vger.kernel.org>; Thu,  2 Nov 2023 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yH09Py8IYRdWEq70yMXJ3wDczRklXyABpCu4Oku+uko=;
        b=SizAcB/3S6N6dFX/+7vHslRbTJZWQGV8h18TpFfF2Q0/czKw6ppyPhL1OpXx1nYy9wCCpE
        6VU1tpakKfkpBCdQosH6JaeN/YI5nvXfUvN/Oy9g1052k9tSizXDUfoIEDcxk7YAM2q5di
        Naeb5omcrrNq1XCbi1Wx344v1b20osE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-RLBysd_KNy63FxD0Z1u9PQ-1; Thu, 02 Nov 2023 14:16:04 -0400
X-MC-Unique: RLBysd_KNy63FxD0Z1u9PQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c3e3672dc8so2089181fa.1
        for <linux-s390@vger.kernel.org>; Thu, 02 Nov 2023 11:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948963; x=1699553763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yH09Py8IYRdWEq70yMXJ3wDczRklXyABpCu4Oku+uko=;
        b=IHdj7Kwp05d0px3az4ZP2vahEuK8OIrcIMKN976gNjaluvvgF5/eMs5Uufnkdz43Jl
         gczjCZX0OwNzwFohW7/CyxgEjgBA4bF9+WBgsjyaK3HWZRlkde6iV9q7M7hdl0VjLLPz
         d3MrjUBpZJgUk9HVhFpthba4J2dL989YSEhuSN82/N/GvqMJmkP5NLPLnGD1cb9Mcjh/
         uUoIhx1V04syxBr8hpOTdMPvMZYTiMKUOW/mdDExDOwbxVEc2DqaqP4iiUF6hWqX5Zil
         0EIGu7+3ioQBP0bBHt0QnZiQiymzb68z5zsrRJxK9PgUhLHThlfRQ485UWjaAvNE1IGp
         2ReQ==
X-Gm-Message-State: AOJu0YzksQqQicHaJC07CSTi5zYap37OeGbbqeHWeMQL5YWkjnTMJfB/
        LgRsUZntVua0q6Ub5Vgnc40IAwaDQSMHFnWmgf8wWJp8B6cg00ysLyQ4Y230fTdWVgjuKn+R1c7
        FYoqLFJ8uceK6ffhPqUj+cw==
X-Received: by 2002:a2e:9695:0:b0:2c4:ff24:b02e with SMTP id q21-20020a2e9695000000b002c4ff24b02emr14483930lji.3.1698948963408;
        Thu, 02 Nov 2023 11:16:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS1zGZUHtg3KOcze+sfSekgUGd8coQqnik/gqhe4Qn0cg6IP3P+fkjw/XDjmt/1fT6T4eXsA==
X-Received: by 2002:a2e:9695:0:b0:2c4:ff24:b02e with SMTP id q21-20020a2e9695000000b002c4ff24b02emr14483906lji.3.1698948963067;
        Thu, 02 Nov 2023 11:16:03 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b004076f522058sm3879929wms.0.2023.11.02.11.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:16:02 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 3/3] virt/kvm: copy userspace-array safely
Date:   Thu,  2 Nov 2023 19:15:26 +0100
Message-ID: <20231102181526.43279-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102181526.43279-1-pstanner@redhat.com>
References: <20231102181526.43279-1-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

kvm_main.c utilizes vmemdup_user() and array_size() to copy a userspace
array. Currently, this does not check for an overflow.

Use the new wrapper vmemdup_array_user() to copy the array more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 virt/kvm/kvm_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 486800a7024b..2a2f409c2a7d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4932,9 +4932,8 @@ static long kvm_vm_ioctl(struct file *filp,
 			goto out;
 		if (routing.nr) {
 			urouting = argp;
-			entries = vmemdup_user(urouting->entries,
-					       array_size(sizeof(*entries),
-							  routing.nr));
+			entries = vmemdup_array_user(urouting->entries,
+						     routing.nr, sizeof(*entries));
 			if (IS_ERR(entries)) {
 				r = PTR_ERR(entries);
 				goto out;
-- 
2.41.0


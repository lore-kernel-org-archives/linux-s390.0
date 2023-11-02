Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A36C4167B
	for <linux-s390@archiver.kernel.org>; Thu,  2 Nov 2023 18:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377140AbjKBSQ6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Nov 2023 14:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjKBSQy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Nov 2023 14:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2876192
        for <linux-s390@vger.kernel.org>; Thu,  2 Nov 2023 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lX9pDYhUv0xNWCwt2hkI8FAcvsPw051Wv1MARO9LEh8=;
        b=bFfPgMvOPB2357SzbJws51CKGTPxicMLFpsF9oPnlJNwyhpmnlvX789gCsbzPxv2o7vgb3
        ZNcAYiPz34hALSev1ScpVd5wmfiAhcNplUriMmTkF2rY8+LqKV+/PEfB3AfzERloiuSDAy
        qaMI4Nq4u3h8ZUu5YMXKL4K/enbIy1A=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-MJI4G3ZmNS2YAnRAv2RGgA-1; Thu, 02 Nov 2023 14:16:02 -0400
X-MC-Unique: MJI4G3ZmNS2YAnRAv2RGgA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c56c75ea84so2546551fa.1
        for <linux-s390@vger.kernel.org>; Thu, 02 Nov 2023 11:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948961; x=1699553761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lX9pDYhUv0xNWCwt2hkI8FAcvsPw051Wv1MARO9LEh8=;
        b=M3Wl0R+BEQFfZa7f5hN3IA/nrCad2NNCUZHpgJU8bEL/L3aalDAZausc5yR4tOwwpt
         TmUKNipC4TlPoqyJTXaBOmnLhDOVOKM5vTwCA7An1YPpeX/YHJjYlDUO1ksT6tigsOj8
         s7fQCdV69/CgEhJs41Grf4fgpSjqY34aOErXNDsynNMD5qef7AH2aOcimkf+K2BQGjW4
         YOfI8HI9GMUNpINY5NQMPhh8InI32KKojjMBQuKgrrD/zvsgITpmtxPKje7olNZ9FQ/F
         PRGVukkVv2QSUZ0WxeReusP7Ypycefy0Tj/6uSuvV3YcdDSoK76rz0R4816RP705IJ7N
         5bPg==
X-Gm-Message-State: AOJu0YxkqlZUcZJKuEet2F24h8IVdwBHS+WquvRNQbq4VI99sfWg7MYm
        gljKj2FhdaDVASB+Wmee9rU0MwIFwF3RVi5jxmwXVKGldvNKQK1OA6UiJiIzc4mORE60nP/LXNN
        RtWhucPCAZ4M5HcpPH6+3bw==
X-Received: by 2002:a2e:b5cd:0:b0:2c0:7d6:1349 with SMTP id g13-20020a2eb5cd000000b002c007d61349mr13191958ljn.0.1698948960955;
        Thu, 02 Nov 2023 11:16:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA9GFg/9wbEsQk9hiRtyKr5Sw8+tU0lzjpfffLtjFPJgequPAx/iZqfrIIRwYQeDUno1rPwQ==
X-Received: by 2002:a2e:b5cd:0:b0:2c0:7d6:1349 with SMTP id g13-20020a2eb5cd000000b002c007d61349mr13191934ljn.0.1698948960612;
        Thu, 02 Nov 2023 11:16:00 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b004076f522058sm3879929wms.0.2023.11.02.11.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:16:00 -0700 (PDT)
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
Subject: [PATCH 1/3] arch/x86/kvm: copy user-array with overflow-check
Date:   Thu,  2 Nov 2023 19:15:24 +0100
Message-ID: <20231102181526.43279-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102181526.43279-1-pstanner@redhat.com>
References: <20231102181526.43279-1-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

cpuid.c utilizes vmemdup_user() and array_size() to copy two userspace
arrays. This, currently, does not check for an overflow.

Use the new wrapper vmemdup_array_user() to copy the arrays more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 arch/x86/kvm/cpuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 773132c3bf5a..4a15b2a20f84 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -467,7 +467,7 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
 		return -E2BIG;
 
 	if (cpuid->nent) {
-		e = vmemdup_user(entries, array_size(sizeof(*e), cpuid->nent));
+		e = vmemdup_array_user(entries, cpuid->nent, sizeof(*e));
 		if (IS_ERR(e))
 			return PTR_ERR(e);
 
@@ -511,7 +511,7 @@ int kvm_vcpu_ioctl_set_cpuid2(struct kvm_vcpu *vcpu,
 		return -E2BIG;
 
 	if (cpuid->nent) {
-		e2 = vmemdup_user(entries, array_size(sizeof(*e2), cpuid->nent));
+		e2 = vmemdup_array_user(entries, cpuid->nent, sizeof(*e2));
 		if (IS_ERR(e2))
 			return PTR_ERR(e2);
 	}
-- 
2.41.0


Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B8CC4167D
	for <linux-s390@archiver.kernel.org>; Thu,  2 Nov 2023 18:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377151AbjKBSQ4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Nov 2023 14:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjKBSQy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Nov 2023 14:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0EDB9
        for <linux-s390@vger.kernel.org>; Thu,  2 Nov 2023 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dm/JjHi370CidasORpTf+wVzVufl6jy0cXiZxdhplD4=;
        b=DejjRJw4cOiygxcJzU8usL3wa9wwDOhwOcoFlVl+OBJYjrAOcLZBfkvC5B4QBgVkmfreSQ
        qyRyIxDt2Q8sqsZ8dtow/Y+t14rC7STxT8NcIjesERy+uTbV6E3uXN/l5DpasUe7bDPhXC
        CDJFY2wFbI31mEdbWVEG70Wh4BnN5co=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-h77rWQGROCqMANe7lsoxBg-1; Thu, 02 Nov 2023 14:16:00 -0400
X-MC-Unique: h77rWQGROCqMANe7lsoxBg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4084b6f4515so2553835e9.1
        for <linux-s390@vger.kernel.org>; Thu, 02 Nov 2023 11:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948960; x=1699553760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dm/JjHi370CidasORpTf+wVzVufl6jy0cXiZxdhplD4=;
        b=m+/xMl8MsiSZi+qRmuG6y8Nx1Gq0Kms/zlakijoSO6WYPqKTDaFVfMoQbYK9yoUtOq
         bN5YTnDoqeN+fcgR8NRcZeKv+3eVeWMqsF/ZHOLEKlqnOWSr/SEB1Z1Z/zH2WqGCBjDT
         z2O3EfVnqBlnm4ZFCnLwLxdu+Lfrk1KMxpPMhGNIWcso8f28FzT6ou9jQHakA80Xz6V7
         raHp8s2vWzLIqXCEzPKr/+0J8qtirmFmVVfJfa5v40IR7lhfbaIVdkcywiBOulHjyjcT
         +HxudF2CfViePjVREyPr4FAOrfOe/9yApdFhqgrd6Dj93Nl9BwPkJuCaFBZvGcuSlwPl
         A1xw==
X-Gm-Message-State: AOJu0YxsI0uaEQBmFqAAMVYPkTVQgSgwf1FsVrhl1qRYaCh3vpyi0Qde
        3S9uVdsHnAUpGDbgeFklNw35lXJU69pdL6wvysnw4Gml3CmLoRGQoMmjxj4iV/G6CM0bkCLKT2m
        N5DBetCjQmWyig5M/EECKJg==
X-Received: by 2002:a05:600c:35d6:b0:3fe:21a6:a18 with SMTP id r22-20020a05600c35d600b003fe21a60a18mr15692794wmq.3.1698948959799;
        Thu, 02 Nov 2023 11:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdSFZUxYnwUz4IzHW2eQMQDQi7I71cXUtCaaSMnHVgWWbl2msHbfrBfeDCbf3D1IMoAJPZeQ==
X-Received: by 2002:a05:600c:35d6:b0:3fe:21a6:a18 with SMTP id r22-20020a05600c35d600b003fe21a60a18mr15692766wmq.3.1698948959456;
        Thu, 02 Nov 2023 11:15:59 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b004076f522058sm3879929wms.0.2023.11.02.11.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:15:58 -0700 (PDT)
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
        Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 0/3] Use new wrappers to copy userspace arrays
Date:   Thu,  2 Nov 2023 19:15:23 +0100
Message-ID: <20231102181526.43279-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

Linus recently merged [1] the wrapper functions memdup_array_user() and
vmemdup_array_user() in include/linux/string.h for Kernel v6.7

I am currently adding them to all places where (v)memdup_user() had been
used to copy arrays.

The wrapper is different to the wrapped functions only in that it might
return -EOVERFLOW. So this new error code might get pushed up to
userspace. I hope this is fine.

I felt that it might be a good idea to land those three patches here
with a single series, since they all touch something KVM-related.

Kind regards,
P.

[1] https://lore.kernel.org/all/169886743808.2396.17544791408117731525.pr-tracker-bot@kernel.org/

Philipp Stanner (3):
  arch/x86/kvm: copy user-array with overflow-check
  arch/s390/kvm: copy userspace-array safely
  virt/kvm: copy userspace-array safely

 arch/s390/kvm/guestdbg.c | 4 ++--
 arch/x86/kvm/cpuid.c     | 4 ++--
 virt/kvm/kvm_main.c      | 5 ++---
 3 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.41.0


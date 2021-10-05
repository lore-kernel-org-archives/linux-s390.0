Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D786CC433F5
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 15:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8BAC61154
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 15:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhJEPoq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235588AbhJEPoq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 11:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633448575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKDntHxzJOetHKbIPGUlL8NO/wbE042BlEFlU+R/BTE=;
        b=A0AUxVqj/YQodM1zJQG78Hq19h+ivq8l54O+8Bi3+lDJpRb8EK07NGVfrwqMUJITr0Eo1R
        J7oYgUj53Xx5sZxL+dOLj0/nezmuWitAWsjDxazjAxsXZscLXhsEdvqh1rFkNfykrxAVue
        IrzT+ia8jbpbBDYVAye9eOclGQuDARs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-7Lh3_BykNzaSnP49xm6-Xg-1; Tue, 05 Oct 2021 11:42:52 -0400
X-MC-Unique: 7Lh3_BykNzaSnP49xm6-Xg-1
Received: by mail-wm1-f69.google.com with SMTP id n17-20020a7bc5d1000000b0030d4041f73eso1204164wmk.4
        for <linux-s390@vger.kernel.org>; Tue, 05 Oct 2021 08:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pKDntHxzJOetHKbIPGUlL8NO/wbE042BlEFlU+R/BTE=;
        b=tco3ZKTcAAMnmlWH/XZ6/GmaXV5erwjUZm0RdmFkDYWc7YVCWY5eomrPqLBfXGES1e
         fdJhGY7Nvb8JDnD9sHZ8c/iEktnh5zjUKE2zVYfPSrUbGPKKMtfg7vttxnhOOg7aDtz7
         5HzD9tdqKI/XqyixCGLLEit1QZ9vHJey4V/6L+uEMSx7Vc+qJKi870SOKfkptemCU+nk
         cR7RKZc9ZqwVQIvacu5MfzZIV9rbTBRSSPE+4loQAH1x10b8TCMO2nrm+wfyJ6tfhwr/
         +U5CRyG7dNol4ZackuWv/8uOcBIkLUwALm5VsG9B/FwWl1RgaJYbzUFvvfwX12yMTfI2
         mFCA==
X-Gm-Message-State: AOAM530SS4ZBrzlK0iAMDoAqhSxgO4DG7z/FM9fW84aPTNULDSjLAQ6t
        3A0ptstqMj/sAtSkvIVqvlS0S2IUSRQ8hqkMNnhFeFMWPoa18Sr3d7uT2TV7h+/GJUNnGUD+6bB
        enCVmVDT+eb1xcl8lsj0DX33D3wAE4KSwPvtQuHuTbDsDJQ91E98a30llUTsdwLnZoGeW8w==
X-Received: by 2002:adf:a154:: with SMTP id r20mr22999671wrr.326.1633448570994;
        Tue, 05 Oct 2021 08:42:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHSPI1IRwixTMGerHUDu4oO6qB21Y4tIuWzxQ2/xnPIsskWzR3SXr5r0UgA4SsVDAY0yR+Mg==
X-Received: by 2002:adf:a154:: with SMTP id r20mr22999647wrr.326.1633448570792;
        Tue, 05 Oct 2021 08:42:50 -0700 (PDT)
Received: from thuth.remote.csb (p549bb2bd.dip0.t-ipconnect.de. [84.155.178.189])
        by smtp.gmail.com with ESMTPSA id y191sm2699170wmc.36.2021.10.05.08.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 08:42:50 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v2 5/5] Use report_pass(...) instead of
 report(1/true, ...)
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20211005090921.1816373-1-scgl@linux.ibm.com>
 <20211005090921.1816373-6-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <c3ee78df-3caf-f9a7-90c2-624ab09e5949@redhat.com>
Date:   Tue, 5 Oct 2021 17:42:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005090921.1816373-6-scgl@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/10/2021 11.09, Janis Schoetterl-Glausch wrote:
> Whitespace is kept consistent with the rest of the file.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   s390x/css.c         |  4 ++--
>   s390x/diag288.c     |  2 +-
>   s390x/selftest.c    |  2 +-
>   s390x/smp.c         | 16 ++++++++--------
>   s390x/spec_ex.c     |  7 +++----
>   x86/asyncpf.c       |  7 +++----
>   x86/emulator.c      |  2 +-
>   x86/hyperv_stimer.c | 18 ++++++++----------
>   x86/svm_tests.c     | 17 ++++++++---------
>   x86/syscall.c       |  2 +-
>   x86/taskswitch2.c   |  2 +-
>   x86/tsc_adjust.c    |  2 +-
>   x86/vmx.c           |  6 +++---
>   x86/vmx_tests.c     | 36 ++++++++++++++++++------------------
>   14 files changed, 59 insertions(+), 64 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


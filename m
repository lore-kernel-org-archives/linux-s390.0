Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB3FC433F5
	for <linux-s390@archiver.kernel.org>; Tue, 15 Mar 2022 21:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351921AbiCOVU5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244702AbiCOVU4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Mar 2022 17:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CF665B3FE
        for <linux-s390@vger.kernel.org>; Tue, 15 Mar 2022 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647379183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7jUK/Zy3c/rIDtBsF8csvV0VQ7PgqvLYqxZFFngnNhM=;
        b=ULLKvwsyVqn6ZdbLsHGnTSFoMCVLQO9RZj+UmZvKtJ5rfXj4fAfSnmhB0Vy69dif89luNV
        UJQhUydkUKq1WA1xX5jhLC5lrDjU/qHSfsis2Ex3yZdaNdzcLrTfdzcinUXPR70QR9NIjU
        YUcI0UpLS+lT6JbcqOrjQeTBvaERII8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-MBgF3i_QMCK_E57RcMQwVA-1; Tue, 15 Mar 2022 17:19:40 -0400
X-MC-Unique: MBgF3i_QMCK_E57RcMQwVA-1
Received: by mail-ej1-f71.google.com with SMTP id jl21-20020a17090775d500b006df69a83946so41343ejc.23
        for <linux-s390@vger.kernel.org>; Tue, 15 Mar 2022 14:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7jUK/Zy3c/rIDtBsF8csvV0VQ7PgqvLYqxZFFngnNhM=;
        b=Q3KutX4mHW/Rf4LmzRh0rkL9AUGtMUTrVc1FEbzjW7L2bxo8hg86Hqp/Pv8SOTCSn+
         oV52+IbgGxDwHXwsGBZvFiRZ3+wnkXopSY7kv3phpdfJda8HmaR9hZ7hBE2l0mn18GdO
         QnCWF+zojl+WWTwz2ORKRoI5ndxOCc3y78JB6OcL4E9GDlSXeNRLAe9clh0ylapE+fSp
         NfkwbXKwDxF5ulK91LtBj5QqwJqJGESWxnQlV7MSXbGRzftmlB/tgT7yYxBQXFHXv2HM
         aeLSra7o5Woj+9tFfT9ZkYEaL21OqEQ7R9byTJIg+lKPUApPx5/2cMwstX9iM6EMCYtH
         tH9A==
X-Gm-Message-State: AOAM5313clTbe6Kmy4lCFeQV1hfWHAX4+5bLDkAWRWwBCroOUJ/i1v/X
        MitMO8ylgAfOWcU7drGVBh9GXtlfZaC7XoAiVIRO/RxBGLskbhD9BVayJ2AgvOcK+Dr+0AbwNOg
        WOj0Q9cjkyZ+c/Ks2Xx5phA==
X-Received: by 2002:a50:a6d2:0:b0:418:63e1:e4ac with SMTP id f18-20020a50a6d2000000b0041863e1e4acmr16209297edc.169.1647379178872;
        Tue, 15 Mar 2022 14:19:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGoQOeEdXSq9l09EDd9Ie4vogmFni75MTcsHW4UVuCdrEbQa5cQxionuGJWQcEe9HBBX5IXQ==
X-Received: by 2002:a50:a6d2:0:b0:418:63e1:e4ac with SMTP id f18-20020a50a6d2000000b0041863e1e4acmr16209280edc.169.1647379178687;
        Tue, 15 Mar 2022 14:19:38 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id z11-20020a50e68b000000b00412ec8b2180sm43881edm.90.2022.03.15.14.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 14:19:38 -0700 (PDT)
Message-ID: <f9c0542b-f2cc-c90d-1644-fba62a11e85d@redhat.com>
Date:   Tue, 15 Mar 2022 22:19:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GIT PULL 0/7] KVM: s390: Fix, test and feature for 5.18 part 2
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
References: <20220315141137.357923-1-borntraeger@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220315141137.357923-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 3/15/22 15:11, Christian Borntraeger wrote:
> Paolo,
> 
> the 2nd chunk for 5.18 via kvm/next.
> 
> The following changes since commit 3d9042f8b923810c169ece02d91c70ec498eff0b:
> 
>    KVM: s390: Add missing vm MEM_OP size check (2022-02-22 09:16:18 +0100)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.18-2

Pulled, thanks.

Paolo

> for you to fetch changes up to 3bcc372c9865bec3ab9bfcf30b2426cf68bc18af:
> 
>    KVM: s390: selftests: Add error memop tests (2022-03-14 16:12:27 +0100)
> 
> ----------------------------------------------------------------
> KVM: s390: Fix, test and feature for 5.18 part 2
> 
> - memop selftest
> - fix SCK locking
> - adapter interruptions virtualization for secure guests


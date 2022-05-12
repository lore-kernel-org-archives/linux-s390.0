Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C99EC433F5
	for <linux-s390@archiver.kernel.org>; Thu, 12 May 2022 09:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347283AbiELJIK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 12 May 2022 05:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243585AbiELJIJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 May 2022 05:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BEDC6622D
        for <linux-s390@vger.kernel.org>; Thu, 12 May 2022 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652346487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/j2DLJTcGndHtvQqB0oEoKz+UbynhWSX4BfSSQ/pzc=;
        b=BU67vvRMQAyOPBTHxHb9jiz672yYv6hcyn3vwpOVHDbHtfW4ABXI+D6uCNTShKRVVMPL2L
        PCoReYlFqun1gcSlTj7Hxdjpu1Lo4u6TynnYG0MJxYWWNQLTcBJSwdm6I5GHjqxkfyv4PM
        zHp0Wwpz4AkK0d6G0VD4gS8Ni1bH/Ro=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-cFmSb4ePN0-tbg8ubImRxg-1; Thu, 12 May 2022 05:08:05 -0400
X-MC-Unique: cFmSb4ePN0-tbg8ubImRxg-1
Received: by mail-wr1-f69.google.com with SMTP id p10-20020adfaa0a000000b0020c4829af5fso1814922wrd.16
        for <linux-s390@vger.kernel.org>; Thu, 12 May 2022 02:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=y/j2DLJTcGndHtvQqB0oEoKz+UbynhWSX4BfSSQ/pzc=;
        b=TS3cIjrTfF9oT+SGQjBUBqPWCGEx9DI/iELOHdrmUI6LhVw5grV4Xrr7U1yX8ytBTX
         WfjsuJJjKx4DKccJE5Jj7qrUKmazgIjIHfGZqHUQp90FOlm4SBIPcR42k738ugmJCitK
         zxJZjuJXZyJt2bODCyTjIPxeCF9uNmhMjDXJqGJl2W4z5yJBxJByvVtZrkPIAcOgSVqG
         +uzbH/ywkzle8RSC2jb0TXy9Sjo7e+ZJLD6U5SFe2amBDDRHI0oSNr/l6lDr1rmhvzjI
         aRoWFolpb7ZH7+oxuWk++dQ6EwclSmpR/fzsFmWpAB/Q2pDXQ5mpeGbLn1B4UgYwSIu2
         WUWg==
X-Gm-Message-State: AOAM532D+i6bCIpQ8aY9eEOhFMH9Zdg6Fe4XmDkKcCRVEoJitbBecKyF
        r8pCIIAX+bX9XMTyQD07X3dP+2q7SNZOavDh6KwVTApLN3m5VdBsx5gK/MzoGpBKxfxi/M4amYD
        dYE3lg4gbmf6PRbAPO98C0w==
X-Received: by 2002:a05:600c:2e12:b0:395:b6ae:f551 with SMTP id o18-20020a05600c2e1200b00395b6aef551mr7210538wmf.36.1652346484324;
        Thu, 12 May 2022 02:08:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUQEGT0+VpyQO5wHnlhPG2R7sv8wC84gKC8UIrDB+7/35B8+9BWk8Lk8wiU9+qsxrKMLibQA==
X-Received: by 2002:a05:600c:2e12:b0:395:b6ae:f551 with SMTP id o18-20020a05600c2e1200b00395b6aef551mr7210512wmf.36.1652346484044;
        Thu, 12 May 2022 02:08:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id i25-20020a7bc959000000b003942a244ee4sm2390056wml.41.2022.05.12.02.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 02:08:03 -0700 (PDT)
Message-ID: <e23160b6-2d3c-ebdb-ac5a-c71311e7e5ec@redhat.com>
Date:   Thu, 12 May 2022 11:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 1/3] s390x: KVM: ipte lock for SCA access should be
 contained in KVM
Content-Language: en-US
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        thuth@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, wintera@linux.ibm.com, seiden@linux.ibm.com,
        nrb@linux.ibm.com
References: <20220506092403.47406-1-pmorel@linux.ibm.com>
 <20220506092403.47406-2-pmorel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220506092403.47406-2-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06.05.22 11:24, Pierre Morel wrote:
> The former check to chose between SIIF or not SIIF can be done
> using the sclp.has_siif instead of accessing per vCPU structures
> 
> When accessing the SCA, ipte lock and ipte_unlock do not need
> to access any vcpu structures but only the KVM structure.
> 
> Let's simplify the ipte handling.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>

Much better

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb


Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E39C4338F
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 07:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08ED360F02
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 07:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhHFHcO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 6 Aug 2021 03:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230204AbhHFHcN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Aug 2021 03:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628235118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pVWC3UDptA7H+V1Kg/+VGDadWKlNerXuJRs5msdmzWc=;
        b=gIqoq2QX813tQJ+hBQKF6zvhm3KM+uESNpbzMUmMh65Wd5gIBczGoPysG5S8O46YIxArAg
        F1kGZJeGYQ3Ci5IM7DCn/MztmsonyePDiEBPrcF3urf1SOwY2c4nLrRofzKRHgCTzDGKL/
        VN2uLRyI9sK9u0ce6JzWeMhcR8Skko4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-hhQzrdRIO5SoD3066BpZXA-1; Fri, 06 Aug 2021 03:31:56 -0400
X-MC-Unique: hhQzrdRIO5SoD3066BpZXA-1
Received: by mail-wm1-f69.google.com with SMTP id u14-20020a7bcb0e0000b0290248831d46e4so2158532wmj.6
        for <linux-s390@vger.kernel.org>; Fri, 06 Aug 2021 00:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pVWC3UDptA7H+V1Kg/+VGDadWKlNerXuJRs5msdmzWc=;
        b=udeCdIzaOAmKNMSlpCY5W9SewaDHvKlQkj1Dg1NtVRbtkPXEsYuFZWVr/4cWndjEdz
         BBLcwPilM8VkT4sFM8UPrklKMBH4BBawRptP0YuIs1Cp5IdueBwnYUWMLfBRmUcu+qJd
         8FfQ7d+0yyPF/vMDYKNbKjB8WLS4frZOG6s7YJ7UIbZOcBN6fqf5md7fS4CfpQcY6A4W
         zPHyO+ekektsui+RyOXl+VYuVfnNQziWSJGTVbP+JHH04X6ZdupnE4TBoHaG1BiHwksc
         CBrhVfTIp653200RJUMcNZVzEch1msLqTYt3JeFvvbRDslTd/hM++5YBuWskmi1n6oMR
         jRbA==
X-Gm-Message-State: AOAM530vuP+igSUdI8P8AXvL92nY3lDYUftslBacZq74cyL5NJlgDEBC
        MHPQz68Iig8zRPrK2saKgnh7FDe2Fvi5RQofO42VRgA4A2vQVnMB+e4zUUmjpCTrWCrY3cL/n1f
        BLWaiC+qSJiuQZjMInIZk/w==
X-Received: by 2002:adf:d84b:: with SMTP id k11mr9111337wrl.135.1628235115559;
        Fri, 06 Aug 2021 00:31:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdlvx8qxBMUwmS1NtvHCTtU89EIX8U1VYvVts48XyoDGlCmxjLvN0ZVnYLEfLtdPlwCuIpmw==
X-Received: by 2002:adf:d84b:: with SMTP id k11mr9111324wrl.135.1628235115424;
        Fri, 06 Aug 2021 00:31:55 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6104.dip0.t-ipconnect.de. [91.12.97.4])
        by smtp.gmail.com with ESMTPSA id o24sm9843900wmm.37.2021.08.06.00.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 00:31:55 -0700 (PDT)
Subject: Re: [PATCH v3 03/14] KVM: s390: pv: leak the ASCE page when destroy
 fails
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc:     cohuck@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulrich.Weigand@de.ibm.com
References: <20210804154046.88552-1-imbrenda@linux.ibm.com>
 <20210804154046.88552-4-imbrenda@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6b75cc71-b996-cf3d-ce57-dbcd475ebc3a@redhat.com>
Date:   Fri, 6 Aug 2021 09:31:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804154046.88552-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04.08.21 17:40, Claudio Imbrenda wrote:
> When a protected VM is created, the topmost level of page tables of its
> ASCE is marked by the Ultravisor; any attempt to use that memory for
> protected virtualization will result in failure.
> 
> Only a successful Destroy Configuration UVC will remove the marking.
> 
> When the Destroy Configuration UVC fails, the topmost level of page
> tables of the VM does not get its marking cleared; to avoid issues it
> must not be used again.
> 
> Since the page becomes in practice unusable, we set it aside and leak it.

Instead of leaking, can't we add it to some list and try again later? Or 
do we only expect permanent errors?

Also, we really should bail out loud (pr_warn) to tell the admin that 
something really nasty is going on.

-- 
Thanks,

David / dhildenb


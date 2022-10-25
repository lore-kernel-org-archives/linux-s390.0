Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C001C04A95
	for <linux-s390@archiver.kernel.org>; Tue, 25 Oct 2022 09:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiJYJbI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 Oct 2022 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiJYJao (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Oct 2022 05:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74D545054
        for <linux-s390@vger.kernel.org>; Tue, 25 Oct 2022 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666690230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N52J9g4cZ+1Mq7ONZQzSB0PW3bqTQoiOPUv/1Ns1UPw=;
        b=NHD1NeptmR5ll20btXWTOXEm/iCQ7EHUn+cSh5vN6GfuOHEqmtoq27k6URFTr9LSOLtgDN
        XhRoPNvSYVw/iY6VkOSr/nYGngsyFe0T2LfncCsvi2S9bLV7QZVwZeVvKK/diRhGm7oGXR
        EY+9vYq0iQ8sfvs1HrCz51g7nfEJypY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-1OT5j1C3N7Ouo2GZDnOxGQ-1; Tue, 25 Oct 2022 05:30:28 -0400
X-MC-Unique: 1OT5j1C3N7Ouo2GZDnOxGQ-1
Received: by mail-wm1-f72.google.com with SMTP id f7-20020a7bcd07000000b003c6e73579d3so4967983wmj.8
        for <linux-s390@vger.kernel.org>; Tue, 25 Oct 2022 02:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N52J9g4cZ+1Mq7ONZQzSB0PW3bqTQoiOPUv/1Ns1UPw=;
        b=qRkbiuyOkBoOKrhNerRdrhlwPvxaOGtjgqrPQgZTjTfRZ1ZpAGnkL1VdQBAHLdOgXA
         qXmvqTCsByQsCZk0nOhqamkN/B/yqAbK89EhFvxTo0nI2SmQ7nBfwArFycSN0Ke84HLI
         yenZ/Mq0SsGX6kw9qMT9gFkckCGurjIrxH6iKPjyvtmqrGPvj90OOsE75RPkotJRBBKg
         7KZLJqQwuLV0M6LwU2+VStIcW8nkvoGRNp7ynY2mXRiF77VUIn3MD1eXA2wt/R52bS5v
         NulRz7zcbdcRNGegN7CtQaI56OT/pchlw8oEdi0wPRoDo0+zUxmfOruG7McjNWmZW3+1
         1jig==
X-Gm-Message-State: ACrzQf38WRWF/jOGOMPuo8N798iE7gAPA9yLWByaYymlzsrgU7lY2KWs
        RZIEK/izbQM8XmHysE/GSjnK/FKwKYu7zQ9ElyKJfOBNN69QaiQPiWKyvopYvOBZhxq/ENIC6AG
        OzazlVkDPj0GxDTkfFFF5Og==
X-Received: by 2002:a5d:6d0d:0:b0:230:1b65:a378 with SMTP id e13-20020a5d6d0d000000b002301b65a378mr25282790wrq.406.1666690227069;
        Tue, 25 Oct 2022 02:30:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7N8lway8LYM22bmLrqzEuyTCqW2V+jEHnyQjtJOL0+fVqPU1iWuXxFShng6/h9WrTr8DpxYQ==
X-Received: by 2002:a5d:6d0d:0:b0:230:1b65:a378 with SMTP id e13-20020a5d6d0d000000b002301b65a378mr25282776wrq.406.1666690226815;
        Tue, 25 Oct 2022 02:30:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:4e00:3efc:1c60:bc60:f557? (p200300cbc70b4e003efc1c60bc60f557.dip0.t-ipconnect.de. [2003:cb:c70b:4e00:3efc:1c60:bc60:f557])
        by smtp.gmail.com with ESMTPSA id t189-20020a1c46c6000000b003c701c12a17sm10237937wma.12.2022.10.25.02.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 02:30:26 -0700 (PDT)
Message-ID: <e9a237d7-3a34-11c8-1c5b-1a3c14e8cfb0@redhat.com>
Date:   Tue, 25 Oct 2022 11:30:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/1] KVM: s390: vsie: clarifications on setting the
 APCB
Content-Language: en-US
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        thuth@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, svens@linux.ibm.com
References: <20221025091319.37110-1-pmorel@linux.ibm.com>
 <20221025091319.37110-2-pmorel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221025091319.37110-2-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 25.10.22 11:13, Pierre Morel wrote:
> The APCB is part of the CRYCB.
> The calculation of the APCB origin can be done by adding
> the APCB offset to the CRYCB origin.
> 
> Current code makes confusing transformations, converting
> the CRYCB origin to a pointer to calculate the APCB origin.
> 


While at it, can we rename "crycb_o" to "crycb_gpa" and "apcb_o" to 
"apcb_gpa".

These are not pointers but guest physical addresses.

-- 
Thanks,

David / dhildenb


Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903BEC61DA4
	for <linux-s390@archiver.kernel.org>; Thu, 16 Feb 2023 13:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBPNFO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Feb 2023 08:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBPNFO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Feb 2023 08:05:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12DB4C6FE
        for <linux-s390@vger.kernel.org>; Thu, 16 Feb 2023 05:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676552656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WpU46aDI0Nq+Pm5BTLIuPyiBJXqm15CgT5zEhAsrlS0=;
        b=JBwNSp+1/ky85tZURB8ChYshnV5sgL9m4qc1zVQF36we71vKLrd53OpP46lLFMjRGIqwcx
        KlT3voBNRotuNNqFQljjCfoYzzHtWIT5ojsM62JZtYvrfJu5Ci6MyShHLrqWOMstJ5zE+m
        n9HoMiH963d3oS/KTTDtVvllp+Qw0OA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-496-uF2E66SXNeKVQYsvrtDngQ-1; Thu, 16 Feb 2023 08:04:15 -0500
X-MC-Unique: uF2E66SXNeKVQYsvrtDngQ-1
Received: by mail-wr1-f69.google.com with SMTP id r15-20020a5d494f000000b002c54d9b8312so230771wrs.5
        for <linux-s390@vger.kernel.org>; Thu, 16 Feb 2023 05:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpU46aDI0Nq+Pm5BTLIuPyiBJXqm15CgT5zEhAsrlS0=;
        b=bZ5WGU8eWVAeolW19BS5fJTZ2IjV3XIPI0yQ9p1vQZA+FDaeP1xscl09fZYkKmjQbJ
         2+rl7J605qJclq+ytzUb+JcuG6N1EcKZarhy8JlPKR/nDWzkbRXT4A+uZceivZiqOMh1
         cN53Eugm4U7oSyaX3pkihtS7ountQ5pDR65x+AEOq0XPHcvdoNCp4/YbwVCICAqHOtdb
         gD6/GWatJVAyedVtZqWrdAVHpinYAk5XD6HierNmfoZuXW8bGE+E4uRc4zS4qO9Gf3gW
         Pvnnv5uNgxMAhx40x7pNk7+X6cwqtBYskqTyaWChYzlKaN8eIaW20o0NBBmQ9AHZfmJ4
         dhUg==
X-Gm-Message-State: AO0yUKVDEArkNHLYT2RyQ6lWx5rGXZy8tqzbiiogEvupz8p6vUDe74KS
        Jqba2OEoIS/0h8AGm5GOxv6rOWrZ4+X48loRd5ikCUowbWaIvkEM0mjklF2wUTEJNo641mgvObD
        hfW/UcMLY9hm8qfChQFrF7Q==
X-Received: by 2002:a1c:cc17:0:b0:3df:e549:da54 with SMTP id h23-20020a1ccc17000000b003dfe549da54mr4335139wmb.17.1676552654229;
        Thu, 16 Feb 2023 05:04:14 -0800 (PST)
X-Google-Smtp-Source: AK7set8sW89+S6rdN2PFz8dxoWKxIGVdYL9e5lSreJUROczAagSAkfFun80bRQhysfYeh1OT/RcUMQ==
X-Received: by 2002:a1c:cc17:0:b0:3df:e549:da54 with SMTP id h23-20020a1ccc17000000b003dfe549da54mr4335106wmb.17.1676552653903;
        Thu, 16 Feb 2023 05:04:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003e00c453447sm4756678wmc.48.2023.02.16.05.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 05:04:13 -0800 (PST)
Message-ID: <2e1d3f81-9cc0-bf96-abde-a270a58701a1@redhat.com>
Date:   Thu, 16 Feb 2023 14:04:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/1] KVM: s390: vsie: clarifications on setting the
 APCB
Content-Language: en-US
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, cohuck@redhat.com, thuth@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        svens@linux.ibm.com
References: <20230214122841.13066-1-pmorel@linux.ibm.com>
 <20230214122841.13066-2-pmorel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230214122841.13066-2-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14.02.23 13:28, Pierre Morel wrote:
> The APCB is part of the CRYCB.
> The calculation of the APCB origin can be done by adding
> the APCB offset to the CRYCB origin.
> 
> Current code makes confusing transformations, converting
> the CRYCB origin to a pointer to calculate the APCB origin.
> 
> Let's make things simpler and keep the CRYCB origin to make
> these calculations.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---

Much better

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


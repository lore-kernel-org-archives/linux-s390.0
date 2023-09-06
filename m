Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABD1EB8FA5
	for <linux-s390@archiver.kernel.org>; Wed,  6 Sep 2023 07:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjIFHgT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 6 Sep 2023 03:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjIFHgS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Sep 2023 03:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69327E41
        for <linux-s390@vger.kernel.org>; Wed,  6 Sep 2023 00:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693985733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S9525qsdmaz1EKzskd2zaTN3MO2SfATilPf4OtTizIo=;
        b=J1f29eiHS3oxY2rNshLS0eRORWO+NLxFrUGCXN66XJr21rP+yNT00B61OiAR74dEIT83Fu
        664rjko/oIlQTo2cdsozOB6gIShL9ZOoVlPqsJSt9x/0zwgFzg8IeljkCjfKUnLSezgDHv
        TsR2fOHTrH2/BCcctcKbqAcP1cTwdWw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-L9t6Kif9NUWqIUzmfjDVoA-1; Wed, 06 Sep 2023 03:35:31 -0400
X-MC-Unique: L9t6Kif9NUWqIUzmfjDVoA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-401dba99384so20370055e9.3
        for <linux-s390@vger.kernel.org>; Wed, 06 Sep 2023 00:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693985731; x=1694590531;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9525qsdmaz1EKzskd2zaTN3MO2SfATilPf4OtTizIo=;
        b=JEEbJZX11pbJVhu8ulz43XHYqHh6eCbTYAtlmXelNyZicQr17mVZIQ/Lub2H33iFEQ
         KUTvsK4J57ssOvG4kdVrH/OvmLm5KD6fqMXtTVwyCm5+2siSNWXLsemFNWL8PwZ59zDs
         uY76vU5qIGlI2rPqlhOVyI8d5F18RZ6sJ6Erof/V/qDq6AYwEbNjHWppFiEYdmuU/upW
         YViVRzxv5ohMsmep5isEFheeHKLO+P0qJebc/Y/9Cmt/RGazpr3FMM8yvm3/7vlzY4IV
         DF6nivbLfd3CYf93GISNMzffubyIFQ7NU5zUHjzOotHt2vJSB6vTn9HOwsj2Vp0OnCvH
         Dcsg==
X-Gm-Message-State: AOJu0Yw+lpfsQZWsMjxn+/tZoetyM3AQh4KsQ8rXHH17c4UNf3Gi0Nnj
        bPBa42HfnyBiTqaWF3UYdMnQz9RrOpQp0wlc0WW3AYrYQ+adTcv1aHxh4Q5m7jM+JhAyy28/SLs
        mtc7GniF9MZCVRPvKNepGpThxxub79A==
X-Received: by 2002:a7b:cbcf:0:b0:400:8d91:ffe9 with SMTP id n15-20020a7bcbcf000000b004008d91ffe9mr1421845wmi.26.1693985730803;
        Wed, 06 Sep 2023 00:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMcPWL3aQHtiz5UoTH7jq3Jrne3uoeX28Xa/4VjaBF88KLbGYAciW2ubPscjXi/ru9eOQwew==
X-Received: by 2002:a7b:cbcf:0:b0:400:8d91:ffe9 with SMTP id n15-20020a7bcbcf000000b004008d91ffe9mr1421830wmi.26.1693985730459;
        Wed, 06 Sep 2023 00:35:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:6c00:92a4:6f8:ff7e:6853? (p200300cbc70c6c0092a406f8ff7e6853.dip0.t-ipconnect.de. [2003:cb:c70c:6c00:92a4:6f8:ff7e:6853])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c22d900b003fe2b6d64c8sm22213047wmg.21.2023.09.06.00.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:35:29 -0700 (PDT)
Message-ID: <73d4900e-52e6-8fce-ff91-8243dcd4d6da@redhat.com>
Date:   Wed, 6 Sep 2023 09:35:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] KVM: s390: add stat counter for shadow gmap events
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230904130140.22006-1-nrb@linux.ibm.com>
 <20230904130140.22006-2-nrb@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230904130140.22006-2-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04.09.23 15:01, Nico Boehr wrote:
> The shadow gmap tracks memory of nested guests (guest-3). In certain
> scenarios, the shadow gmap needs to be rebuilt, which is a costly operation
> since it involves a SIE exit into guest-1 for every entry in the respective
> shadow level.
> 
> Add kvm stat counters when new shadow structures are created at various
> levels. Also add a counter gmap_shadow_create when a completely fresh
> shadow gmap is created as well as a counter gmap_shadow_reuse when an
> existing gmap is being reused.
> 
> Note that when several levels are shadowed at once, counters on all
> affected levels will be increased.
> 
> Also note that not all page table levels need to be present and a ASCE
> can directly point to e.g. a segment table. In this case, a new segment
> table will always be equivalent to a new shadow gmap and hence will be
> counted as gmap_shadow_create and not as gmap_shadow_segment.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


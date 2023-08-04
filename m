Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CC9C001DB
	for <linux-s390@archiver.kernel.org>; Fri,  4 Aug 2023 10:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjHDKAY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 4 Aug 2023 06:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjHDKAP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Aug 2023 06:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B713B4C03
        for <linux-s390@vger.kernel.org>; Fri,  4 Aug 2023 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691143166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwNEzLWGsJF00DekH3AwAc6pC/o4FSo3yR01IWQfvHs=;
        b=atRJDwIqFj7xPQNjfN+KjoEIU7J6tr8ZvQIWdlsAk3vxWxps4QXFyQnIxvNqOqoBF7Vgw5
        zamyJTxwJr2U7cvWQ27j8+wC/PiDthSNrGAdi1cJrJyz3OTl9cH4cNTDY3ZFHzrCYBz2+O
        qTu389YXzUjNTZ+WveF02qpHTyB0IQI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-MpEB2PPfO62vAweWVYTXAQ-1; Fri, 04 Aug 2023 05:59:25 -0400
X-MC-Unique: MpEB2PPfO62vAweWVYTXAQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe13881511so14206605e9.3
        for <linux-s390@vger.kernel.org>; Fri, 04 Aug 2023 02:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691143164; x=1691747964;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwNEzLWGsJF00DekH3AwAc6pC/o4FSo3yR01IWQfvHs=;
        b=UA1/yctMab5oM8zg5NZFdd5Hr9OKwiz8MA3DTiYf7fIGJraK1k/8OyrFEuCJFi+1Pd
         KDBXZJlCPexWyMwhxGtvnaLImo6D7WYV/fOZBO0ahWSh6d9HIBdpmCQk7qovvqBtduqH
         1rIQpZPoN/aZU2PIhZF+2lhkzJ2rOpZ5G3W3PO4dr5jiSagExv32FcoSp9sdprknUZ02
         ff/1O5gLWvesV9kWtUpnUdNUVcID/iMI9u9sd7/iphuFlUGvFayd66G/8ZtFhQh3B2av
         OJq+eDeGTJbqjCsuk2feLiKEWqLnsloC7JgOr13hps76QKYzf2uug4bLOeBGzOu6UNtE
         Br9w==
X-Gm-Message-State: AOJu0Yxd3Kv2ONHBzBHG4+XCczJczvr4gzMaZF9EJ8wPoMuBlq33cgs5
        +Vk0G0iwBtrDtLrakaBRjQPuOfk/qrE5JWDnqI+COBp+wptuqB2M6iLSGrbEOwWimdeA+Dw0UUz
        ed8pyxFTjibBwUvkfETU0cLhotnSnHQ==
X-Received: by 2002:a5d:680e:0:b0:317:4ef8:1659 with SMTP id w14-20020a5d680e000000b003174ef81659mr812283wru.28.1691143164584;
        Fri, 04 Aug 2023 02:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEue9tewoodArBSqmAheDz6m/xWkDWULrRXyLWMYNeF828bYBIF2Vl1Pj7mVe+YTuhO+DS5ow==
X-Received: by 2002:a5d:680e:0:b0:317:4ef8:1659 with SMTP id w14-20020a5d680e000000b003174ef81659mr812271wru.28.1691143164268;
        Fri, 04 Aug 2023 02:59:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:5900:10b9:2373:11c6:216c? (p200300cbc724590010b9237311c6216c.dip0.t-ipconnect.de. [2003:cb:c724:5900:10b9:2373:11c6:216c])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d5483000000b0030ae53550f5sm2092325wrv.51.2023.08.04.02.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 02:59:23 -0700 (PDT)
Message-ID: <2e2c5026-4aff-0dc6-9f92-70cb8365c106@redhat.com>
Date:   Fri, 4 Aug 2023 11:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] KVM: s390: add tracepoint in gmap notifier
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230510121822.546629-1-nrb@linux.ibm.com>
 <20230510121822.546629-3-nrb@linux.ibm.com>
 <6f8951e2-9ea6-5bad-9c2c-b27d70d57ffe@redhat.com>
 <169114236545.36389.12085901437050856794@t14-nrb>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <169114236545.36389.12085901437050856794@t14-nrb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

>>>    
>>>    #endif /* _TRACE_KVMS390_H */
>>>    
>>
>> In the context of vsie, I'd have thought you'd be tracing
>> kvm_s390_vsie_gmap_notifier() instead.
> 
> Right, I can change that if you / others have a preference for that.
> 

No strong opinion, just a thought.


-- 
Cheers,

David / dhildenb


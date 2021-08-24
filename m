Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED15C4338F
	for <linux-s390@archiver.kernel.org>; Tue, 24 Aug 2021 06:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E592861265
	for <linux-s390@archiver.kernel.org>; Tue, 24 Aug 2021 06:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhHXGus (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 24 Aug 2021 02:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28954 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230192AbhHXGus (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Aug 2021 02:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629787804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=smEbHzblXx6RDwsdPQ8zTE40MkkErt1zu2jIV9SRWO4=;
        b=HAb9O1PUA2T6YyDC/+398jNRBCA1gmST8klL4o9TEzZd+xqSA07S13kLz/I+XwnFkI5ctE
        xkGFTe0teSJ4Y25GtESV1aGOK6AMOX/Enj924eHHwu/t7GLZEQ6Agh0uXvKpl/M2k+tyc1
        JCOjNX3g/SrpO6zKfeeQfnhAHX8cDME=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-KwtN0Y80MEqEB1BxkkMKHA-1; Tue, 24 Aug 2021 02:50:02 -0400
X-MC-Unique: KwtN0Y80MEqEB1BxkkMKHA-1
Received: by mail-wm1-f69.google.com with SMTP id j33-20020a05600c1c21b02902e6828f7a20so761616wms.7
        for <linux-s390@vger.kernel.org>; Mon, 23 Aug 2021 23:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=smEbHzblXx6RDwsdPQ8zTE40MkkErt1zu2jIV9SRWO4=;
        b=R5JKf9XdJtWB6rZOtghR+XdGJglSjZ4XIe2DXEUaaH5qiNs9OYDSYnDfRilLERD/0u
         yDC9uZKaw4BQTzbaby6jvmF56g5p1GzM+7vnznNK/PxohPz9sbDFfZPzPzjvTHhUV+kf
         UwwoIvJWU4h/lOzCcErLkN3YJwkf8PgxNfPIFiLY4xsgVXBRD5TK9+UCwGNMw51bYXO/
         58HLlgjqGxlEFsEL9UFLebQTP1dhAjmptzUPJbgvVD6yRPo1NE1pGQLrPFCtkqc3WCT/
         MmMKOfZHwYWDLFHZ5mCOv7PzgDf7idghTLQMYJpJZZGZtjoT9whRHQ1Wr4d7KmIsJzgw
         nPzw==
X-Gm-Message-State: AOAM532mGbjdcXNYXoHpcTSouGqULiaiE/cD/lXGHH7LatNumMB8bFDx
        6ToRdEqPj9yytgVzm4Ya+Nt88aEVBrtEkGc43CNqjwHycftJTDBlpSLMD+6fXHX2XNvoCWDcrtL
        xPrnGIfHqJ+KHTxin0ukBASwtOjhT9qO0Kutw8dVvwxRWoiDbgv7INNQB/lNa4+Fifex0yw==
X-Received: by 2002:a05:600c:19ce:: with SMTP id u14mr2576212wmq.12.1629787801545;
        Mon, 23 Aug 2021 23:50:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzL1/974TaRC4DVC7n3KRvEvlLa6nIPMFoGRrCmDENm2VXp4QK8Bf5jNXbnI/AdFA1V0Enzg==
X-Received: by 2002:a05:600c:19ce:: with SMTP id u14mr2576181wmq.12.1629787801219;
        Mon, 23 Aug 2021 23:50:01 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c4d.dip0.t-ipconnect.de. [79.242.60.77])
        by smtp.gmail.com with ESMTPSA id g138sm611737wmg.34.2021.08.23.23.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 23:50:00 -0700 (PDT)
Subject: Re: can we finally kill off CONFIG_FS_DAX_LIMITED
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org
References: <20210820054340.GA28560@lst.de> <20210823160546.0bf243bf@thinkpad>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c186f1f4-0217-35b4-ba4a-6c20aece3d8f@redhat.com>
Date:   Tue, 24 Aug 2021 08:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823160546.0bf243bf@thinkpad>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23.08.21 16:05, Gerald Schaefer wrote:
> On Fri, 20 Aug 2021 07:43:40 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
>> Hi all,
>>
>> looking at the recent ZONE_DEVICE related changes we still have a
>> horrible maze of different code paths.  I already suggested to
>> depend on ARCH_HAS_PTE_SPECIAL for ZONE_DEVICE there, which all modern
>> architectures have anyway.  But the other odd special case is
>> CONFIG_FS_DAX_LIMITED which is just used for the xpram driver.  Does
>> this driver still see use?  If so can we make it behave like the
>> other DAX drivers and require a pgmap?  I think the biggest missing
>> part would be to implement ARCH_HAS_PTE_DEVMAP for s390.
> 
> Puh, yes, that seems to be needed in order to enable ZONE_DEVICE, and
> then we could use devm_memremap_pages(), at least that was my plan
> some time ago. However, either the ARCH_HAS_PTE_DEVMAP dependency
> is new, or I overlooked it before, but we do not have any free bits
> in the pte left, so this is not going to work.
> 
> Would it strictly be necessary to implement ZONE_DEVICE, or would
> it be enough if we would use e.g. add_memory() instead of just
> adding the DCSS memory directly to the kernel mapping via
> vmem_add_mapping()? That way we might at least get the struct pages,
> but somehow it doesn't feel completely right.
> 

add_memory() is for adding system RAM. I don't think that's what you 
want in the case of DCSS. Supporting ZONE_DEVICE cleanly would be ideal.

-- 
Thanks,

David / dhildenb


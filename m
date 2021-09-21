Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6746AC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 21 Sep 2021 13:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC0B61168
	for <linux-s390@archiver.kernel.org>; Tue, 21 Sep 2021 13:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhIUNGF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232344AbhIUNGF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Sep 2021 09:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632229476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DEFJseg8rq7SE74sOaoFIgE1jPfm5DbO1epvMS8BpNI=;
        b=OyfnwmV4UDsNDYE1ekaal0phNcYdQNqJx1o+5dd7sQxilIWQ5IxK8LZI2SeCAL2GP37Sku
        HarARw5br5dzhdtq2gE59JAgX/dcR1IaUO//f6jiPgSogU93/JJ9lur9wrwR2I1NarWAXZ
        xObAg9pV+jtdN70MQjzLuhYShwtkyko=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-v41aNJMVPQyiyaAMhurHLQ-1; Tue, 21 Sep 2021 09:04:35 -0400
X-MC-Unique: v41aNJMVPQyiyaAMhurHLQ-1
Received: by mail-ed1-f72.google.com with SMTP id b7-20020a50e787000000b003d59cb1a923so18060499edn.5
        for <linux-s390@vger.kernel.org>; Tue, 21 Sep 2021 06:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DEFJseg8rq7SE74sOaoFIgE1jPfm5DbO1epvMS8BpNI=;
        b=Ddr2/fsW/v7WGhsWaWDx37lONyFRrDQ5jEOO5RGh1r9AICyf11TGICQMzEOEwldJ5S
         ZAWOn0CK/kUQYQK3w5LBA84DiszX30aJXZ01WmResL1xOcWUJmhDkea+IW5oMcCBuODd
         db6reQ8tfaWXC3PH9NR6JSNOjCrcesyxBQzUM/xd2wNe4pAJcfK7Q4zmpK6KNjW+Gcf3
         mJOQ0FxhYMOcA517WAtniqT3WEFTqLde96aVtWcdET+vEl+hZPJZXjfA/Gp0vHMAaImH
         aQNLlNP8K2HnRtID54nZVazWjDsGpa8FJRq4wjAQLfX2R0ISYr9MDNNdBUPnm/QpD9T2
         Ru5w==
X-Gm-Message-State: AOAM531FM0OdN7931QQcxXvocphKlWXUoylYD7X3otvI4J2diKLKh+G+
        Oc7smp4Fk/8Om20lc3pmwPX4hrHAEG04Jusc+MzlTXAme1SK5Nsq+AA8ICakTK8CsGfJ9apmBby
        2h2boX5anoLwpnkY7NnzrKg==
X-Received: by 2002:a05:6402:2cd:: with SMTP id b13mr35310665edx.267.1632229473812;
        Tue, 21 Sep 2021 06:04:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDA29e1Aksu1e28kf6zXlPoA7bgowJwNPG2Y3YjfjcqiNKuIQK2uhaN2r0tICRjjw+CMDp6A==
X-Received: by 2002:a05:6402:2cd:: with SMTP id b13mr35310646edx.267.1632229473573;
        Tue, 21 Sep 2021 06:04:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y5sm8429318edt.21.2021.09.21.06.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 06:04:32 -0700 (PDT)
Subject: Re: [PATCH 0/1] KVM: s390: backport for stable of "KVM: s390: index
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, KVM <kvm@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20210920150616.15668-1-borntraeger@de.ibm.com>
 <b9b9e014-d8d9-1a76-679b-cd7af54ad3f9@redhat.com>
 <e8881cf8-987c-e2b2-5cda-8e3c5a19cc99@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cc34be64-cfd5-798a-9192-be0c6b839224@redhat.com>
Date:   Tue, 21 Sep 2021 15:04:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e8881cf8-987c-e2b2-5cda-8e3c5a19cc99@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 21/09/21 10:46, Christian Borntraeger wrote:
>>> 
>> 
>> Sure, I suppose you're going to send a separate backport that I can
>> ack.
> 
> It does seem to apply when cherry-picked, but I can send it as a
> patch if you and Greg prefer it that way.

Yes, please do!  Thanks,

Paolo


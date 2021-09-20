Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE20AC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 20 Sep 2021 18:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D8561268
	for <linux-s390@archiver.kernel.org>; Mon, 20 Sep 2021 18:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352671AbhITSKn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 20 Sep 2021 14:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358505AbhITSG5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Sep 2021 14:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632161126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQ2nEJldCi7rrPXAbLdRM2HtG7wBW/RDodqNONHFaZI=;
        b=F2pRRfTNFJHmB/wlADRyrEA9xvTXJEzP4zysDfJW8Q2C5mBeVjihsw0mY9sdA3UgvYKIle
        ou4p/ZN+JLKlk4GH8V84NqAHrGkxLDuX3Y6zRP9vGRvG6+DYMjl/Es5Bk1UuyD9N/fAe71
        MXsAz+Kp6qAFnfgN7+k4siG/vmGoFHs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-KLm24dvXOnCSare0ZkuQQA-1; Mon, 20 Sep 2021 14:05:25 -0400
X-MC-Unique: KLm24dvXOnCSare0ZkuQQA-1
Received: by mail-wr1-f69.google.com with SMTP id r9-20020a5d4989000000b0015d0fbb8823so6752177wrq.18
        for <linux-s390@vger.kernel.org>; Mon, 20 Sep 2021 11:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MQ2nEJldCi7rrPXAbLdRM2HtG7wBW/RDodqNONHFaZI=;
        b=3nwvbEgW8a44v5lPEduw1vfpBppCefjFdydYbqbTyef7Km4TaXcGyOPVTvmPVg4r1y
         LSTkSpGz2czCTqBrhJMrAhRdJaj0WuMxnjSTMLJ6NnKSz/XtsRmLlMRAy+yKKmJuj47/
         aekvHblruTtvKD3NagTT25k2nXr1cxVrNas//TBQ8BLTgLtF4MPb6OyxxsjLgEp3mMyS
         iHYVND42XXOd1axwQGB8/BtUmld5MTopPFNK9MQLBYxNlLgzifLCRa6TcXKkhnzl6v1z
         RWH6UwnL8vSOlHaqRr5hZNxARMq4umEwOzMkhojmWaYEZXturiGczaa3+7wPbxDH1EIj
         hwzw==
X-Gm-Message-State: AOAM530OrkoQkbNISvjsF0l9anFaKKLJc4ZUx3S2Q5Mvrw7JcQETmJWx
        qpVr0TsZ8BftLOHg9sKnZIShkFSvWYNljSH7PslkfNGTgxeNggzGk6iOMYn5GznrdiMJK50xWsz
        8tUlhmGlXB/fbAoVZ7aoJLw==
X-Received: by 2002:a5d:598c:: with SMTP id n12mr29456628wri.391.1632161124509;
        Mon, 20 Sep 2021 11:05:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYp4hW7E1g6b+/rISmMbNzmIAqnwgwgNMeutkchln13LhBXc0BGdLZt9ZAqx8AsyogmjkBZg==
X-Received: by 2002:a5d:598c:: with SMTP id n12mr29456593wri.391.1632161124284;
        Mon, 20 Sep 2021 11:05:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l15sm207553wme.42.2021.09.20.11.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 11:05:23 -0700 (PDT)
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9b9e014-d8d9-1a76-679b-cd7af54ad3f9@redhat.com>
Date:   Mon, 20 Sep 2021 20:05:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210920150616.15668-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 20/09/21 17:06, Christian Borntraeger wrote:
> here is a backport for 4.19 of
> commit a3e03bc1368 ("KVM: s390: index kvm->arch.idle_mask by vcpu_idx")
> This basically removes the kick_mask parts that were introduced with
> kernel 5.0 and fixes up the location of the idle_mask to the older
> place.
> 
> FWIW, it might be a good idea to also backport
> 8750e72a79dd ("KVM: remember position in kvm->vcpus array") to avoid
> a performance regression for large guests (many vCPUs) when this patch
> is applied.
> @Paolo Bonzini, would you be ok with 8750e72a79dd in older stable releases?

Sure, I suppose you're going to send a separate backport that I can ack.

Paolo


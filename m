Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64096C48BE8
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 09:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32AD161357
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 09:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhFNJxc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Jun 2021 05:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232796AbhFNJx3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Jun 2021 05:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623664286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVGqXIcKrLCK11mCl5CKOO3c7mK+et1d86zdU/of4sY=;
        b=Jb5JdD8X/xF0x/6xn+VQj7HDjgkfSpyZXv+u8LxkZZRpkqK8QiJbszXNbbqmytvJUswjQs
        Wnh3v1wG7WdNrqW3OaEz5NFOC+Kgg9a4MAO1oogYDNpFmeHbbOrpK2aN02aRyD1pBINXUw
        dM7asWdPEOMhXzzu0G0sEYa0G83cYJ4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-XH7K5m0zNlC9cT8oUA849w-1; Mon, 14 Jun 2021 05:51:24 -0400
X-MC-Unique: XH7K5m0zNlC9cT8oUA849w-1
Received: by mail-ed1-f72.google.com with SMTP id y16-20020a0564024410b0290394293f6816so2590700eda.20
        for <linux-s390@vger.kernel.org>; Mon, 14 Jun 2021 02:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yVGqXIcKrLCK11mCl5CKOO3c7mK+et1d86zdU/of4sY=;
        b=Dt+/ZiHcOSzdBBp7bXAe0wb9HWv5TjECKDBe5BxkUPSx2hGuTXoLyOJOws8Jmmz84O
         ycMYmvfjNfat38KiY435otfq8780kEJ6huDQx7XKwFXn1npQKDuukEz+lCD38/NkxF5f
         dg7cP2w/yEgNHiFefSt56/4J5BuYT1J18DFDVPSCPszQy0p8BLwJrsU/GfamIdcBRKY1
         ZPmH25JNhgIScWIqcAM1xFYgjrN0lgUSbswWoa4N7J9PPj+uigjymf+3epylXME9uh0M
         zmDLQbYffdAhr/0j+fwf8993v0PYuEif12rxtOvx9rRH3N4ErVbixucqJ7lgr4Mr2OnL
         ZA6A==
X-Gm-Message-State: AOAM533qXaVRo59dvKXqhx7Ny0IfIFnvtJj0B1VZp61kbDQlLw/3pil3
        jACAkvJ/P12TbyZcfELRKyatDDpXzknJd7Kn8Sj+hncCBSY0W13VblVC+r7qTS8dyGpI/f8Ljur
        OeDSvvJEHjGHx59YdB7rHtQ==
X-Received: by 2002:a17:906:606:: with SMTP id s6mr14277117ejb.206.1623664283795;
        Mon, 14 Jun 2021 02:51:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUGdB6YCrtVUeX6wpPs0U6HuF+wRnjGRZ9weZzhvjGvM0kMMRuORQ5jQGRt+viUDl0Dzm5nQ==
X-Received: by 2002:a17:906:606:: with SMTP id s6mr14277110ejb.206.1623664283633;
        Mon, 14 Jun 2021 02:51:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y15sm8131933edd.55.2021.06.14.02.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 02:51:22 -0700 (PDT)
Subject: Re: [PATCH 2/4] KVM: stats: Use binary stats descriptors for debugfs
 interface
To:     Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Fuad Tabba <tabba@google.com>
References: <20210614025351.365284-1-jingzhangos@google.com>
 <20210614025351.365284-3-jingzhangos@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b57502b-116a-9be5-fa2f-1e8f5b5fce2d@redhat.com>
Date:   Mon, 14 Jun 2021 11:51:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210614025351.365284-3-jingzhangos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14/06/21 04:53, Jing Zhang wrote:
> +	STATS_DESC_ICOUNTER_RONLY(VM, lpages),
> +	STATS_DESC_ICOUNTER_RONLY(VM, nx_lpage_splits),
>  	STATS_DESC_ICOUNTER(VM, max_mmu_page_hash_collisions)

I think we're now adding too many macros.

max_mmu_page_hash_collisions is the only remaining instant counter that 
is not read-only.  In fact, in the statsfs prototype we made all instant 
counters read-only.

You could add a third type in addition to instant and cumulative, let's 
call it "peak".  This essentially corresponds to the "max" aggregation 
function in the statsfs prototype.  Then instant counters would be read 
only, while cumulative and peak would be read-write.

Paolo


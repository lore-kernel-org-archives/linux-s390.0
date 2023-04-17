Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0C3C77B70
	for <linux-s390@archiver.kernel.org>; Mon, 17 Apr 2023 11:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjDQLaR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 17 Apr 2023 07:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjDQLaQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Apr 2023 07:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D6B135
        for <linux-s390@vger.kernel.org>; Mon, 17 Apr 2023 04:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681730838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVc9uxy2kIdreOR/jYYEkHBdj+2RYiJitTncQTj92Ak=;
        b=NanM95DIf6UqjG2Vx5RF7ykf0oZmfTs/2USLb19AXJCGj+zVOHGy9cSV2QghmE+K5qo87U
        qzqBOFXZ0PgBHYGDwQ5N3yrClRiR7CQFCcnmMLRBQX91F/5zVnjiYosuoqmja2QAitRaHU
        LDcF0eQkZnNUwADKchhrd4Jv61QWPi0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-j9XW0plZMwyCmigtu_-ofQ-1; Mon, 17 Apr 2023 07:01:23 -0400
X-MC-Unique: j9XW0plZMwyCmigtu_-ofQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2efbab2e7ffso389710f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 17 Apr 2023 04:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681729281; x=1684321281;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVc9uxy2kIdreOR/jYYEkHBdj+2RYiJitTncQTj92Ak=;
        b=OD7vI020Td72zlGH5A/QekBxb/4dWaTpP/7px+6Q7KaJByljX55Z6FCXz1TyeM/Uyh
         KOwk+WXebIEQ0ohohAESZ3UiTRCqkDc791QxihfxCD2ansE9sn5jD5Tr0Xftyl3BB8Wh
         hL81/REmOFurNi5CUt6hTIDRLsHz5ox3S+SM/eGiax0R3gZRAzPvJKOkTNaZYAOAAsf+
         U0p8OqcJhtCoellxtE2VtHm5F1GK7TcLyXEtrda/YzyoSskJFgZbIy9bIdTCG+n+vrII
         PDRh8eatCNmwNYeLu9XA8SO9K0k44+jSPi055DcgURxF0bLDHW+JAnMlIcVZXvz5tXZM
         9w5g==
X-Gm-Message-State: AAQBX9cRV6r/WTzQZQElga42X7AoT+4tysilHD4kiRx2M615ujTURiBo
        Et6cLS6GanLWrEwbScjljdhPk6Htljeh7l40XTSG9bo363cZyrXP5Zkcmm+cFkt7bzNwCde37bV
        45IIpN0WZnaTeNn72q9GCDQ==
X-Received: by 2002:a05:6000:1376:b0:2f7:fb78:9694 with SMTP id q22-20020a056000137600b002f7fb789694mr5066260wrz.17.1681729281617;
        Mon, 17 Apr 2023 04:01:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZQIa4sVrexrjBGWt+x2dl05vD2C7OxIO4qZKWXoX9kbiyotAMI/EdKnSlVTtQjGuOSPjILbQ==
X-Received: by 2002:a05:6000:1376:b0:2f7:fb78:9694 with SMTP id q22-20020a056000137600b002f7fb789694mr5066215wrz.17.1681729280958;
        Mon, 17 Apr 2023 04:01:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d4fcc000000b002f22c44e974sm10214704wrw.102.2023.04.17.04.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 04:01:20 -0700 (PDT)
Message-ID: <8a323d9f-f54e-065d-d611-0a07aea170c8@redhat.com>
Date:   Mon, 17 Apr 2023 13:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 3/7] mm/gup: remove vmas parameter from
 get_user_pages_remote()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1681558407.git.lstoakes@gmail.com>
 <523f0764f4979276a6d4b89cbad9af9124e4bf0a.1681558407.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <523f0764f4979276a6d4b89cbad9af9124e4bf0a.1681558407.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 15.04.23 14:09, Lorenzo Stoakes wrote:
> The only instances of get_user_pages_remote() invocations which used the
> vmas parameter were for a single page which can instead simply look up the
> VMA directly. In particular:-
> 
> - __update_ref_ctr() looked up the VMA but did nothing with it so we simply
>    remove it.
> 
> - __access_remote_vm() was already using vma_lookup() when the original
>    lookup failed so by doing the lookup directly this also de-duplicates the
>    code.
> 
> This forms part of a broader set of patches intended to eliminate the vmas
> parameter altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---

I guess we should never drop the mmap lock temporarily in these cases, 
so it's fine.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


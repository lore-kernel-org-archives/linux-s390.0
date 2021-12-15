Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03918C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 15 Dec 2021 13:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242827AbhLONYf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Dec 2021 08:24:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49720 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237399AbhLONYe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Dec 2021 08:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639574674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=faX0xzTuw4r5Ss1p1Z66O3C+rjUZMW4qDeU2/6j1vvQ=;
        b=B0tBW3Iv4VJi6HafhbAT2cNrO+1o1JkbEZeU86ah7IK/KSPLo13Nl7CbuHXcHLUpVqKslH
        +iiG+SWpPlbb7EFHFG5wEIrvsZYwkk4jv8LVU1YEYq609Cv6+lnaRhAsigB0vZT6m+DrSO
        L2YDG4ZWaG2ur0iRwmOOrE0VQZskDYU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-h-eYk1FxOqCAGHnfQ4QRlQ-1; Wed, 15 Dec 2021 08:24:33 -0500
X-MC-Unique: h-eYk1FxOqCAGHnfQ4QRlQ-1
Received: by mail-wr1-f70.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so5916704wrd.1
        for <linux-s390@vger.kernel.org>; Wed, 15 Dec 2021 05:24:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=faX0xzTuw4r5Ss1p1Z66O3C+rjUZMW4qDeU2/6j1vvQ=;
        b=MHwvBSW+2vtxRfP7ODYebf/4enUAIDaAV6HNVE1MUjf53SS4M6iJ5q+r3nJp0YhPyQ
         lypMLK7xbY9dqdL1GwgLHJ3ruN8Oyxsg5j9UuZkJT0atluNHr4/cwz072YapYo0LadII
         hYgqY+n3nA3WjTe3QZKmrWgeqqIiVoS57RPSDotTweiZeWfXXNgkzNPNzqmvgOyHXeBg
         KveaTktb+sbndw19cX3kUep6bstLAPl6oROHRAnhNS86DIjZs2P6wpCmmrENZRYfjv8F
         lKFUWMuiJn5ODGNEpFzKZURVcl3vGGre9MYkq7/oOgF6pC2orIz7Zd0/dIdAkYIK58fT
         NLLw==
X-Gm-Message-State: AOAM532jWX7WN9Haga/0hPlfekxe0drtedNvVV6g2n85iUPaXrJ3R97n
        +Z24JpE1rVI0NTG+maTtat/JUbQe+ScGycS7SuOyW3EATE9snKXXl2t+LyiAOi1TwckHMNUnUzA
        QkvhzlUGv1flYZr80hUK8Rg==
X-Received: by 2002:a5d:4e92:: with SMTP id e18mr4477449wru.89.1639574672098;
        Wed, 15 Dec 2021 05:24:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvYE115YTEnXyOnYw+6M9nPcYQcDwa5GAYcHppd/Ruc2VVaVYWw55fHwyFOHuOPUuAyhomuw==
X-Received: by 2002:a5d:4e92:: with SMTP id e18mr4477429wru.89.1639574671898;
        Wed, 15 Dec 2021 05:24:31 -0800 (PST)
Received: from [192.168.3.132] (p5b0c609b.dip0.t-ipconnect.de. [91.12.96.155])
        by smtp.gmail.com with ESMTPSA id b132sm1894704wmd.38.2021.12.15.05.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 05:24:31 -0800 (PST)
Message-ID: <3832e4ab-ffb7-3389-908d-99225ccea038@redhat.com>
Date:   Wed, 15 Dec 2021 14:24:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH v5 1/1] KVM: s390: Clarify SIGP orders versus
 STOP/RESTART
Content-Language: en-US
To:     Eric Farman <farman@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20211213210550.856213-1-farman@linux.ibm.com>
 <20211213210550.856213-2-farman@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211213210550.856213-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 13.12.21 22:05, Eric Farman wrote:
> With KVM_CAP_S390_USER_SIGP, there are only five Signal Processor
> orders (CONDITIONAL EMERGENCY SIGNAL, EMERGENCY SIGNAL, EXTERNAL CALL,
> SENSE, and SENSE RUNNING STATUS) which are intended for frequent use
> and thus are processed in-kernel. The remainder are sent to userspace
> with the KVM_CAP_S390_USER_SIGP capability. Of those, three orders
> (RESTART, STOP, and STOP AND STORE STATUS) have the potential to
> inject work back into the kernel, and thus are asynchronous.
> 
> Let's look for those pending IRQs when processing one of the in-kernel
> SIGP orders, and return BUSY (CC2) if one is in process. This is in
> agreement with the Principles of Operation, which states that only one
> order can be "active" on a CPU at a time.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---

In general, LGTM. As raised, with SIGP RESTART there are other cases we
could fix in the kernel, but they are of very low priority IMHO.

-- 
Thanks,

David / dhildenb


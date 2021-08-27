Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE767C432BE
	for <linux-s390@archiver.kernel.org>; Fri, 27 Aug 2021 07:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7FA560FD8
	for <linux-s390@archiver.kernel.org>; Fri, 27 Aug 2021 07:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244368AbhH0HU4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244255AbhH0HUz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Aug 2021 03:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630048806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8VasvezmSl84LxW/Gp2bxkUkiZuhYPO9+N7tbIG3zY=;
        b=Ukft8AyyQdHvZsMsVfmAo5kK41gYoliekqjx+2/G9L9tZz1ynD87tDugwXmTWFSUBfG2X1
        Bm/ZLd9URa6hmUUwKyXILm84FWteLpLHU+I2oN9bKC5CLsuCfCK9lokVr0Xo9ptkXG3q5s
        ZcX+jrgwYLoxVvYalNCcxw+t4gQ2G9U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-dp10PwpzMCeuV0Wy6_rZFw-1; Fri, 27 Aug 2021 03:20:05 -0400
X-MC-Unique: dp10PwpzMCeuV0Wy6_rZFw-1
Received: by mail-wm1-f71.google.com with SMTP id f19-20020a1c1f13000000b002e6bd83c344so1453121wmf.3
        for <linux-s390@vger.kernel.org>; Fri, 27 Aug 2021 00:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M8VasvezmSl84LxW/Gp2bxkUkiZuhYPO9+N7tbIG3zY=;
        b=Z4P+GU+yD+ocL9Xndiu7fVt1gi2OgiP6wqZQYQEHKBrw/gXpIeil2FOXMtdnJpipZ3
         KWu04ExgNCTWc2aSLwYbjTQoLe1iVD0IL16FZ5lw45YkSsSlrocM/4AgGQk9v6rPrwlI
         hw6fi3TxgtRWCRpYg61am7nOiSVV3DjKDsjnWhBlsXBiIHsaEUX78PyRyWNzP3kT8XXb
         oAYuMZLVGJ5g5TMnJzgtFgvV3RunABCMu/sn7fHPnKhuFmJj61O3JLB1t/F3LY38FIVw
         xEI4eddfM8lg3H10Mii+x3evSCKNwC5ECGOy2UOxVSpXsr2Y/JVFWBewoAJBV469yt6p
         pUWA==
X-Gm-Message-State: AOAM533gfmJl+gnooYYeFvhhH37zl6K8g1qA6Eo1jjbb0Lx30457ZbIK
        bE7ssHC8lBKSpY1hLzVNqfp+2lxRd8Ssch1f+M7V94Z7sdfgw28MVpChfo7WRaV7MCz+vZq0tVX
        c9ftNywEieMbMdPEF5/ZeEg==
X-Received: by 2002:a5d:58e7:: with SMTP id f7mr8684513wrd.51.1630048804263;
        Fri, 27 Aug 2021 00:20:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTl9i5nBeoXpyrIICHyuDAVdEjoMlEzjsx5J+YiYXGLf74oC1sYlJ6u79cx1FXoWewoLtWBw==
X-Received: by 2002:a5d:58e7:: with SMTP id f7mr8684494wrd.51.1630048804134;
        Fri, 27 Aug 2021 00:20:04 -0700 (PDT)
Received: from thuth.remote.csb (dynamic-046-114-148-182.46.114.pool.telefonica.de. [46.114.148.182])
        by smtp.gmail.com with ESMTPSA id n20sm4115941wms.15.2021.08.27.00.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 00:20:03 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v2 3/3] lib: s390x: Control register
 constant cleanup
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210820114000.166527-1-frankja@linux.ibm.com>
 <20210820114000.166527-4-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <a8302c3a-1bd6-7dbe-62d8-85601f28301e@redhat.com>
Date:   Fri, 27 Aug 2021 09:20:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210820114000.166527-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 20/08/2021 13.40, Janosch Frank wrote:
> We had bits and masks defined and don't necessarily need both.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/asm/arch_def.h | 28 ++++++++++++----------------
>   lib/s390x/smp.c          |  3 ++-
>   s390x/skrf.c             |  3 ++-
>   3 files changed, 16 insertions(+), 18 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


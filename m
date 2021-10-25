Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D64C433FE
	for <linux-s390@archiver.kernel.org>; Mon, 25 Oct 2021 12:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059DB60EFE
	for <linux-s390@archiver.kernel.org>; Mon, 25 Oct 2021 12:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhJYM1l (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 25 Oct 2021 08:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232951AbhJYM1j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 Oct 2021 08:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635164717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=18r9doZrRUt+BZbjEGhEOloW0CqhcTxE7FqwLW3Bz2k=;
        b=djjFLCnfWJRQuDHKw5NFIpGO0scigJgFKpJss4MZ/MJx6Jbjah83pL9TCMPub3fSLy8B3t
        vimtamFQ4LkkeGMZ3jDU//qrfJGsAWlDsKdC7a5jlrN4TjTCIZy2ukKqcXmswuotD2+z68
        uPwCj/EUVh6T91/izHtKsVNjej+Ir0k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-IH8Y8G2DNyiwuqNjEg9AKA-1; Mon, 25 Oct 2021 08:25:14 -0400
X-MC-Unique: IH8Y8G2DNyiwuqNjEg9AKA-1
Received: by mail-ed1-f69.google.com with SMTP id b17-20020a056402351100b003dd23c083b1so7849422edd.0
        for <linux-s390@vger.kernel.org>; Mon, 25 Oct 2021 05:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=18r9doZrRUt+BZbjEGhEOloW0CqhcTxE7FqwLW3Bz2k=;
        b=xqvy8NPTfYyZUy5hJBvoFuTDVuZifRlyll5A8Zra6TbyR2+Ljs1jK8TiX4goxrEAnR
         V9ZyhOO0AEpiRWJCiCVJ2+XXKnGAAnS0gU1YNiForV4WZGsIhlXo3M+2SZQqym8w8xec
         9xReN5NzVWUekBIg8P4q1ISC4E0g+EibfuIegfBDlkGplqNtoFENsVnkr4MKpX/cZPw3
         UQoBbKpArAzvjnx1HNw+6t072G0NPG9kJIn07S4ehSXwmpOmsQCVRNQqXS5kUZ91oSI+
         I9jhNWxKgdFpTjtZn9aCKjEuCNoEVzmEMfqXUFU/XWkfgGjJfJeXN16Bxjoy1oPOTNHD
         5FkA==
X-Gm-Message-State: AOAM530IugkaP8lkNYt1pKbsENX38/jhx+vLmfIy4J9RhghvLV3rPhVU
        UgHyOneVc5Fg5QxA9B72yes9LfxzWtFyb9CWEBp+gHJ2fmacfXVuydDXOHcMIu9TzpftCRGxD8+
        /xmH2hO4ERFzRXKBfCyBQ49Ps3J1CHIrCIR02RhGOdrf3T676zC0r+QZBL23hfVzvRrikZw==
X-Received: by 2002:a05:6402:5114:: with SMTP id m20mr25817508edd.256.1635164713026;
        Mon, 25 Oct 2021 05:25:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDE2vtGk/FAnvNWNoKQg2UsRP1gq3GewEgLeJl6BRtSGccZejtvGjAdkUOW/VFxysNmyOaYw==
X-Received: by 2002:a05:6402:5114:: with SMTP id m20mr25817469edd.256.1635164712785;
        Mon, 25 Oct 2021 05:25:12 -0700 (PDT)
Received: from thuth.remote.csb (tmo-096-150.customers.d1-online.com. [80.187.96.150])
        by smtp.gmail.com with ESMTPSA id j11sm7341803ejt.114.2021.10.25.05.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 05:25:12 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v3 1/1] s390x: Add specification exception
 interception test
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Janosch Frank <frankja@de.ibm.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20211022131057.1308851-1-scgl@linux.ibm.com>
 <20211022131057.1308851-2-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <e1448e42-3023-ec4f-8c57-bef4d1850b1a@redhat.com>
Date:   Mon, 25 Oct 2021 14:25:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211022131057.1308851-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/10/2021 15.10, Janis Schoetterl-Glausch wrote:
> Check that specification exceptions cause intercepts when
> specification exception interpretation is off.
> Check that specification exceptions caused by program new PSWs
> cause interceptions.
> We cannot assert that non program new PSW specification exceptions
> are interpreted because whether interpretation occurs or not is
> configuration dependent.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@de.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   s390x/Makefile             |  2 +
>   lib/s390x/sie.h            |  1 +
>   s390x/snippets/c/spec_ex.c | 21 ++++++++++
>   s390x/spec_ex-sie.c        | 82 ++++++++++++++++++++++++++++++++++++++
>   s390x/unittests.cfg        |  3 ++
>   5 files changed, 109 insertions(+)
>   create mode 100644 s390x/snippets/c/spec_ex.c
>   create mode 100644 s390x/spec_ex-sie.c

Thanks, I've pushed it to the repository now.

  Thomas


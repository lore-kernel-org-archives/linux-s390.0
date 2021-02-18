Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B45DC433DB
	for <linux-s390@archiver.kernel.org>; Thu, 18 Feb 2021 08:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D0364D9F
	for <linux-s390@archiver.kernel.org>; Thu, 18 Feb 2021 08:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhBRIhi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 Feb 2021 03:37:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230185AbhBRIeT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Feb 2021 03:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613637156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L5gxi5miCLrybJnzNLeu8IVLpQjGrhS2HuEqsPFjH2A=;
        b=ETmREWE3BOeKEFH/UXp8cGsoVbQWj8tP5wyDl6NIsHO7KJqXgKq/DXrPwKtdiEWvytxiNJ
        T/lH1VZ/Os6p1FJl0H0OpXW0+yPTjovvSG/6vS5dOxDB5+YTDcVAk3idf4eNRoO+kVj02V
        krv7jQ6PSl70H66naIPNqN3kZI4tfEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-HGJS_tHDOL66fhQxIyAvbQ-1; Thu, 18 Feb 2021 03:32:34 -0500
X-MC-Unique: HGJS_tHDOL66fhQxIyAvbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01FDA8015AD;
        Thu, 18 Feb 2021 08:32:33 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC1A72C01F;
        Thu, 18 Feb 2021 08:32:31 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH] s390x: Remove sthyi partition number check
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        thuth@redhat.com
References: <20210218082449.29876-1-frankja@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <654d87bc-9d2c-9a14-6112-563b035331b3@redhat.com>
Date:   Thu, 18 Feb 2021 09:32:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218082449.29876-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18.02.21 09:24, Janosch Frank wrote:
> Turns out that partition numbers start from 0 and not from 1 so a 0
> check doesn't make sense here.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/sthyi.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/s390x/sthyi.c b/s390x/sthyi.c
> index d8dfc854..db90b56f 100644
> --- a/s390x/sthyi.c
> +++ b/s390x/sthyi.c
> @@ -128,7 +128,6 @@ static void test_fcode0_par(struct sthyi_par_sctn *par)
>   		report(sum, "core counts");
>   
>   	if (par->INFPVAL1 & PART_STSI_SUC) {
> -		report(par->INFPPNUM, "number");
>   		report(memcmp(par->INFPPNAM, null_buf, sizeof(par->INFPPNAM)),
>   		       "name");
>   	}
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


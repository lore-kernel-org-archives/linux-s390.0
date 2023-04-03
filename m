Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DDEC76196
	for <linux-s390@archiver.kernel.org>; Mon,  3 Apr 2023 15:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjDCPjj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 Apr 2023 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjDCPji (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Apr 2023 11:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A2E26AF
        for <linux-s390@vger.kernel.org>; Mon,  3 Apr 2023 08:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680536325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qsuorthvn8/TmOAJNzr8VlhJsrAlr/c+/b77+LMUyz0=;
        b=Gx6t6Qx501phD9YxvxW7nD2hu4KHivAaDVS9cq0SUduB6QhM9vH5varZbQ2iwe33Fyjy1p
        KBjzFVe3vU/BLdTJ4+KlPpoGpCGxSz2Yk9D+FSoGOM8T7CHI6n909QoVdt2k8Un5kpvVwt
        h7tzqveVzEyPYRxOg9T8LX9792PbdTA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-PKhzM66KPgCDiy0kHcNDqw-1; Mon, 03 Apr 2023 11:38:44 -0400
X-MC-Unique: PKhzM66KPgCDiy0kHcNDqw-1
Received: by mail-qv1-f71.google.com with SMTP id px9-20020a056214050900b005d510cdfc41so13320104qvb.7
        for <linux-s390@vger.kernel.org>; Mon, 03 Apr 2023 08:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680536323;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qsuorthvn8/TmOAJNzr8VlhJsrAlr/c+/b77+LMUyz0=;
        b=QOvZJvDcjrX7zjTn4dbJaL0oh5A1WPgkxOAeIIcGUIyp8YmMIZVPlZ1JmjjXWrOtzd
         YBVNoxno2sIO9pcNlwviqS/LZ4ciJEfFGQgxcUQBU+KNNCXOnLfj/fjfTi9607K55iuS
         lWYxJRjL094bJMukzo74RmE3vQoaJh4K547/SEoAodArww0yh8CSHLSynB6Ay+lTnZKk
         NujsTaqQ0fAZ+D2iQV9cUc0NCQA9byg12oyckimYkTD5Ornp+M6MCdaFDPhqOKiIUVqw
         7ONd7hIM7t8QxhO/zxvVZRPhonj99ZeGslANC/hXvi4UbngC9nfnx0u/lyyA176GrhY9
         sQYw==
X-Gm-Message-State: AO0yUKW9S/6PpOErOsMt4iHcAHhSgpLRuhwyHwLhkrXiAsYg7C7r5U4f
        VpnhKby/9N0R3GXRZ8aQhKnbOoUT2BL5zsAKpI3EN3IPsTqaNWN27UENSaxQ976xFtnLsPkiFPC
        dbDkF2YHxoYQgAQa38/6mVA==
X-Received: by 2002:ac8:5e0c:0:b0:3bf:c3be:758e with SMTP id h12-20020ac85e0c000000b003bfc3be758emr61275178qtx.16.1680536323756;
        Mon, 03 Apr 2023 08:38:43 -0700 (PDT)
X-Google-Smtp-Source: AK7set/6WjG0mrUlax50VRRSgBinnw7zW+ccXJe20INnX4CGT+h1L/teHot0XhI/KoSo+551dgUN1w==
X-Received: by 2002:ac8:5e0c:0:b0:3bf:c3be:758e with SMTP id h12-20020ac85e0c000000b003bfc3be758emr61275152qtx.16.1680536323517;
        Mon, 03 Apr 2023 08:38:43 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-12.web.vodafone.de. [109.43.177.12])
        by smtp.gmail.com with ESMTPSA id p11-20020a05620a22ab00b00706b09b16fasm2859004qkh.11.2023.04.03.08.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:38:42 -0700 (PDT)
Message-ID: <2e22a705-47c1-53e2-c539-63db5b92f44a@redhat.com>
Date:   Mon, 3 Apr 2023 17:38:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20230317133253.965010-1-nsg@linux.ibm.com>
 <20230317133253.965010-4-nsg@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 3/3] s390x/spec_ex: Add test of EXECUTE
 with odd target address
In-Reply-To: <20230317133253.965010-4-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17/03/2023 14.32, Nina Schoetterl-Glausch wrote:
> The EXECUTE instruction executes the instruction at the given target
> address. This address must be halfword aligned, otherwise a
> specification exception occurs.
> Add a test for this.
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   s390x/spec_ex.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/s390x/spec_ex.c b/s390x/spec_ex.c
> index ab023347..b4b9095f 100644
> --- a/s390x/spec_ex.c
> +++ b/s390x/spec_ex.c
> @@ -177,6 +177,30 @@ static int short_psw_bit_12_is_0(void)
>   	return 0;
>   }
>   
> +static int odd_ex_target(void)
> +{
> +	uint64_t pre_target_addr;
> +	int to = 0, from = 0x0dd;
> +
> +	asm volatile ( ".pushsection .text.ex_odd\n"
> +		"	.balign	2\n"
> +		"pre_odd_ex_target:\n"
> +		"	. = . + 1\n"
> +		"	lr	%[to],%[from]\n"
> +		"	.popsection\n"
> +
> +		"	larl	%[pre_target_addr],pre_odd_ex_target\n"
> +		"	ex	0,1(%[pre_target_addr])\n"
> +		: [pre_target_addr] "=&a" (pre_target_addr),
> +		  [to] "+d" (to)
> +		: [from] "d" (from)
> +	);
> +
> +	assert((pre_target_addr + 1) & 1);
> +	report(to != from, "did not perform ex with odd target");
> +	return 0;
> +}

  Hi Nina,

FWIW, this fails to compile with Clang v15 here:

s390x/spec_ex.c:187:4: error: symbol 'pre_odd_ex_target' is already defined
                 "pre_odd_ex_target:\n"
                  ^
<inline asm>:3:1: note: instantiated into assembly here
pre_odd_ex_target:

No clue yet why that happens ... but compiling with Clang seems to be broken 
on some other spots, too, so this is not really critical right now ;-)

  Thomas


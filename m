Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CDBC43334
	for <linux-s390@archiver.kernel.org>; Tue, 14 Jun 2022 16:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344151AbiFNQbu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Jun 2022 12:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbiFNQbp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Jun 2022 12:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DDD644A11
        for <linux-s390@vger.kernel.org>; Tue, 14 Jun 2022 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655224302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oavP8gsV6cJWMEx/ty3RSD/S2p03O0ZnolvRU2i8U0U=;
        b=H7a++JjoGsiJiJOmCVb0kqAGvrYDcJ96HOJr+rjSKE/T1LeQ9NSdQJGtcCZQgRgx3Ws1Sn
        jo8El067/yeyWSCPXxy5pbg8HZ1B+5g0wawXw/Vv+1Yw2aVNxzvIe3kl5+sR6AFAtkL/fi
        Z/KXIguGSGiMfI2G/PMLUf+2Rgz0k9Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-mHXpikz3NYiLUT4tFfmEjQ-1; Tue, 14 Jun 2022 12:31:39 -0400
X-MC-Unique: mHXpikz3NYiLUT4tFfmEjQ-1
Received: by mail-wm1-f69.google.com with SMTP id o2-20020a05600c510200b0039747b0216fso7845804wms.0
        for <linux-s390@vger.kernel.org>; Tue, 14 Jun 2022 09:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oavP8gsV6cJWMEx/ty3RSD/S2p03O0ZnolvRU2i8U0U=;
        b=KdOMMClyMIlJv3h1HlDpAoYgnjxuDrWKfvhQDOvdmetyTzxKP4yG63VVt8Sk4CFL+G
         5JYj8vZ+7qoWUns44OhQS06LKhR9eeOjSzKbK270yM7xmX3T3/PXNxuTWjXGu7wxqLkv
         u0EyHQ45WJfAxfgvtutUZPOm15ZyIV8KMSHABXQHgbArhph97U9jCaFENBO8zt9VmYAQ
         8Lmb39oQcOh0dPErbkGQp70i6EmhWptbwx9obMpsyzLgWIkMUnImlvY3sSi1wR4kKCbo
         u3PyGrhHA+C6wghEwWHJi7QoUGP4fWElB7+jqMzwQmWagKkROtgHrdRcKvpIlUKTD+58
         V/Rw==
X-Gm-Message-State: AJIora8NNr/wlxvY4HRUJe0XeEA4ocSRLb6QZxEuU0UW28vNdsqJZNhM
        mlGgS4cALqxMvqIPN3Y0l9OoDr3rzPW6G8NdXIY25S6LNzUHRXjr4XmZleiwWuWRQ+Ptr2o3qRT
        hQxO14gNCs4pgCzBT+R6JRQ==
X-Received: by 2002:a5d:6da3:0:b0:219:bcdd:97cd with SMTP id u3-20020a5d6da3000000b00219bcdd97cdmr5702992wrs.274.1655224297801;
        Tue, 14 Jun 2022 09:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1svQzIL6zLCvemWeG8M2S6FR8uXiEVS4pzOzqfRybaUZfeRrJrTeJlYzJRR2cIqLDUDDp3ugw==
X-Received: by 2002:a5d:6da3:0:b0:219:bcdd:97cd with SMTP id u3-20020a5d6da3000000b00219bcdd97cdmr5702966wrs.274.1655224297599;
        Tue, 14 Jun 2022 09:31:37 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-42-114-75.web.vodafone.de. [109.42.114.75])
        by smtp.gmail.com with ESMTPSA id m17-20020adfc591000000b0020fff0ea0a3sm12632199wrg.116.2022.06.14.09.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:31:37 -0700 (PDT)
Message-ID: <047aa23e-7926-6f8f-eadd-122dc81a3159@redhat.com>
Date:   Tue, 14 Jun 2022 18:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] KVM: s390: selftests: Fix memop extension capability
 check
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, pbonzini@redhat.com
Cc:     david@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org, shuah@kernel.org
References: <36d83871-343d-e8a0-1aed-05bf386f9b1b@redhat.com>
 <20220614162635.3445019-1-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220614162635.3445019-1-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14/06/2022 18.26, Janis Schoetterl-Glausch wrote:
> Fix the inverted logic of the memop extension capability check.
> 
> Fixes: 97da92c0ff92 ("KVM: s390: selftests: Use TAP interface in the memop test")
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
> 
> 
> Here you go.
> Hope it doesn't get lost as a reply, but I can always resend
> and it's not super critical after all.
> 
> 
>   tools/testing/selftests/kvm/s390x/memop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index e704c6fa5758..e1056f20dfa1 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -769,7 +769,7 @@ int main(int argc, char *argv[])
>   	ksft_set_plan(ARRAY_SIZE(testlist));
>   
>   	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
> -		if (testlist[idx].extension >= extension_cap) {
> +		if (extension_cap >= testlist[idx].extension) {
>   			testlist[idx].test();
>   			ksft_test_result_pass("%s\n", testlist[idx].name);
>   		} else {

Thanks!

Reviewed-by: Thomas Huth <thuth@redhat.com>

Paolo, could you please queue this directly as a fix for the "Use TAP 
interface in the memop test" patch that is currently already in your "next" 
branch? (or in case you rebase that branch, squash it directly into that patch?)

  Thanks,
   Thomas


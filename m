Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92560C433DB
	for <linux-s390@archiver.kernel.org>; Sat, 13 Feb 2021 15:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682B164DD5
	for <linux-s390@archiver.kernel.org>; Sat, 13 Feb 2021 15:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhBMPre (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 13 Feb 2021 10:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBMPrc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 13 Feb 2021 10:47:32 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A67C061756;
        Sat, 13 Feb 2021 07:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=tsPf35Vf/yQbIvsw12o9I+1Qj/BI510C23AGErC7pXQ=; b=HURQ50e4cazpBr0VcvOlxvxY1R
        xbbp1WDL5PVDnG9ymIspc8u1ACihJ6WiHqvGoYZzXVj/HhL6a83+RbKXw/CSU+BfCDmNIcrAaANTv
        Wu8rPmTlFw+Lm/6dKz04vm6qUqya/+95lrw3obcm4g+OwgxIh5cT4cm/zSXiZnbJHFFSEzbVE+CBU
        dsP8JH/7Juf0F6178wu7rWRhVUPTqOgxI0J6j3YMc/4d/ZOJe9yUHdO/B9+4LmYcrpUj1w8j+uhsR
        fGoHfr9lL2BShOixsa/3idqucKfqLZMt+eq+r6rBBzsvdMe5ddn+87zclwum8J1kXC/cY+N3aRYcm
        V2nzT2MQ==;
Received: from [2601:1c0:6280:3f0::6444]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lAx8B-0007Ji-9H; Sat, 13 Feb 2021 15:46:47 +0000
Subject: Re: [PATCH] arch: s390: kvm: Fix oustanding to outstanding in the
 file kvm-s390.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210213153227.1640682-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f588a2dd-d562-d8a8-ec8f-9121ec42c38c@infradead.org>
Date:   Sat, 13 Feb 2021 07:46:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210213153227.1640682-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2/13/21 7:32 AM, Bhaskar Chowdhury wrote:
> 
> s/oustanding/outstanding/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/s390/kvm/kvm-s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index dbafd057ca6a..1d01afaca9fe 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4545,7 +4545,7 @@ int kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
>  		/*
>  		 * As we are starting a second VCPU, we have to disable
>  		 * the IBS facility on all VCPUs to remove potentially
> -		 * oustanding ENABLE requests.
> +		 * outstanding ENABLE requests.
>  		 */
>  		__disable_ibs_on_all_vcpus(vcpu->kvm);
>  	}
> --
> 2.30.1
> 


-- 
~Randy


Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35789C433E0
	for <linux-s390@archiver.kernel.org>; Fri, 26 Mar 2021 21:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C6B61A32
	for <linux-s390@archiver.kernel.org>; Fri, 26 Mar 2021 21:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhCZVXz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 26 Mar 2021 17:23:55 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35548 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCZVXj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 26 Mar 2021 17:23:39 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPtvb-000SOd-No; Fri, 26 Mar 2021 15:23:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPtva-00074S-1a; Fri, 26 Mar 2021 15:23:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210326143831.1550030-1-hch@lst.de>
        <20210326143831.1550030-4-hch@lst.de>
Date:   Fri, 26 Mar 2021 16:22:33 -0500
In-Reply-To: <20210326143831.1550030-4-hch@lst.de> (Christoph Hellwig's
        message of "Fri, 26 Mar 2021 15:38:30 +0100")
Message-ID: <m1y2e9vcdi.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lPtva-00074S-1a;;;mid=<m1y2e9vcdi.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18JI1x3OTuGSmP1SAxwgJUKnILVVDmHpGw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 3/4] exec: simplify the compat syscall handling
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:


> diff --git a/fs/exec.c b/fs/exec.c
> index 06e07278b456fa..b34c1eb9e7ad8e 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -391,47 +391,34 @@ static int bprm_mm_init(struct linux_binprm *bprm)
>  	return err;
>  }
>  
> -struct user_arg_ptr {
> -#ifdef CONFIG_COMPAT
> -	bool is_compat;
> -#endif
> -	union {
> -		const char __user *const __user *native;
> -#ifdef CONFIG_COMPAT
> -		const compat_uptr_t __user *compat;
> -#endif
> -	} ptr;
> -};
> -
> -static const char __user *get_user_arg_ptr(struct user_arg_ptr argv, int nr)
> +static const char __user *
> +get_user_arg_ptr(const char __user *const __user *argv, int nr)
>  {
> -	const char __user *native;
> -
> -#ifdef CONFIG_COMPAT
> -	if (unlikely(argv.is_compat)) {
> +	if (in_compat_syscall()) {
> +		const compat_uptr_t __user *compat_argv =
> +			compat_ptr((unsigned long)argv);

Ouch!  Passing a pointer around as the wrong type through the kernel!

Perhaps we should reduce everything to do_execveat and
do_execveat_compat.  Then there would be no need for anything
to do anything odd with the pointer types.

I think the big change would be to factor out a copy_string out
of copy_strings, that performs all of the work once we know the proper
pointer value.

Casting pointers from one type to another scares me as one mistake means
we are doing something wrong and probably exploitable.


Eric




>  		compat_uptr_t compat;
>  
> -		if (get_user(compat, argv.ptr.compat + nr))
> +		if (get_user(compat, compat_argv + nr))
>  			return ERR_PTR(-EFAULT);
> -
>  		return compat_ptr(compat);
> -	}
> -#endif
> -
> -	if (get_user(native, argv.ptr.native + nr))
> -		return ERR_PTR(-EFAULT);
> +	} else {
> +		const char __user *native;
>  
> -	return native;
> +		if (get_user(native, argv + nr))
> +			return ERR_PTR(-EFAULT);
> +		return native;
> +	}
>  }
>  

Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2E6C433B4
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 23:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1CEA610FA
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 23:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbhDOXNB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Apr 2021 19:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbhDOXNB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 15 Apr 2021 19:13:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABE8C061574
        for <linux-s390@vger.kernel.org>; Thu, 15 Apr 2021 16:12:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id kb13-20020a17090ae7cdb02901503d67f0beso2147535pjb.0
        for <linux-s390@vger.kernel.org>; Thu, 15 Apr 2021 16:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=quZmVxdkfveDUtpLM1NU/LuQrdZNONtDpXYzxh0MMQU=;
        b=dlBNCIJGr0qL38amaMZRkug9NjLuSZKepOmlGO/a/0dku+GQVYqb2GS0jPTD9w2gLe
         mxyKCuERedST3RGnVbk4l07BD+E5BOSCp/2NFPvySo56I89CsE7aDSCbVRn53Jv8Ql5N
         hSp7xLsHsW85pUai/ansn/rQu7ZvTTszyfp0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=quZmVxdkfveDUtpLM1NU/LuQrdZNONtDpXYzxh0MMQU=;
        b=XziuCoIXEcxD8aHhLvIunOhHoPciGco/VIp23eFSia1N7VKy0CJH0kTptSYQtZRCkl
         U9giMXnd9+ZfHCFjtYY2lD2WcoesCcnKatoDXqPCQsppOPSKr4aJjiYu5GKbMa2apmpS
         o5cv/+Nx3WSGz6QgtoGrAWfdxVTsEb7dYOZgzNxAmrMTxY4C/LyqHnLKBKIoT9Yp9dqg
         KMHVHsa7fcOY5XlKsJGQZvwMQIrIcm6Alc5VEnr9+v9AY4mYYE0ZudG2O5aC/FQGFmfX
         70m4ylE+dwGY8dtdzGL8stG4efYnUMJEG8yvBk/J42GvspGWbwJdaudhChsq8VOmVp7i
         nYXQ==
X-Gm-Message-State: AOAM532GlhvBjq4aD3vS2SQaCbFIY4dXNhP/Ed1z/QrRD/a2Mb4I2eoA
        vxhgWBhaIFYdrC/xf3vwdu+S8Q==
X-Google-Smtp-Source: ABdhPJxtoW/lfV/Z4uQg/42K/o4Py3SAIqP7jABAruwS7PxREUqkSHGAEbZJMX/djPbOm2w9XfP5tw==
X-Received: by 2002:a17:902:59d4:b029:ea:bbc5:c775 with SMTP id d20-20020a17090259d4b02900eabbc5c775mr6469026plj.11.1618528357637;
        Thu, 15 Apr 2021 16:12:37 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-3f8b-a64e-9a27-b872.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:3f8b:a64e:9a27:b872])
        by smtp.gmail.com with ESMTPSA id x11sm3055779pfr.7.2021.04.15.16.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 16:12:37 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 3/5] mm: ptdump: Provide page size to notepage()
In-Reply-To: <1ef6b954fb7b0f4dfc78820f1e612d2166c13227.1618506910.git.christophe.leroy@csgroup.eu>
References: <cover.1618506910.git.christophe.leroy@csgroup.eu> <1ef6b954fb7b0f4dfc78820f1e612d2166c13227.1618506910.git.christophe.leroy@csgroup.eu>
Date:   Fri, 16 Apr 2021 09:12:34 +1000
Message-ID: <8735vr16sd.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Christophe,

>  static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
> -		      u64 val)
> +		      u64 val, unsigned long page_size)

Compilers can warn about unused parameters at -Wextra level.  However,
reading scripts/Makefile.extrawarn it looks like the warning is
explicitly _disabled_ in the kernel at W=1 and not reenabled at W=2 or
W=3. So I guess this is fine...

> @@ -126,7 +126,7 @@ static int ptdump_hole(unsigned long addr, unsigned long next,
>  {
>  	struct ptdump_state *st = walk->private;
>  
> -	st->note_page(st, addr, depth, 0);
> +	st->note_page(st, addr, depth, 0, 0);

I know it doesn't matter at this point, but I'm not really thrilled by
the idea of passing 0 as the size here. Doesn't the hole have a known
page size?

>  
>  	return 0;
>  }
> @@ -153,5 +153,5 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
>  	mmap_read_unlock(mm);
>  
>  	/* Flush out the last page */
> -	st->note_page(st, 0, -1, 0);
> +	st->note_page(st, 0, -1, 0, 0);

I'm more OK with the idea of passing 0 as the size when the depth is -1
(don't know): if we don't know the depth we conceptually can't know the
page size.

Regards,
Daniel


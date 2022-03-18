Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74061C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 18 Mar 2022 09:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiCRJh2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 18 Mar 2022 05:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbiCRJh1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 18 Mar 2022 05:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B9A72EA91D
        for <linux-s390@vger.kernel.org>; Fri, 18 Mar 2022 02:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647596168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m4jF8/kC8zIHwAO3JdMD+H9wM977DPU+ZmNY1oF3jOo=;
        b=chHGec6+Sd0inbUB8w/aDjHRwp3iZWQeVEkGY3ZXbTEZBmx3RfZgK0654VI3mcLvtCXSas
        FXqRU4wkdOPiB6jKg3UOlOYV0hRUSmzb4sHlYx9ZFroqN7Np7LMXWaphsqvgGzfJxk0CXN
        0y1hFjIQgw2H1NWNzBs1vhSj4nt0Nv8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-QqeSMmSSN8u1XiMe1R-R_Q-1; Fri, 18 Mar 2022 05:36:05 -0400
X-MC-Unique: QqeSMmSSN8u1XiMe1R-R_Q-1
Received: by mail-ed1-f72.google.com with SMTP id b24-20020a50e798000000b0041631767675so4574080edn.23
        for <linux-s390@vger.kernel.org>; Fri, 18 Mar 2022 02:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m4jF8/kC8zIHwAO3JdMD+H9wM977DPU+ZmNY1oF3jOo=;
        b=LhVn7ADxZ5gUx9M2tugFfkWy6Db6VetFT1plSvLQQAVvabWHChYRGYS/8N5zy3tdVg
         VtqMfR8tT77VGYcxDbBmO51Q541EbQLukxE4GlZLcAMvLCsUS5PtVe2aC3DfPsPK6O81
         j7Cu7mzHn25zLUXdS3Xcam4VmLm9QVeeiyHsn+5ISMuht+cH0R5h9OEERQ4sdDTt8dm7
         XGIqiiDu/LNAZ39TnyCNK82Dw5V/U8JllVU+u2W0uDAH3d4kdCrmYwxw9T/y9xME4wR1
         5PHTF8v9kadZ2HIpADdB2hx5K6e5oHIor1GD+y0d8g+aITxdSCxLj8C8EnF4BCYoQ9ZE
         bDRA==
X-Gm-Message-State: AOAM5302/idq5hfmSsVVZdV/hmHw2Do32txnk5s9WM9b0PzgyCzt7fRE
        tObcmwuuiJMesdZTLJDPOO9hyaYvEqN8zUQBwN1XIb6diYyii4zo8bPRItWLdvnm2eyfuyg7aBy
        9Q9gpCfprySyrRvqASAycEw==
X-Received: by 2002:a17:906:4c83:b0:6b7:b321:5d54 with SMTP id q3-20020a1709064c8300b006b7b3215d54mr7986223eju.676.1647596164179;
        Fri, 18 Mar 2022 02:36:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGfngiAJB91ib0NSDhnemNwcbBdY9hFIPe7Ws8dqmHZ+SkhiUDTGSr3KrMjxf9cL0cYbqRvw==
X-Received: by 2002:a17:906:4c83:b0:6b7:b321:5d54 with SMTP id q3-20020a1709064c8300b006b7b3215d54mr7986200eju.676.1647596163934;
        Fri, 18 Mar 2022 02:36:03 -0700 (PDT)
Received: from gator (cst2-173-70.cust.vodafone.cz. [31.30.173.70])
        by smtp.gmail.com with ESMTPSA id sg9-20020a170907a40900b006df8c6df89fsm2355398ejc.93.2022.03.18.02.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 02:36:03 -0700 (PDT)
Date:   Fri, 18 Mar 2022 10:36:01 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Bill Wendling <morbo@google.com>
Cc:     kvm@vger.kernel.org, Nikos Nikoleris <nikos.nikoleris@arm.com>,
        lvivier@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        david@redhat.com, pbonzini@redhat.com,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, alexandru.elisei@arm.com,
        thuth@redhat.com, suzuki.poulose@arm.com, mark.rutland@arm.com
Subject: Re: [kvm-unit-tests PATCH] libfdt: use logical "or" instead of
 bitwise "or" with boolean operands
Message-ID: <20220318093601.zqhuzrp2ujgswsiw@gator>
References: <20220316060214.2200695-1-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316060214.2200695-1-morbo@google.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 15, 2022 at 11:02:14PM -0700, Bill Wendling wrote:
> Clang warns about using a bitwise '|' with boolean operands. This seems
> to be due to a small typo.
> 
>   lib/libfdt/fdt_rw.c:438:6: warning: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
>           if (can_assume(LIBFDT_ORDER) |
> 
> Using '||' removes this warnings.
> 
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  lib/libfdt/fdt_rw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/libfdt/fdt_rw.c b/lib/libfdt/fdt_rw.c
> index 13854253ff86..3320e5559cac 100644
> --- a/lib/libfdt/fdt_rw.c
> +++ b/lib/libfdt/fdt_rw.c
> @@ -435,7 +435,7 @@ int fdt_open_into(const void *fdt, void *buf, int bufsize)
>  			return struct_size;
>  	}
>  
> -	if (can_assume(LIBFDT_ORDER) |
> +	if (can_assume(LIBFDT_ORDER) ||
>  	    !fdt_blocks_misordered_(fdt, mem_rsv_size, struct_size)) {
>  		/* no further work necessary */
>  		err = fdt_move(fdt, buf, bufsize);
> -- 
> 2.35.1.723.g4982287a31-goog
>

We're not getting as much interest in the submodule discussion as I hoped.
I see one vote against on this thread and one vote for on a different
thread[1]. For now I'll just commit a big rebase patch for libfdt. We can
revisit it again after we decide what to do for QCBOR.

Thanks,
drew

[1] https://lore.kernel.org/kvm/20220316105109.oi5g532ylijzldte@gator/T/#m48c47c761f3b3a4da636482b6385c59d4a990137 


Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD3DC433F5
	for <linux-s390@archiver.kernel.org>; Fri, 18 Mar 2022 13:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbiCRNnT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbiCRNnS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 18 Mar 2022 09:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DD152DCBE8
        for <linux-s390@vger.kernel.org>; Fri, 18 Mar 2022 06:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647610915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DIbniuNolZexjaWhREmeAy3eBGSMYEukIAiBx0oi6HQ=;
        b=AihgwDkh5gXLiNZowNC0Yp5p9JXwsPUxtLEFQrKvqp37bDwb2pjxIZfpnG0k7FQvTMzWig
        b9B1YO2ICDid/d999AOCu2EIsDnLGSohYHpBib/JSal4lTMm7ttfHEzdhTkGpY13XyaScs
        AXWXu1hzOTfxCndFPmK5pJ66/nYJe0s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-488PDOjMNHOuWRRGL6BLOg-1; Fri, 18 Mar 2022 09:41:53 -0400
X-MC-Unique: 488PDOjMNHOuWRRGL6BLOg-1
Received: by mail-ed1-f69.google.com with SMTP id c31-20020a509fa2000000b004190d43d28fso1048653edf.9
        for <linux-s390@vger.kernel.org>; Fri, 18 Mar 2022 06:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DIbniuNolZexjaWhREmeAy3eBGSMYEukIAiBx0oi6HQ=;
        b=CZqAqJMuqXRltiKcl9lvLK5KNoq85UbeXqvAX4cvIfLZxFEttw1HhJ8SCuNzIlYn3l
         bWdxhJE/ooaDZ7Q4ZzNMB9QRsMjBWMIM+ip+xSV989jXRsNUv6CTQHlrd9MENEkLZlef
         hanD2+Q8CBzZWqCmVxbfpOxrGcOCxKZ5dsfnhJK1Osy4VSw7ZvaN3bl+SxgSp5ImD4XN
         6CoGQ3WwglT655Sr0OudKCG1wc80R3aYGE80hYRbJ6//9qnOXE0iY4FglMqgWBbwKIc7
         a1mOZLiFpQvPrGUzWWd1b0htJmwhrvVlDArAqVNQz1chPaSmSQQyli7IHxQg41ifzqFJ
         iDcA==
X-Gm-Message-State: AOAM530LQeyu62PM7tYUfdtli1BXHqejSdIJ+IxUOTYwLEM1K45sTgZp
        ALQ2gArKQWVOp2dptT+fgUKox3NOo0IrnPmbALyv8bzJf7NvY958gZHgi+NodfVsPig5kTF3Qrp
        2/ohHeL/G08/iy64TnqYJGg==
X-Received: by 2002:a17:906:1742:b0:6d6:c4f5:84a2 with SMTP id d2-20020a170906174200b006d6c4f584a2mr8868767eje.25.1647610912648;
        Fri, 18 Mar 2022 06:41:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/BdGNh9JsyvjgFzL96Y9Vz6rTgp8OmTHioc8M6Nr9yVk3fxjLP8PWfjOZehG7pgTumaNf0Q==
X-Received: by 2002:a17:906:1742:b0:6d6:c4f5:84a2 with SMTP id d2-20020a170906174200b006d6c4f584a2mr8868744eje.25.1647610912407;
        Fri, 18 Mar 2022 06:41:52 -0700 (PDT)
Received: from gator (cst2-173-70.cust.vodafone.cz. [31.30.173.70])
        by smtp.gmail.com with ESMTPSA id i3-20020a1709067a4300b006dd879b4680sm3812678ejo.112.2022.03.18.06.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 06:41:52 -0700 (PDT)
Date:   Fri, 18 Mar 2022 14:41:49 +0100
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
Message-ID: <20220318134149.i2dqdaiwk3twbixn@gator>
References: <20220316060214.2200695-1-morbo@google.com>
 <20220318093601.zqhuzrp2ujgswsiw@gator>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318093601.zqhuzrp2ujgswsiw@gator>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Mar 18, 2022 at 10:36:01AM +0100, Andrew Jones wrote:
> On Tue, Mar 15, 2022 at 11:02:14PM -0700, Bill Wendling wrote:
> > Clang warns about using a bitwise '|' with boolean operands. This seems
> > to be due to a small typo.
> > 
> >   lib/libfdt/fdt_rw.c:438:6: warning: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
> >           if (can_assume(LIBFDT_ORDER) |
> > 
> > Using '||' removes this warnings.
> > 
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> >  lib/libfdt/fdt_rw.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/libfdt/fdt_rw.c b/lib/libfdt/fdt_rw.c
> > index 13854253ff86..3320e5559cac 100644
> > --- a/lib/libfdt/fdt_rw.c
> > +++ b/lib/libfdt/fdt_rw.c
> > @@ -435,7 +435,7 @@ int fdt_open_into(const void *fdt, void *buf, int bufsize)
> >  			return struct_size;
> >  	}
> >  
> > -	if (can_assume(LIBFDT_ORDER) |
> > +	if (can_assume(LIBFDT_ORDER) ||
> >  	    !fdt_blocks_misordered_(fdt, mem_rsv_size, struct_size)) {
> >  		/* no further work necessary */
> >  		err = fdt_move(fdt, buf, bufsize);
> > -- 
> > 2.35.1.723.g4982287a31-goog
> >
> 
> We're not getting as much interest in the submodule discussion as I hoped.
> I see one vote against on this thread and one vote for on a different
> thread[1]. For now I'll just commit a big rebase patch for libfdt. We can
> revisit it again after we decide what to do for QCBOR.
>

Now merged through misc/queue.

Thanks,
drew 


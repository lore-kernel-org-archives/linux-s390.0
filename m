Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D728C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 30 May 2022 16:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiE3QCn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 May 2022 12:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242304AbiE3QCO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 May 2022 12:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 020E21CF
        for <linux-s390@vger.kernel.org>; Mon, 30 May 2022 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653926463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ZWphZRcK3afyDhn+H8+iYAM34Y/wtF11YrAt0KXpqo=;
        b=OS5bC/RbZWQv79yKd7eUx+L80tJuGwYMwoVX2WpJqFE+WQ2EeHxy5+54Sg+j+dJCpcYZs5
        dO+n8wU9jSdN6aZk2DHWbOuf17Rll0cLfQ2K4qce5CQIdj5CYuWhPA8/1z4t/30tbVQPsk
        H+rQTflA+VYaQexDjenXT6RuodApb3A=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-2y4-Dv-2Nn-CyMAL7GkkIQ-1; Mon, 30 May 2022 12:00:59 -0400
X-MC-Unique: 2y4-Dv-2Nn-CyMAL7GkkIQ-1
Received: by mail-io1-f72.google.com with SMTP id r10-20020a5edb4a000000b006656e9a2603so5661648iop.6
        for <linux-s390@vger.kernel.org>; Mon, 30 May 2022 09:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ZWphZRcK3afyDhn+H8+iYAM34Y/wtF11YrAt0KXpqo=;
        b=bKyIa7LfhafsjiJL3uYLuDpcTlIA1YAFOYfcnwAYtCGId8+s5hqLz9QfAbQYs9qnKz
         0hCSTXT0c4sSk0FCdYHtodyCg672IJVsP+BS97plr2vBgn6LfFX3V/ncR6pQmQJ+lctS
         uw54yIrlz4QI5XdsPEr3Tk73r3DsC4A/CJzCEmiMl0nC9jQPOqzDOQOjTqj3dOw/qVKU
         1ZlYeXvFEhCgQKuGY9v9jc+Fq0HmVOyNw21Ha0e9I9U7G/eV2JehJ5Fgr10buG+KB4Jd
         TbCFwT6y5Y5C9zbFChKk69As0XKDeHayoVL05gXcAUTISlG5ZKqDRtHgHw1Y/lscRR5x
         8L2w==
X-Gm-Message-State: AOAM532iIzWsbZAtY90JEvU8CxPPi44zVtpxM8gV61say7/b/4l3qc38
        BEXzRclAhDdusG6VbGcukktWxOimtEfJiZmj3UE9DRL7NxmtsJSirWv3eIwQ9DFxBXYJ7toMyeU
        hHXchlrAOnwsh4ZxhIyhpzg==
X-Received: by 2002:a05:6e02:1648:b0:2cd:fe43:39db with SMTP id v8-20020a056e02164800b002cdfe4339dbmr30191735ilu.172.1653926458623;
        Mon, 30 May 2022 09:00:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0UxFyFLwjW1ZOMQsp2rrmtoQtqcFmY+n0cdYYM503zYLjoFDoHLhs+0Zam5Eh/FIDylo0ew==
X-Received: by 2002:a05:6e02:1648:b0:2cd:fe43:39db with SMTP id v8-20020a056e02164800b002cdfe4339dbmr30191721ilu.172.1653926458383;
        Mon, 30 May 2022 09:00:58 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id b16-20020a926710000000b002cde6e352e5sm3863762ilc.47.2022.05.30.09.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 09:00:57 -0700 (PDT)
Date:   Mon, 30 May 2022 12:00:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        Matt Turner <mattst88@gmail.com>, linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Cain <bcain@quicinc.com>, Borislav Petkov <bp@alien8.de>,
        linux-alpha@vger.kernel.org, Alistair Popple <apopple@nvidia.com>,
        Jonas Bonn <jonas@southpole.se>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupta@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        Richard Henderson <rth@twiddle.net>,
        Guo Ren <guoren@kernel.org>, linux-parisc@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-um@lists.infradead.org, "H . Peter Anvin" <hpa@zytor.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        openrisc@lists.librecores.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-hexagon@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Stafford Horne <shorne@gmail.com>, linux-csky@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-riscv@lists.infradead.org, Max Filippov <jcmvbkbc@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Chris Zankel <chris@zankel.net>,
        Michal Simek <monstr@monstr.eu>, x86@kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Richard Weinberger <richard@nod.at>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <YpTqNKMTt8PoA41n@xz-m1.local>
References: <20220527193936.30678-1-peterx@redhat.com>
 <YpPYkzbrQmy4FjrI@osiris>
 <33fd4731-9765-d78b-bdc3-f8243c98e81f@linux.ibm.com>
 <YpToVpjXmdFqGOpY@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YpToVpjXmdFqGOpY@xz-m1.local>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 30, 2022 at 11:52:54AM -0400, Peter Xu wrote:
> On Mon, May 30, 2022 at 11:35:10AM +0200, Christian Borntraeger wrote:
> > 
> > 
> > Am 29.05.22 um 22:33 schrieb Heiko Carstens:
> > [...]
> > > 
> > > Guess the patch below on top of your patch is what we want.
> > > Just for clarification: if gmap is not NULL then the process is a kvm
> > > process. So, depending on the workload, this optimization makes sense.
> > > 
> > > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > > index 4608cc962ecf..e1d40ca341b7 100644
> > > --- a/arch/s390/mm/fault.c
> > > +++ b/arch/s390/mm/fault.c
> > > @@ -436,12 +436,11 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> > >   	/* The fault is fully completed (including releasing mmap lock) */
> > >   	if (fault & VM_FAULT_COMPLETED) {
> > > -		/*
> > > -		 * Gmap will need the mmap lock again, so retake it.  TODO:
> > > -		 * only conditionally take the lock when CONFIG_PGSTE set.
> > > -		 */
> > > -		mmap_read_lock(mm);
> > > -		goto out_gmap;
> > > +		if (gmap) {
> > > +			mmap_read_lock(mm);
> > > +			goto out_gmap;
> > > +		}
> > > +		goto out;

Hmm, right after I replied I found "goto out" could be problematic, since
all s390 callers of do_exception() will assume it an error condition (side
note: "goto out_gmap" contains one step to clear "fault" to 0).  I'll
replace this with "return 0" instead if it looks good to both of you.

I'll wait for a confirmation before reposting.  Thanks,

-- 
Peter Xu


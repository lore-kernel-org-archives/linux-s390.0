Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F5EEB64D9
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jun 2023 20:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjFOUGo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jun 2023 16:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjFOUGg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 15 Jun 2023 16:06:36 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300D42965
        for <linux-s390@vger.kernel.org>; Thu, 15 Jun 2023 13:06:34 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39c7f7a151fso81914b6e.0
        for <linux-s390@vger.kernel.org>; Thu, 15 Jun 2023 13:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686859593; x=1689451593;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lnrQN5LlkxP95Mux0T1jB4Dy+AtD6LSbxshFtVQUvTo=;
        b=F+RX5xoKmoh9NZ1KkkiDlzAht39EE2q1unXvlFLYleWlhZ7euinWEZYt6gqZMxC1nl
         WOrFTiniy86xv7YzmWuL0VRa31yG6XSYxpDi5bdZnU4T2n3i3cU5zze56urDimUNHmZJ
         2iK1P2Dt0b9aG9ABKerMfzpfnuCo4VWUYPFXU2TXUJanvAGtKAN4orsIebUEhY7xCEOb
         rbspa8Mz1J9x6T7WE0l+eHZKe0E5XDIpsJJMLg9vlguk2rorj3TiZTrZGhATd7YMsOB4
         P+21SnlDKd1VlzlMUuJMi/2dcY/BqpXyS+PRaVjdxAr0FA6BWnWl0LbIzNkTCjf/P1hA
         iH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686859593; x=1689451593;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lnrQN5LlkxP95Mux0T1jB4Dy+AtD6LSbxshFtVQUvTo=;
        b=GN/Ig6/AHr9xZYgU5CzqHkYzPEKUd/Um7YYaEGF6S8LoiskapL7oDUM0/g5tYOBIJ8
         JgO8pHaqltFFLE/cy2V15s4AGiT3wlMybobH7y00fHgPDaVCN7fHErhrh/tZVP4W4xmS
         99vyOp6mfmYlUvsoN036dMiBEdnL4lXxou9UmsOZrdX13Dd4+TBOSPtA6hSMwTx/gqRN
         ofNv7H7Oy9TJDywogC6h80FF9vrk7Bk6kTQT+hvGgp9arLAcdT21FNBfN7Zqcc8TpJ6W
         RSE9EaaQG/asv71jxWmmUduY6JAftxbi63xoJiPUroUZxZ891VpLeTYZViT7gRKYWtSY
         jyuw==
X-Gm-Message-State: AC+VfDwzPkqnqEcO5ntMsnTR3tjLiPErHLai93uikwcZOhPeaQi3vNVX
        UbPg3UNodZ9smKrZZ7DasTSySI/9CKse7rw1B+gxxw==
X-Google-Smtp-Source: ACHHUZ5PmtEbli6fXiqgCoybNOhq2vdAqyVg9151Hknsw+CyikxFFk3pvjvX2FiopzSD0ErUTWXgcg==
X-Received: by 2002:a05:6358:7018:b0:12b:dc0e:d33e with SMTP id 24-20020a056358701800b0012bdc0ed33emr9279934rwo.23.1686859593098;
        Thu, 15 Jun 2023 13:06:33 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y14-20020a25ad0e000000b00bc6a712c523sm2816679ybi.64.2023.06.15.13.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 13:06:32 -0700 (PDT)
Date:   Thu, 15 Jun 2023 13:06:24 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 07/12] s390: add pte_free_defer(), with use of
 mmdrop_async()
In-Reply-To: <20230615141132.63ac6e67@thinkpad-T15>
Message-ID: <9563741b-a880-be7b-2b1e-34ca96c4af7c@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com> <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com> <20230606214037.09c6b280@thinkpad-T15> <dbed4c5-1d-f278-d03a-66f5eff5e48e@google.com>
 <20230608174756.27cace18@thinkpad-T15> <a948f24b-4fe6-8bc0-221a-65e9ccc8371a@google.com> <20230614153042.43a52187@thinkpad-T15> <fc5cd62e-d85f-36c3-ba37-db87e8b625d@google.com> <20230615141132.63ac6e67@thinkpad-T15>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 15 Jun 2023, Gerald Schaefer wrote:
> On Wed, 14 Jun 2023 14:59:33 -0700 (PDT)
> Hugh Dickins <hughd@google.com> wrote:
...
> > > 
> > > Also, we would not need to use page->pt_mm, and therefore make room for
> > > page->pt_frag_refcount, which for some reason is (still) being used
> > > in new v4 from Vishals "Split ptdesc from struct page" series...  
> > 
> > Vishal's ptdesc: I've been ignoring as far as possible, I'll have to
> > respond on that later today, I'm afraid it will be putting this all into
> > an intolerable straitjacket.  If ptdesc is actually making more space
> > available by some magic, great: but I don't expect to find that is so.
> > Anyway, for now, there it's impossible (for me anyway) to think of that
> > at the same time as this.
> 
> I can totally relate to that. And I also had the feeling and hope that
> ptdesc would give some relief on complex struct page (mis-)use, but did
> not yet get into investigating further.

ptdesc doesn't give any relief, just codifies some existing practices
under new names, and tends to force one architecture to conform to
another's methods.  As I warned Vishal earlier, s390 may need to go
its own way: we can update ptdesc to meet whatever are s390's needs.

> 
> [...]
> > > I dot not fully understand if / why we need the new HH bits. While working
> > > on my patch it seemed to be useful for sorting out list_add/del in the
> > > various cases. Here it only seems to be used for preventing double rcu_head
> > > usage, is this correct, or am I missing something?  
> > 
> > Correct, I only needed the HH bits for avoiding double rcu_head usage (then
> > implementing the second usage one the first has completed).  If you want to
> > distinguish pte_free_defer() tables from page_table_free_rcu() tables, the
> > HH bits would need to be considered in other places too, I imagine: that
> > gets more complicated, I fear.
> 
> Yes, I have the same impression. My approach would prevent scary "unstable mm"
> issues in __tlb_remove_table(), but probably introduce other subtle issue.
> Or not so subtle, like potential double list_free(), as mentioned in my last
> reply.

A more urgent broken MIPS issue (with current linux-next) came up, so I
didn't get to look at your patch at all yesterday (nor the interesting
commit you pointed me to, still on my radar).  I take it from your words
above and below, that you've gone off your patch, and I shouldn't spend
time on it now - holding mulitple approaches in mind gets me confused!

> 
> So it seems we have no completely safe approach so far, but I would agree
> on going further with your approach for now. See below for patch comments.
> 
> [...]
> > 
> > I'm getting this reply back to you, before reviewing your patch below.
> > Probably the only way I can review yours is to try it myself and compare.
> > I'll look into it, once I understand c2c224932fd0.  But may have to write
> > to Vishal first, or get the v2 of my series out: if only I could work out
> > a safe and easy way of unbreaking s390...
> > 
> > Is there any chance of you trying mine?
> > But please don't let it waste your time.
> 
> I have put it to some LTP tests now, and good news is that it does not show
> any obvious issues.

Oh that's very encouraging news, thanks a lot.

> Only some deadlocks on mm->context.lock,

I assume lockdep reports of risk of deadlock, rather than actual deadlock
seen?  I had meant to ask you to include lockdep (CONFIG_PROVE_LOCKING=y),
but it sounds like you rightly did so anyway.

> but that can
> easily be solved. Problem is that we have some users of that lock, who do
> spin_lock() and not spin_lock_bh(). In the past, we had 3 different locks
> in mm->context, and then combined them to use the same. Only the pagetable
> list locks were taken with spin_lock_bh(), the others used spin_lock().

I'd noticed that discrepancy, and was a little surprised that it wasn't
already causing problems (not being a driver person, I rarely come across
spin_lock_bh(); but by coincidence had to look into it very recently, to
fix a 6.4-rc iwlwifi regression on this laptop - and lockdep didn't like
me mixing spin_lock() and spin_lock_bh() there).

> 
> Of course, after combining them to use the same lock, it would have been
> required to change the others to also use spin_lock_bh(), at least if there
> was any good reason for using _bh in the pagetable list lock.
> It seems there was not, which is why that mismatch was not causing any
> issues so far, probably we had some reason which got removed in one of
> the various reworks of that code...
> 
> With your patch, we do now have a reason, because __tlb_remove_table()
> will usually be called in _bh context as RCU callback, and now also
> takes that lock. So we also need this change (and two compile fixes,
> marked below):

Right.  Though with my latest idea, we can use a separate lock for the
page table list, and leave mm->context_lock with spin_lock() as is.

> 
> --- a/arch/s390/include/asm/tlbflush.h
> +++ b/arch/s390/include/asm/tlbflush.h
> @@ -79,12 +79,12 @@ static inline void __tlb_flush_kernel(vo
>  
>  static inline void __tlb_flush_mm_lazy(struct mm_struct * mm)
>  {
> -	spin_lock(&mm->context.lock);
> +	spin_lock_bh(&mm->context.lock);
>  	if (mm->context.flush_mm) {
>  		mm->context.flush_mm = 0;
>  		__tlb_flush_mm(mm);
>  	}
> -	spin_unlock(&mm->context.lock);
> +	spin_unlock_bh(&mm->context.lock);
>  }
>  
>  /*
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -102,14 +102,14 @@ struct gmap *gmap_create(struct mm_struc
>  	if (!gmap)
>  		return NULL;
>  	gmap->mm = mm;
> -	spin_lock(&mm->context.lock);
> +	spin_lock_bh(&mm->context.lock);
>  	list_add_rcu(&gmap->list, &mm->context.gmap_list);
>  	if (list_is_singular(&mm->context.gmap_list))
>  		gmap_asce = gmap->asce;
>  	else
>  		gmap_asce = -1UL;
>  	WRITE_ONCE(mm->context.gmap_asce, gmap_asce);
> -	spin_unlock(&mm->context.lock);
> +	spin_unlock_bh(&mm->context.lock);
>  	return gmap;
>  }
>  EXPORT_SYMBOL_GPL(gmap_create);
> @@ -250,7 +250,7 @@ void gmap_remove(struct gmap *gmap)
>  		spin_unlock(&gmap->shadow_lock);
>  	}
>  	/* Remove gmap from the pre-mm list */
> -	spin_lock(&gmap->mm->context.lock);
> +	spin_lock_bh(&gmap->mm->context.lock);
>  	list_del_rcu(&gmap->list);
>  	if (list_empty(&gmap->mm->context.gmap_list))
>  		gmap_asce = 0;
> @@ -260,7 +260,7 @@ void gmap_remove(struct gmap *gmap)
>  	else
>  		gmap_asce = -1UL;
>  	WRITE_ONCE(gmap->mm->context.gmap_asce, gmap_asce);
> -	spin_unlock(&gmap->mm->context.lock);
> +	spin_unlock_bh(&gmap->mm->context.lock);
>  	synchronize_rcu();
>  	/* Put reference */
>  	gmap_put(gmap);

So we won't need to include those changes above...

> 
> These are the compile fixes:
> 
> > +static void pte_free_now1(struct rcu_read *head)
> 
> rcu_read -> rcu_head
> 
> > +{
> > +	pte_free_half(head, 1);
> > +}
> > +
> > +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> > +{
> > +	unsigned int bit, mask;
> > +	struct page *page;
> > +
> > +	page = virt_to_page(pgtable);
> > +	WARN_ON_ONCE(page->pt_mm != mm);
> > +	if (mm_alloc_pgste(mm)) {
> > +		call_rcu(&page->rcu_head, pte_free_pgste)
> 
> Missing ";" at the end
> 
> > +		return;
> > +	}

... but of course I must add these in: many thanks.
And read up on the interesting commit.

You don't mention whether you were running with the
#define destroy_context synchronize_rcu
patch in.  And I was going to ask you to clarify on that,
but there's no need: I found this morning that it was a bad idea.

Of course x86 doesn't tell a lot about s390 down at this level, and
what's acceptable on one may be unacceptable on the other; but when
I tried a synchronize_rcu() in x86's destroy_context(), the machines
were not happy under load, warning messages, freeze: it looks like
final __mmdrop() can sometimes be called from a context which is
not at all suited for synchronize_rcu().

So then as another experiment, I tried adding synchronize_rcu() into
the safer context at the end of exit_mmap(): that ran okay, but
significantly slower (added 12% on kernel builds) than before.

My latest idea: we keep a SLAB_TYPESAFE_BY_RCU kmem cache for the
spinlock, and most probably the pgtable_list head, and back pointer
to the mm; and have each page table page using the pt_mm field to
point to that structure, instead of to the mm itself.  Then
__tlb_remove_table() can safely take the lock, even when the
mm itself has gone away and been reused, even when that structure
has gone away and been reused.  Hmm, I don't think it will even
need to contain a backpointer to the mm.

But I see that as the right way forward, rather than as something
needed today or tomorrow: in the meanwhile, to get v2 of my patchset
out without breaking s390, I'm contemplating (the horror!) a global
spinlock.

Many thanks, Gerald, I feel much better about it today.
Hugh

Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61AFEB64D9
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jun 2023 12:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbjFOMLq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jun 2023 08:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbjFOMLo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 15 Jun 2023 08:11:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6224B184
        for <linux-s390@vger.kernel.org>; Thu, 15 Jun 2023 05:11:43 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FBvckU005585;
        Thu, 15 Jun 2023 12:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=weMHHVI5IXIoF9N+IEmAC5kALD9U4wuUAgPd69x0aAc=;
 b=LBfrdXhQNt4UHVmuTOEHB31KIh2ohdWtaCc3+KxhyU07cmKXrpJfqyRvDggsY8eZZIrC
 W50fd23hvXZJuJxHAmMVQUt5tAyBAJmcHbXAyL99lUnt+GGellxM+89Tdigsy7RgmESp
 0/c4fIfvxeVJM5j2Nreohnea16Lov7cRFnfrYTwBYpwD5JdIyF4xGR42sCmHTp8BdEyN
 MJrFTOqM4UV0JAFMYphNAjYMpyQyDNVC4vvhVbo6S5ha/eoPluYCUxwh2MJ2dQqg8XtC
 i5a7hDSJ6/xJIInI12iWDRuSN07NlDY5xz3DoMSMTBrfeZaFiKyzrpLdjfUawgCGJq+v ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r827ughcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 12:11:42 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35FCBAGQ017281;
        Thu, 15 Jun 2023 12:11:42 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r827ughbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 12:11:42 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35F0o5Dp005877;
        Thu, 15 Jun 2023 12:11:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt53k21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 12:11:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35FCBZb245351242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 12:11:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5686A2004B;
        Thu, 15 Jun 2023 12:11:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8DF820049;
        Thu, 15 Jun 2023 12:11:34 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.179.12.110])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
        Thu, 15 Jun 2023 12:11:34 +0000 (GMT)
Date:   Thu, 15 Jun 2023 14:11:32 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 07/12] s390: add pte_free_defer(), with use of
 mmdrop_async()
Message-ID: <20230615141132.63ac6e67@thinkpad-T15>
In-Reply-To: <fc5cd62e-d85f-36c3-ba37-db87e8b625d@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
        <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com>
        <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com>
        <20230606214037.09c6b280@thinkpad-T15>
        <dbed4c5-1d-f278-d03a-66f5eff5e48e@google.com>
        <20230608174756.27cace18@thinkpad-T15>
        <a948f24b-4fe6-8bc0-221a-65e9ccc8371a@google.com>
        <20230614153042.43a52187@thinkpad-T15>
        <fc5cd62e-d85f-36c3-ba37-db87e8b625d@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RogeMhsqas_Dvu2Tg8B8-Np0X0LTgwvE
X-Proofpoint-GUID: 37IOUYoC7_r69OdrDXSfwhenqbZQOpNS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_08,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150105
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 14 Jun 2023 14:59:33 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

[...]
> > 
> > It would be much more acceptable to simply not add back such fragments
> > to the list, and therefore risking some memory waste, than risking to
> > use an unstable mm in __tlb_remove_table(). The amount of wasted memory
> > in practice might also not be a lot, depending on whether the fragments
> > belong to the same and contiguous mapping.  
> 
> I agree that it's much better to waste a little memory (and only temporarily)
> than to freeze or corrupt.  But it's not an insoluble problem, I just didn't
> want to get into more change if there was already an answer that covers it.
> 
> I assume that the freed mm issue scared you away from testing my patch,
> so we don't know whether I got those mask conditionals right or not?

Correct, that scared me a lot :-). On the one hand, I do not feel familiar
enough with the common code logic that might need to be changed, or at
least understood, in order to judge if this is a problem and how it could
be addressed.

On the other hand, I am scared of subtle bugs that would not show
immediately, and hit us by surprise later.

Your thoughts about using RCU to free mm, in order to address this
"unstable mm" in __tlb_remove_table(), sound like a reasonable approach.
But again, with my lack of understanding, I am not sure if I can cope
with that.

So at least be prepared for call backs on that issue, not by RCU but
by mail :-)

> 
> > 
> > Also, we would not need to use page->pt_mm, and therefore make room for
> > page->pt_frag_refcount, which for some reason is (still) being used
> > in new v4 from Vishals "Split ptdesc from struct page" series...  
> 
> Vishal's ptdesc: I've been ignoring as far as possible, I'll have to
> respond on that later today, I'm afraid it will be putting this all into
> an intolerable straitjacket.  If ptdesc is actually making more space
> available by some magic, great: but I don't expect to find that is so.
> Anyway, for now, there it's impossible (for me anyway) to think of that
> at the same time as this.

I can totally relate to that. And I also had the feeling and hope that
ptdesc would give some relief on complex struct page (mis-)use, but did
not yet get into investigating further.

[...]
> > I dot not fully understand if / why we need the new HH bits. While working
> > on my patch it seemed to be useful for sorting out list_add/del in the
> > various cases. Here it only seems to be used for preventing double rcu_head
> > usage, is this correct, or am I missing something?  
> 
> Correct, I only needed the HH bits for avoiding double rcu_head usage (then
> implementing the second usage one the first has completed).  If you want to
> distinguish pte_free_defer() tables from page_table_free_rcu() tables, the
> HH bits would need to be considered in other places too, I imagine: that
> gets more complicated, I fear.

Yes, I have the same impression. My approach would prevent scary "unstable mm"
issues in __tlb_remove_table(), but probably introduce other subtle issue.
Or not so subtle, like potential double list_free(), as mentioned in my last
reply.

So it seems we have no completely safe approach so far, but I would agree
on going further with your approach for now. See below for patch comments.

[...]
> 
> I'm getting this reply back to you, before reviewing your patch below.
> Probably the only way I can review yours is to try it myself and compare.
> I'll look into it, once I understand c2c224932fd0.  But may have to write
> to Vishal first, or get the v2 of my series out: if only I could work out
> a safe and easy way of unbreaking s390...
> 
> Is there any chance of you trying mine?
> But please don't let it waste your time.

I have put it to some LTP tests now, and good news is that it does not show
any obvious issues. Only some deadlocks on mm->context.lock, but that can
easily be solved. Problem is that we have some users of that lock, who do
spin_lock() and not spin_lock_bh(). In the past, we had 3 different locks
in mm->context, and then combined them to use the same. Only the pagetable
list locks were taken with spin_lock_bh(), the others used spin_lock().

Of course, after combining them to use the same lock, it would have been
required to change the others to also use spin_lock_bh(), at least if there
was any good reason for using _bh in the pagetable list lock.
It seems there was not, which is why that mismatch was not causing any
issues so far, probably we had some reason which got removed in one of
the various reworks of that code...

With your patch, we do now have a reason, because __tlb_remove_table()
will usually be called in _bh context as RCU callback, and now also
takes that lock. So we also need this change (and two compile fixes,
marked below):

--- a/arch/s390/include/asm/tlbflush.h
+++ b/arch/s390/include/asm/tlbflush.h
@@ -79,12 +79,12 @@ static inline void __tlb_flush_kernel(vo
 
 static inline void __tlb_flush_mm_lazy(struct mm_struct * mm)
 {
-	spin_lock(&mm->context.lock);
+	spin_lock_bh(&mm->context.lock);
 	if (mm->context.flush_mm) {
 		mm->context.flush_mm = 0;
 		__tlb_flush_mm(mm);
 	}
-	spin_unlock(&mm->context.lock);
+	spin_unlock_bh(&mm->context.lock);
 }
 
 /*
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -102,14 +102,14 @@ struct gmap *gmap_create(struct mm_struc
 	if (!gmap)
 		return NULL;
 	gmap->mm = mm;
-	spin_lock(&mm->context.lock);
+	spin_lock_bh(&mm->context.lock);
 	list_add_rcu(&gmap->list, &mm->context.gmap_list);
 	if (list_is_singular(&mm->context.gmap_list))
 		gmap_asce = gmap->asce;
 	else
 		gmap_asce = -1UL;
 	WRITE_ONCE(mm->context.gmap_asce, gmap_asce);
-	spin_unlock(&mm->context.lock);
+	spin_unlock_bh(&mm->context.lock);
 	return gmap;
 }
 EXPORT_SYMBOL_GPL(gmap_create);
@@ -250,7 +250,7 @@ void gmap_remove(struct gmap *gmap)
 		spin_unlock(&gmap->shadow_lock);
 	}
 	/* Remove gmap from the pre-mm list */
-	spin_lock(&gmap->mm->context.lock);
+	spin_lock_bh(&gmap->mm->context.lock);
 	list_del_rcu(&gmap->list);
 	if (list_empty(&gmap->mm->context.gmap_list))
 		gmap_asce = 0;
@@ -260,7 +260,7 @@ void gmap_remove(struct gmap *gmap)
 	else
 		gmap_asce = -1UL;
 	WRITE_ONCE(gmap->mm->context.gmap_asce, gmap_asce);
-	spin_unlock(&gmap->mm->context.lock);
+	spin_unlock_bh(&gmap->mm->context.lock);
 	synchronize_rcu();
 	/* Put reference */
 	gmap_put(gmap);

These are the compile fixes:

> +static void pte_free_now1(struct rcu_read *head)

rcu_read -> rcu_head

> +{
> +	pte_free_half(head, 1);
> +}
> +
> +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> +{
> +	unsigned int bit, mask;
> +	struct page *page;
> +
> +	page = virt_to_page(pgtable);
> +	WARN_ON_ONCE(page->pt_mm != mm);
> +	if (mm_alloc_pgste(mm)) {
> +		call_rcu(&page->rcu_head, pte_free_pgste)

Missing ";" at the end

> +		return;
> +	}

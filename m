Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C22EB64D7
	for <linux-s390@archiver.kernel.org>; Fri, 16 Jun 2023 08:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245664AbjFPIit (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 16 Jun 2023 04:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244545AbjFPIio (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 16 Jun 2023 04:38:44 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4AE2D4D
        for <linux-s390@vger.kernel.org>; Fri, 16 Jun 2023 01:38:41 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G7tQxG001794;
        Fri, 16 Jun 2023 08:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=EMWdsX77X40ujuLjsWCNBz0ADXsIyeXeUIdhjVXfsGg=;
 b=V4Kg7KKNs6VQIdKxnIuq4LPrIJOcctOPMYvWafI5+XfgiWtDCgaYEHk38pwgUoaDD/Zl
 t4JZKeKvAVbWBki8iYWdt37tSXPaGMvw6IZ3Axsx5fUNYMiG/jEPPh7T8iItFJIPr1eG
 CryPOCB2VPKc5xLIH8VFPTwcUUzNKf+HOi8/Ss5F6kOrl1rQDp6ZZnfjAHGWz1Rre60/
 4F/7jO37E8SL5sq+8FO1P2kTZVRxxZq31MGFM7LjK8NZHo3BWA+c9iVeba2GKnBCB816
 kMIlv33VuJxUrpMrajcaDQuo9OPmlsh+m1SARuPYttCUoLG+KFby89I16D6H1cyTNylz KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r8ksas417-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 08:38:40 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35G7taiE002121;
        Fri, 16 Jun 2023 08:38:40 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r8ksas3yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 08:38:40 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35G5Kt6E029407;
        Fri, 16 Jun 2023 08:38:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3r4gee487c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 08:38:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35G8cYl836176572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 08:38:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DFE520043;
        Fri, 16 Jun 2023 08:38:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A17B720040;
        Fri, 16 Jun 2023 08:38:33 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.171.57.127])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
        Fri, 16 Jun 2023 08:38:33 +0000 (GMT)
Date:   Fri, 16 Jun 2023 10:38:31 +0200
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
Message-ID: <20230616103831.1407439a@thinkpad-T15>
In-Reply-To: <9563741b-a880-be7b-2b1e-34ca96c4af7c@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
        <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com>
        <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com>
        <20230606214037.09c6b280@thinkpad-T15>
        <dbed4c5-1d-f278-d03a-66f5eff5e48e@google.com>
        <20230608174756.27cace18@thinkpad-T15>
        <a948f24b-4fe6-8bc0-221a-65e9ccc8371a@google.com>
        <20230614153042.43a52187@thinkpad-T15>
        <fc5cd62e-d85f-36c3-ba37-db87e8b625d@google.com>
        <20230615141132.63ac6e67@thinkpad-T15>
        <9563741b-a880-be7b-2b1e-34ca96c4af7c@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _Q6yZIJJjCb_zU_6-DLqt3XjAAcz7_ZF
X-Proofpoint-ORIG-GUID: mVqKflZCTCxfmg-N_SBu7IRa_8dcSCbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_04,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160076
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 15 Jun 2023 13:06:24 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

> On Thu, 15 Jun 2023, Gerald Schaefer wrote:
> > On Wed, 14 Jun 2023 14:59:33 -0700 (PDT)
> > Hugh Dickins <hughd@google.com> wrote:  
> ...
> > > > 
> > > > Also, we would not need to use page->pt_mm, and therefore make room for
> > > > page->pt_frag_refcount, which for some reason is (still) being used
> > > > in new v4 from Vishals "Split ptdesc from struct page" series...    
> > > 
> > > Vishal's ptdesc: I've been ignoring as far as possible, I'll have to
> > > respond on that later today, I'm afraid it will be putting this all into
> > > an intolerable straitjacket.  If ptdesc is actually making more space
> > > available by some magic, great: but I don't expect to find that is so.
> > > Anyway, for now, there it's impossible (for me anyway) to think of that
> > > at the same time as this.  
> > 
> > I can totally relate to that. And I also had the feeling and hope that
> > ptdesc would give some relief on complex struct page (mis-)use, but did
> > not yet get into investigating further.  
> 
> ptdesc doesn't give any relief, just codifies some existing practices
> under new names, and tends to force one architecture to conform to
> another's methods.  As I warned Vishal earlier, s390 may need to go
> its own way: we can update ptdesc to meet whatever are s390's needs.
> 
> > 
> > [...]  
> > > > I dot not fully understand if / why we need the new HH bits. While working
> > > > on my patch it seemed to be useful for sorting out list_add/del in the
> > > > various cases. Here it only seems to be used for preventing double rcu_head
> > > > usage, is this correct, or am I missing something?    
> > > 
> > > Correct, I only needed the HH bits for avoiding double rcu_head usage (then
> > > implementing the second usage one the first has completed).  If you want to
> > > distinguish pte_free_defer() tables from page_table_free_rcu() tables, the
> > > HH bits would need to be considered in other places too, I imagine: that
> > > gets more complicated, I fear.  
> > 
> > Yes, I have the same impression. My approach would prevent scary "unstable mm"
> > issues in __tlb_remove_table(), but probably introduce other subtle issue.
> > Or not so subtle, like potential double list_free(), as mentioned in my last
> > reply.  
> 
> A more urgent broken MIPS issue (with current linux-next) came up, so I
> didn't get to look at your patch at all yesterday (nor the interesting
> commit you pointed me to, still on my radar).  I take it from your words
> above and below, that you've gone off your patch, and I shouldn't spend
> time on it now - holding mulitple approaches in mind gets me confused!

Correct, I think we should stick to your approach first, after all it
would allow to keep all the cleverness, and fragment re-use.

In case the "unstable mm" issue turns out to be unsolvable, instead
of my also flawed approach, I guess we would rather take more drastic
measures, and turn to some fundamental change by removing the list
and need for page->lru completely, and not adding back fragments
at all. This is something we already considered before, when working
on the last race fix, in order to reduce complexity, which might
not have such a huge benefit anyway. We probably want to do some
measurements to get a better feeling on possible "memory waste"
effects.

> 
> > 
> > So it seems we have no completely safe approach so far, but I would agree
> > on going further with your approach for now. See below for patch comments.
> > 
> > [...]  
> > > 
> > > I'm getting this reply back to you, before reviewing your patch below.
> > > Probably the only way I can review yours is to try it myself and compare.
> > > I'll look into it, once I understand c2c224932fd0.  But may have to write
> > > to Vishal first, or get the v2 of my series out: if only I could work out
> > > a safe and easy way of unbreaking s390...
> > > 
> > > Is there any chance of you trying mine?
> > > But please don't let it waste your time.  
> > 
> > I have put it to some LTP tests now, and good news is that it does not show
> > any obvious issues.  
> 
> Oh that's very encouraging news, thanks a lot.
> 
> > Only some deadlocks on mm->context.lock,  
> 
> I assume lockdep reports of risk of deadlock, rather than actual deadlock
> seen?  I had meant to ask you to include lockdep (CONFIG_PROVE_LOCKING=y),
> but it sounds like you rightly did so anyway.

I actually hit the deadlock, CONFIG_PROVE_LOCKING was off, but will
also give it a try with our debug config, that certainly would not be
wrong.

This was the deadlock, on the spin_lock() in __tlb_flush_mm_lazy(),
triggered from finish_arch_post_lock_switch():

[ 1275.753548] rcu: INFO: rcu_sched self-detected stall on CPU
[ 1275.753554] rcu:     8-....: (6000 ticks this GP) idle=918c/1/0x4000000000000000 softirq=15306/15306 fqs=1965
[ 1275.753582] rcu:     (t=6000 jiffies g=47925 q=27525 ncpus=16)
[ 1275.753584] Task dump for CPU 4:
[ 1275.753585] task:mmap1           state:R  running task     stack:0     pid:12815 ppid:12787  flags:0x00000005
[ 1275.753589] Call Trace:
[ 1275.753591]  [<00000000d79cec28>] __alloc_pages+0x158/0x310 
[ 1275.753598]  [<00000000d84a5288>] __func__.3+0x70/0x80 
[ 1275.753604]  [<00000000d83738d0>] do_ext_irq+0xe8/0x160 
[ 1275.753608]  [<00000000d83839ec>] ext_int_handler+0xc4/0xf0 
[ 1275.753610]  [<00000000d79b3574>] tlb_flush_mmu+0x14c/0x1c8 
[ 1275.753615]  [<00000000d79b3722>] tlb_finish_mmu+0x3a/0xc8 
[ 1275.753617]  [<00000000d79ace30>] unmap_region+0xf8/0x118 
[ 1275.753619]  [<00000000d79af98a>] do_vmi_align_munmap+0x2da/0x4b0 
[ 1275.753621]  [<00000000d79afc5a>] do_vmi_munmap+0xba/0xf0 
[ 1275.753623]  [<00000000d79afd34>] __vm_munmap+0xa4/0x168 
[ 1275.753625]  [<00000000d79afee2>] __s390x_sys_munmap+0x32/0x40 
[ 1275.753627]  [<00000000d8373654>] __do_syscall+0x1d4/0x200 
[ 1275.753629]  [<00000000d8383768>] system_call+0x70/0x98 
[ 1275.753632] CPU: 8 PID: 12816 Comm: mmap1 Not tainted 6.4.0-rc6-00037-gb6dad5178cea-dirty #6
[ 1275.753635] Hardware name: IBM 3931 A01 704 (LPAR)
[ 1275.753636] Krnl PSW : 0704e00180000000 00000000d777d12c (finish_arch_post_lock_switch+0x34/0x170)
[ 1275.753643]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[ 1275.753645] Krnl GPRS: 00000000000000f4 0000000000000001 000000009d5915c8 0000000096be9b4e
[ 1275.753647]            0000000000000000 000000000000000b 0000000091f5a100 0000000000000000
[ 1275.753687]            000000009d590600 00000000803d4200 00000003f898d100 000000009d591200
[ 1275.753689]            000000000000021a 00000000d891a930 0000038003e1fd20 0000038003e1fce0
[ 1275.753696] Krnl Code: 00000000d777d11e: 4120b3c8            la      %r2,968(%r11)
[ 1275.753696]            00000000d777d122: 5810b3c8            l       %r1,968(%r11)
[ 1275.753696]           #00000000d777d126: ec180008007e        cij     %r1,0,8,00000000d777d136
[ 1275.753696]           >00000000d777d12c: 58102000            l       %r1,0(%r2)
[ 1275.753696]            00000000d777d130: ec16fffe007e        cij     %r1,0,6,00000000d777d12c
[ 1275.753696]            00000000d777d136: 583003a0            l       %r3,928
[ 1275.753696]            00000000d777d13a: 41a0b4a8            la      %r10,1192(%r11)
[ 1275.753696]            00000000d777d13e: ec2323bc3d59        risbgn  %r2,%r3,35,188,61
[ 1275.753711] Call Trace:
[ 1275.753712]  [<00000000d777d12c>] finish_arch_post_lock_switch+0x34/0x170 
[ 1275.753715]  [<00000000d777ec66>] finish_task_switch.isra.0+0x8e/0x238 
[ 1275.753718]  [<00000000d837bb2a>] __schedule+0x2f2/0x770 
[ 1275.753721]  [<00000000d837c00a>] schedule+0x62/0x108 
[ 1275.753724]  [<00000000d77eea46>] exit_to_user_mode_prepare+0xde/0x1a8 
[ 1275.753728]  [<00000000d8373cf4>] irqentry_exit_to_user_mode+0x1c/0x70 
[ 1275.753731]  [<00000000d83838d6>] pgm_check_handler+0x116/0x168 
[ 1275.753733] Last Breaking-Event-Address:
[ 1275.753733]  [<00000000d777d130>] finish_arch_post_lock_switch+0x38/0x170

> 
> > but that can
> > easily be solved. Problem is that we have some users of that lock, who do
> > spin_lock() and not spin_lock_bh(). In the past, we had 3 different locks
> > in mm->context, and then combined them to use the same. Only the pagetable
> > list locks were taken with spin_lock_bh(), the others used spin_lock().  
> 
> I'd noticed that discrepancy, and was a little surprised that it wasn't
> already causing problems (not being a driver person, I rarely come across
> spin_lock_bh(); but by coincidence had to look into it very recently, to
> fix a 6.4-rc iwlwifi regression on this laptop - and lockdep didn't like
> me mixing spin_lock() and spin_lock_bh() there).
> 
> > 
> > Of course, after combining them to use the same lock, it would have been
> > required to change the others to also use spin_lock_bh(), at least if there
> > was any good reason for using _bh in the pagetable list lock.
> > It seems there was not, which is why that mismatch was not causing any
> > issues so far, probably we had some reason which got removed in one of
> > the various reworks of that code...
> > 
> > With your patch, we do now have a reason, because __tlb_remove_table()
> > will usually be called in _bh context as RCU callback, and now also
> > takes that lock. So we also need this change (and two compile fixes,
> > marked below):  
> 
> Right.  Though with my latest idea, we can use a separate lock for the
> page table list, and leave mm->context_lock with spin_lock() as is.

I think we want to have that change anyway, might also make sense to put it
in a separate patch. Simply for consistency, even if we are fine ATM, the
current code with mixing spin_lock() and spin_lock_bh() only causes
confusion. I also see no negative impact of that change, and it surely
feels better than a new global lock.

> 
> > 
> > --- a/arch/s390/include/asm/tlbflush.h
> > +++ b/arch/s390/include/asm/tlbflush.h
> > @@ -79,12 +79,12 @@ static inline void __tlb_flush_kernel(vo
> >  
> >  static inline void __tlb_flush_mm_lazy(struct mm_struct * mm)
> >  {
> > -	spin_lock(&mm->context.lock);
> > +	spin_lock_bh(&mm->context.lock);
> >  	if (mm->context.flush_mm) {
> >  		mm->context.flush_mm = 0;
> >  		__tlb_flush_mm(mm);
> >  	}
> > -	spin_unlock(&mm->context.lock);
> > +	spin_unlock_bh(&mm->context.lock);
> >  }
> >  
> >  /*
> > --- a/arch/s390/mm/gmap.c
> > +++ b/arch/s390/mm/gmap.c
> > @@ -102,14 +102,14 @@ struct gmap *gmap_create(struct mm_struc
> >  	if (!gmap)
> >  		return NULL;
> >  	gmap->mm = mm;
> > -	spin_lock(&mm->context.lock);
> > +	spin_lock_bh(&mm->context.lock);
> >  	list_add_rcu(&gmap->list, &mm->context.gmap_list);
> >  	if (list_is_singular(&mm->context.gmap_list))
> >  		gmap_asce = gmap->asce;
> >  	else
> >  		gmap_asce = -1UL;
> >  	WRITE_ONCE(mm->context.gmap_asce, gmap_asce);
> > -	spin_unlock(&mm->context.lock);
> > +	spin_unlock_bh(&mm->context.lock);
> >  	return gmap;
> >  }
> >  EXPORT_SYMBOL_GPL(gmap_create);
> > @@ -250,7 +250,7 @@ void gmap_remove(struct gmap *gmap)
> >  		spin_unlock(&gmap->shadow_lock);
> >  	}
> >  	/* Remove gmap from the pre-mm list */
> > -	spin_lock(&gmap->mm->context.lock);
> > +	spin_lock_bh(&gmap->mm->context.lock);
> >  	list_del_rcu(&gmap->list);
> >  	if (list_empty(&gmap->mm->context.gmap_list))
> >  		gmap_asce = 0;
> > @@ -260,7 +260,7 @@ void gmap_remove(struct gmap *gmap)
> >  	else
> >  		gmap_asce = -1UL;
> >  	WRITE_ONCE(gmap->mm->context.gmap_asce, gmap_asce);
> > -	spin_unlock(&gmap->mm->context.lock);
> > +	spin_unlock_bh(&gmap->mm->context.lock);
> >  	synchronize_rcu();
> >  	/* Put reference */
> >  	gmap_put(gmap);  
> 
> So we won't need to include those changes above...
> 
> > 
> > These are the compile fixes:
> >   
> > > +static void pte_free_now1(struct rcu_read *head)  
> > 
> > rcu_read -> rcu_head
> >   
> > > +{
> > > +	pte_free_half(head, 1);
> > > +}
> > > +
> > > +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> > > +{
> > > +	unsigned int bit, mask;
> > > +	struct page *page;
> > > +
> > > +	page = virt_to_page(pgtable);
> > > +	WARN_ON_ONCE(page->pt_mm != mm);
> > > +	if (mm_alloc_pgste(mm)) {
> > > +		call_rcu(&page->rcu_head, pte_free_pgste)  
> > 
> > Missing ";" at the end
> >   
> > > +		return;
> > > +	}  
> 
> ... but of course I must add these in: many thanks.
> And read up on the interesting commit.
> 
> You don't mention whether you were running with the
> #define destroy_context synchronize_rcu
> patch in.  And I was going to ask you to clarify on that,
> but there's no need: I found this morning that it was a bad idea.

I wasn't, only your original patch, with compile fixes and spin_lock_bh()
changes, and our defconfig.

> 
> Of course x86 doesn't tell a lot about s390 down at this level, and
> what's acceptable on one may be unacceptable on the other; but when
> I tried a synchronize_rcu() in x86's destroy_context(), the machines
> were not happy under load, warning messages, freeze: it looks like
> final __mmdrop() can sometimes be called from a context which is
> not at all suited for synchronize_rcu().
> 
> So then as another experiment, I tried adding synchronize_rcu() into
> the safer context at the end of exit_mmap(): that ran okay, but
> significantly slower (added 12% on kernel builds) than before.
> 
> My latest idea: we keep a SLAB_TYPESAFE_BY_RCU kmem cache for the
> spinlock, and most probably the pgtable_list head, and back pointer
> to the mm; and have each page table page using the pt_mm field to
> point to that structure, instead of to the mm itself.  Then
> __tlb_remove_table() can safely take the lock, even when the
> mm itself has gone away and been reused, even when that structure
> has gone away and been reused.  Hmm, I don't think it will even
> need to contain a backpointer to the mm.
> 
> But I see that as the right way forward, rather than as something
> needed today or tomorrow: in the meanwhile, to get v2 of my patchset
> out without breaking s390, I'm contemplating (the horror!) a global
> spinlock.

Not sure if I understood that right, would you want that global
lock as replacement for the current spin_lock() vs. spin_lock_bh()
confusion, or for addressing the "unstable mm" issue? In the first
case, I don't think it would be necessary, using spin_lock_bh()
in all places should be fine.

> 
> Many thanks, Gerald, I feel much better about it today.

Pleased to hear that :-)

Taking some closer look at your patch, I also have more questions,
related to page_table_alloc() changes, and also possibly breaking
commit c2c224932fd0:

> @@ -244,25 +252,15 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>  			page = list_first_entry(&mm->context.pgtable_list,
>  						struct page, lru);
>  			mask = atomic_read(&page->_refcount) >> 24;
> -			/*
> -			 * The pending removal bits must also be checked.
> -			 * Failure to do so might lead to an impossible
> -			 * value of (i.e 0x13 or 0x23) written to _refcount.
> -			 * Such values violate the assumption that pending and
> -			 * allocation bits are mutually exclusive, and the rest
> -			 * of the code unrails as result. That could lead to
> -			 * a whole bunch of races and corruptions.
> -			 */
> -			mask = (mask | (mask >> 4)) & 0x03U;
> -			if (mask != 0x03U) {
> -				table = (unsigned long *) page_to_virt(page);
> -				bit = mask & 1;		/* =1 -> second 2K */
> -				if (bit)
> -					table += PTRS_PER_PTE;
> -				atomic_xor_bits(&page->_refcount,
> -							0x01U << (bit + 24));
> -				list_del(&page->lru);
> -			}
> +			/* Cannot be on this list if either half pending free */
> +			WARN_ON_ONCE(mask & ~0x03U);
> +			/* One or other half must be available, but not both */
> +			WARN_ON_ONCE(mask == 0x00U || mask == 0x03U);
> +			table = (unsigned long *)page_to_virt(page);
> +			bit = mask & 0x01U;	/* =1 -> second 2K available */
> +			table += bit * PTRS_PER_PTE;
> +			atomic_xor_bits(&page->_refcount, 0x01U << (bit + 24));
> +			list_del(&page->lru);
>  		}
>  		spin_unlock_bh(&mm->context.lock);
>  		if (table)

I do not really see why this is needed, and it also does not seem to
change anything relevant wrt to the bits, only make it less restrictive
by removing the PP bits check. Of course, removing that important-looking
comment also does not feel very good.

I guess it is related either to what you do in pte_free_defer(), or
__tlb_remove_table(), but both places are under spin_lock, and I'm
not sure what this change here is good for (I think I thought I
understood on first review, but not any more, unfortunately this often
happens with this code...)

> @@ -314,24 +313,22 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
>  	struct page *page;
>  
>  	page = virt_to_page(table);
> +	WARN_ON_ONCE(page->pt_mm != mm);
>  	if (!mm_alloc_pgste(mm)) {
>  		/* Free 2K page table fragment of a 4K page */
>  		bit = ((unsigned long) table & ~PAGE_MASK)/(PTRS_PER_PTE*sizeof(pte_t));
>  		spin_lock_bh(&mm->context.lock);
>  		/*
> -		 * Mark the page for delayed release. The actual release
> -		 * will happen outside of the critical section from this
> -		 * function or from __tlb_remove_table()
> +		 * Mark the page for release. The actual release will happen
> +		 * below from this function, or later from __tlb_remove_table().
>  		 */
> -		mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
> +		mask = atomic_xor_bits(&page->_refcount, 0x01U << (bit + 24));

I guess you did this ...

>  		mask >>= 24;
> -		if (mask & 0x03U)
> +		if (mask & 0x03U)		/* other half is allocated */
>  			list_add(&page->lru, &mm->context.pgtable_list);
> -		else
> +		else if (!(mask & 0x30U))	/* other half not pending */

... to be able to add this check. But pte_free_defer() and page_table_free()
should never be called for the very same fragment, so (temporarily) setting
the P bit above, and clearing it below, should not cause any conflict with
the P bit set from pte_free_defer(), right?

Of course, the "if (!(mask & 0x30U))" check would always be true if you
did not remove the temporary P bit set above, but I guess that could also
be solved by explicitly checking for the other halves P bit, i.e. instead
of checking for any P bit with 0x30U.

>  			list_del(&page->lru);
>  		spin_unlock_bh(&mm->context.lock);
> -		mask = atomic_xor_bits(&page->_refcount, 0x10U << (bit + 24));
> -		mask >>= 24;

This reset of the temporary P bit might need to be moved inside the
spin_lock(), so that pte_free_defer() would observe a consistent state.

The race fix from commit c2c224932fd0 wants to temporarily set the P
bit for this fragment, until after list_del(), to prevent
__tlb_remove_table() from observing zero too early (it currently has no
spin_lock()!) and doing its free_page() in conflict with the list_del().

Not sure if your changes to __tlb_remove_table() changed anything
in that regard, now having access to the spin_lock(). But I also do
not see why the above change would necessarily be needed, and risk
introducing that race again.

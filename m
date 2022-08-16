Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65167C2BB41
	for <linux-s390@archiver.kernel.org>; Tue, 16 Aug 2022 20:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiHPUoU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 16 Aug 2022 16:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbiHPUnz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 Aug 2022 16:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F1940551
        for <linux-s390@vger.kernel.org>; Tue, 16 Aug 2022 13:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660682632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fxf9g37yt4QV3sYboUS8drWbHKZT6H8bVu/xJaEn0Rg=;
        b=eM9xgZnWVRvaSgxvkkrf6XteBA4JBMCBAouVpEbd/7DwtO2s0UswW+onMG187+UtGyhpPX
        dhdJ+YQ/+FR0RWC26/7baPhnR0eEcSSHeEgpjvTxZQZoU36ZQ7Jk1Qs5gh+zPPdesDRMJu
        rzlTo7XfybbxnHlUYQGAYGe74NiM3rA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-QN7u9S2gPXq2aih4oBCOWQ-1; Tue, 16 Aug 2022 16:43:50 -0400
X-MC-Unique: QN7u9S2gPXq2aih4oBCOWQ-1
Received: by mail-ed1-f71.google.com with SMTP id z6-20020a05640240c600b0043e1d52fd98so7476454edb.22
        for <linux-s390@vger.kernel.org>; Tue, 16 Aug 2022 13:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Fxf9g37yt4QV3sYboUS8drWbHKZT6H8bVu/xJaEn0Rg=;
        b=ZuItDK4C/udcU+N9AuYKqrlhGYKIca8fm8z0yYidyrOH8CRhvSs91w1zrN4RVG1Oei
         KaKvSK1A33Me49JKLJEWUuQliKQrXgaEeUCpHPa4qGs8Owwv8qIDN0/pN8h+wzqsBaJo
         qgcurJEgF2DEUzIV48Czuat/w1XAVUiDP3oOsEwFAm6M/8K3/kP7RWpRh3DBo8E2HQBy
         qICnPf9NQveogEPrwiZZAKqU+qmEnUK68AfpOoZzUWiMTqwhTo+yEAUPh1dAbuNbNmwW
         qZ8pNrzHc3Z+2E4Ckgw1oVPIueR0rPVMPp28gUY+HTjzIZowl24DAg67Xjb/ln2FjAX8
         OmdA==
X-Gm-Message-State: ACgBeo2sRC8oyXqyGaraS7txW8Q/ZfY4JfuAC0eiCqCKkyUYw4C2AJpu
        QH3dst+k01gnMFbm9SkZp58Yn/8y2vNQJJwJ03r8SzaQ++F9CClJxxTj2ELCpgmfZLz0zuJX85I
        kp5KpcEHqXaVvAfMqL+H9Er+K+SP14g4m6anNWg==
X-Received: by 2002:a17:907:2d12:b0:731:6a4e:ceb0 with SMTP id gs18-20020a1709072d1200b007316a4eceb0mr14858112ejc.115.1660682628492;
        Tue, 16 Aug 2022 13:43:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6mQoJ2O5YQF6G2r3WkspIUVkvBOxFCch0fVBSiDl1gYE66/cPrbW4OldsDj5twWFTyEbDTfZf7egY2AUaRKbQ=
X-Received: by 2002:a17:907:2d12:b0:731:6a4e:ceb0 with SMTP id
 gs18-20020a1709072d1200b007316a4eceb0mr14858098ejc.115.1660682628222; Tue, 16
 Aug 2022 13:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220811103435.188481-1-david@redhat.com> <20220811103435.188481-3-david@redhat.com>
 <YvVRfSYsPOraTo6o@monkey> <20220815153549.0288a9c6@thinkpad>
 <CADFyXm7-0zXDG+ZHjft95aAAiSZh_RyAqgJw1nGsALwEL1XKiw@mail.gmail.com>
 <20220815175929.303774fd@thinkpad> <CADFyXm40iiz-xFpLK4qGgHGh5Qp+98G9qxnqC20c8qtRiKt9_A@mail.gmail.com>
 <20220815203844.43b74fd1@thinkpad> <Yvq99MmpaGJBhlt4@monkey> <20220816113359.33843f54@thinkpad>
In-Reply-To: <20220816113359.33843f54@thinkpad>
From:   David Hildenbrand <david@redhat.com>
Date:   Tue, 16 Aug 2022 22:43:37 +0200
Message-ID: <CADFyXm5m1a+ZRwp1Kejt0L4HFcVBSoSz6mG-19_65CnR7s7Q-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/hugetlb: support write-faults in shared mappings
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, stable <stable@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Gerald,

>
> Thanks, we were also trying to reproduce on x86, w/o success so far. But
> I guess that matches David latest observations wrt to our exception handling
> code on s390.
>
> Good news is that the problem goes away when I add this simple patch, which
> should result in proper VM_WRITE check for vma flags, before triggering a
> FAULT_FLAG_WRITE fault:
>
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -379,7 +379,9 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>         flags = FAULT_FLAG_DEFAULT;
>         if (user_mode(regs))
>                 flags |= FAULT_FLAG_USER;
> -       if (access == VM_WRITE || is_write)
> +       if (is_write)
> +               access = VM_WRITE;
> +       if (access == VM_WRITE)
>                 flags |= FAULT_FLAG_WRITE;
>         mmap_read_lock(mm);

That's what I had in mind, good.

>
> Still find it a bit hard to believe that this > 10 years old logic really
> is/was broken all the time. I guess it simply did not matter for normal
> PTE faults, probably because the common fault handling code later would
> check itself via maybe_mkwrite(). And for hugetlb PTEs, it might not have
> mattered before commit bcd51a3c679d.

It is akward, but maybe we never really noticed for hugetlb (not sure
how common read-only mappings are after all).

>
> >
> > bcd51a3c679d eliminates the copying of page tables at fork for non-anon
> > hugetlb vmas.  So, in these tests you would likely see more pte_none()
> > faults.
>
> Yes, makes sense, assuming now that it actually is related to s390
> exception handling code, not checking for VM_WRITE before triggering a
> write fault for pte_none().
>
> Thanks for checking! And Thanks a lot to David for finding that issue
> in s390 exception handling code!

Thanks! Looks like adding the WARN_ON_ONCE was the right decision.


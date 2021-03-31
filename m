Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9355EC433C1
	for <linux-s390@archiver.kernel.org>; Wed, 31 Mar 2021 11:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B6C61989
	for <linux-s390@archiver.kernel.org>; Wed, 31 Mar 2021 11:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhCaLn3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 31 Mar 2021 07:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbhCaLn0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 31 Mar 2021 07:43:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17B8C06174A
        for <linux-s390@vger.kernel.org>; Wed, 31 Mar 2021 04:43:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so1026026pjc.2
        for <linux-s390@vger.kernel.org>; Wed, 31 Mar 2021 04:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGpodPHkfXLm7iN56tDwGRyDh5EuD8H1YpMxQufPMD0=;
        b=rwKHgWGBF7LbXnXNy5oGtdkj7nZFlz59noFuMNooFY6kaShHxbzRMz2I7d5nGgL7/t
         +ok1CQz/P9V4NcwZTV2I0zxbXSPqbmClTwg/N6NxPY284O20IoD6Z14MbEqsJBz9AdNY
         sjAmyPj74zOc/MnKuHRJS1kkUxVPpGUyhANWVh2yPxPTsW1uNnlblhzlrnN6pCrjWjSW
         IBe48QfLRzk3/tqGPuo0GP3N63V3cnkBIG7dd0nll8vo3JVEl7KOi6ueOuAFcw+0L71G
         vezVPvBBidgrSFC5btdWIO8bQk8h0Rkgcb0BZKA/blokIIYpu1h8vSipqhLmUXsk96rC
         Ibfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGpodPHkfXLm7iN56tDwGRyDh5EuD8H1YpMxQufPMD0=;
        b=Gpm5FVujXDQ92pvz471hMm9YfoinRd/Z6g2VJRCVRZxO5oA5xDWbaSzTbEqSrBlr1b
         Ipn4oAKwsyCG2/6n2BMWbSmwsI/owgkxEXLQ4EEe4TVWj+L29qbj04TdNSWEw76T8sje
         KU5HTFJ+Uk5IFfnCYjdUVwajBKeJ9xFNyGpfZgcw+PE/t51HDQUwdCrwiCSRWHJV8rhf
         e3OyxVroN3JbMtNKfyebwFjrQwN7klXCaXR9OICfw4l4zzrHAM6MPa4oy7VBDS0BO4KJ
         LgCC01p8CnwyoC2nR0n74FIM+1iENWcSm9iMwkQ9Ge+1omEEMUlXIl2YF/4ch10PrPAa
         kYEQ==
X-Gm-Message-State: AOAM531bws0PebDkCuLCpkhi09UEniAjC3dcUkTYyLkekPt6SCOHdo27
        wvc2zmQsNdCm484upzB2HYgD9tQ+m6M8Kl/GKZq5bw==
X-Google-Smtp-Source: ABdhPJyQeEccOchdfuIdOfAs7vnS1u5W66NAQF5XOs+4FxaBFfEy50turP6fbzyVPqbmyOQiVacohw7vfOhJFSVtnrU=
X-Received: by 2002:a17:902:da91:b029:e5:e7cf:d737 with SMTP id
 j17-20020a170902da91b02900e5e7cfd737mr2747859plx.24.1617191005204; Wed, 31
 Mar 2021 04:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210329205249.6b557510@canb.auug.org.au> <83263d0d-1f3f-8a3c-8a95-49e0cfa15051@de.ibm.com>
 <4419611b-3282-2197-884c-332025cdada8@de.ibm.com> <CAMZfGtUaTdmpcw1dr_rWQZTz3UTh9ZFavr0WBSa_obENPasgFw@mail.gmail.com>
 <7c27fc2e-5cea-5a17-6e30-8ae1cb291274@de.ibm.com> <CAMZfGtV9w24cJAwYsQuhvVpdLiYssjdfwfXApNK51zacr31c3w@mail.gmail.com>
 <179f84ad-7b98-4bc5-f895-c19faabbb311@de.ibm.com>
In-Reply-To: <179f84ad-7b98-4bc5-f895-c19faabbb311@de.ibm.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 31 Mar 2021 19:42:48 +0800
Message-ID: <CAMZfGtX0MvsXCE2DgBo=jsmTGWa5wcS40vaOJSBZ1U6Wnkx8Fw@mail.gmail.com>
Subject: Re: [External] RE: kernel warning percpu ref in obj_cgroup_release
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Mar 31, 2021 at 2:22 PM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
>
> On 30.03.21 18:25, Muchun Song wrote:
> > On Tue, Mar 30, 2021 at 11:10 PM Christian Borntraeger
> > <borntraeger@de.ibm.com> wrote:
> >>
> >>
> >> On 30.03.21 15:49, Muchun Song wrote:
> >>> On Tue, Mar 30, 2021 at 9:27 PM Christian Borntraeger
> >>> <borntraeger@de.ibm.com> wrote:
> >>>>
> >>>> So bisect shows this for belows warning:
> >>>
> >>> Thanks for your effort on this. Can you share your config?
> >>
> >> attached (but its s390x) for next-20210330
> >
> > Thanks. Can you apply the following patch and help me test?
> > Very Thanks.
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 7fdc92e1983e..579408e4d46f 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -793,6 +793,12 @@ static inline void obj_cgroup_get(struct obj_cgroup *objcg)
> >          percpu_ref_get(&objcg->refcnt);
> >   }
> >
> > +static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
> > +                                      unsigned long nr)
> > +{
> > +       percpu_ref_get_many(&objcg->refcnt, nr);
> > +}
> > +
> >   static inline void obj_cgroup_put(struct obj_cgroup *objcg)
> >   {
> >          percpu_ref_put(&objcg->refcnt);
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c0b83a396299..1634dba1044c 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3133,7 +3133,10 @@ void split_page_memcg(struct page *head, unsigned int nr)
> >
> >          for (i = 1; i < nr; i++)
> >                  head[i].memcg_data = head->memcg_data;
> > -       css_get_many(&memcg->css, nr - 1);
> > +       if (PageMemcgKmem(head))
> > +               obj_cgroup_get_many(__page_objcg(head), nr - 1);
> > +       else
> > +               css_get_many(&memcg->css, nr - 1);
> >   }
> >
> >   #ifdef CONFIG_MEMCG_SWAP
> >
>
> This one seems to do the trick, I can no longer see the warning.

Thanks for your testing. I will send a fix patch.

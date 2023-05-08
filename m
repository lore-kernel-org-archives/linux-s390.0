Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5FEC7EE24
	for <linux-s390@archiver.kernel.org>; Mon,  8 May 2023 17:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjEHR0R (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 8 May 2023 13:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjEHR0Q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 May 2023 13:26:16 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C15C59D0
        for <linux-s390@vger.kernel.org>; Mon,  8 May 2023 10:26:14 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7576eb88a46so183749185a.3
        for <linux-s390@vger.kernel.org>; Mon, 08 May 2023 10:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566773; x=1686158773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdTG6ohHjTz/AJd0T3pLa5J84Bi4YtOOy88Rg5Wrl88=;
        b=sZKcQvQ8ss2FfAs3cWAq70XoPSdDmF46CT2ZeYJcMXw2/RV1OLb1qBWC+tMubE/Eft
         dCWb8dhIMam2oBdieGewF20DcJkTMZU09dqeH6cq1ro1raSC5d0xeUwhwxhxI66ZDKlM
         cDZnbQBm4TQobVlcjzklowrhJyM8AMRLK+3h2+toO/jBzZaxk+EedwydP98RlLv37Yl+
         A1ydfsEdIfqI5x5SGRTMJOBkyJMOXInTuqDWaLSYZTMgq+fGsLNeQq6sER9YQ/OQo/An
         Js35GKOUX6+5hU+GcNn6CdnXf4F4ffC3BZAmtKE7fzhFGLN7vj4LJxyts3uHVbhL4xMD
         8/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566773; x=1686158773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdTG6ohHjTz/AJd0T3pLa5J84Bi4YtOOy88Rg5Wrl88=;
        b=ThwvDtjF4bMS5YPDRagZdtOavWEG92U2OttnO+a60NHtKwsuA94OxNsibYqUGnNmqu
         TD0ItdsFTvIYv0xzu7vXWL2yvkifBTpuFlxhf7KUmurJ/W3l09TW9rDAGD19j7svzC+b
         yLogLjZ+DMInLdGbmBBVN+vqn+pAODpSFeiHyG4gssDNqF4FZbBYKjaSFSzCX1kNGeZO
         FPrBiDUQBCZGYYU4S9gpXeN49t8RLDF+zLZRT+yrNKCcMDIgG8812zF1ofb4jJJnsMo7
         A3/DAdlQWZwBu2gaVkOPAROfbRDzMPbjmh0B0dZzaYuNqMhUXtRuLP15w45PFgCBhi2q
         9Vgw==
X-Gm-Message-State: AC+VfDx+PVvPgIlPDw4GmPNl/autGxsUqESHbTeh489bJfQU1TDTrG0V
        /NV5+FgsuDewcgDL1ZONqDkiICup6SCeUkXxhT8=
X-Google-Smtp-Source: ACHHUZ7oAEM+KBY9fBtUy4rvw55f2AWZiE1lM90iPY5z0ly8O9pDj3kxdVxcFGr9YTOMr2VeJpgxndQnN15ryBEb5xY=
X-Received: by 2002:a05:6214:2409:b0:61b:5b4b:2a4 with SMTP id
 fv9-20020a056214240900b0061b5b4b02a4mr18194563qvb.29.1683566773494; Mon, 08
 May 2023 10:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <202305070840.X0G3ofjl-lkp@intel.com> <CAKEwX=MrPCPKF7Yxfjc-uOR2P-+Ee8+RV_B_u1f7iqC0L=_yew@mail.gmail.com>
 <ZFkqBteEnMxRjUfj@osiris>
In-Reply-To: <ZFkqBteEnMxRjUfj@osiris>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 8 May 2023 10:26:02 -0700
Message-ID: <CAKEwX=NrYdaGOvzh41LNfMfWuzM+Yc1GP4V3ybj8tqiKPLFKxQ@mail.gmail.com>
Subject: Re: [linux-next:master 14680/14811] mm/filemap.c:4250:1: sparse:
 sparse: Using plain integer as NULL pointer
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 8, 2023 at 9:57=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> w=
rote:
>
> On Mon, May 08, 2023 at 09:45:56AM -0700, Nhat Pham wrote:
> > On Sat, May 6, 2023 at 5:28=E2=80=AFPM kernel test robot <lkp@intel.com=
> wrote:
> > > sparse warnings: (new ones prefixed by >>)
> > >    mm/filemap.c:1416:17: sparse: sparse: context imbalance in 'migrat=
ion_entry_wait_on_locked' - unexpected unlock
> > > >> mm/filemap.c:4250:1: sparse: sparse: Using plain integer as NULL p=
ointer
> > > >> mm/filemap.c:4250:1: sparse: sparse: Using plain integer as NULL p=
ointer
> > > >> mm/filemap.c:4250:1: sparse: sparse: Using plain integer as NULL p=
ointer
> ...
> > > > 4250  SYSCALL_DEFINE4(cachestat, unsigned int, fd,
> >
> > Hmm I couldn't see where I used 0 as the null pointer. Maybe
> > this is a false positive or a result of not wiring up the syscall
> > for s390? Especially since this is pointed toward the macro
> > line (SYSCALL_DEFINE).
> >
> > cc-ing this to s390 maintainers and the s390 mailing list...
> > Could you help me debug this? Thanks!
>
> Just ignore, this is a known false positive with s390's SYSCALL_DEFINE()
> implementation vs sparse. I looked into it once, but couldn't figure out
> how to silence sparse.
> IIRC, the __TYPE_IS_PTR() macro causes this.

Thanks for the prompt response and support, Heiko!

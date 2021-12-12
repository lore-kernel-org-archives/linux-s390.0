Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47154C433F5
	for <linux-s390@archiver.kernel.org>; Sun, 12 Dec 2021 15:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhLLPDO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 12 Dec 2021 10:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhLLPDN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 12 Dec 2021 10:03:13 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79338C061714
        for <linux-s390@vger.kernel.org>; Sun, 12 Dec 2021 07:03:13 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso11360235pjb.2
        for <linux-s390@vger.kernel.org>; Sun, 12 Dec 2021 07:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndCqA56yDPdk4/U5zH+4CHcCyXDgYIZ2oi0MLXCjqSE=;
        b=lhO3UYFyJKrqzq5HPDfc+PFbsq6QQfW7AmBNbExvbtFXlq0wrjQecG2WRqAzp6e4AG
         dLqR+L0MONeWmNZKrCWbmSw7KsFBqjQk0a6JStD9bDnpx6T5Rf298y84DqrtyoiNln+j
         /nxi0T904eMzGulj/yucVxrxufrXlv7SPyx3OB+4L7NQnQPGsSQQIeP+cWrzCOBXdsdB
         9uR0OqjTM+0xenAf71ShyHD6/tIbAIQM7rMQSqR1TDFxRmDysjPBgtFNyHL48igzxdl/
         aA0JNL1H+gyAVZzrzpbutn6XyR9YQkl5t8TYUpejKIAviNSqCIACT31/viHV0LOGrf3g
         xFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndCqA56yDPdk4/U5zH+4CHcCyXDgYIZ2oi0MLXCjqSE=;
        b=cyi26SgaxvPu4gDB7H3ExpqrMG6SUJAxzQYYnOkUNTOqLWwp9EnhkJhvKbr4tDByzQ
         NQF7sJM7f0OalBvXhydVi79Hv/oAOXBR8Z6fPAB9vOTwHZVtfmWftsSwneVQTx6P8fgq
         Vi0ZDOfblT2Oix8E/CWmS0VJZvDQXdFixXlHYeHhBzvWhiZt5G9wsMuwcxb++COklpCY
         mooX/1pF2+vUgYBJ3d6cF3oLM7jh2MRpJTJSBZBGK+rLWBvZwIcR5cgtD8YUzMDFnRMu
         e7tHLUfEHwMcHbcNsxi5myumiHtw7t1H5Ak1v9zSliigtnCAm4f9Z3mBn2rwER+zO+/+
         c+Nw==
X-Gm-Message-State: AOAM53107wit+xOk+d3v4mEogUCR2cknnPOjyg1Nd+htveTIkB2evt9C
        C63hNLM+0P4SobozyjpiyqE2WdrAUxlSvuM672wWWw==
X-Google-Smtp-Source: ABdhPJzM6ThjE9fb1jBuOnaTRvStJ0J72a1wwy0FvBkYR9v9S0zmF+mqndMBqw+OLDevQiB5qKGoueX9OBCB41euCZc=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr89560721plt.89.1639321392929; Sun, 12
 Dec 2021 07:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20211209063828.18944-1-hch@lst.de> <20211209063828.18944-6-hch@lst.de>
In-Reply-To: <20211209063828.18944-6-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 12 Dec 2021 07:03:02 -0800
Message-ID: <CAPcyv4gYXqbNRLkM4zJUq=sZuw4h_T+BSTXmESXc8juiWijKbQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] dax: always use _copy_mc_to_iter in dax_copy_to_iter
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Dec 8, 2021 at 10:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> While using the MC-safe copy routines is rather pointless on a virtual device
> like virtiofs, it also isn't harmful at all.  So just use _copy_mc_to_iter
> unconditionally to simplify the code.

From a correctness perspective, yes, but from a performance perspective, see:

enable_copy_mc_fragile()

...on those platforms fast-string copy implementation is replaced with
a manual unrolled copy. So this will cause a performance regression on
those platforms.

How about let's keep this as is / still only use it for PMEM where end
users are already dealing with the performance difference across
platforms? I considered exporting an indicator of which backend
routine has been selected from arch/x86/lib/copy_mc.c, but it got
messy quickly so I fell back to just keeping the status quo.

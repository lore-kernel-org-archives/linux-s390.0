Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10211C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  7 Sep 2021 07:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A29610FF
	for <linux-s390@archiver.kernel.org>; Tue,  7 Sep 2021 07:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhIGHw6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Sep 2021 03:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhIGHw6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Sep 2021 03:52:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4265EC061575;
        Tue,  7 Sep 2021 00:51:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u19so12675789edb.3;
        Tue, 07 Sep 2021 00:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6IndFkSb1Yiibw/M5NalmlPTesP6Xh/pdy6tyUvygQ=;
        b=ozMVxvWXxkl+emax0axRFeeClqY5f6Osmvx6CCs0XIDJ/JGdbQJEzfm91mMjywufZd
         C+CrajFMvscOiHNSB41iK4wLGKohKqgOltVdk/DxklufUdrFXAlB2yJNPnEJjlkqmhve
         LMLh98+h4dDbx800by/TLRbT5TbZ9Euo4uYN1+HwtT+K7Z39YDtTzeI8K9X7+m7KDkpB
         L7Nz8Fg9Ummt47zVNXsYyUq6Vw4Fw3AF4GKH/usJPpCT4U2lJaraVynEsZOXq6YgMIyD
         y3wVuTVuMxdhX+vggaow/qu45NiP4VkFziod8KLeEQSKUXtAg+51nxxI6vySErvBo1TB
         qlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6IndFkSb1Yiibw/M5NalmlPTesP6Xh/pdy6tyUvygQ=;
        b=pmpQSFdsybUe/xkXbKaoBvYy9FpFUeaqQvMOVVUTpoRR45Nc6ERB7oL1GIqV8+xCGV
         r+KikI1F8dUAUqQwNC3Oaudtg9Rpg/gxAICXRoCTdbk9Xk1pUMTBBdfRN8chGTg2P5s/
         BM0Dv4od/op0ZmftlMcPn7rHdavJ7wcurEJ0aIx32I599HF0LucwNoHL0w9G3fCQ/zZf
         GlzpYLLoepPMcVusMxu/f9T0LItIqZ5pBgNZs68OUMbKG1jNjstU40TZAWfpeppEFwER
         hPj+EXToDGeAgHYyye0GTAFmP/KnXcjl1fVuREeQWv/tQZwSOOpZX0Rp/e6Ng5V3KuJ5
         xBng==
X-Gm-Message-State: AOAM531dcWdmfbC3KSKa1wd7zv+K4FCCD1nDO3CTVd4+HYDJN51xGwhJ
        MX6NNdQZuVbp03ma7jCqaO7ujtb3nbCqyjTYzLc=
X-Google-Smtp-Source: ABdhPJx5tcHR6VKH3/CJ6YHoRXcJmHRud0LMRXdXY2Dt5BBF40tT5b/NYsnb0yaIEzafeGyKlPxhtYtMC2wTSQGfKis=
X-Received: by 2002:a05:6402:959:: with SMTP id h25mr17018341edz.283.1631001110739;
 Tue, 07 Sep 2021 00:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210906094927.524106-4-schnelle@linux.ibm.com> <202109070818.aHlo0OT9-lkp@intel.com>
In-Reply-To: <202109070818.aHlo0OT9-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Sep 2021 10:51:14 +0300
Message-ID: <CAHp75VeiWH0MoAchctDES7zLk4Q9NwODu=O2y-NYOsu3SBeimg@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: Move pci_dev_is/assign_added() to pci.h
To:     kernel test robot <lkp@intel.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kbuild-all@lists.01.org,
        Linas Vepstas <linasvepstas@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Russell Currey <ruscur@russell.cc>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 7, 2021 at 3:26 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Niklas,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on s390/features]
> [also build test ERROR on next-20210906]
> [cannot apply to pci/next powerpc/next v5.14]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Niklas-Schnelle/s390-pci-automatic-error-recovery/20210906-175309
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/404ed8c00a612e7ae31c50557c80c6726c464863
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Niklas-Schnelle/s390-pci-automatic-error-recovery/20210906-175309
>         git checkout 404ed8c00a612e7ae31c50557c80c6726c464863
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):

Obviously drivers/pci/pci.h is not only for the above.

When play with headers always do two test builds: allyesconfig and allmodconfig.

-- 
With Best Regards,
Andy Shevchenko

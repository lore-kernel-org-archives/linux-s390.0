Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D82C433EF
	for <linux-s390@archiver.kernel.org>; Fri, 24 Jun 2022 14:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiFXOt0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 24 Jun 2022 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiFXOr3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 24 Jun 2022 10:47:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C392A7E01D
        for <linux-s390@vger.kernel.org>; Fri, 24 Jun 2022 07:44:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h82-20020a25d055000000b00668b6a4ee32so2428274ybg.3
        for <linux-s390@vger.kernel.org>; Fri, 24 Jun 2022 07:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4626xia5d5LkF7af7H2/cvkuUYPcK6Kx8h2FacVJFEk=;
        b=th1qe6nCen6zmaCB190GBZfnRnMr8qckPf7xXdSq0EVD8gYjLt6WzhfTitRavGwMgd
         vXilcNgCDBJRRUwP86/NE2cFk2yt4LhrpvKbk+OSVaOhZ9QX7RoXNrnjse0RW8wrov0A
         e/AjVrKc+b2APqiS3MmTV8TXpGYJnfibLdZbRt8tPJAQ4VejcBVaHjm3xiHfRthqt3hO
         14SO9lJx7tqftr6orGS/SfyVF/xr5P71GTXTgmaE3fA6eyIJ4dLNQMv3/dfvge1guWtE
         73rzZBtWVKfBk7sNXfxQEVTU5QpWxtJpBQ75xhUnQaYU9jnnZSOcZn/PcgtTEVHgJAUL
         xvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4626xia5d5LkF7af7H2/cvkuUYPcK6Kx8h2FacVJFEk=;
        b=xSamk3MVFhQf+35E757vWlzg0pK1GbzVbKdUcSRUtAC0Eula2UZyruV/iiIiRXxi+K
         xK9HEpUUQhdEHD2W7YBRBL+j0l8jLDWA2+LUbtUUslZ7EPmhgv8wKfH+kdROsoG/8G5A
         SSYeuehem8xmVYezD1X4Swex6XGBAN7xDrYYQE3lJfbvuubHMY79+iCLzIYrq81ZY/3J
         DWVJDIh2I+mIrjJPjYzE7/SxXNl9KB9Z6To3e5R614aG9QyKul5bSK8kURTrFysjtCRt
         du2ovq/n4bkxcTa7EtWHe4W9vZ6+sJg29a2po4XjO7x16DqQviEmHKdMYzSMHXKRV0JS
         KAVw==
X-Gm-Message-State: AJIora+xXOg8uCXhvKwu5Sv+hliklB9yABeKETFf/e8bv+Djt0ozpJ8A
        BPuQ7xSX6HGlEmjWIRF+2i4LI5XT7e1HdQ==
X-Google-Smtp-Source: AGRyM1u8PEp1pM9/KxJIfa3nFsPEcGkFKuipmMhOWQIlB56Ud7icllIM9M0fY7r3dfrgjjZsEQIIA/WAW9Z2GQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:5bc3:0:b0:669:b722:beb8 with SMTP id
 p186-20020a255bc3000000b00669b722beb8mr5658217ybb.447.1656081841097; Fri, 24
 Jun 2022 07:44:01 -0700 (PDT)
Date:   Fri, 24 Jun 2022 14:43:58 +0000
In-Reply-To: <20220624070656.GE79500@shbuild999.sh.intel.com>
Message-Id: <20220624144358.lqt2ffjdry6p5u4d@google.com>
Mime-Version: 1.0
References: <20220619150456.GB34471@xsang-OptiPlex-9020> <20220622172857.37db0d29@kernel.org>
 <CADvbK_csvmkKe46hT9792=+Qcjor2EvkkAnr--CJK3NGX-N9BQ@mail.gmail.com>
 <CADvbK_eQUmb942vC+bG+NRzM1ki1LiCydEDR1AezZ35Jvsdfnw@mail.gmail.com>
 <20220623185730.25b88096@kernel.org> <CANn89iLidqjiiV8vxr7KnUg0JvfoS9+TRGg=8ANZ8NBRjeQxsQ@mail.gmail.com>
 <CALvZod7kULCvHAuk53FE-XBOi4-BbLdY3HCg6jfCZTJDxYsZow@mail.gmail.com> <20220624070656.GE79500@shbuild999.sh.intel.com>
Subject: Re: [net] 4890b686f4: netperf.Throughput_Mbps -69.4% regression
From:   Shakeel Butt <shakeelb@google.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Eric Dumazet <edumazet@google.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        linux-s390@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>, Ying Xu <yinxu@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 24, 2022 at 03:06:56PM +0800, Feng Tang wrote:
> On Thu, Jun 23, 2022 at 11:34:15PM -0700, Shakeel Butt wrote:
[...]
> > 
> > Feng, can you please explain the memcg setup on these test machines
> > and if the tests are run in root or non-root memcg?
> 
> I don't know the exact setup, Philip/Oliver from 0Day can correct me.
> 
> I logged into a test box which runs netperf test, and it seems to be
> cgoup v1 and non-root memcg. The netperf tasks all sit in dir:
> '/sys/fs/cgroup/memory/system.slice/lkp-bootstrap.service'
> 

Thanks Feng. Can you check the value of memory.kmem.tcp.max_usage_in_bytes
in /sys/fs/cgroup/memory/system.slice/lkp-bootstrap.service after making
sure that the netperf test has already run?

If this is non-zero then network memory accounting is enabled and the
slowdown is expected.

> And the rootfs is a debian based rootfs
> 
> Thanks,
> Feng
> 
> 
> > thanks,
> > Shakeel

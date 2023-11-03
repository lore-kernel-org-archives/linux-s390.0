Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D71C4332F
	for <linux-s390@archiver.kernel.org>; Fri,  3 Nov 2023 04:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjKCE7A convert rfc822-to-8bit (ORCPT
        <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Nov 2023 00:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCE67 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Nov 2023 00:58:59 -0400
X-Greylist: delayed 155 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 21:58:55 PDT
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B792E1A4
        for <linux-s390@vger.kernel.org>; Thu,  2 Nov 2023 21:58:55 -0700 (PDT)
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] net/smc: avoid atomic_set and smp_wmb in the tx path when
 possible
Thread-Topic: [PATCH] net/smc: avoid atomic_set and smp_wmb in the tx path
 when possible
Thread-Index: AQHaDZx2DjwnGoCXVUiRNSdWa8EgxrBoASeg
Date:   Fri, 3 Nov 2023 04:43:40 +0000
Message-ID: <6cadd420741145b897cc18237ce78688@baidu.com>
References: <20231102092712.30793-1-lirongqing@baidu.com>
 <20231102145418.GH92403@linux.alibaba.com>
In-Reply-To: <20231102145418.GH92403@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.206.15]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.56
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



> -----Original Message-----
> From: Dust Li <dust.li@linux.alibaba.com>
> Sent: Thursday, November 2, 2023 10:54 PM
> To: Li,Rongqing <lirongqing@baidu.com>; linux-s390@vger.kernel.org;
> netdev@vger.kernel.org
> Subject: Re: [PATCH] net/smc: avoid atomic_set and smp_wmb in the tx path
> when possible
> 
> On Thu, Nov 02, 2023 at 05:27:12PM +0800, Li RongQing wrote:
> >these is less opportunity that conn->tx_pushing is not 1, since
> 
> these -> there ?

Yes, thanks

> 
> >tx_pushing is just checked with 1, so move the setting tx_pushing to 1
> >after atomic_dec_and_test() return false, to avoid atomic_set and
> >smp_wmb in tx path when possible
> 
> The patch should add [PATCH net-next] subject-prefix since this is an
> optimization.
> 

OK

> Besides, do you have any performance number ?

Just try a simple performance test,  seems same.

-Li


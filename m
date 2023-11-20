Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C1DC197A0
	for <linux-s390@archiver.kernel.org>; Mon, 20 Nov 2023 09:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjKTJuE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 20 Nov 2023 04:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjKTJuD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Nov 2023 04:50:03 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86078A7;
        Mon, 20 Nov 2023 01:49:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vwlwy7d_1700473796;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0Vwlwy7d_1700473796)
          by smtp.aliyun-inc.com;
          Mon, 20 Nov 2023 17:49:57 +0800
Date:   Mon, 20 Nov 2023 17:49:52 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     dust.li@linux.alibaba.com,
        Alexandra Winter <wintera@linux.ibm.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net/smc: avoid atomic_set and smp_wmb in the
 tx path when possible
Message-ID: <ZVsrwM0U7XUTgXAo@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20231117111657.16266-1-lirongqing@baidu.com>
 <422c5968-8013-4b39-8cdb-07452abbf5fb@linux.ibm.com>
 <20231120032029.GA3323@linux.alibaba.com>
 <22394c7b-0470-472d-9474-4de5fc86c5ea@linux.ibm.com>
 <f648fe4f-c911-43c5-be52-1a6324f063a6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f648fe4f-c911-43c5-be52-1a6324f063a6@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Nov 20, 2023 at 10:17:15AM +0100, Alexandra Winter wrote:
> 
> 
> On 20.11.23 10:11, Alexandra Winter wrote:
> > 
> > 
> > On 20.11.23 04:20, Dust Li wrote:
> >>> It seems to me that the purpose of conn->tx_pushing is
> >>> a) Serve as a mutex, so only one thread per conn will call __smc_tx_sndbuf_nonempty().
> >>> b) Repeat, in case some other thread has added data to sndbuf concurrently.
> >>>
> >>> I agree that this patch does not change the behaviour of this function and removes an
> >>> atomic_set() in the likely path.
> >>>
> >>> I wonder however: All callers of smc_tx_sndbuf_nonempty() must hold the socket lock.
> >>> So how can we ever run in a concurrency situation?
> >>> Is this handling of conn->tx_pushing necessary at all?
> >> Hi Sandy,
> >>
> >> Overall, I think you are right. But there is something we need to take care.
> >>
> >> Before commit 6b88af839d20 ("net/smc: don't send in the BH context if
> >> sock_owned_by_user"), we used to call smc_tx_pending() in the soft IRQ,
> >> without checking sock_owned_by_user(), which would caused a race condition
> >> because bh_lock_sock() did not honor sock_lock(). To address this issue,
> >> I have added the tx_pushing mechanism. However, with commit 6b88af839d20,
> >> we now defer the transmission if sock_lock() is held by the user.
> >> Therefore, there should no longer be a race condition. Nevertheless, if
> >> we remove the tx_pending mechanism, we must always remember not to call
> >> smc_tx_sndbuf_nonempty() in the soft IRQ when the user holds the sock lock.
> >>
> >> Thanks
> >> Dust
> > 
> > 
> > ok, I understand.
> > So whoever is willing to give it a try and simplify smc_tx_sndbuf_nonempty(),
> > should remember to document that requirement/precondition.
> > Maybe in a Function context section of a kernel-doc function decription?
> > (as described in https://docs.kernel.org/doc-guide/kernel-doc.html)
> > Although smc_tx_sndbuf_nonempty() is not exported, this format is helpful.
> > 
> 
> 
> Tony Lu <tonylu@linux.alibaba.com> ' mail address has been corrupted in this whole thread.
> Please reply to this message (corrected address) or take care, if replying to
> other messages in this thread.

Yes, that's true. Thanks Alexandra.

Please use my correct address, RongQing: Tony Lu <tonylu@linux.alibaba.com>.

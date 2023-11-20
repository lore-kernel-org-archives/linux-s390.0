Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E25C5ACB3
	for <linux-s390@archiver.kernel.org>; Mon, 20 Nov 2023 03:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjKTDUs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 19 Nov 2023 22:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjKTDUr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 19 Nov 2023 22:20:47 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3598BD5D;
        Sun, 19 Nov 2023 19:20:33 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vwg4HNF_1700450429;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Vwg4HNF_1700450429)
          by smtp.aliyun-inc.com;
          Mon, 20 Nov 2023 11:20:30 +0800
Date:   Mon, 20 Nov 2023 11:20:29 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Li RongQing <lirongqing@baidu.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.co,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net/smc: avoid atomic_set and smp_wmb in the
 tx path when possible
Message-ID: <20231120032029.GA3323@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20231117111657.16266-1-lirongqing@baidu.com>
 <422c5968-8013-4b39-8cdb-07452abbf5fb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422c5968-8013-4b39-8cdb-07452abbf5fb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Nov 17, 2023 at 01:27:57PM +0100, Alexandra Winter wrote:
>
>
>On 17.11.23 12:16, Li RongQing wrote:
>> There is rare possibility that conn->tx_pushing is not 1, since
>> tx_pushing is just checked with 1, so move the setting tx_pushing
>> to 1 after atomic_dec_and_test() return false, to avoid atomic_set
>> and smp_wmb in tx path
>> 
>> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>> ---
>> diff v3: improvements in the commit body and comments
>> diff v2: fix a typo in commit body and add net-next subject-prefix
>>  net/smc/smc_tx.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
>> index 3b0ff3b..2c2933f 100644
>> --- a/net/smc/smc_tx.c
>> +++ b/net/smc/smc_tx.c
>> @@ -667,8 +667,6 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
>>  		return 0;
>>  
>>  again:
>> -	atomic_set(&conn->tx_pushing, 1);
>> -	smp_wmb(); /* Make sure tx_pushing is 1 before real send */
>>  	rc = __smc_tx_sndbuf_nonempty(conn);
>>  
>>  	/* We need to check whether someone else have added some data into
>> @@ -677,8 +675,11 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
>>  	 * If so, we need to push again to prevent those data hang in the send
>>  	 * queue.
>>  	 */
>> -	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing)))
>> +	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing))) {
>> +		atomic_set(&conn->tx_pushing, 1);
>> +		smp_wmb(); /* Make sure tx_pushing is 1 before send again */
>>  		goto again;
>> +	}
>>  
>>  	return rc;
>>  }
>
>It seems to me that the purpose of conn->tx_pushing is
>a) Serve as a mutex, so only one thread per conn will call __smc_tx_sndbuf_nonempty().
>b) Repeat, in case some other thread has added data to sndbuf concurrently.
>
>I agree that this patch does not change the behaviour of this function and removes an
>atomic_set() in the likely path.
>
>I wonder however: All callers of smc_tx_sndbuf_nonempty() must hold the socket lock.
>So how can we ever run in a concurrency situation?
>Is this handling of conn->tx_pushing necessary at all?

Hi Sandy,

Overall, I think you are right. But there is something we need to take care.

Before commit 6b88af839d20 ("net/smc: don't send in the BH context if
sock_owned_by_user"), we used to call smc_tx_pending() in the soft IRQ,
without checking sock_owned_by_user(), which would caused a race condition
because bh_lock_sock() did not honor sock_lock(). To address this issue,
I have added the tx_pushing mechanism. However, with commit 6b88af839d20,
we now defer the transmission if sock_lock() is held by the user.
Therefore, there should no longer be a race condition. Nevertheless, if
we remove the tx_pending mechanism, we must always remember not to call
smc_tx_sndbuf_nonempty() in the soft IRQ when the user holds the sock lock.

Thanks
Dust

Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76D4C54E76
	for <linux-s390@archiver.kernel.org>; Mon, 20 Nov 2023 09:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjKTJ4y (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 20 Nov 2023 04:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjKTJ4x (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Nov 2023 04:56:53 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F94CD;
        Mon, 20 Nov 2023 01:56:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VwlZREN_1700474204;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VwlZREN_1700474204)
          by smtp.aliyun-inc.com;
          Mon, 20 Nov 2023 17:56:45 +0800
Date:   Mon, 20 Nov 2023 17:56:42 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 29/34] net: smc: fix opencoded find_and_set_bit() in
 smc_wr_tx_get_free_slot_index()
Message-ID: <ZVstWgls5D2c8m4a@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-30-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118155105.25678-30-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The prefix tag and subject imply that it is a bugfix. I think, first, it
should be a new feature with net-next tag. Also please use net/smc as
prefix.

Thanks,
Tony Lu

On Sat, Nov 18, 2023 at 07:51:00AM -0800, Yury Norov wrote:
> The function opencodes find_and_set_bit() with a for_each() loop. Fix
> it, and make the whole function a simple almost one-liner.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  net/smc/smc_wr.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 0021065a600a..b6f0cfc52788 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -170,15 +170,11 @@ void smc_wr_tx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
>  
>  static inline int smc_wr_tx_get_free_slot_index(struct smc_link *link, u32 *idx)
>  {
> -	*idx = link->wr_tx_cnt;
>  	if (!smc_link_sendable(link))
>  		return -ENOLINK;
> -	for_each_clear_bit(*idx, link->wr_tx_mask, link->wr_tx_cnt) {
> -		if (!test_and_set_bit(*idx, link->wr_tx_mask))
> -			return 0;
> -	}
> -	*idx = link->wr_tx_cnt;
> -	return -EBUSY;
> +
> +	*idx = find_and_set_bit(link->wr_tx_mask, link->wr_tx_cnt);
> +	return *idx < link->wr_tx_cnt ? 0 : -EBUSY;
>  }
>  
>  /**
> -- 
> 2.39.2

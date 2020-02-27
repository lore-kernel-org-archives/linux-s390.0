Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:37178 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgB0E5H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Feb 2020 23:57:07 -0500
Date: Wed, 26 Feb 2020 20:57:06 -0800 (PST)
Message-Id: <20200226.205706.235234689411895706.davem@davemloft.net>
Subject: Re: [PATCH net] net/smc: check for valid ib_client_data
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200226165246.3426-1-kgraul@linux.ibm.com>
References: <20200226165246.3426-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Wed, 26 Feb 2020 17:52:46 +0100

> In smc_ib_remove_dev() check if the provided ib device was actually
> initialized for SMC before.
> 
> Reported-by: syzbot+84484ccebdd4e5451d91@syzkaller.appspotmail.com
> Fixes: a4cf0443c414 ("smc: introduce SMC as an IB-client")
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Applied and queued up for -stable, thanks.

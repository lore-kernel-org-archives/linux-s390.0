Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:59486 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfKGBqD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 20:46:03 -0500
Date: Wed, 06 Nov 2019 17:46:01 -0800 (PST)
Message-Id: <20191106.174601.340921510977427928.davem@davemloft.net>
Subject: Re: [PATCH net] net/smc: fix ethernet interface refcounting
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191106094957.94521-1-kgraul@linux.ibm.com>
References: <20191106094957.94521-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Wed,  6 Nov 2019 10:49:57 +0100

> From: Ursula Braun <ubraun@linux.ibm.com>
> 
> If a pnet table entry is to be added mentioning a valid ethernet
> interface, but an invalid infiniband or ISM device, the dev_put()
> operation for the ethernet interface is called twice, resulting
> in a negative refcount for the ethernet interface, which disables
> removal of such a network interface.
> 
> This patch removes one of the dev_put() calls.
> 
> Fixes: 890a2cb4a966 ("net/smc: rework pnet table")
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Applied and queued up for -stable, thanks.

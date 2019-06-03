Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:34118 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFCTnv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Jun 2019 15:43:51 -0400
Date: Mon, 03 Jun 2019 12:43:48 -0700 (PDT)
Message-Id: <20190603.124348.5212561789204100.davem@davemloft.net>
Subject: Re: [PATCH net 2/4] s390/qeth: don't use obsolete dst entry
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190603150446.23351-3-jwi@linux.ibm.com>
References: <20190603150446.23351-1-jwi@linux.ibm.com>
        <20190603150446.23351-3-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Mon,  3 Jun 2019 17:04:44 +0200

> While qeth_l3 uses netif_keep_dst() to hold onto the dst, a skb's dst
> may still have been obsoleted (via dst_dev_put()) by the time that we
> end up using it. The dst then points to the loopback interface, which
> means the neighbour lookup in qeth_l3_get_cast_type() determines a bogus
> cast type of RTN_BROADCAST.
> For IQD interfaces this causes us to place such skbs on the wrong
> HW queue, resulting in TX errors.
> 
> Fix-up the various call sites to check whether the dst is obsolete, and
> fall back accordingly.
> 
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>

Please use "dst_check()".

Some routes have DST_OBSOLETE_FORCE_CHK set on them from the very beginning
so that uses of the route are forced through the dst->ops->check() method.

Simply use dst_check() and then you can just retain the 'rt == NULL' logic
as-is.

Thanks.

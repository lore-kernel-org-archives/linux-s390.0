Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:50616 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfIPTpw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 16 Sep 2019 15:45:52 -0400
Date: Mon, 16 Sep 2019 21:45:49 +0200 (CEST)
Message-Id: <20190916.214549.77520800522293464.davem@davemloft.net>
Subject: Re: [PATCH net-next] s390/ctcm: Delete unnecessary checks before
 the macro call =?iso-2022-jp?B?GyRCIUgbKEJkZXZfa2ZyZWVfc2tiGyRCIUkbKEI=?=
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190915172105.42024-1-jwi@linux.ibm.com>
References: <20190915172105.42024-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com, elfring@users.sourceforge.net

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Sun, 15 Sep 2019 19:21:05 +0200

> From: Markus Elfring <elfring@users.sourceforge.net>
> 
> The dev_kfree_skb() function performs also input parameter validation.
> Thus the test around the shown calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>

Applied.

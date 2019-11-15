Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:57684 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfKOCRW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 21:17:22 -0500
Date: Thu, 14 Nov 2019 18:17:21 -0800 (PST)
Message-Id: <20191114.181721.1380376470346120906.davem@davemloft.net>
Subject: Re: [PATCH net-next 00/11] s390/qeth: updates 2019-11-14
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191114101924.29558-1-jwi@linux.ibm.com>
References: <20191114101924.29558-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Thu, 14 Nov 2019 11:19:13 +0100

> please apply the following qeth patches to net-next.
> Along with the usual cleanups, this
> (1) reduces collateral packet loss in the RX path when dealing with
>     bad packets and/or allocation errors, and
> (2) simplifies how the L3 driver deals with mcast IP addresses.

Series applied, thanks.

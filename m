Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:34474 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgCJBQf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 21:16:35 -0400
Date: Mon, 09 Mar 2020 18:16:34 -0700 (PDT)
Message-Id: <20200309.181634.1145606871494987543.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/2] s390/qeth: updates 2020-03-06
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200306081311.50635-1-jwi@linux.ibm.com>
References: <20200306081311.50635-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Fri,  6 Mar 2020 09:13:09 +0100

> please apply the following patch series for qeth to netdev's net-next
> tree.
> 
> Just a small update to take care of a regression wrt to IRQ handling in
> net-next, reported by Qian Cai. The fix needs some qdio layer changes,
> so you will find Vasily's Acked-by in that patch.

Series applied, thank you.

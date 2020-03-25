Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:46506 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgCYTHi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 25 Mar 2020 15:07:38 -0400
Date: Wed, 25 Mar 2020 12:07:36 -0700 (PDT)
Message-Id: <20200325.120736.1056190737805711257.davem@davemloft.net>
Subject: Re: [PATCH v2 net-next 00/11] s390/qeth: updates 2020-03-25
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200325093507.20831-1-jwi@linux.ibm.com>
References: <20200325093507.20831-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Wed, 25 Mar 2020 10:34:56 +0100

> please apply the following patch series for qeth to netdev's net-next
> tree.
> Same series as yesterday, with one minor update to patch 1 as per
> your review.
> 
> This adds
> 1) NAPI poll support for the async-Completion Queue (with one qdio layer
>    patch acked by Heiko),
> 2) ethtool support for per-queue TX IRQ coalescing,
> 3) various cleanups.

Series applied, thank you.

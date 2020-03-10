Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:43890 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgCJXIn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 10 Mar 2020 19:08:43 -0400
Date: Tue, 10 Mar 2020 16:08:42 -0700 (PDT)
Message-Id: <20200310.160842.1259774022339854727.davem@davemloft.net>
Subject: Re: [PATCH net 0/3] s390/qeth: fixes 2020-03-10
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200310173803.91602-1-jwi@linux.ibm.com>
References: <20200310173803.91602-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Tue, 10 Mar 2020 18:38:00 +0100

> please apply the following patch series for qeth to netdev's net tree.
> 
> This fixes three minor issues:
> 1) a setup parameter gets cleared unnecessarily when the HW config
>    changes,
> 2) insufficient error handling when initially filling the RX ring, and
> 3) a rarely used worker that needs to be cancelled during tear down.

Series applied and queued up for -stable, thank you.

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:56366 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387831AbgCLGw5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 Mar 2020 02:52:57 -0400
Date: Wed, 11 Mar 2020 23:52:55 -0700 (PDT)
Message-Id: <20200311.235255.608477201434903797.davem@davemloft.net>
Subject: Re: [PATCH net 0/3] s390/qeth: fixes 2020-03-11
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200311170711.50376-1-jwi@linux.ibm.com>
References: <20200311170711.50376-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Wed, 11 Mar 2020 18:07:08 +0100

> please apply the following patch series for qeth to netdev's net tree.
> 
> Just one fix to get the RX buffer pool resizing right, with two
> preparatory cleanups.
> This is on the larger side given where we are in the -rc cycle, but a
> big chunk of the delta is just refactoring to make the fix look nice.
> 
> I intentionally split these off from yesterday's series. No objections
> if you'd rather punt them to net-next, the series should apply cleanly.

Series applied, thanks.

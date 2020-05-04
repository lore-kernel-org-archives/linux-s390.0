Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729958AbgEDSWE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 14:22:04 -0400
Date: Mon, 04 May 2020 11:22:03 -0700 (PDT)
Message-Id: <20200504.112203.513284964071545941.davem@davemloft.net>
Subject: Re: [PATCH net] s390/qeth: fix cancelling of TX timer on
 dev_close()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200504173942.69298-1-jwi@linux.ibm.com>
References: <20200504173942.69298-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Mon,  4 May 2020 19:39:42 +0200

> With the introduction of TX coalescing, .ndo_start_xmit now potentially
> starts the TX completion timer. So only kill the timer _after_ TX has
> been disabled.
> 
> Fixes: ee1e52d1e4bb ("s390/qeth: add TX IRQ coalescing support for IQD devices")
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>

Applied, thanks Julian.

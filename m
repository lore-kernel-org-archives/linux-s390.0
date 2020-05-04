Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730356AbgEDRyy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 13:54:54 -0400
Date: Mon, 04 May 2020 10:54:52 -0700 (PDT)
Message-Id: <20200504.105452.654741717600774282.davem@davemloft.net>
Subject: Re: [PATCH net-next 00/12] net/smc: add failover processing
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200504121848.46585-1-kgraul@linux.ibm.com>
References: <20200504121848.46585-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Mon,  4 May 2020 14:18:36 +0200

> This patch series adds the actual SMC-R link failover processing and 
> improved link group termination. There will be one more (very small) 
> series after this which will complete the SMC-R link failover support.

Series applied, thanks.

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2T1W (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 15:27:22 -0400
Date: Wed, 29 Apr 2020 12:27:20 -0700 (PDT)
Message-Id: <20200429.122720.1365020998978075421.davem@davemloft.net>
Subject: Re: [PATCH net-next 00/13] net/smc: preparations for SMC-R link
 failover
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200429151049.49979-1-kgraul@linux.ibm.com>
References: <20200429151049.49979-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Wed, 29 Apr 2020 17:10:36 +0200

> This patch series prepares the SMC code for the implementation of SMC-R link 
> failover capabilities which are still missing to reach full compliance with 
> RFC 7609.
> The code changes are separated into 65 patches which together form the new
> functionality. I tried to create meaningful patches which allow to follow the 
> implementation.

Series applied.

> Question: how to handle the remaining 52 patches? All of them are needed for 
> link failover to work and should make it into the same merge window. 
> Can I send them all together?

No.

You must break these changes up into significantly smaller sized,
logical, group of changes.  That's part of your responsibility when
submitting changes, keeping the patch series small and reviewable.

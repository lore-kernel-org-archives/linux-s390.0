Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBXXK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Oct 2020 19:23:10 -0400
Date: Fri, 02 Oct 2020 16:23:07 -0700 (PDT)
Message-Id: <20201002.162307.2247455671956675824.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/7] s390/net: updates 2020-10-01
From: David Miller <davem@davemloft.net>
In-Reply-To: <20201001171136.46830-1-jwi@linux.ibm.com>
References: <20201001171136.46830-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, ubraun@linux.ibm.com, kgraul@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Thu,  1 Oct 2020 19:11:29 +0200

> please apply the following patch series to netdev's net-next tree.
> 
> Patches 1-3 enable qeth to also support the .set_channels() ethtool
> callback for OSA devices. This completes support for the full range
> of device types.
> 
> The other patches are just the usual mix of cleanups.
> (Even one for ctcm!)

Series applied, thanks.

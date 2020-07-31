Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgGaXo6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 31 Jul 2020 19:44:58 -0400
Date: Fri, 31 Jul 2020 16:44:56 -0700 (PDT)
Message-Id: <20200731.164456.1479099850550140032.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/4] s390/qeth: updates 2020-07-30
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200730150121.18005-1-jwi@linux.ibm.com>
References: <20200730150121.18005-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, ubraun@linux.ibm.com, kgraul@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Thu, 30 Jul 2020 17:01:17 +0200

> please apply the following patch series for qeth to netdev's net-next tree.
> 
> This primarily brings some modernization to the RX path, laying the
> groundwork for smarter RX refill policies.
> Some of the patches are tagged as fixes, but really target only rare /
> theoretical issues. So given where we are in the release cycle and that we
> touch the main RX path, taking them through net-next seems more appropriate.

Series applied to net-next, thanks.

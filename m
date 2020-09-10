Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIJUbf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Sep 2020 16:31:35 -0400
Date: Thu, 10 Sep 2020 13:31:33 -0700 (PDT)
Message-Id: <20200910.133133.1446679823351648711.davem@davemloft.net>
Subject: Re: [PATCH net] s390/qeth: delay draining the TX buffers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200910090518.71420-1-jwi@linux.ibm.com>
References: <20200910090518.71420-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, ubraun@linux.ibm.com, kgraul@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Thu, 10 Sep 2020 11:05:18 +0200

> Wait until the QDIO data connection is severed. Otherwise the device
> might still be processing the buffers, and end up accessing skb data
> that we already freed.
> 
> Fixes: 8b5026bc1693 ("s390/qeth: fix qdio teardown after early init error")
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>

Applied.

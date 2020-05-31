Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgEaBMG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 30 May 2020 21:12:06 -0400
Date: Sat, 30 May 2020 18:12:04 -0700 (PDT)
Message-Id: <20200530.181204.1805037250596208281.davem@davemloft.net>
Subject: Re: [PATCH net-next] net/smc: pre-fetch send buffer outside of
 send_lock
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200530144237.15883-1-kgraul@linux.ibm.com>
References: <20200530144237.15883-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Sat, 30 May 2020 16:42:37 +0200

> Pre-fetch send buffer for the CDC validation message before entering the
> send_lock. Without that the send call might fail with -EBUSY because
> there are no free buffers and waiting for buffers is not possible under
> send_lock.
> 
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
> Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>

Applied, thanks.

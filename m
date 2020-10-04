Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgJDAFk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 3 Oct 2020 20:05:40 -0400
Date: Sat, 03 Oct 2020 17:05:38 -0700 (PDT)
Message-Id: <20201003.170538.1607088552412478587.davem@davemloft.net>
Subject: Re: [PATCH net-next 1/2] net/smc: send ISM devices with unique
 chid in CLC proposal
From: David Miller <davem@davemloft.net>
In-Reply-To: <20201002150927.72261-2-kgraul@linux.ibm.com>
References: <20201002150927.72261-1-kgraul@linux.ibm.com>
        <20201002150927.72261-2-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Fri,  2 Oct 2020 17:09:26 +0200

> When building a CLC proposal message then the list of ISM devices does
> not need to contain multiple devices that have the same chid value,
> all these devices use the same function at the end.
> Improve smc_find_ism_v2_device_clnt() to collect only ISM devices that
> have unique chid values.
> 
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Series applied, but could you send a proper patch series in the future
with a "[PATCH 0/N] ..." header posting?  It must explain what the
patch series does at a high level, how it is doing it, and why it is
doing it that way.

Thank you.

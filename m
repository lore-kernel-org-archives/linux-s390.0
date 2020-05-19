Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTuf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 May 2020 15:50:35 -0400
Date: Tue, 19 May 2020 12:50:34 -0700 (PDT)
Message-Id: <20200519.125034.1856641699531010946.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/5] net/iucv: updates 2020-05-19
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200519191012.65438-1-jwi@linux.ibm.com>
References: <20200519191012.65438-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com, kgraul@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Tue, 19 May 2020 21:10:07 +0200

> please apply the following patch series for iucv to netdev's net-next
> tree.
> 
> s390 dropped its support for power management, this removes the relevant
> iucv code. Also, some easy cleanups I found mouldering in an old branch.

Series applied, thank you.

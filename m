Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgICXwr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Sep 2020 19:52:47 -0400
Date: Thu, 03 Sep 2020 16:52:46 -0700 (PDT)
Message-Id: <20200903.165246.626786206174168805.davem@davemloft.net>
Subject: Re: [PATCH net 0/4] net/smc: fixes 2020-09-03
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200903195318.39288-1-kgraul@linux.ibm.com>
References: <20200903195318.39288-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Thu,  3 Sep 2020 21:53:14 +0200

> Please apply the following patch series for smc to netdev's net tree.
> 
> Patch 1 fixes the toleration of older SMC implementations. Patch 2
> takes care of a problem that happens when SMCR is used after SMCD
> initialization failed. Patch 3 fixes a problem with freed send buffers,
> and patch 4 corrects refcounting when SMC terminates due to device
> removal.

Series applied, thank you.

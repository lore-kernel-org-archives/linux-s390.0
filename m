Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgGSWal (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 19 Jul 2020 18:30:41 -0400
Date: Sun, 19 Jul 2020 15:30:38 -0700 (PDT)
Message-Id: <20200719.153038.2294671622833273160.davem@davemloft.net>
Subject: Re: [PATCH net v2 00/10] net/smc: fixes 2020-07-16
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200718130618.16724-1-kgraul@linux.ibm.com>
References: <20200718130618.16724-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Sat, 18 Jul 2020 15:06:08 +0200

> Please apply the following patch series for smc to netdev's net tree.
> 
> The patches address problems caused by late or unexpected link layer
> control packets, dma sync calls for unmapped memory, freed buffers
> that are not removed from the buffer list and a possible null pointer
> access that results in a crash.
> 
> v1->v2: in patch 4, improve patch description and correct the comment
>         for the new mutex

Series applied, thanks.

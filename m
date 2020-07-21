Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgGUAwk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Jul 2020 20:52:40 -0400
Date: Mon, 20 Jul 2020 17:52:39 -0700 (PDT)
Message-Id: <20200720.175239.84496358252925760.davem@davemloft.net>
Subject: Re: [PATCH net 0/2] net/smc: fixes 2020-07-20
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200720142429.17916-1-kgraul@linux.ibm.com>
References: <20200720142429.17916-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Mon, 20 Jul 2020 16:24:27 +0200

> Please apply the following patch series for smc to netdev's net tree.
> 
> Patch 1 fixes a problem with a buffer that is not put back when the
> connection was killed in the meantime.
> Patch 2 fixes a wrong behaviour when the maximum dmb buffer count
> exceeded.

Series applied, thank you.

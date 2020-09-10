Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgIJWYr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Sep 2020 18:24:47 -0400
Date: Thu, 10 Sep 2020 15:24:44 -0700 (PDT)
Message-Id: <20200910.152444.1800275701910693047.davem@davemloft.net>
Subject: Re: [PATCH net-next 00/10] net/smc: updates 2020-09-10
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200910164829.65426-1-kgraul@linux.ibm.com>
References: <20200910164829.65426-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Thu, 10 Sep 2020 18:48:19 +0200

> Please apply the following patch series for smc to netdev's net-next tree.
> 
> This patch series is a mix of various improvements and cleanups.
> The patches 1 and 10 improve the handling of large parallel workloads.
> Patch 8 corrects a kernel config default for config CCWGROUP on s390.
> Patch 9 allows userspace tools to retrieve socket information for more
> sockets.

Series applied, thank you.

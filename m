Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:40764 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfKOUaP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Nov 2019 15:30:15 -0500
Date: Fri, 15 Nov 2019 12:30:14 -0800 (PST)
Message-Id: <20191115.123014.497961657029798608.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/8] net/smc: improve termination handling
 (part 3)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191114120247.68889-1-kgraul@linux.ibm.com>
References: <20191114120247.68889-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Thu, 14 Nov 2019 13:02:39 +0100

> Part 3 of the SMC termination patches improves the link group
> termination processing and introduces the ability to immediately
> terminate a link group.

Series applied, thanks.

I wonder if you need an explicit ATOMIC_INIT() for that new atomic_t you
add to the data structures?

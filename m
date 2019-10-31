Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:59912 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfJaTdb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 31 Oct 2019 15:33:31 -0400
Date: Thu, 31 Oct 2019 12:33:30 -0700 (PDT)
Message-Id: <20191031.123330.290389323537118897.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/8] s390/qeth: updates 2019-10-31
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191031124221.34028-1-jwi@linux.ibm.com>
References: <20191031124221.34028-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Thu, 31 Oct 2019 13:42:13 +0100

> please apply the following series of spooky qeth updates for net-next.

I hear that if you hack on S390, every day is like Halloween.

> The first two patches add support for an enhanced TX doorbell, which
> enables us to do more xmit_more-based bulking.
> Note that this requires one patch for the s390/qdio base layer, which
> has been graciously acked by Heiko to go through your tree.
> 
> The remaining patches are just the usual minor cleanups/improvements.

Series applied to net-next, thank you.

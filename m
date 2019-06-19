Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:39724 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfFSU1z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 19 Jun 2019 16:27:55 -0400
Date: Wed, 19 Jun 2019 16:27:49 -0400 (EDT)
Message-Id: <20190619.162749.1687527787908840319.davem@davemloft.net>
Subject: Re: [PATCH net 0/3] net/af_iucv: fixes 2019-06-18
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190618184301.96472-1-jwi@linux.ibm.com>
References: <20190618184301.96472-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Tue, 18 Jun 2019 20:42:58 +0200

> I spent a few cycles on transmit problems for af_iucv over regular
> netdevices - please apply the following fixes to -net.
> 
> The first patch allows for skb allocations outside of GFP_DMA, while the
> second patch respects that drivers might use skb_cow_head() and/or want
> additional dev->needed_headroom.
> Patch 3 is for a separate issue, where we didn't setup some of the
> netdevice-specific infrastructure when running as a z/VM guest.

Series applied.

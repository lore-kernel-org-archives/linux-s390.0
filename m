Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:44578 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLZXYQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 26 Dec 2019 18:24:16 -0500
Date: Thu, 26 Dec 2019 15:24:14 -0800 (PST)
Message-Id: <20191226.152414.315032656379968442.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/3] s390/qeth: updates 2019-12-23
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191223142227.19500-1-jwi@linux.ibm.com>
References: <20191223142227.19500-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Mon, 23 Dec 2019 15:22:24 +0100

> please apply the following patch series for qeth to your net-next tree.
> 
> This reworks the RX code to use napi_gro_frags() when building non-linear
> skbs, along with some consolidation and cleanups.

Series applied to net-next.

> Happy holidays - and many thanks for all the effort & support over the past
> year, to both Jakub and you. It's much appreciated.

No problem :)

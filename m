Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:47102 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLEUZX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Dec 2019 15:25:23 -0500
Date: Thu, 05 Dec 2019 12:25:22 -0800 (PST)
Message-Id: <20191205.122522.618665603577837878.davem@davemloft.net>
Subject: Re: [PATCH net 0/3] s390/qeth: fixes 2019-12-05
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191205133304.58895-1-jwi@linux.ibm.com>
References: <20191205133304.58895-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Thu,  5 Dec 2019 14:33:01 +0100

> please apply the following fixes to your net tree.
> 
> The first two patches target the RX data path, the third fixes a memory
> leak when shutting down a qeth device.

Series applied, thanks Julian.

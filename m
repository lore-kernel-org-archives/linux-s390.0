Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:56946 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLUFby (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 21 Dec 2019 00:31:54 -0500
Date: Fri, 20 Dec 2019 21:31:53 -0800 (PST)
Message-Id: <20191220.213153.1257291319387433154.davem@davemloft.net>
Subject: Re: [PATCH net] net/smc: unregister ib devices in reboot_event
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191219115113.49414-1-kgraul@linux.ibm.com>
References: <20191219115113.49414-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Thu, 19 Dec 2019 12:51:13 +0100

> In the reboot_event handler, unregister the ib devices and enable
> the IB layer to release the devices before the reboot.
> 
> Fixes: a33a803cfe64 ("net/smc: guarantee removal of link groups in reboot")
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
> Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>

Applied.

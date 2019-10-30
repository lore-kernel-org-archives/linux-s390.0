Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:34040 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfJ3BLf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Oct 2019 21:11:35 -0400
Date: Tue, 29 Oct 2019 18:11:34 -0700 (PDT)
Message-Id: <20191029.181134.1661591070658151478.davem@davemloft.net>
Subject: Re: [PATCH net-next 1/1] net/smc: remove unneeded include for smc.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191029114346.73418-1-ubraun@linux.ibm.com>
References: <20191029114346.73418-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, jakub.kicinski@netronome.com

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Tue, 29 Oct 2019 12:43:46 +0100

> The only smc-related reference in net/sock.h is struct smc_hashinfo.
> But just its address is refered to. Thus there is no need for the
> include of net/smc.h. Remove it.
> 
> Suggested-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Reviewed by: Karsten Graul <kgraul@linux.ibm.com>
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>

Applied, thanks.

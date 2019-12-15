Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37098 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfLOTIg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 15 Dec 2019 14:08:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so2390631pga.4
        for <linux-s390@vger.kernel.org>; Sun, 15 Dec 2019 11:08:36 -0800 (PST)
Date: Sun, 15 Dec 2019 11:08:33 -0800
From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH net-next] net/smc: shorten lgr_cnt initialization
Message-ID: <20191215110833.1746428a@cakuba.netronome.com>
In-Reply-To: <20191212213541.10485-1-kgraul@linux.ibm.com>
References: <20191212213541.10485-1-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

On Thu, 12 Dec 2019 22:35:41 +0100, Karsten Graul wrote:
> From: Ursula Braun <ubraun@linux.ibm.com>
> 
> Save a line of code by making use of ATOMIC_INIT() for lgr_cnt.
> 
> Suggested-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Applied, thank you!

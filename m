Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:56460 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0RDC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 Jun 2019 13:03:02 -0400
Date: Thu, 27 Jun 2019 10:03:01 -0700 (PDT)
Message-Id: <20190627.100301.1135989168205665397.davem@davemloft.net>
Subject: Re: [PATCH] net/smc: common release code for non-accepted sockets
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190627130452.15408-1-kgraul@linux.ibm.com>
References: <20190627130452.15408-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Thu, 27 Jun 2019 15:04:52 +0200

> From: Ursula Braun <ubraun@linux.ibm.com>
> 
> There are common steps when releasing an accepted or unaccepted socket.
> Move this code into a common routine.
> 
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Applied.

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD3Tro (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 15:47:44 -0400
Date: Thu, 30 Apr 2020 12:47:41 -0700 (PDT)
Message-Id: <20200430.124741.540598145038382743.davem@davemloft.net>
Subject: Re: [PATCH net-next 00/14] net/smc: add event-based framework for
 LLC msgs
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200430135551.26267-1-kgraul@linux.ibm.com>
References: <20200430135551.26267-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Thu, 30 Apr 2020 15:55:37 +0200

> These patches are the next step towards SMC-R link failover support. They add
> a new framework to handle Link Layer Control (LLC) messages and adapt the
> existing code to use the new framework.

Series applied to net-next, thanks.

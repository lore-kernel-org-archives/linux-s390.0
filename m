Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730695AbgG0RaS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 27 Jul 2020 13:30:18 -0400
Date: Mon, 27 Jul 2020 10:30:16 -0700 (PDT)
Message-Id: <20200727.103016.906657345775183235.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/2] net/smc: show unique rsn code for
 exceeded max dmb count
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200726183428.3284-1-kgraul@linux.ibm.com>
References: <20200726183428.3284-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Sun, 26 Jul 2020 20:34:26 +0200

> Resolve some confusion at the user side when the reason code shows
> out-of-memory but actually there is enough memory left.

Series applied, thank you.

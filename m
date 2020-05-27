Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbgE0DT1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 23:19:27 -0400
Date: Tue, 26 May 2020 20:19:25 -0700 (PDT)
Message-Id: <20200526.201925.2160949442758094082.davem@davemloft.net>
Subject: Re: [PATCH] net/smc: mark smc_pnet_policy as const
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200525153158.247394-1-dvyukov@google.com>
References: <20200525153158.247394-1-dvyukov@google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: dvyukov@google.com
Cc: ubraun@linux.ibm.com, kgraul@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 25 May 2020 17:31:58 +0200

> Netlink policies are generally declared as const.
> This is safer and prevents potential bugs.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>

Applied to net-next, thanks.

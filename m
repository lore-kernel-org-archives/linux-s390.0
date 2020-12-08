Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgLHX6M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Dec 2020 18:58:12 -0500
Date: Tue, 08 Dec 2020 15:57:31 -0800 (PST)
Message-Id: <20201208.155731.1558729549312660543.davem@davemloft.net>
Subject: Re: [PATCH net-next] net/af_iucv: use DECLARE_SOCKADDR to cast
 from sockaddr
From: David Miller <davem@davemloft.net>
In-Reply-To: <20201207125307.68725-1-jwi@linux.ibm.com>
References: <20201207125307.68725-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, kgraul@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Mon,  7 Dec 2020 13:53:07 +0100

> This gets us compile-time size checking.
> 
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>

Applied, thanks.

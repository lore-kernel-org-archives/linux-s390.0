Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWTIN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Sep 2020 15:08:13 -0400
Date: Wed, 23 Sep 2020 12:08:12 -0700 (PDT)
Message-Id: <20200923.120812.1709996847344700602.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/9] s390/qeth: updates 2020-09-23
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200923083700.44624-1-jwi@linux.ibm.com>
References: <20200923083700.44624-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, ubraun@linux.ibm.com, kgraul@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Wed, 23 Sep 2020 10:36:51 +0200

> please apply the following patch series for qeth to netdev's net-next tree.
> 
> This brings all sorts of cleanups. Highlights are more code sharing in
> the init/teardown paths, and more fine-grained rollback on errors during
> initialization (instead of a full-blown teardown).

Series applied, thank you.

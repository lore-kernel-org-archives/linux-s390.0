Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgFSD2B (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 18 Jun 2020 23:28:01 -0400
Date: Thu, 18 Jun 2020 20:27:59 -0700 (PDT)
Message-Id: <20200618.202759.2208335891359562794.davem@davemloft.net>
Subject: Re: [PATCH net 0/2] s390/qeth: fixes 2020-06-17
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200617145453.61382-1-jwi@linux.ibm.com>
References: <20200617145453.61382-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com, kgraul@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Wed, 17 Jun 2020 16:54:51 +0200

> please apply the following patch series for qeth to netdev's net tree.
> 
> The first patch fixes a regression in the error handling for a specific
> cmd type. I have some follow-ups queued up for net-next to clean this
> up properly...
> 
> The second patch fine-tunes the HW offload restrictions that went in
> with this merge window. In some setups we don't need to apply them.

Series applied, thanks.

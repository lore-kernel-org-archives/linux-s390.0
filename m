Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTtC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 May 2020 15:49:02 -0400
Date: Tue, 19 May 2020 12:49:00 -0700 (PDT)
Message-Id: <20200519.124900.1271332249104138126.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/2] s390/net: updates 2020-05-19
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200519190904.64217-1-jwi@linux.ibm.com>
References: <20200519190904.64217-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com, kgraul@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Tue, 19 May 2020 21:09:02 +0200

> please apply the following patch series to netdev's net-next tree.
> 
> s390 dropped its support for power management, this removes the relevant
> code from the s390 network drivers.

Series applied.

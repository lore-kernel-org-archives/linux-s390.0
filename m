Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAXVA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 May 2020 19:21:00 -0400
Date: Fri, 01 May 2020 16:20:58 -0700 (PDT)
Message-Id: <20200501.162058.1644504393259832631.davem@davemloft.net>
Subject: Re: [PATCH net-next 00/13] net/smc: extent buffer mapping and port
 handling
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200501104813.76601-1-kgraul@linux.ibm.com>
References: <20200501104813.76601-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Fri,  1 May 2020 12:48:00 +0200

> Add functionality to map/unmap and register/unregister memory buffers for
> specific SMC-R links and for the whole link group. Prepare LLC layer messages
> for the support of multiple links and extent the processing of adapter events.
> And add further small preparations needed for the SMC-R failover support.

Series applied, thanks.

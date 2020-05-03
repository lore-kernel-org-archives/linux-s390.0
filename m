Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725844AbgECXIq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 May 2020 19:08:46 -0400
Date: Sun, 03 May 2020 16:08:44 -0700 (PDT)
Message-Id: <20200503.160844.1392977826698935408.davem@davemloft.net>
Subject: Re: [PATCH net-next v2 00/11] net/smc: add and delete link
 processing
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200503123850.57261-1-kgraul@linux.ibm.com>
References: <20200503123850.57261-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Sun,  3 May 2020 14:38:39 +0200

> These patches add the 'add link' and 'delete link' processing as 
> SMC server and client. This processing allows to establish and
> remove links of a link group dynamically.
> 
> v2: Fix mess up with unused static functions. Merge patch 8 into patch 4.
>     Postpone patch 13 to next series.

Series applied, thanks.

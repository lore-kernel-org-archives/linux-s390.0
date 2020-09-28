Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgI1Xim (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Sep 2020 19:38:42 -0400
Date: Mon, 28 Sep 2020 15:19:32 -0700 (PDT)
Message-Id: <20200928.151932.1462655542943966425.davem@davemloft.net>
Subject: Re: [PATCH net-next 00/14] net/smc: introduce SMC-Dv2 support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200926104432.74293-1-kgraul@linux.ibm.com>
References: <20200926104432.74293-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Sat, 26 Sep 2020 12:44:18 +0200

> Please apply the following patch series for smc to netdev's net-next tree.
> 
> SMC-Dv2 support (see https://www.ibm.com/support/pages/node/6326337)
> provides multi-subnet support for SMC-D, eliminating the current
> same-subnet restriction. The new version detects if any of the virtual
> ISM devices are on the same system and can therefore be used for an
> SMC-Dv2 connection. Furthermore, SMC-Dv2 eliminates the need for
> PNET IDs on s390.

Series applied, thanks.

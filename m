Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgGHTff (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jul 2020 15:35:35 -0400
Date: Wed, 08 Jul 2020 12:35:33 -0700 (PDT)
Message-Id: <20200708.123533.193185690205076854.davem@davemloft.net>
Subject: Re: [PATCH net 0/5] net/smc: fixes 2020-07-08
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200708150515.44938-1-kgraul@linux.ibm.com>
References: <20200708150515.44938-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Wed,  8 Jul 2020 17:05:10 +0200

> Please apply the following patch series for smc to netdev's net tree.
> 
> The patches fix problems found during more testing of SMC
> functionality, resulting in hang conditions and unneeded link
> deactivations. The clc module was hardened to be prepared for
> possible future SMCD versions.

Series applied, thank you.

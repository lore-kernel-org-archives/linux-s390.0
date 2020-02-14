Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:53270 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbgBNPOB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Feb 2020 10:14:01 -0500
Date: Fri, 14 Feb 2020 07:14:00 -0800 (PST)
Message-Id: <20200214.071400.1992303683626175409.davem@davemloft.net>
Subject: Re: [PATCH net 0/2] net/smc: fixes for -net
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200214075900.31624-1-kgraul@linux.ibm.com>
References: <20200214075900.31624-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Fri, 14 Feb 2020 08:58:58 +0100

> Fix a syzbot finding and a problem with the CLC handshake content.

Series applied, thank you.

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:39732 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfJZCS6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Oct 2019 22:18:58 -0400
Date: Fri, 25 Oct 2019 19:18:55 -0700 (PDT)
Message-Id: <20191025.191855.2235401668260921153.davem@davemloft.net>
Subject: Re: [PATCH net 0/2] net/smc: fixes for -net
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191023134406.66319-1-kgraul@linux.ibm.com>
References: <20191023134406.66319-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Wed, 23 Oct 2019 15:44:04 +0200

> Fixes for the net tree, covering a memleak when closing
> SMC fallback sockets and fix SMC-R connection establishment
> when vlan-ids are used.

Series applied, thanks.

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:53344 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfKPU1E (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 16 Nov 2019 15:27:04 -0500
Date: Sat, 16 Nov 2019 12:27:03 -0800 (PST)
Message-Id: <20191116.122703.1149059023974816708.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/4] last part of termination improvements
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191116164732.47059-1-kgraul@linux.ibm.com>
References: <20191116164732.47059-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Sat, 16 Nov 2019 17:47:28 +0100

> Patches 1 and 2 finish the set of termination patches, introducing 
> a reboot handler that terminates all link groups. Patch 3 adds an 
> rcu_barrier before the module is unloaded, and patch 4 is cleanup.

Series applied, thanks.

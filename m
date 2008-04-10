From: David Miller <davem@davemloft.net>
Subject: Re: [patch 3/3] iucv: Delay bus registration until core is ready.
Date: Thu, 10 Apr 2008 02:12:54 -0700 (PDT)
Message-ID: <20080410.021254.46545431.davem@davemloft.net>
References: <20080401134521.169525000@linux.vnet.ibm.com>
	<20080401135709.863647000@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20080401135709.863647000@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: braunu@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, cornelia.huck@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>
Date: Tue, 01 Apr 2008 15:45:24 +0200

> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> If we register the iucv bus after the infrastructure is ready,
> userspace can start relying on it when it receives the uevent
> for the bus.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Ursula Braun <braunu@de.ibm.com>

Also applied, thanks.

From: David Miller <davem@davemloft.net>
Subject: Re: [patch 2/3] iucv: get rid of in_atomic() use.
Date: Thu, 10 Apr 2008 02:12:11 -0700 (PDT)
Message-ID: <20080410.021211.08640419.davem@davemloft.net>
References: <20080401134521.169525000@linux.vnet.ibm.com>
	<20080401135709.170734000@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20080401135709.170734000@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: braunu@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>
Date: Tue, 01 Apr 2008 15:45:23 +0200

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> This BUG_ON is not needed, since all (debug) checks are also done
> in smp_call_function() which gets called by this function.
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Ursula Braun <braunu@de.ibm.com>

Applied.

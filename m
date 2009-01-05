From: David Miller <davem@davemloft.net>
Subject: Re: [patch 6/6] qeth: get rid of extra argument after printk to
 dev_* conversion
Date: Sun, 04 Jan 2009 17:37:17 -0800 (PST)
Message-ID: <20090104.173717.124451945.davem@davemloft.net>
References: <20090102150139.830998000@de.ibm.com>
	<20090102150256.663537000@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20090102150256.663537000@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: frank.blaschka@de.ibm.com
Date: Fri, 02 Jan 2009 16:01:45 +0100

> drivers/s390/net/qeth_l3_main.c: In function 'qeth_l3_setadapter_parms':
> drivers/s390/net/qeth_l3_main.c:1049: warning: too many arguments for format
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>

Also applied, thanks.

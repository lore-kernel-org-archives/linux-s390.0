From: David Miller <davem@davemloft.net>
Subject: Re: [patch 4/5] [PATCH] qeth: rework TSO functions
Date: Mon, 16 Nov 2009 02:36:07 -0800 (PST)
Message-ID: <20091116.023607.264393400.davem@davemloft.net>
References: <20091112101301.126320000@de.ibm.com>
	<20091113.203621.39740182.davem@davemloft.net>
	<4B00F81D.8090106@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <4B00F81D.8090106@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: blaschka@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Date: Mon, 16 Nov 2009 07:58:37 +0100

> I did not add any new sysfs knobs for TSO. The old one was just moved
> from the core part of the driver to the L3 discipline. I know ethtool
> is the way to configure TSO and I would be happy to drop sysfs off, but
> we have to keep this legacy interface because of our customers and
> distributors. If you say there is no way to keep it let me know and I
> will rework the patch.

Ok, if it's always been there :-/  It never should have been added
in the first place.

I'll add these patches to net-next-2.6, thanks.

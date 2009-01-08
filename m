From: David Miller <davem@davemloft.net>
Subject: Re: [patch 2/2] qeth: convert to net_device_ops
Date: Thu, 08 Jan 2009 10:50:59 -0800 (PST)
Message-ID: <20090108.105059.214628615.davem@davemloft.net>
References: <20090107121550.878339000@de.ibm.com>
	<20090107121700.139748000@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20090107121700.139748000@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: frank.blaschka@de.ibm.com
Date: Wed, 07 Jan 2009 13:15:52 +0100

> qeth_l2, qeth_l3 convert to net_device_ops.
> qeth_l3 remove vlan neigh_setup hack since it does not work any longer
> with the new net_device_ops.
> 
> Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>

Also applied, thanks.

From: David Miller <davem@davemloft.net>
Subject: Re: [patch 0/5] s390: network patches for net-next
Date: Mon, 24 Sep 2012 15:47:11 -0400 (EDT)
Message-ID: <20120924.154711.513889883892939731.davem@davemloft.net>
References: <20120924142422.001953152@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20120924142422.001953152@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: frank.blaschka@de.ibm.com
Date: Mon, 24 Sep 2012 16:24:22 +0200

> here are some s390 related patches for net-next
> 
> shortlog:
> 
> Sebastian Ott(2)
> qeth: cleanup channel path descriptor function
> lcs: ensure proper ccw setup
> 
> Wei Yongjun(1)
> qeth: fix possible memory leak in qeth_l3_add_[vipa|rxip]()
> 
> Peter Senna(2)
> drivers/s390/net: removes unnecessary semicolon
> ctcm: fix error return code

All applied, thanks!

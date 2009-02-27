From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] iucv: remove some pointless conditionals before
 kfree_skb()
Date: Thu, 26 Feb 2009 23:09:51 -0800 (PST)
Message-ID: <20090226.230951.232142354.davem@davemloft.net>
References: <49A5203F.5060009@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <49A5203F.5060009@cn.fujitsu.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: yjwei@cn.fujitsu.com
Cc: ursula.braun@de.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Wei Yongjun <yjwei@cn.fujitsu.com>
Date: Wed, 25 Feb 2009 18:41:03 +0800

> Remove some pointless conditionals before kfree_skb().
> 
> Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>

Applied.

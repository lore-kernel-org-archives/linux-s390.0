From: David Miller <davem@davemloft.net>
Subject: Re: [patch 1/1] [PATCH] qeth: tagging with VLAN-ID 0
Date: Sun, 03 Oct 2010 22:08:29 -0700 (PDT)
Message-ID: <20101003.220829.28819804.davem@davemloft.net>
References: <20101001125112.459999476@de.ibm.com>
	<20101001125142.037089467@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20101001125142.037089467@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: frank.blaschka@de.ibm.com
Date: Fri, 01 Oct 2010 14:51:13 +0200

> From: Ursula Braun <ursula.braun@de.ibm.com>
> 
> This patch adapts qeth to handle tagged frames with VLAN-ID 0 and
> with or without priority information in the tag. It enables qeth to
> receive priority-tagged frames on a base interface, for example from
> z/OS, without configuring an additional VLAN interface.
> 
> Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
> Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>

I'll apply this, thanks.

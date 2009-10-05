From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/4] qeth: Convert ethtool get_stats_count() ops to
 get_sset_count()
Date: Mon, 05 Oct 2009 00:13:23 -0700 (PDT)
Message-ID: <20091005.001323.102260628.davem@davemloft.net>
References: <1254432272.2735.20.camel@achroite>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1254432272.2735.20.camel@achroite>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: bhutchings@solarflare.com
Cc: ursula.braun@de.ibm.com, frank.blaschka@de.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ben Hutchings <bhutchings@solarflare.com>
Date: Thu, 01 Oct 2009 22:24:32 +0100

> This string query operation was supposed to be replaced by the
> generic get_sset_count() starting in 2007.  Convert qeth's
> implementation.
> 
> Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>

Applied to net-next-2.6

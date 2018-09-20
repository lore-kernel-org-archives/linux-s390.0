From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] smc: generic netlink family should be __ro_after_init
Date: Thu, 20 Sep 2018 07:50:16 -0700 (PDT)
Message-ID: <20180920.075016.2069698292089129165.davem@davemloft.net>
References: <20180920072730.17584-1-johannes@sipsolutions.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180920072730.17584-1-johannes@sipsolutions.net>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: johannes@sipsolutions.net
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, ubraun@linux.ibm.com, johannes.berg@intel.com
List-ID: <linux-s390.vger.kernel.org>

From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 20 Sep 2018 09:27:30 +0200

> From: Johannes Berg <johannes.berg@intel.com>
> 
> The generic netlink family is only initialized during module init,
> so it should be __ro_after_init like all other generic netlink
> families.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Looks good, applied.

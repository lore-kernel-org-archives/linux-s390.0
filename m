Return-Path: <netdev-owner@vger.kernel.org>
Date: Wed, 28 Feb 2018 11:17:40 -0500 (EST)
Message-Id: <20180228.111740.1893624730140590032.davem@davemloft.net>
Subject: Re: [PATCH net 0/6] s390/qeth: fixes 2018-02-27 
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180227175817.84727-1-jwi@linux.vnet.ibm.com>
References: <20180227175817.84727-1-jwi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 18:58:11 +0100

> please apply some more qeth patches for -net and stable.
> 
> One patch fixes a performance bug in the TSO path. Then there's several
> more fixes for IP management on L3 devices - including a revert, so that
> the subsequent fix cleanly applies to earlier kernels.
> The final patch takes care of a race in the control IO code that causes
> qeth to miss the cmd response, and subsequently trigger device recovery.

Series applied and queued up for -stable, thanks Julian.

From: David Miller <davem@davemloft.net>
Subject: Re: [RFC] qeth: exploit gro for layer 3 driver
Date: Thu, 21 Jan 2010 05:11:33 -0800 (PST)
Message-ID: <20100121.051133.102632014.davem@davemloft.net>
References: <20100121123722.GA13815@tuxmaker.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20100121123722.GA13815@tuxmaker.boeblingen.de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Blaschka <frank.blaschka@de.ibm.com>
Date: Thu, 21 Jan 2010 13:37:22 +0100

> Since the qeth driver can not use NAPI I would like to hear
> your opinion about following approach to exploit GRO.

Can you remind us why it can't use NAPI?

I personally find it hard to believe... :-)

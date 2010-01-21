From: David Miller <davem@davemloft.net>
Subject: Re: [RFC] qeth: exploit gro for layer 3 driver
Date: Thu, 21 Jan 2010 06:03:54 -0800 (PST)
Message-ID: <20100121.060354.119388130.davem@davemloft.net>
References: <20100121123722.GA13815@tuxmaker.boeblingen.de.ibm.com>
	<20100121.051133.102632014.davem@davemloft.net>
	<20100121134845.GA28645@tuxmaker.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20100121134845.GA28645@tuxmaker.boeblingen.de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Blaschka <frank.blaschka@de.ibm.com>
Date: Thu, 21 Jan 2010 14:48:45 +0100

> So the qeth driver can not disable qdio IRQs (I guess this is a
> major reason why not using NAPI) and poll the data.

Just because you cannot stop the events from coming in
doesn't mean you can't just queue them up in software
or similar.

The important bits you get are:

1) RX ring depletion and packet processing all from software
   interrupt context

2) transparent GRO support, without the generic code having
   to disclose most of the GRO internals to drivers

I think it can be done.

I have a similar issue as your's with the Sun virtualized network
driver (I can't really stop the hypervisor events from pouring in) on
sparc64 and I plan to add NAPI support to it.

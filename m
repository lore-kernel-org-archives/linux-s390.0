From: David Miller <davem@davemloft.net>
Subject: Re: [patch 0/5] s390: qeth/ctcm patches for 2.6.31
Date: Wed, 20 May 2009 17:37:16 -0700 (PDT)
Message-ID: <20090520.173716.130039305.davem@davemloft.net>
References: <20090520073836.897878000@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20090520073836.897878000@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: frank.blaschka@de.ibm.com
Date: Wed, 20 May 2009 09:38:36 +0200

> shortlog:
> Klaus-Dieter Wacker (1)
> qeth: Clear SBALF15 in any case for output buffers.
> 
> Ursula Braun (4)
> qeth: avoid crash after detach of replugged device
> ctcm: avoid crash in ctcm_remove_device
> qeth: support z/VM VSWITCH Port Isolation
> qeth: omit upstream checksumming for HiperSockets

Applied into net-next-2.6, thanks!

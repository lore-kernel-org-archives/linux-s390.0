Return-Path: <linux-kernel-owner+w=401wt.eu-S1753313AbYGZJYg@vger.kernel.org>
Date: Sat, 26 Jul 2008 02:24:27 -0700 (PDT)
Message-Id: <20080726.022427.100320136.davem@davemloft.net>
Subject: Re: [BUG] qeth doesn't work anymore because of netdev_priv changes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080725015755.GA5179@osiris.boeblingen.de.ibm.com>
References: <20080724184624.GB8969@osiris.boeblingen.de.ibm.com>
	<20080724.135602.196740386.davem@davemloft.net>
	<20080725015755.GA5179@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: heiko.carstens@de.ibm.com
Cc: frank.blaschka@de.ibm.com, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, braunu@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 25 Jul 2008 03:57:55 +0200

> qeth: use dev->ml_priv instead of dev->priv
> 
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> This makes qeth working again after git commit
> e3c50d5d25ac09efd9acbe2b2a3e365466de84ed
> "netdev: netdev_priv() can now be sane again.".
> 
> Cc: Ursula Braun <braunu@de.ibm.com>
> Cc: Frank Blaschka <frank.blaschka@de.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Patch applied, thanks a lot Heiko.

Return-Path: <linux-kernel-owner+w=401wt.eu-S1754172AbYGXU4R@vger.kernel.org>
Date: Thu, 24 Jul 2008 13:56:02 -0700 (PDT)
Message-Id: <20080724.135602.196740386.davem@davemloft.net>
Subject: Re: [BUG] qeth doesn't work anymore because of netdev_priv changes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080724184624.GB8969@osiris.boeblingen.de.ibm.com>
References: <20080724184624.GB8969@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: heiko.carstens@de.ibm.com
Cc: frank.blaschka@de.ibm.com, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 24 Jul 2008 20:46:24 +0200

> git commit e3c50d5d25ac09efd9acbe2b2a3e365466de84ed
> "netdev: netdev_priv() can now be sane again." breaks qeth on s390
> (no more networking possible). Reverting the patch fixes it.
> I haven't looked into this any further.

You guys have to stop overriding netdev->priv if that's what
you're doing.

If you need a mid-layer private pointer, use netdev->ml_priv
as it's created exactly for that purpose.

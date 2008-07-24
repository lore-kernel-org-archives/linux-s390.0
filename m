Return-Path: <linux-kernel-owner+w=401wt.eu-S1753389AbYGXSqi@vger.kernel.org>
Date: Thu, 24 Jul 2008 20:46:24 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [BUG] qeth doesn't work anymore because of netdev_priv changes
Message-ID: <20080724184624.GB8969@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: Frank Blaschka <frank.blaschka@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi David,

git commit e3c50d5d25ac09efd9acbe2b2a3e365466de84ed
"netdev: netdev_priv() can now be sane again." breaks qeth on s390
(no more networking possible). Reverting the patch fixes it.
I haven't looked into this any further.

Thanks,
Heiko

Return-Path: <linux-kernel-owner+w=401wt.eu-S1161461AbXDWLt0@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/8] Kconfig: silicon backplane dependency.
Date: Mon, 23 Apr 2007 13:48:05 +0200
References: <20070420113505.GH3738@skybase> <200704231322.36970.arnd@arndb.de> <1177327676.5984.12.camel@localhost>
In-Reply-To: <1177327676.5984.12.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704231348.06148.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: Michael Buesch <mb@bu3sch.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, linville@tuxdriver.com
List-ID: <linux-s390.vger.kernel.org>

On Monday 23 April 2007, Martin Schwidefsky wrote:
> 
> > Isn't B44 already behind a WIRELESS or IEEE80211 or similar option that
> > can't be selected on s390?
> 
> No, the option can be found in drivers/net/Kconfig under menu "Ethernet
> (10 or 100Mbit)".

Ah, I was confusing it with b43.

Depends on HAS_IOMEM sounds good then. I'd prefer to make it
'depends on SSB' instead of 'select SSB', but I don't want to get into
that argument ;-)

	Arnd <><

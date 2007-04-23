Return-Path: <linux-kernel-owner+w=401wt.eu-S1752228AbXDWOi4@vger.kernel.org>
From: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 7/8] Kconfig: silicon backplane dependency.
Date: Mon, 23 Apr 2007 16:37:48 +0200
References: <20070420113505.GH3738@skybase> <1177327676.5984.12.camel@localhost> <200704231348.06148.arnd@arndb.de>
In-Reply-To: <200704231348.06148.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704231637.48500.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, linville@tuxdriver.com
List-ID: <linux-s390.vger.kernel.org>

On Monday 23 April 2007 13:48, Arnd Bergmann wrote:
> On Monday 23 April 2007, Martin Schwidefsky wrote:
> > 
> > > Isn't B44 already behind a WIRELESS or IEEE80211 or similar option that
> > > can't be selected on s390?
> > 
> > No, the option can be found in drivers/net/Kconfig under menu "Ethernet
> > (10 or 100Mbit)".
> 
> Ah, I was confusing it with b43.
> 
> Depends on HAS_IOMEM sounds good then. I'd prefer to make it
> 'depends on SSB' instead of 'select SSB', but I don't want to get into
> that argument ;-)

No, don't.
Add depends on to SSB and B44.

-- 
Greetings Michael.

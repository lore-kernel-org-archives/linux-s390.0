Return-Path: <linux-kernel-owner+w=401wt.eu-S1161434AbXDWLXZ@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/8] Kconfig: silicon backplane dependency.
Date: Mon, 23 Apr 2007 13:22:36 +0200
References: <20070420113505.GH3738@skybase> <200704221146.11439.mb@bu3sch.de> <1177327011.5984.10.camel@localhost>
In-Reply-To: <1177327011.5984.10.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704231322.36970.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: Michael Buesch <mb@bu3sch.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, linville@tuxdriver.com
List-ID: <linux-s390.vger.kernel.org>

On Monday 23 April 2007, Martin Schwidefsky wrote:
> The current Kconfig code does not check all select statements if they
> can be enabled before allowing the config option that does the select.
> So the rule for using select statements is that the depends line of the
> config option that selects another config option needs to be at least as
> restrictive as the depends line of the selected option. Hence I'll add
> the HAS_IOMEM depends to B44 as well. Okay ?

Isn't B44 already behind a WIRELESS or IEEE80211 or similar option that
can't be selected on s390?

	Arnd <><

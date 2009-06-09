Return-Path: <linux-kernel-owner+w=401wt.eu-S1759539AbZFIT62@vger.kernel.org>
Date: Tue, 9 Jun 2009 21:58:13 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] pm: Move nvs routines into a seperate file.
Message-ID: <20090609195813.GA1388@ucw.cz>
References: <20090604161847.513682672@de.ibm.com> <20090608063501.GC1444@ucw.cz> <20090608173611.16238cf9@gondolin> <200906082048.28779.rjw@sisk.pl> <20090609104003.50830165@gondolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090609104003.50830165@gondolin>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue 2009-06-09 10:40:03, Cornelia Huck wrote:
> The *_nvs_* routines in swsusp.c make use of the io*map()
> functions, which are only provided for HAS_IOMEM, thus
> breaking compilation if HAS_IOMEM is not set. Fix this
> by moving the *_nvs_* routines into hibernation_nvs.c, which
> is only compiled if HAS_IOMEM is set.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -0,0 +1,135 @@
> +/*
> + * linux/kernel/power/hibernation_nvs.c
> + *
> + * Copyright (C) 2008,2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
> + *
> + * Routines for NVS memory handling
> + */

Specifying  GPLv2 here would be nice. If it contains copyright, it
should contain license, too.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

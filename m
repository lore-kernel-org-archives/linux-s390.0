Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 1/1] [PATCH] include storage keys in hibernation image.
Date: Wed, 17 Aug 2011 11:15:21 +0200
References: <20110816141441.898339466@de.ibm.com> <201108161956.47434.rjw@sisk.pl> <20110817094347.3c106bd9@mschwide>
In-Reply-To: <20110817094347.3c106bd9@mschwide>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201108171115.21607.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Jiri Slaby <jslaby@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Wednesday, August 17, 2011, Martin Schwidefsky wrote:
> On Tue, 16 Aug 2011 19:56:47 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Tuesday, August 16, 2011, Martin Schwidefsky wrote:
> > > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > 
> > > For s390 there is one additional byte associated with each page,
> > > the storage key. This byte contains the referenced and changed
> > > bits and needs to be included into the hibernation image.
> > > If the storage keys are not restored to their previous state all
> > > original pages would appear to be dirty. This can cause
> > > inconsistencies e.g. with read-only filesystems.
> > > 
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > > Cc: Jiri Slaby <jslaby@suse.cz>
> > > Cc: linux-pm@lists.linux-foundation.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-s390@vger.kernel.org
> > > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > 
> > OK, I don't have any complaints.  Do you want me to take this
> > patch or do you want to push it through the s390 tree?
> 
> The patch affects the common power management code. At minimum I
> would like an acked-by to take it into the s390 tree. I would feel
> more comfortable if you'd take it via the power management tree
> though.

OK, I will.  Expect it to appear in 3.2. :-)

Thanks,
Rafael

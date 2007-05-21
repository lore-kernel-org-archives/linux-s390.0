Return-Path: <linux-kernel-owner+w=401wt.eu-S1759654AbXEUIwr@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.22-rc1-mm1 - s390 vs. md
Date: Mon, 21 May 2007 01:52:36 -0700
Message-ID: <0C7297FA1D2D244A9C7F6959C0BF1E5201DEAE7F@azsmsx413.amr.corp.intel.com>
In-Reply-To: <20070521092449.34a50f2e@gondolin.boeblingen.de.ibm.com>
From: "Williams, Dan J" <dan.j.williams@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

> From: Cornelia Huck [mailto:cornelia.huck@de.ibm.com]
> On Fri, 18 May 2007 09:30:09 -0700,
> "Williams, Dan J" <dan.j.williams@intel.com> wrote:
> 
> > When CONFIG_DMA_ENGINE=n async_tx_find_channel takes the form:
> > ... async_tx_find_channel( ... )
> > {
> > 	return NULL;
> > }
> >
> > So in the S390 case the entire asynchronous path will be compiled
away.
> 
> Unfortunately, do_async_xor() (and others) is not ifdef'ed and
contains
> dma_map_page(), which led to the compile failure...

Sorry, I did not realize dma_map_page did not exist on s390.  I am
building an s390 cross compiler so I can clean up these errors.

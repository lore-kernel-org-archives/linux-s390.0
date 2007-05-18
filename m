Return-Path: <linux-kernel-owner+w=401wt.eu-S1762189AbXERFkD@vger.kernel.org>
Date: Fri, 18 May 2007 07:39:46 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: 2.6.22-rc1-mm1 - s390 vs. md
Message-ID: <20070518073946.716132f4@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <0C7297FA1D2D244A9C7F6959C0BF1E5201DEA0F1@azsmsx413.amr.corp.intel.com>
References: <0C7297FA1D2D244A9C7F6959C0BF1E5201DEA0F1@azsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 16 May 2007 23:36:56 -0700,
"Williams, Dan J" <dan.j.williams@intel.com> wrote:

> async_tx: add the Kconfig infrastructure for async_tx
> 
> From: Dan Williams <dan.j.williams@intel.com>
> 
> async_tx is similar to crypto in that there is an api component and a
> drivers component.
> 
> * Add 'source "async_tx/Kconfig"' to the per architecture Kconfig files,
>   for each architecture that sources drivers/md/Kconfig (which appears
> to be
>   all of them).
> * Add 'select' statements for the subsystems that use async_tx
> (md-raid4,5)

Finer granularity is certainly better here, but I'm not quite sure if
this solves our s390 problem (we don't have dma support). All those
backends should also have a non-dma version...

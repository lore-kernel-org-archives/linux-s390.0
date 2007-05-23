Return-Path: <linux-kernel-owner+w=401wt.eu-S1762648AbXEWIF2@vger.kernel.org>
Subject: RE: 2.6.22-rc1-mm1 - s390 vs. md
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <0C7297FA1D2D244A9C7F6959C0BF1E5201E39968@azsmsx413.amr.corp.intel.com>
References: <0C7297FA1D2D244A9C7F6959C0BF1E5201E39968@azsmsx413.amr.corp.intel.com>
Content-Type: text/plain
Date: Wed, 23 May 2007 10:05:39 +0200
Message-Id: <1179907539.17849.16.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2007-05-22 at 17:25 -0700, Williams, Dan J wrote:
> The approach I have taken is to add the missing definitions to
> include/asm-s390/dma-mapping.h [ a non-outlook-mangled version of the
> patch is pushed out in my rebased git tree ].  I was not able to fully
> compile-test this change as the three s390-cross-toolchains I tried
> each

We are trying to get rid of dma-mapping.h, see the last change to the
file with commit 411f0f3edc141a582190d3605cadd1d993abb6df. I don't think
we should reintroduce dma related definition but split the async_tx in a
way that allows to compile it on an architecture with CONFIG_NO_DMA=y
(yes I know that is harder that to just add the dma stubs).
You've said that there is a software implementation if there is no dma
engine present. This software implementation should be independent of
dma-mapping.h. Without having looked at the code, isn't it possible to
isolate that software implementation into its own C file? That would be
the only one that gets compiled for s390.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

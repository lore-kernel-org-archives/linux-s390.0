Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Nov 2017 15:56:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/12] arch/s390/ license text cleanup
Message-ID: <20171124145609.GA419@kroah.com>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
 <20171124153808.63d502f0@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171124153808.63d502f0@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Nov 24, 2017 at 03:38:08PM +0100, Martin Schwidefsky wrote:
> On Fri, 24 Nov 2017 15:00:31 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > Here are 12 patches against linux-next of today that add SPDX
> > identifiers to the remaining files in arch/s390 that do not currently
> > have them, and then it cleans up the various different ways that the
> > license text boilerplate was written for the GPLv2 in a few files.  This
> > cleanup was done in the quest to remove the 700+ different ways the
> > kernel describes GPLv2.
> > 
> > No copyright headers or any other non-license-description text was
> > removed in these patches.
> > 
> > FWIW, this license cleanup action has been "blessed" by IBM lawyers, but
> > feel free to check internally if you are curious.
> 
> Ok, Christian picked up patches #2 and #8. I have added the remaining 10
> patches to the fixes branch of s390/linux and created an additional patch
> to have arch/s390/kernel/sthyi.c marked as GPL-2.0.

Wonderful, thanks for picking them all up and doing that additional
file, missed that one, sorry.

greg k-h

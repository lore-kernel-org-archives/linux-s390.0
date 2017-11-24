Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Nov 2017 15:38:08 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 00/12] arch/s390/ license text cleanup
In-Reply-To: <20171124140043.10062-1-gregkh@linuxfoundation.org>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171124153808.63d502f0@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 24 Nov 2017 15:00:31 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> Here are 12 patches against linux-next of today that add SPDX
> identifiers to the remaining files in arch/s390 that do not currently
> have them, and then it cleans up the various different ways that the
> license text boilerplate was written for the GPLv2 in a few files.  This
> cleanup was done in the quest to remove the 700+ different ways the
> kernel describes GPLv2.
> 
> No copyright headers or any other non-license-description text was
> removed in these patches.
> 
> FWIW, this license cleanup action has been "blessed" by IBM lawyers, but
> feel free to check internally if you are curious.

Ok, Christian picked up patches #2 and #8. I have added the remaining 10
patches to the fixes branch of s390/linux and created an additional patch
to have arch/s390/kernel/sthyi.c marked as GPL-2.0.

Thanks Greg!

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 3 Aug 2017 12:59:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 0/2] s390: add const to bin_attribute structures
In-Reply-To: <1501690043-7640-1-git-send-email-bhumirks@gmail.com>
References: <1501690043-7640-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170803125933.3bd42075@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, sebott@linux.vnet.ibm.com, oberpar@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed,  2 Aug 2017 21:37:21 +0530
Bhumika Goyal <bhumirks@gmail.com> wrote:

> Declare bin_attribute structures as const.
> 
> Bhumika Goyal (2):
>   s390/sclp: add const to bin_attribute structure
>   s390/cio: add const to bin_attribute structures
> 
>  drivers/s390/char/sclp_config.c | 2 +-
>  drivers/s390/cio/chp.c          | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
 
Applied. Thanks!

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

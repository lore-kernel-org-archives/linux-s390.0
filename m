Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 5 Aug 2015 09:03:48 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/2] s390: Remove unneeded semicolon
Message-ID: <20150805070348.GA4163@osiris>
References: <1438701075-30664-1-git-send-email-peter.senna@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438701075-30664-1-git-send-email-peter.senna@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Senna Tschudin <peter.senna@gmail.com>
Cc: wein@de.ibm.com, stefan.haberland@de.ibm.com, schwidefsky@de.ibm.com, linux390@de.ibm.com, maier@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Aug 04, 2015 at 05:11:15PM +0200, Peter Senna Tschudin wrote:
> Remove unneeded semicolon.
> 
> The semantic patch that detects this change is available
> at scripts/coccinelle/misc/semicolon.cocci.
> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
> ---
> Tested by cross compilation only.
> 
>  drivers/s390/block/dasd_alias.c | 6 +++---
>  drivers/s390/char/monreader.c   | 2 +-
>  drivers/s390/scsi/zfcp_fsf.c    | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

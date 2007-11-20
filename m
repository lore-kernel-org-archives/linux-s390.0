Return-Path: <linux-kernel-owner+w=401wt.eu-S1757363AbXKTIwe@vger.kernel.org>
Date: Tue, 20 Nov 2007 09:52:21 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 39/59] drivers/s390: Add missing "space"
Message-ID: <20071120085221.GC7992@osiris.boeblingen.de.ibm.com>
References: <ee1678e1bc8b80b7ae420059fffc7241486ea91a.1195454434.git.joe@perches.com> <d9fb5d88f80db783c403b0d7c8e13c1e82c9ad32.1195454435.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9fb5d88f80db783c403b0d7c8e13c1e82c9ad32.1195454435.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Frank Blaschka <blaschka@linux.vnet.ibm.com>, Swen Schillig <swen@vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux390@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 19, 2007 at 05:48:31PM -0800, Joe Perches wrote:
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/s390/char/monwriter.c |    2 +-
>  drivers/s390/char/vmlogrdr.c  |    2 +-
>  drivers/s390/cio/chsc.c       |    2 +-
>  drivers/s390/net/claw.c       |    2 +-
>  drivers/s390/net/lcs.c        |    2 +-
>  drivers/s390/scsi/zfcp_fsf.c  |   10 +++++-----
>  6 files changed, 10 insertions(+), 10 deletions(-)

Applied as well. Thanks.

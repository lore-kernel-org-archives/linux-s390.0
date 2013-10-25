Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 25 Oct 2013 09:18:33 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 03/24] s390: Convert use of typedef ctl_table to struct
 ctl_table
Message-ID: <20131025071833.GB4136@osiris>
References: <cover.1382480758.git.joe@perches.com>
 <deafe94275c9ebec32ef09eb6f583b2c5a014dae.1382480758.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deafe94275c9ebec32ef09eb6f583b2c5a014dae.1382480758.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 22, 2013 at 03:29:46PM -0700, Joe Perches wrote:
> This typedef is unnecessary and should just be removed.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/s390/appldata/appldata_base.c | 10 +++++-----
>  arch/s390/kernel/debug.c           |  2 +-
>  arch/s390/mm/cmm.c                 |  8 ++++----
>  3 files changed, 10 insertions(+), 10 deletions(-)

Applied, thanks.

Return-Path: <linux-kernel-owner+w=401wt.eu-S1752987AbXLGIT5@vger.kernel.org>
Date: Fri, 7 Dec 2007 09:19:24 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 09/20] drivers/s390/: use LIST_HEAD instead of
	LIST_HEAD_INIT
Message-ID: <20071207081924.GB8081@osiris.boeblingen.de.ibm.com>
References: <1196954381-5483-1-git-send-email-crquan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1196954381-5483-1-git-send-email-crquan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Denis Cheng <crquan@gmail.com>
Cc: linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 06, 2007 at 11:19:41PM +0800, Denis Cheng wrote:
> single list_head variable initialized with LIST_HEAD_INIT could almost
> always can be replaced with LIST_HEAD declaration, this shrinks the code
> and looks better.
> 
> Signed-off-by: Denis Cheng <crquan@gmail.com>
> ---
>  drivers/s390/block/dcssblk.c  |    2 +-
>  drivers/s390/char/raw3270.c   |    4 ++--
>  drivers/s390/char/tape_core.c |    2 +-
>  drivers/s390/net/netiucv.c    |    3 +--
>  drivers/s390/net/smsgiucv.c   |    2 +-
>  5 files changed, 6 insertions(+), 7 deletions(-)

Thanks, applied. I added the possible change in arch/s390/mm/extmem.c
to your patch.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 22 Dec 2014 10:21:00 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: cio: idset.c:  Remove some unused functions
Message-ID: <20141222092100.GA3295@osiris>
References: <1419078469-30933-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1419078469-30933-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Dec 20, 2014 at 01:27:49PM +0100, Rickard Strandqvist wrote:
> Removes some functions that are not used anywhere:
> idset_clear() idset_sch_get_first()
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  drivers/s390/cio/idset.c |   20 --------------------
>  drivers/s390/cio/idset.h |    2 --
>  2 files changed, 22 deletions(-)

Applied, thanks!

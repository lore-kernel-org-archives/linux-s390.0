Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 17 May 2017 12:41:50 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: use generic fb.h
References: <20170517083449.1994-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517083449.1994-1-tklauser@distanz.ch>
Message-Id: <20170517104150.GB6131@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 17, 2017 at 10:34:49AM +0200, Tobias Klauser wrote:
> The arch uses a verbatim copy of the asm-generic version and does not
> add any own implemntations to the header, so use asm-generic/fb.h
> instead of duplicating code.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  arch/s390/include/asm/Kbuild |  1 +
>  arch/s390/include/asm/fb.h   | 12 ------------
>  2 files changed, 1 insertion(+), 12 deletions(-)
>  delete mode 100644 arch/s390/include/asm/fb.h

Thanks, however a similar patch which addresses this and yet another
header file is available in our features branch, which should be part
of linux-next soon:

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=b14b748a1df95a91207ba34981c9a51061b8c93d

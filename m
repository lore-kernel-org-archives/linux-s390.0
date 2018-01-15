Date: Mon, 15 Jan 2018 13:06:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] s390: fix setgid16/setuid16 handling of -1
Message-ID: <20180115120652.GA16218@kroah.com>
References: <20180115115242.GA15131@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115115242.GA15131@asgard.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Return-Path: <linux-kernel-owner@vger.kernel.org>
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 15, 2018 at 12:52:42PM +0100, Eugene Syromiatnikov wrote:
> For some reason, the implementation of these two 16-bit ID system calls
> used cast instead of low2highgid/low2highuid macros for converting [GU]IDs,
> which leads to incorrect handling of value of -1 (which ought to be
> considered invalid).
> 
> Discovered by strace test suite.
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>  arch/s390/kernel/compat_linux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Care to add a cc: stable on this?

thanks,

greg k-h

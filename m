Date: Mon, 15 Jan 2018 23:36:52 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2] s390: fix handling of -1 in set{,fs}[gu]id16 syscalls
References: <20180115115242.GA15131@asgard.redhat.com>
 <20180115193817.GA8145@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115193817.GA8145@asgard.redhat.com>
Message-Id: <20180115223652.GB3054@osiris>
Sender: linux-kernel-owner@vger.kernel.org
Return-Path: <linux-kernel-owner@vger.kernel.org>
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 15, 2018 at 08:38:17PM +0100, Eugene Syromiatnikov wrote:
> For some reason, the implementation of some 16-bit ID system calls
> (namely, setuid16/setgid16 and setfsuid16/setfsgid16) used type cast
> instead of low2highgid/low2highuid macros for converting [GU]IDs, which
> led to incorrect handling of value of -1 (which ought to be considered
> invalid).
> 
> Discovered by strace test suite.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>  arch/s390/kernel/compat_linux.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks!

From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] clean up scary strncpy(dst, src, strlen(src)) uses
Date: Fri, 31 May 2013 10:11:24 -0700
Message-ID: <20130531171124.GB14699@kroah.com>
References: <20130531161807.GA9536@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130531161807.GA9536@www.outflux.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 31, 2013 at 09:18:07AM -0700, Kees Cook wrote:
> Fix various weird constructions of strncpy(dst, src, strlen(src)). Length
> limits should be about the space available in the destination, not
> repurposed as a method to either always include or always exclude
> a trailing NULL byte. Either the NULL should always be copied
> (using strlcpy), or it should not be copied (using something like
> memcpy). Readable code should not depend on the weird behavior of strncpy
> when it hits the length limit. Better to avoid the anti-pattern entirely.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This is a follow-up to the anti-pattern being fixed in iscsi-target,
> which was exploitable:
> "iscsi-target: fix heap buffer overflow on error"
> http://git.kernel.org/cgit/linux/kernel/git/nab/target-pending.git/commit/?id=cea4dcfdad926a27a18e188720efe0f2c9403456
> ---
>  Documentation/accounting/getdelays.c             |    3 ++-
>  drivers/acpi/sysfs.c                             |    3 +--
>  drivers/s390/net/qeth_l3_sys.c                   |    6 ++----
>  drivers/staging/tidspbridge/rmgr/drv_interface.c |    3 +--

For the drivers/staging/ part of this:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

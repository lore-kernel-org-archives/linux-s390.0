From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: forbid 8250 on s390
Date: Tue, 12 Dec 2017 09:48:08 +0100
Message-ID: <20171212084808.GA14030@kroah.com>
References: <20171212080835.23610-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171212080835.23610-1-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-serial/>
List-Post: <mailto:linux-serial@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Dec 12, 2017 at 09:08:35AM +0100, Christian Borntraeger wrote:
> Using "make kvmconfig" results in a potentially unusable linux image
> on s390.  The reason is that both the (default on s390) sclp consoles
> as well as the 8250 console register a ttyS<x> as console. Since there
> will be no 8250 on s390 let's fence 8250. This will ensure that there
> is always a working sclp console.
> 
> Reported-by: Alice Frosi <alice@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> ---
>  drivers/tty/serial/8250/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Does this need to be backported to any stable kernels?  Or does anyone
who runs them on s390 already have this config option disabled?

thanks,

greg k-h

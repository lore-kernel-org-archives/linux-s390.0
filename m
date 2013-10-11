Return-Path: <brueckner@linux.vnet.ibm.com>
Date: Fri, 11 Oct 2013 14:47:07 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] tty/hvc_console: Add DTR/RTS callback to handle
 HUPCL control
Message-ID: <20131011124707.GA6082@linux.vnet.ibm.com>
References: <1372777635-10423-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1372777635-10423-2-git-send-email-brueckner@linux.vnet.ibm.com>
 <1381475711.5630.67.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381475711.5630.67.camel@pasglop>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-s390@vger.kernel.org, brueckner@linux.vnet.com, gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, schwidefsky@de.ibm.com, jslaby@suse.cz
List-ID: <linux-s390.vger.kernel.org>

Hi Benjamin,

On Fri, Oct 11, 2013 at 06:15:11PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2013-07-02 at 17:07 +0200, Hendrik Brueckner wrote:
> > Introduce a new callback to explicitly handle the HUPCL termios control flag.
> > This prepares for a follow-up commit for the hvc_iucv device driver to
> > improve handling when to drop an established network connection.
> > 
> > The callback naming is based on the recently added tty_port interface to
> > facilitate a potential refactoring of the hvc_console to use tty_port
> > functions.
> 
> I only just noticed that ... oops. Why add those dtr_rts() calls ? We
> already have tiocmset in there which is used to set DTR on HVSI consoles
> such as hvc_opal when using hvsi_lib...
> 
> Any reason why a separate callback was needed ?

The tiocmget/tiocmset callbacks are used to set and get modem status and
triggered through an tty ioctl.

The dtr_rts() callback is different and it is used for DTS/RTS handshaking
between the hvc_console (or any other tty_port) and the tty layer.  The tty
port layer uses this callback to signal the hvc_console whether to raise or
lower the DTR/RTS lines.  This is different than the ioctl interface to
controls the modem status.

Thanks and kind regards,
  Hendrik

Return-Path: <brueckner@linux.vnet.ibm.com>
Date: Tue, 15 Oct 2013 17:36:26 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] tty/hvc_console: Add DTR/RTS callback to handle
 HUPCL control
Message-ID: <20131015153626.GA6129@linux.vnet.ibm.com>
References: <1372777635-10423-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1372777635-10423-2-git-send-email-brueckner@linux.vnet.ibm.com>
 <1381475711.5630.67.camel@pasglop>
 <20131011124707.GA6082@linux.vnet.ibm.com>
 <1381524204.5630.91.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381524204.5630.91.camel@pasglop>
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

On Sat, Oct 12, 2013 at 07:43:24AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2013-10-11 at 14:47 +0200, Hendrik Brueckner wrote:
> > The tiocmget/tiocmset callbacks are used to set and get modem status and
> > triggered through an tty ioctl.
> > 
> > The dtr_rts() callback is different and it is used for DTS/RTS handshaking
> > between the hvc_console (or any other tty_port) and the tty layer.  The tty
> > port layer uses this callback to signal the hvc_console whether to raise or
> > lower the DTR/RTS lines.  This is different than the ioctl interface to
> > controls the modem status.
> 
> Well, DTR at least is the same via both callbacks... Also normal handshaking
> is normally RTS/CTS, only some HW setups "hijacks" DTR for RTS (old Macs come
> to mind).

Yep. DTR is changed in both callbacks but from different layers.  The
tiocmget/tiocmset are triggered through the ioctl.  The dtr_rts() callback is
called in hvc_close() to properly handle HUPCL to lower modem control lines
after last process closes the device (hang up).

This is also done in the hvsilib_close() in hvsi_lib.c:

	/* Clear our own DTR */
	if (!pv->tty || (pv->tty->termios.c_cflag & HUPCL))
		hvsilib_write_mctrl(pv, 0); 

This is actually what the dtr_rts() callback should trigger and I wonder
whether it would be worth to introduce the dtr_rts() callback to encapsulate
the "hvsilib_write_mctrl(pv, 0);" call from above.

On the other hand, the dtr_rts() callback is a good encapsulation to not
directly access the hp->tty to potentially prevent a layering violation. At
least for the hvc_iucv() I do not want to deal with the "underlying" tty layer
and introduce additional reference accounting.

I hope this helps you to understand my rational for introducing the dtr_rts()
callback.

Thanks and kind regards,
  Hendrik

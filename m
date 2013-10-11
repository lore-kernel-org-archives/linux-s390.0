Return-Path: <benh@kernel.crashing.org>
Message-ID: <1381524204.5630.91.camel@pasglop>
Subject: Re: [PATCH 1/2] tty/hvc_console: Add DTR/RTS callback to handle
 HUPCL control
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 12 Oct 2013 07:43:24 +1100
In-Reply-To: <20131011124707.GA6082@linux.vnet.ibm.com>
References: <1372777635-10423-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1372777635-10423-2-git-send-email-brueckner@linux.vnet.ibm.com>
 <1381475711.5630.67.camel@pasglop>
 <20131011124707.GA6082@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, brueckner@linux.vnet.com, schwidefsky@de.ibm.com, jslaby@suse.cz
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2013-10-11 at 14:47 +0200, Hendrik Brueckner wrote:
> The tiocmget/tiocmset callbacks are used to set and get modem status and
> triggered through an tty ioctl.
> 
> The dtr_rts() callback is different and it is used for DTS/RTS handshaking
> between the hvc_console (or any other tty_port) and the tty layer.  The tty
> port layer uses this callback to signal the hvc_console whether to raise or
> lower the DTR/RTS lines.  This is different than the ioctl interface to
> controls the modem status.

Well, DTR at least is the same via both callbacks... Also normal handshaking
is normally RTS/CTS, only some HW setups "hijacks" DTR for RTS (old Macs come
to mind).

Cheers,
Ben.

Return-Path: <brueckner@linux.vnet.ibm.com>
Date: Thu, 17 Oct 2013 10:16:42 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] tty/hvc_console: Add DTR/RTS callback to handle
 HUPCL control
Message-ID: <20131017081642.GA6134@linux.vnet.ibm.com>
References: <1372777635-10423-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1372777635-10423-2-git-send-email-brueckner@linux.vnet.ibm.com>
 <1381475711.5630.67.camel@pasglop>
 <20131011124707.GA6082@linux.vnet.ibm.com>
 <1381524204.5630.91.camel@pasglop>
 <20131015153626.GA6129@linux.vnet.ibm.com>
 <1381870070.17841.24.camel@pasglop>
 <20131016090432.GA6053@linux.vnet.ibm.com>
 <1381965672.17841.71.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381965672.17841.71.camel@pasglop>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: linux-s390@vger.kernel.org, brueckner@linux.vnet.com, gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, schwidefsky@de.ibm.com, jslaby@suse.cz
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 16, 2013 at 06:21:12PM -0500, Benjamin Herrenschmidt wrote:
> On Wed, 2013-10-16 at 11:04 +0200, Hendrik Brueckner wrote:
> > Indeed, two callbacks change the DTR line.  The main difference is that
> > tiocmget/tiocmset can be called from user space by ioctl.  That's not the case
> > for the dtr_cts callback.  Also, tiocmget/tiocmset provide more flags that can
> > be changed (ST, SR, CTS, CD, RNG, RI,  ...)
> > 
> > Assume we would like to unify them have a single callback to change DTR, then
> > we have to take care of these differences.  So the question to you now is
> > whether you plan for a) other modem flags to be changed and b) if changing the
> > DTR line (or other control flags) through an ioctl?
> > 
> > Depending on your results, I could work on sth that helps us both and reduces
> > the callbacks.
> 
> Can we not just have the users of dtr_cts just call the backend's tiocmset ?

That's possible.  The only concern is that the tiocmset() callback could be
triggered from within the hvc_console() layer as well as from user space via
ioctl.  For the hvc_iucv driver, I do not want to introduce this ioctl.

One option would be to add parameter to the hvc_callbacks that indicate the
origin so that a backend could filter.

> If they need to filter or clamp bits, we could handle all that in hvc_console
> by caching the user intended value and passing a cooked value down to the backend..

Sure the hvc_console layer could do as much as possible.

> 
> None of that is urgent or anything, it's just odd and would be nice to cleanup.

Thanks and kind regards,
  Hendrik

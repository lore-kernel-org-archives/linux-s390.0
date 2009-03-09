From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Date: Mon, 09 Mar 2009 09:46:28 +0000
Subject: Re: [BUG,2.6.29-rc7] Fails to boot in Hercules if HVC_IUCV is set
Message-Id: <20090309094628.GB4124@cetus.boeblingen.de.ibm.com>
In-Reply-To: <200903090302.08873.elendil@planet.nl>
References: <200903090302.08873.elendil@planet.nl>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 09, 2009 at 03:02:07AM +0100, Frans Pop wrote:
> On Sunday 08 March 2009, Frans Pop wrote:
> > > Initially I had CONFIG_HVC_IUCV set to y, and with that the boot
> > > stopped after:
> > > hvc_iucv: The z/VM IUCV HVC device driver cannot be used without z/VM
> > >
> > > Looks like the system got into a loop with one processor at 100%.
> > >
> > > After disabling the option the boot was successful.
> As I can't be sure whether the boot failure with HVC_IUCV is or isn't
> a side effect of the hrtimer issue mentioned in my previous mail [1],
> I suggest we leave this until the hrtimer issue has been resolved. From 
> what I've seen during the bisection I suspect it is just a side-effect.
If the HVC_IUCV driver writes the message "...cannot be used without z/VM",
the driver initialization stops and returns with ENODEV.

Best regards
  Hendrik

-- 
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Geschaeftsfuehrung: Erich Baier
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

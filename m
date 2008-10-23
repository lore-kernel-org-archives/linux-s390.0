Return-Path: <linux-kernel-owner+w=401wt.eu-S1757574AbYJWVGc@vger.kernel.org>
Date: Thu, 23 Oct 2008 23:04:46 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL/RESEND] kernel message catalog patches
Message-ID: <20081023210446.GA12003@osiris.boeblingen.de.ibm.com>
References: <1224168620.9617.14.camel@localhost> <1224230354.4631.1.camel@localhost> <20081021092148.GB4980@osiris.boeblingen.de.ibm.com> <alpine.LFD.2.00.0810230835150.3287@nehalem.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810230835150.3287@nehalem.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 23, 2008 at 08:35:40AM -0700, Linus Torvalds wrote:
> On Tue, 21 Oct 2008, Heiko Carstens wrote:
> > 
> > please pull from 'kmsg' branch of
> > 
> >         git://git390.osdl.marist.edu/pub/scm/linux-2.6.git kmsg
> > 
> > to get the kernel message catalog code.
> 
> I'm not going to pull it, since I have no idea what it is, or why I'd 
> _want_ to pull it.

The whole point of the patch set is to add documentation for kernel
messages that are emitted via printk. The documentation is supposed to
help a sys admin to help understand what went wrong.

To achieve this each message gets a component name and a hash and so
gets a unique identifier with which the documentation for the message
can be found. The documentation can be within the source code or in
the Documentation/kmsg/<arch> folder. A script allows to create man
pages from the documentations (make D=2). The user can then just issue
'man <componentname>.<hash>' and gets a detailed description of what
went wrong and what to do.

To add component name and hash to the printk output new macros have to
be used (see patch "kmsg: tagged kernel messages."):

kmsg_emerg(format, args...);
kmsg_alert(format, args...);
kmsg_crit(format, args...);
kmsg_err(format, args...);
kmsg_warn(format, args...);
kmsg_notice(format, args...);
kmsg_info(format, args...);

If kernel message identifiers are disabled they just translate into
printk(KERN_EMERG, format, args...); etc.

Otherwise the code in question has to specify its compoment name
with a KMSG_COMPONENT define and kmesg_<level>() would translate into

printk_hash(level KMSG_COMPONENT ".%06x" ": ", format, ##__VA_ARGS__)

where printk_hash will generate a hash for the format string.

Example:

The s390 xpram driver now has:

#define KMSG_COMPONENT "xpram"
[...]
	if (devs <= 0 || devs > XPRAM_MAX_DEVS) {
		kmsg_err("%d is not a valid number of XPRAM devices\n",devs);

If the message would be printed it could look like:

xpram.ab9aa4 42 is not a valid number of XPRAM devices

The corresponding description for the message is in
Documentation/kmsg/s390/xpram :

/*?
 * Tag: xpram.ab9aa4
 * Text: "%d is not a valid number of XPRAM devices\n"
 * Severity: Error
 * Parameter:
 *   @1: number of partitions
 * Description:
 * The number of XPRAM partitions specified for the 'devs' module parameter 
 * or with the 'xpram.parts' kernel parameter must be an integer in the
 * range 1 to 32. The XPRAM device driver created a maximum of 32 partitions
 * that are probably not configured as intended.
 * User action:
 * If the XPRAM device driver has been compiled as a separate module,
 * unload the module and load it again with a correct value for the 
 * 'devs' module parameter. If the XPRAM device driver has been compiled
 * into the kernel, correct the 'xpram.parts' parameter in the kernel
 * command line and restart Linux.
 */

With "make D=2" a man page can be created from this:

.TH "xpram.ab9aa4" 9 "Linux Messages" LINUX
.SH Message
xpram.ab9aa4: %d is not a valid number of XPRAM devices\n
.SH Severity
Error
.SH Parameters
@1: number of partitions

.SH Description
The number of XPRAM partitions specified for the 'devs' module parameter 
or with the 'xpram.parts' kernel parameter must be an integer in the
range 1 to 32. The XPRAM device driver created a maximum of 32 partitions
that are probably not configured as intended.
.SH User action
If the XPRAM device driver has been compiled as a separate module,
unload the module and load it again with a correct value for the 
'devs' module parameter. If the XPRAM device driver has been compiled
into the kernel, correct the 'xpram.parts' parameter in the kernel
command line and restart Linux.


So with 'man <componentname>.<hash>' a sys admin would get information
of what went wrong.

Please note that this was initially an s390 only patch set but we moved
the infrastructure to generic code since it looks like others want a
facility like this too. iirc Andrew requested the move.

Thanks,
Heiko

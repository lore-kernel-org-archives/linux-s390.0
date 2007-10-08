From: Frans Pop <elendil@planet.nl>
Date: Mon, 08 Oct 2007 15:12:37 +0000
Subject: Re: fsck during system boot fails with separate /boot partition
Message-Id: <200710081712.38052.elendil@planet.nl>
In-Reply-To: <OF0D3D6394.7CCE4101-ONC125736E.004510FE-C125736E.0045C5C6@de.ibm.com>
References: <OF0D3D6394.7CCE4101-ONC125736E.004510FE-C125736E.0045C5C6@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Monday 08 October 2007, Peter 1 Oberparleiter wrote:
> This might indicate a timing problem - the init script tries to mount a
> DASD that has not yet been fully initialized by the kernel (the return
> code -EBUSY that triggers the "already mounted" message may indicate
> different problems). Try to add a sleep 5 into the init script just
> before the mount command that fails to check if this is the case.

I've found the root of the problem. It's a configuration problem after all.

We currently do not add the 'dasd=' parameter to the kernel boot arguments. 
Instead, we let udev assign device names.

Because of the 'root=' parameter (in which we use a by-path device name), 
the first dasd that is detected in my test is 0123, which ends up as dasda 
and thus 0122 ends up as dasdb, effectively swapping the two dasds. And as 
we still use the classic device names in /etc/fstab, the result is chaos.

The confusion came from the fact that mount still lists / mounted as
/dev/dasd_b_1, even if it is actually mounted as /dev/dasd_a_1.
So, fsck is completely correct in reporting /dev/dasda1 as already mounted.
It also means that when /boot is mounted later, it's not actually the boot 
partition that is mounted, but it is the root partition that is mounted 
(for a second time) on /boot.

Adding the dasd= boot parameter did not help - it seems to be ignored in our 
initrds; changing /etc/fstab to use /dev/disk/by-path devices consistently 
does result in a correct boot.
I'll consult with other Debian people how we want to resolve this.

Thanks very much for your replies, which did help in straightening this out 
for me.

Cheers,
Frans Pop

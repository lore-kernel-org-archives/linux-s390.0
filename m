From: Stephen Powell <zlinuxman@wowway.com>
Date: Mon, 21 Dec 2009 15:26:38 +0000
Subject: Appeal to backport dasd_diag fix to stable update for 2.6.32
Message-Id: <1697192065.629161261409198260.JavaMail.root@md01.wow.synacor.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello upstream kernel team!

A fix was recently published for drivers/s390/block/dasd_diag.c to fix a problem
with an inability to get read-only minidisks online to Linux via the dasd_diag
driver.  This fix was published for kernel release 2.6.33.  (See
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=22825ab7693fd29769518a0d25ba43c01a50092a
for the git commit.)  Here is a description of the problem:

----------

[S390] dasd: support DIAG access for read-only devices

author	Stefan Weinhuber <wein@de.ibm.com>	
	Mon, 7 Dec 2009 11:51:48 +0000 (12:51 +0100)
committer	Martin Schwidefsky <sky@mschwide.boeblingen.de.ibm.com>	
	Mon, 7 Dec 2009 11:51:34 +0000 (12:51 +0100)

When a DASD device is used with the DIAG discipline, the DIAG
initialization will indicate success or error with a respective
return code. So far we have interpreted a return code of 4 as error,
but it actually means that the initialization was successful, but
the device is read-only. To allow read-only devices to be used with
DIAG we need to accept a return code of 4 as success.

Re-initialization of the DIAG access is also part of the DIAG error
recovery. If we find that the access mode of a device has been
changed from writable to read-only while the device was in use,
we print an error message.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

----------

I am the one who originally reported this problem to my Linux distributor
(Debian), and I'd like to thank you all for your quick response to this problem.
However, I'd also like to make an appeal to have this fix backported to your
next stable release update for 2.6.32.  It appears likely at this point that
2.6.32 will be adopted as the kernel used by Debian's next release (6.0.0,
codename "Squeeze").  Having this fix in the kernel when Squeeze is first released
will be a great benefit.  This is an important fix for the s390 architecture.
Other distributions have recognized this and have backported the fix as far back
as 2.6.16 kernels (SLES10).

Regards,
Steve Powell

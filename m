From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Date: Tue, 20 May 2014 09:04:35 +0000
Subject: Re: format string mismatch
Message-Id: <537B1AA3.2030002@gmx.de>
In-Reply-To: <1400575849.17323.9.camel@BR9GV9YG.de.ibm.com>
References: <1400575849.17323.9.camel@BR9GV9YG.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05/20/2014 10:50 AM, Ursula Braun wrote:
> thanks for reporting these inconsistencies in our drivers. Patches are
> welcome, if you can spend the time. Otherwise we will take care about
> them. I suggest to keep the "unsigned int" format in lcs.c and
> ctcm_sysfs.c, but move to a "u8" format in qeth_l3_main.c.

Well, still in charge with other patches of this kind, so if you have a
solution, I'm completely fine if your team fixes this.

-- 
Toralf

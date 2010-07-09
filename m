From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [-next July 9 - s390 ] Badness at fs/sysfs/symlink.c:82 during qeth initalization
Date: Fri, 09 Jul 2010 03:39:24 -0700
Message-ID: <m14og95483.fsf@fess.ebiederm.org>
References: <20100709150117.51612026.sfr@canb.auug.org.au>
	<4C36EF9C.7010804@in.ibm.com> <m1d3ux55od.fsf@fess.ebiederm.org>
	<4C36F974.4030608@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4C36F974.4030608@in.ibm.com> (Sachin Sant's message of "Fri\, 09 Jul 2010 15\:57\:00 +0530")
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Sachin Sant <sachinp@in.ibm.com> writes:

> Eric W. Biederman wrote:
>>> With today's next(20100709) qeth interface fails to initialize
>>> with following Badness message:
>>>     sysfs: symlink across ns_types 0.0.6000/net:eth0 -> net/eth0
>>>     
>>
>> Is this with CONFIG_SYSFS_DEPRECATED set?
>>
>> I think I may have made my warning check a little extra strict.
>>   
> Yes.
>
> CONFIG_SYSFS_DEPRECATED=y
> CONFIG_SYSFS_DEPRECATED_V2=y

Ugh. It looks like the warning is correct and I have a regression
in 2.6.35 that was overlooked because I did not closely test
CONIFG_SYSFS_DEPRECATED.  I will see if I can cook up a proper
patch shortly.

Eric

From: Sachin Sant <sachinp@in.ibm.com>
Subject: [-next: Oct 4] s390x build break (kernel/power/process.o)
Date: Mon, 04 Oct 2010 14:04:13 +0530
Message-ID: <4CA99185.3020900@in.ibm.com>
References: <20101004113638.a7f8517b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20101004113638.a7f8517b.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Today's next fails to build on a s390x box with

kernel/power/process.c: In function try_to_freeze_tasks:
kernel/power/process.c:82: error: implicit declaration of function pm_check_wakeup_events

The code in question was added via following commit

commit a87bcded7c384857f4f83f38d666c9bf5c7c9727
PM: Allow wakeup events to abort freezing of tasks

CONFIG_PM_SLEEP is not enabled in the config.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------

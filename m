Return-Path: <linux-kernel-owner+w=401wt.eu-S1753102AbXLDKbp@vger.kernel.org>
Subject: Re: [build failure] Re: Linux 2.6.24-rc4 on S390x
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <47552A98.9010108@linux.vnet.ibm.com>
References: <alpine.LFD.0.9999.0712032055080.2981@woody.linux-foundation.org>
	 <47552A98.9010108@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 11:31:26 +0100
Message-Id: <1196764286.9441.0.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ptiedem@de.ibm.com, braunu@de.ibm.com, jeff@garzik.org, linux-s390@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Balbir Singh <balbir@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2007-12-04 at 15:53 +0530, Kamalesh Babulal wrote:
> The patch ctc: make use of alloc_netdev() (commit 1c1478859017452a1179dbbdf7b9eb5b48438746)
> introduces the build failure
> 
>   CC [M]  drivers/s390/net/fsm.o
>   CC [M]  drivers/s390/net/smsgiucv.o
>   CC [M]  drivers/s390/net/ctcmain.o
> drivers/s390/net/ctcmain.c: In function `ctc_init_netdevice':
> drivers/s390/net/ctcmain.c:2805: error: implicit declaration of function `SET_MODULE_OWNER'
> make[2]: *** [drivers/s390/net/ctcmain.o] Error 1
> make[1]: *** [drivers/s390/net] Error 2
> make: *** [drivers/s390] Error 2

Hi Uschi,
that last patch reverted commit 10d024c1b2fd58af8362670d7d6e5ae52fc33353.
That needs to get readded.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

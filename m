Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 28 Sep 2010 13:47:32 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 00/10] taskstats: Enhancements for precise accounting
Message-ID: <20100928081732.GB4128@balbir.in.ibm.com>
Reply-To: balbir@linux.vnet.ibm.com
References: <1285249681.1837.28.camel@holzheu-laptop>
 <20100923131136.356075f4.akpm@linux-foundation.org>
 <1285319415.2179.116.camel@holzheu-laptop>
 <20100924115002.fcb4385a.akpm@linux-foundation.org>
 <1285579127.2116.62.camel@holzheu-laptop>
 <20100927130256.5d9a3db8.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20100927130256.5d9a3db8.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: holzheu@linux.vnet.ibm.com, Shailabh Nagar <nagar1234@in.ibm.com>, Venkatesh Pallipadi <venki@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@redhat.com>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, containers@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

* Andrew Morton <akpm@linux-foundation.org> [2010-09-27 13:02:56]:

> > Good point. It is not really necessary. I started development using the
> > netlink code. Therefore I first added the new command in the netlink
> > code. I also thought, it would be a good idea to provide all netlink
> > commands over the procfs interface to be consistent.
> 
> Maybe we should have delivered taskstats over procfs from day one.
>

The intention was to provide taskstats over a scalable backend to deal
with a large amount of data, including exit notifications. We provided
some information like blkioi delay data on proc, but not the whole structure. 

-- 
	Three Cheers,
	Balbir

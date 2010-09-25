Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 25 Sep 2010 13:19:28 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [RFC][PATCH 00/10] taskstats: Enhancements for precise
 accounting
Message-ID: <20100925181928.GA19611@hallyn.com>
References: <1285249681.1837.28.camel@holzheu-laptop>
 <20100923131136.356075f4.akpm@linux-foundation.org>
 <20100923221139.GI23839@count0.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100923221139.GI23839@count0.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shailabh Nagar <nagar1234@in.ibm.com>, linux-s390@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Venkatesh Pallipadi <venki@google.com>, John stultz <johnstul@us.ibm.com>, containers@lists.linux-foundation.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Suresh Siddha <suresh.b.siddha@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>, holzheu@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Quoting Matt Helsley (matthltc@us.ibm.com):
> I don't think even "root" can see/use pids outside its namespace (without

Just to be clear on this, you're right in what you say, but if a task in a child
pidns still has access to the /proc mount of the parent pidns, then it can see
the pids in there, and get information from them, i.e. /proc/pid/maps.  So
in that sense, some people could misinterpret "see/use pids" and think you
weren't right.

-serge

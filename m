Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 10 Feb 2014 12:59:23 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH RFC/RFT v2 3/8] s390: move cacheinfo sysfs to generic
 cacheinfo infrastructure
Message-ID: <20140210115923.GF19013@osiris>
References: <1391791763-28518-1-git-send-email-sudeep.holla@arm.com>
 <1391791763-28518-4-git-send-email-sudeep.holla@arm.com>
 <20140210095020.GB19013@osiris>
 <52F8B95F.5030401@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52F8B95F.5030401@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sudeep Holla <Sudeep.Holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 10, 2014 at 11:34:55AM +0000, Sudeep Holla wrote:
> On 10/02/14 09:50, Heiko Carstens wrote:
> > On Fri, Feb 07, 2014 at 04:49:18PM +0000, Sudeep Holla wrote:
> >> -		show_cacheinfo(m);
> >>  	}
> >>  	get_online_cpus();
> >>  	if (cpu_online(n)) {
> > 
> > You can't remove that. It's a user space visible change.
> > 
> Correct, I wanted to add show_cacheinfo back as its user ABI already, missed it.
> 
> Is it ok if I use cpu0 cacheinfo or to be safer as cpu0 can be offline, use
> the cacheinfo of the cpu executing this ?

Any online cpu would do, as the information is completely symmetrical.

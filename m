From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [-next] Latest next does not boot on s390x
Date: Thu, 23 Sep 2010 16:00:22 +0200
Message-ID: <20100923140022.GB3832@osiris.boeblingen.de.ibm.com>
References: <4C9B5AAB.6020000@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C9B5AAB.6020000@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: linux-s390@vger.kernel.org, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Sep 23, 2010 at 07:18:27PM +0530, Sachin Sant wrote:
> I cannot boot recent linux-next builds on a s390x box.
> 
> I first ran into this problem with Sept 17th linux-next build(2.6.36-rc4_next_20100917)
> 
> The following messages are displayed on the console :
> 
> 03: Please choose (default will boot in 20 seconds):
> 03: Booting default (autotest)...
> 03: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 00000000 0010DB3E
> 
> Any idea what could be the problem or how can i debug this issue ?

It crashes when the kernel tries to initialize the memmap. I'll have a
look at it. Probably tomorrow.

Thanks for reporting!

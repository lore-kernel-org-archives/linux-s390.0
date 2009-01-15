From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [BUILD_FAILURE] next-20090115 - s390x - mm/kmemleak.c
Date: Thu, 15 Jan 2009 17:00:38 +0000
Message-ID: <1232038838.32016.73.camel@pc1117.cambridge.arm.com>
References: <20090115170415.3edc1df6.sfr@canb.auug.org.au>
	 <20090115103504.GA5178@linux.vnet.ibm.com>
	 <20090115112001.GC5093@osiris.boeblingen.de.ibm.com>
	 <1232020540.32016.19.camel@pc1117.cambridge.arm.com>
	 <20090115120526.GD5093@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090115120526.GD5093@osiris.boeblingen.de.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, penberg@cs.helsinki.fi
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2009-01-15 at 13:05 +0100, Heiko Carstens wrote:
> Btw. you have
> 
> /*
>  * Stop the automatic memory scanning thread. This function must be called
>  * with the kmemleak_mutex held.
>  */
> void stop_scan_thread(void)
> {
> ...
> 
> but call the function unlocked from kmemleak_write. Looks like a bug ;)

kmemleak_write() is called with the kmemleak_mutex acquired in the
kmemleak_open() function (and released in kmemleak_release()).

-- 
Catalin

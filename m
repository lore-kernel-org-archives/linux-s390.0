Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 20 Feb 2015 10:44:59 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: s390: references to MARCH_G5
Message-ID: <20150220094459.GB3952@osiris>
References: <1424422488.5308.21.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424422488.5308.21.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Valentin Rothberg <valentinrothberg@gmail.com>, Andreas Ruprecht <rupran@einserver.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 20, 2015 at 09:54:48AM +0100, Paul Bolle wrote:
> Your commit c5f43f0a70fc ("s390: remove 31 bit support") is included in
> today's linux-next (ie, next-20150220). I noticed because a script I use
> to check linux-next spotted a problem with it.
> 
> That commit removed the Kconfig symbol MARCH_G5. It didn't remove all
> references to it (there are three left in arch/s390/Kconfig and one in
> arch/s390/Makefile). Are patches to remove these last references queued
> somewhere?

Hi Paul,

no, they are leftovers. I'll remove them and that will be merged with
the 31 bit removal patch.
Thanks a lot for letting me know!

Return-Path: <linux-kernel-owner+w=401wt.eu-S1754924AbYG2IJ2@vger.kernel.org>
Subject: Re: [patch 01/15] kmsg: Kernel message catalog macros.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <1217268724.9355.14.camel@localhost>
References: <20080728175355.734299984@de.ibm.com>
	 <20080728175511.023246676@de.ibm.com>  <1217268724.9355.14.camel@localhost>
Content-Type: text/plain
Date: Tue, 29 Jul 2008 10:07:32 +0200
Message-Id: <1217318852.10259.1.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Michael Holzheu <holzheu@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2008-07-28 at 11:12 -0700, Joe Perches wrote:
> On Mon, 2008-07-28 at 19:53 +0200, Martin Schwidefsky wrote:
> > The kmsg component name is defined per source file with the KMSG_COMPONENT
> > macro.
> 
> Why not use KBUILD_MODNAME?

Because sometimes we might want to use the same kmsg prefix for multiple
modules. And the message tag is supposed to stay the same even if the
code structure changes. I'd rather not use KBUILD_MODNAME.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

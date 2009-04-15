Return-Path: <linux-kernel-owner+w=401wt.eu-S1757798AbZDOCGt@vger.kernel.org>
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 10/14] smp: fix cpu_possible_map initialization
Date: Wed, 15 Apr 2009 11:36:34 +0930
References: <20090414135327.576111185@de.ibm.com> <20090414135348.874771700@de.ibm.com>
In-Reply-To: <20090414135348.874771700@de.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904151136.34934.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 14 Apr 2009 11:23:37 pm Martin Schwidefsky wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> The cpu_possible_map by default is initialized with all ones in s390.
> If the kernel paramert possible_cpus=<x> is passed the cpu_possible_map
> is supposed to have x bits set.
> However the current code just sets the x bits without clearing the NR_CPUS
> bits that were already set. So we end up with an unchanged map that has
> all bits set.
> To fix this just clear the map before setting any new bits.

You're right; I created this patch back before I did the
CONFIG_INIT_ALL_POSSIBLE patch.

It'd be nice to wean S390 off CONFIG_INIT_ALL_POSSIBLE, then there'd
only be two (parisc and m32r).  But it's a minor wart.

Thanks,
Rusty.

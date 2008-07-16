Return-Path: <linux-kernel-owner+w=401wt.eu-S1759161AbYGPIRA@vger.kernel.org>
Date: Wed, 16 Jul 2008 10:15:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [2.6 patch] chsc headers userspace cleanup
Message-ID: <20080716081527.GA4869@osiris.boeblingen.de.ibm.com>
References: <20080715125817.GB24533@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080715125817.GB24533@cs181140183.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 15, 2008 at 03:58:18PM +0300, Adrian Bunk wrote:
> Kernel headers shouldn't expose functions to userspace.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Makes sense. Applied -- Thanks.

> BTW: For compile-testing my patches it would be nice if s390 had
>      more defconfigs (e.g. also a non-64bit one).

Yes, will consider that ;)

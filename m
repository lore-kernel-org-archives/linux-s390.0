Return-Path: <linux-kernel-owner+w=401wt.eu-S1754557AbXECGNj@vger.kernel.org>
Date: Wed, 2 May 2007 22:30:47 -0700
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 6/8] Kconfig: no userspace I/O on s390.
Message-ID: <20070503053047.GB7458@kroah.com>
References: <20070420113430.GG3738@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070420113430.GG3738@skybase>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 20, 2007 at 01:34:30PM +0200, Martin Schwidefsky wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Hide the config menu for userspace I/O on s390.

Why?  Who says s390 can't have userspace I/O drivers someday?

thanks,

greg k-h

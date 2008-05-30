Return-Path: <linux-kernel-owner+w=401wt.eu-S1759634AbYE3FvF@vger.kernel.org>
Date: Fri, 30 May 2008 07:50:49 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 06/11] showmem: Only walk spanned pages.
Message-ID: <20080530055049.GA6475@osiris.boeblingen.de.ibm.com>
References: <20080529125501.196123527@de.ibm.com> <20080529125729.607377419@de.ibm.com> <8763sxowli.fsf@saeurebad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8763sxowli.fsf@saeurebad.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Johannes Weiner <hannes@saeurebad.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 29, 2008 at 07:20:57PM +0200, Johannes Weiner wrote:
> >  	printk("%lu pages dirty\n", global_page_state(NR_FILE_DIRTY));
> >  	printk("%lu pages writeback\n", global_page_state(NR_WRITEBACK));
> >  	printk("%lu pages mapped\n", global_page_state(NR_FILE_MAPPED));
> 
> These are redundant, check show_free_areas().

Indeed. Removed them. Thanks!

Btw. what's up with your show_mem() cleanup patch series? I thought it
would be merged before 2.6.26 and now it isn't even in -mm?

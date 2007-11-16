Return-Path: <linux-kernel-owner+w=401wt.eu-S933986AbXKPPPd@vger.kernel.org>
Message-ID: <3ae72650711160715w8479bacs445993b7766e6529@mail.gmail.com>
Date: Fri, 16 Nov 2007 16:15:22 +0100
From: "Kay Sievers" <kay.sievers@vrfy.org>
Subject: Re: [patch 6/6] kernel: Shutdown Actions Interface
In-Reply-To: <20071116143322.198591347@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20071116142942.978412023@de.ibm.com>
	 <20071116143322.198591347@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Michael Holzheu <holzheu@de.ibm.com>, Greg KH <greg@kroah.com>
List-ID: <linux-s390.vger.kernel.org>

On Nov 16, 2007 3:29 PM, Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> From: Michael Holzheu <holzheu@de.ibm.com>

> -static struct subsys_attribute dump_type_attr =
> -               __ATTR(dump_type, 0644, dump_type_show, dump_type_store);
> -
> -static decl_subsys(dump, NULL, NULL);

I guess this will conflict with:
http://git.kernel.org/?p=linux/kernel/git/gregkh/patches.git;a=blob;f=driver/kobject-convert-s390-ipl.c-to-kobj_attr-interface.patch;hb=HEAD

which in in -mm.

Thanks,
Kay

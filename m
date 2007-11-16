Return-Path: <linux-kernel-owner+w=401wt.eu-S1762536AbXKPPIb@vger.kernel.org>
Message-ID: <3ae72650711160708m1855eb18q3a986998cfd87a3f@mail.gmail.com>
Date: Fri, 16 Nov 2007 16:08:21 +0100
From: "Kay Sievers" <kay.sievers@vrfy.org>
Subject: Re: [patch 1/6] sclp: sysfs interface for SCLP cpi
In-Reply-To: <20071116143320.980985765@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20071116142942.978412023@de.ibm.com>
	 <20071116143320.980985765@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Michael Ernst <mernst@de.ibm.com>, Greg KH <greg@kroah.com>
List-ID: <linux-s390.vger.kernel.org>

On Nov 16, 2007 3:29 PM, Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> +
> +static decl_subsys(cpi, NULL, NULL);
> +

decl_subsys() and all other static kset cruft called "subsys" will be
gone with 2.6.25.
The patch series doing this is in -mm, and this patch will need
(trivial) adaption to the
new interfaces.

Thanks,
Kay

Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 31 Oct 2016 10:24:20 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 0/9] s390: remove modular usage from non-modular code
References: <20161030203732.26405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161030203732.26405-1-paul.gortmaker@windriver.com>
Message-Id: <20161031092420.GA4434@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arndb@de.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Oct 30, 2016 at 04:37:23PM -0400, Paul Gortmaker wrote:
> My ongoing audit looking for non-modular code that needlessly uses
> modular macros (vs. built-in equivalents) and/or has dead code
> relating to module unloading that can never be executed led to the
> creation of these s390 related commits.
> 
> For anyone new to the underlying goal of this cleanup, we are trying to
> not use module support for code that can never be built as a module since:
> 
>  (1) it is easy to accidentally write unused module_exit and remove code
>  (2) it can be misleading when reading the source, thinking it can be
>      modular when the Makefile and/or Kconfig prohibit it
>  (3) it requires the include of the module.h header file which in turn
>      includes nearly everything else, thus adding to CPP overhead.
>  (4) it gets copied/replicated into other code and spreads like weeds.
> 
> Build tested on current linux-next (allyes/allno/allmod) to ensure no
> silly typos or implicit include issues that would break compilation
> crept in.
> 
> Paul Gortmaker (9):
>   s390: cio: make it explicitly non-modular
>   s390: char: make zcore explicitly non-modular
>   s390: char: make con3215 explicitly non-modular
>   s390: char: make sclp_tty explicitly non-modular
>   s390: char: make slcp_quiesce explicitly non-modular
>   s390: hotplug: make pci_hpc explicitly non-modular
>   s390: hypfs: make inode explicitly non-modular
>   s390: kernel: make lgr explicitly non-modular
>   s390: virtio: make ccw explicitly non-modular

Whole series applied. Thanks!

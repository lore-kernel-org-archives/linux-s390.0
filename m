Return-Path: <linux-kernel-owner+w=401wt.eu-S1754509AbXJXGqc@vger.kernel.org>
Date: Wed, 24 Oct 2007 08:46:16 +0200
From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH] sg: add missing sg_init_table calls to zfcp
Message-ID: <20071024064616.GT14671@kernel.dk>
References: <20071024052900.GB12335@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071024052900.GB12335@osiris.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christoph Schmitt <schmichr@de.ibm.com>, Swen Schillig <swen@vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 24 2007, Heiko Carstens wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> CONFIG_DEBUG_SG reveals two missing sg_init_table calls. Add them.
> 
> kernel BUG at include/linux/scatterlist.h:50!
> illegal operation: 0001 [#1]
> [...]
> Call Trace:
> ([<000000000026f184>] zfcp_ns_gid_pn_request+0x4c/0x2a0)
>  [<0000000000276dd4>] zfcp_erp_strategy_do_action+0x1410/0x1938
>  [<0000000000278412>] zfcp_erp_thread+0x4fa/0x1430
>  [<000000000001990a>] kernel_thread_starter+0x6/0xc
>  [<0000000000019904>] kernel_thread_starter+0x0/0xc
> 
> Cc: Swen Schillig <swen@vnet.ibm.com>
> Cc: Christof Schmitt <christof.schmitt@de.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
> 
> Jens, could you please push this one via your tree? Thanks!

You bet, thanks!

-- 
Jens Axboe

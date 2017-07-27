Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 27 Jul 2017 10:19:29 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 06/11] s390/topology: Remove the unused parent_node()
 macro
References: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1501076076-1974-7-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501076076-1974-7-git-send-email-douly.fnst@cn.fujitsu.com>
Message-Id: <20170727081929.GB3744@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 26, 2017 at 09:34:31PM +0800, Dou Liyang wrote:
> Commit a7be6e5a7f8d ("mm: drop useless local parameters of
> __register_one_node()") removes the last user of parent_node().
> 
> The parent_node() macro in S390 platform is unnecessary.
> 
> Remove it for cleanup.
> 
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---

Are arch maintainers supposed to pick these patches up?

In any case: Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

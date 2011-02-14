Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 Feb 2011 19:57:23 +0100
From: Robert Richter <robert.richter@amd.com>
Subject: Re: [patch v2 1/3] This patch adds support for hardware based
 sampling on System z processors (models z10 and up)
Message-ID: <20110214185723.GR5874@erda.amd.com>
References: <20110121100651.821690659@linux.vnet.ibm.com>
 <20110121100841.879534437@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20110121100841.879534437@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Cc: "mingo@elte.hu" <mingo@elte.hu>, "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Maran Pakkirisamy <maranp@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 21.01.11 05:06:52, Heinz Graalfs wrote:
> From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
> 
> System z's hardware sampling is described in detail in:
> 
>    SA23-2260-01 "The Load-Program-Parameter and CPU-Measurement Facilities"
> 
> The patch introduces
>  - support for System z's hardware sampler in OProfile's kernel module
>  - it adds functions that control all hardware sampling related operations as
>   - checking if hardware sampling feature is available
>     - ie: on System z models z10 and up, in LPAR mode only, and authorised during LPAR activation
>   - allocating memory for the hardware sampling feature
>   - starting/stopping hardware sampling
> 
> All functions required to start and stop hardware sampling have to be
> invoked by the oprofile kernel module as provided by the other patches of this patch set.
> 
> In case hardware based sampling cannot be setup standard timer based sampling is used by OProfile.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Maran Pakkirisamy <maranp@linux.vnet.ibm.com>
> Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
> ---
>  arch/Kconfig                   |    3
>  arch/s390/Kconfig              |    1
>  arch/s390/oprofile/hwsampler.c | 1256 +++++++++++++++++++++++++++++++++++++++++
>  arch/s390/oprofile/hwsampler.h |  113 +++
>  4 files changed, 1373 insertions(+)

Applied with following changes:
    * enable compilation in Makefile

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center

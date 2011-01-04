Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 4 Jan 2011 16:34:11 +0100
From: Robert Richter <robert.richter@amd.com>
Subject: Re: [patch 3/4] This patch introduces a new oprofile sample add
 function (oprofile_add_ext_hw_sample)
Message-ID: <20110104153411.GV4739@erda.amd.com>
References: <20101220130541.446049933@linux.vnet.ibm.com>
 <20101220130629.823952802@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20101220130629.823952802@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "graalfs@linux.vnet.ibm.com" <graalfs@linux.vnet.ibm.com>
Cc: "mingo@elte.hu" <mingo@elte.hu>, "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Maran Pakkirisamy <maranp@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 20.12.10 08:05:44, graalfs@linux.vnet.ibm.com wrote:
> From: graalfs@linux.vnet.ibm.com
> 
> This patch introduces a new oprofile sample add function (oprofile_add_ext_hw_sample)
> that can also take task_struct as an argument, which is used by the hwsampler kernel module 
> when copying hardware samples to OProfile buffers.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Maran Pakkirisamy <maranp@linux.vnet.ibm.com>
> Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
> ---
>  drivers/oprofile/cpu_buffer.c |   26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

> +void oprofile_add_ext_hw_sample(unsigned long pc, struct pt_regs * const regs,
> +				unsigned long event, int is_kernel,
> +				struct task_struct *task)
> +{
> +	__oprofile_add_ext_sample(pc, regs, event, is_kernel, task);
> +}
> +EXPORT_SYMBOL_GPL(oprofile_add_ext_hw_sample);

Hmm, I am not convinced of this new interface between the hwsampler
module and oprofile. It is asymmetric and bloats the function's
parameters list. A first simplification would be to not implement
hwsampler as module and integrate this in oprofile. Then, we can look
for a better way to add samples to the oprofile buffer. What do you
think?

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center

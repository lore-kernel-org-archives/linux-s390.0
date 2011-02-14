Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 Feb 2011 19:55:48 +0100
From: Robert Richter <robert.richter@amd.com>
Subject: Re: [patch v2 3/3] This patch introduces a new oprofile sample add
 function (oprofile_add_ext_hw_sample)
Message-ID: <20110214185548.GQ5874@erda.amd.com>
References: <20110121100651.821690659@linux.vnet.ibm.com>
 <20110121100842.200732938@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20110121100842.200732938@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Cc: "mingo@elte.hu" <mingo@elte.hu>, "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Maran Pakkirisamy <maranp@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 21.01.11 05:06:54, Heinz Graalfs wrote:
> From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
> 
> This patch introduces a new oprofile sample add function (oprofile_add_ext_hw_sample)
> that can also take task_struct as an argument, which is used by the hwsampler kernel module 
> when copying hardware samples to OProfile buffers.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Maran Pakkirisamy <maranp@linux.vnet.ibm.com>
> Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
> ---
>  drivers/oprofile/cpu_buffer.c |   27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)

Applied with following changes:
    * removed #include <linux/module.h>
    * whitespace changes
    * removed conditional compilation (CONFIG_HAVE_HWSAMPLER)
    * modified order of functions
    * fix missing function definition in header file

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center

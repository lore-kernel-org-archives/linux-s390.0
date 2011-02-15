Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 15 Feb 2011 20:11:22 +0100
From: Robert Richter <robert.richter@amd.com>
Subject: Re: [patch 0/2] delta patch - s390 hw sampling rework on comments
 as of Feb 14th
Message-ID: <20110215191122.GJ5874@erda.amd.com>
References: <20110215180212.334742128@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20110215180212.334742128@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Cc: "mingo@elte.hu" <mingo@elte.hu>, "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 15.02.11 13:02:12, Heinz Graalfs wrote:
>    It is not clear to me how you want me to merge the static functions.
> 
>    One possibility I'm seeing is to merge log_sample, op_add_code, and op_add_sample?

Yes, that's it. We don't need all this different functions that almost
do the same.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
